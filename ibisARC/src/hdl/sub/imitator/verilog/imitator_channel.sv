`include "imitator_channel.svh"
`include "global_param.v"

module imitator_channel#(
    parameter BASEADDR  = 0,
    parameter OUT_WIDTH = 0,
    parameter PRN_GEN   = 0, // 0 or 1
    parameter PRN_RAM   = 0  // 0 or 1
)
(
    intbus_interf.slave                 bus,
    input                               clk,
    input                               fix_pulse,
    input                               irq_pulse,
    output logic signed [OUT_WIDTH-1:0] I,
    output logic signed [OUT_WIDTH-1:0] Q
);

localparam NBUSES = 4;

intbus_interf bus_sl[NBUSES]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

// The generator data structure definition
IMI_CHANNEL_STRUCT PL;
IMI_CHANNEL_STRUCT PS;     // The registers from CPU

logic [AMULT_WIDTH-1:0] AMULT;
logic [ADIV_WIDTH-1:0]  ADIVEXP;
TIME_WORD time_out;
wire [2:0] phase_hi;

localparam BASETIME = BASEADDR + `HUBSIZE;

time_scale_ch#(
    .BASEADDR   (BASETIME)
)TIME_SCALE_CH (
    .bus           (bus_sl[0]),
    .clk           (clk),
    .chip_pulse    (chip_pulse),
    .epoch_pulse   (epoch_pulse),
    .sec_pulse     (sec_pulse),
    .fix_pulse     (fix_pulse),
    .do_rqst       (do_rqst),
    .eph_apply     (eph_apply),
    .time_out      (time_out),
    .phase_hi      (phase_hi)
);

wire pn_gen;
wire pn_ram;
wire mask_gen;
wire mask_ram;

localparam BASE_PRN_GEN = BASETIME + `TIME_SCALE_CH_FULL_SIZE;
if(PRN_GEN) begin
    prn_gen#(
        .BASEADDR (BASE_PRN_GEN)
    )PRN_GEN_CH (
        .bus           (bus_sl[1]),
        .clk           (clk),
        .sr_shift      (chip_pulse),
        .phase_hi      (phase_hi),
        .update        (do_rqst),
        .epoch_pulse   (epoch_pulse),
        .code_out      (pn_gen),
        .mask          (mask_gen)
    );
end else begin
    regs_file#(
        .BASEADDR (BASE_PRN_GEN),
        .ID       (`PRN_GEN_ID_CONST),
        .DATATYPE (PRN_GEN_STRUCT),
        .OUTFF    ("n")
    )PRN_GEN_CH_DUMMY (
        .clk    (),
        .bus    (bus_sl[1]),
        .in     ('0),
        .out    (),
        .pulse  (),
        .wr     (),
        .rd     ()
    );
end

localparam BASE_PRN_RAM = BASE_PRN_GEN + `PRN_GEN_FULL_SIZE;
if(PRN_RAM) begin
    prn_ram#(
        .BASEADDR (BASE_PRN_RAM),
        .RAM_SIZE (10240)
    )PRN_RAM_CH (
        .bus           (bus_sl[2]),
        .clk           (clk),
        .phase_hi      (phase_hi),
        .update        (do_rqst),
        .code_out      (pn_ram),
        .mask          (mask_ram),
        .chip          (time_out.CHIP),
        .chip_pulse    (chip_pulse),
        .epoch_pulse   (epoch_pulse)
    );
end else begin
    regs_file#(
        .BASEADDR (BASE_PRN_RAM),
        .ID       (`PRN_RAM_ID_CONST),
        .DATATYPE (PRN_RAM_STRUCT),
        .OUTFF    ("n")
    )PRN_RAM_CH_DUMMY (
        .clk    (),
        .bus    (bus_sl[2]),
        .in     ('0),
        .out    (),
        .pulse  (),
        .wr     (),
        .rd     ()
    );
end

assign PN   = (PS.CFG.PN_MUX) ? pn_gen   : pn_ram;   // сделать через if оптимизацию мультиплексора
assign MASK = (PS.CFG.PN_MUX) ? mask_gen : mask_ram;

localparam BASEREGFILE = BASE_PRN_RAM + `PRN_RAM_FULL_SIZE;
regs_file#(
    .BASEADDR (BASEREGFILE),
    .ID       (`IMI_CHANNEL_ID_CONST),
    .DATATYPE (IMI_CHANNEL_STRUCT)
)RF (
    .clk    (),
    .bus    (bus_sl[3]),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

assign PL.CFG                 = '0;
assign PL.PHASE_RATE          = '0;
assign PL.RESERVED_EPOCH_IRQ  = '0;
assign PL.DATA                = '0;

always_ff@(posedge clk) begin
    if(irq_pulse) begin
        PL.EPOCH_IRQ <= time_out.EPOCH;
    end
end

// Delay line
reg  [DLY_LEN:0] PN_LINE;
wire             PN_dly;
reg  [DLY_LEN:0] mask_LINE;
wire             mask_dly;

always_ff@(posedge clk) begin
    PN_LINE <= {PN_LINE[DLY_LEN-1:0], PN};
end

assign PN_dly = PN_LINE[DLY_LEN];

always_ff@(posedge clk) begin
    mask_LINE <= {mask_LINE[DLY_LEN-1:0], MASK};
end

assign mask_dly = mask_LINE[DLY_LEN];

reg [31:0] PHASE_RATE = '0;
always_ff@(posedge clk) begin
    if(do_rqst | eph_apply)
        PHASE_RATE <= PS.PHASE_RATE;
end

wire [32:0] phase_cntr;
reg  [31:0] CAR_CYCLES = '0;
always_ff@(posedge clk) begin
    if(PHASE_RATE[31]) begin
        if(phase_cntr[32] == '0) begin
            CAR_CYCLES <= CAR_CYCLES - 1'b1;
        end
    end else begin
        if(phase_cntr[32]) begin
            CAR_CYCLES <= CAR_CYCLES + 1'b1;
        end
    end
end

always_ff@(posedge clk) begin
    if(fix_pulse) begin
        PL.CAR_PHASE  <= phase_cntr[31:0];
        PL.CAR_CYCLES <= CAR_CYCLES;
    end
end

logic signed [SIN_COS_WIDTH-1:0] cos_product;
logic signed [SIN_COS_WIDTH-1:0] sin_product;
dds_iq_hd#(
    .IQ_WIDTH    (SIN_COS_WIDTH),
    .PHASE_WIDTH (PHASE_WIDTH),
    .TABLE_NAME  (DDS_TABLE_NAME)
)dds_iq_hd (
    .clk        (clk),
    .sin        (sin_product),
    .cos        (cos_product),
    .code       (PHASE_RATE),
    .phase_cntr (phase_cntr)
);

wiper WIPER(
    .clk           (clk),
    .epoch_pulse   (epoch_pulse),
    .sec2_pulse    (sec_pulse & time_out.SEC[0]), // пульс раз в 2 секунды
    .data          (PS.DATA),
    .data_symb     (data_symb)
);

assign GcGd = data_symb ^ PN_dly;

logic signed [SIN_COS_WIDTH-1:0] Gcos;
logic signed [SIN_COS_WIDTH-1:0] Gsin;
assign Gcos = $signed((!mask_dly) ? (GcGd ? cos_product : (-cos_product)) : '0);
assign Gsin = $signed((!mask_dly) ? (GcGd ? sin_product : (-sin_product)) : '0);

logic signed [OUT_WIDTH-1:0] AGcos;
logic signed [OUT_WIDTH-1:0] AGsin;
always_ff@(posedge clk) begin
    AGcos <= $signed({1'b0,AMULT}) * Gcos;
    AGsin <= $signed({1'b0,AMULT}) * Gsin;
end

always_ff@(posedge clk) begin
    if(epoch_pulse) begin
        AMULT <= PS.CFG.AMULT;
        ADIVEXP <= PS.CFG.ADIVEXP;
    end
end

always_ff@(posedge clk) begin
    if(PS.CFG.CH_EN) begin // сделано округление по модулю вниз
        I <= $signed(AGcos >>> ADIVEXP) + ((AGcos[OUT_WIDTH-1] & |(AGcos & (2**ADIVEXP - 1))) ? 1 : 0);
        Q <= $signed(AGsin >>> ADIVEXP) + ((AGsin[OUT_WIDTH-1] & |(AGsin & (2**ADIVEXP - 1))) ? 1 : 0);
    end else begin
        I <= '0;
        Q <= '0;
    end
end

endmodule
