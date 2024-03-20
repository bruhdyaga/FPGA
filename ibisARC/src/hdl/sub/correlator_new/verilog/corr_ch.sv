`include "corr_ch.svh"
`include "global_param.v"

module corr_ch
#(
    parameter BASEADDR = 0,
    parameter PRN_GEN  = 0, // 0 or 1
    parameter PRN_RAM  = 0  // 0 or 1
)
(
    intbus_interf.slave bus,
    adc_interf.slave adc,
    input  fix_pulse,
    input  irq_pulse
);

localparam IQ_DIGS = 21; // количество разрядов накапливающих сумматоров IQ
localparam NBUSES = 4;
intbus_interf bus_sl[NBUSES]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES),
    .OUTFF      ("n"),
    .MASTERFF   ("n")
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

// The generator data structure definition
CORR_CH PL;     // The registers from logic
CORR_CH PS;     // The registers from CPU

assign PL.CFG                = '0;
assign PL.PHASE_RATE         = '0;
assign PL.RESERVED_EPOCH_IRQ = '0;

wire epoch_pulse;
wire do_rqst;
wire eph_apply;

TIME_WORD time_out;
wire [2:0] phase_hi;

localparam BASETIME = BASEADDR + `HUBSIZE;
time_scale_ch#(
    .BASEADDR   (BASETIME)
)TIME_SCALE_CH (
    .bus           (bus_sl[0]), // последовательность обговорена
    .clk           (adc.clk),
    .chip_pulse    (chip_pulse),
    .epoch_pulse   (epoch_pulse),
    .sec_pulse     (),
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
wire PN;
wire MASK;

localparam BASE_PRN_GEN = BASETIME + `TIME_SCALE_CH_FULL_SIZE;
if(PRN_GEN) begin
    prn_gen#(
        .BASEADDR (BASE_PRN_GEN)
    )PRN_GEN_CH (
        .bus           (bus_sl[1]),
        .clk           (adc.clk),
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
        .clk           (adc.clk),
        .phase_hi      (phase_hi),
        .update        (do_rqst),
        .code_out      (pn_ram),
        .mask          (mask_ram),
        .chip          (time_out.CHIP[9:0]),
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

wire [(($bits(CORR_CH) + 1)/`AXI_GP_WIDTH) - 1 : 0] int_wr_arr;
localparam BASEREGFILE = BASE_PRN_RAM + `PRN_RAM_FULL_SIZE;
regs_file#(
    .BASEADDR (BASEREGFILE),
    .ID       (`CORR_CH_ID_CONST),
    .DATATYPE (CORR_CH),
    .OUTFF    ("n")
)RF (
    .clk           (adc.clk),
    .bus           (bus_sl[3]), // последовательность обговорена
    .in            (PL),
    .out           (PS),
    .pulse         (),
    .wr            (int_wr_arr),
    .rd            ()
);

always_ff@(posedge adc.clk) begin
    if(irq_pulse) begin
        PL.EPOCH_IRQ <= time_out.EPOCH;
    end
end

// Delay line
reg  [DLY_LEN*2:0] PN_LINE;
wire [DELAYS*2:0]  PN_dly;
reg  [DLY_LEN*2:0] mask_LINE;
wire [DELAYS*2:0]  mask_dly;

always_ff@(posedge adc.clk) begin
    PN_LINE <= {PN_LINE[DLY_LEN*2-1:0], PN};
end

for(genvar dly=0; dly<DELAYS*2+1; dly++) begin: DLY_PN
    assign PN_dly[dly] = PN_LINE[DLY_LEN + (dly - DELAYS) * (PS.CFG.DELAY)];
end

always_ff@(posedge adc.clk) begin
    mask_LINE <= {mask_LINE[DLY_LEN*2-1:0], MASK};
end

for(genvar dly=0; dly<DELAYS*2+1; dly++) begin: DLY_mask
    assign mask_dly[dly] = mask_LINE[DLY_LEN + (dly - DELAYS) * (PS.CFG.DELAY)];
end

// Actual PHASE_RATE register update sync to epoch_pulse
reg [31:0] PHASE_RATE = 32'h00003000;
always_ff@(posedge adc.clk) begin
    if(do_rqst | eph_apply) begin
        PHASE_RATE <= PS.PHASE_RATE;
    end
end

// Reference generator PHASE
wire [32:0] phase_next;
reg  [31:0] PHASE = '0;
reg  [31:0] CAR_CYCLES;
assign phase_next = PHASE + PHASE_RATE;

always_ff@(posedge adc.clk) begin
    if(do_rqst) begin // в дальнейшем можно будет выкинуть
        PHASE <= '0;
    end else begin
        PHASE <= phase_next[31:0];
    end
end

always_ff@(posedge adc.clk) begin
    if(PHASE_RATE[31]) begin
        if(phase_next[32] == '0) begin
            CAR_CYCLES <= CAR_CYCLES - 1'b1;
        end
    end else begin
        if(phase_next[32]) begin
            CAR_CYCLES <= CAR_CYCLES + 1'b1;
        end
    end
end

always_ff@(posedge adc.clk) begin
    if(fix_pulse) begin
        PL.CAR_PHASE  <= PHASE;
        PL.CAR_CYCLES <= CAR_CYCLES;
    end
end

// Reference carrier generators
wire signed [N_INP-1:0][4:0] cos_prod;
wire signed [N_INP-1:0][4:0] sin_prod;

// Multiplier
wire signed [N_INP-1:0][DELAYS*2:0][IQ_DIGS-1:0] cos_prod32;
wire signed [N_INP-1:0][DELAYS*2:0][IQ_DIGS-1:0] sin_prod32;

// Accumulators
reg signed [N_INP-1:0][DELAYS*2:0][IQ_DIGS-1:0] I;
reg signed [N_INP-1:0][DELAYS*2:0][IQ_DIGS-1:0] Q;

logic [N_INP-1:0][4:0] INPUT_I = '0; // хранение номеров входов
logic [N_INP-1:0][4:0] INPUT_Q = '0; // хранение номеров входов

always_ff@(posedge bus.clk) begin// PS.CFG не синхронизирован, используем bus.clk
    if(int_wr_arr[1]) begin
        INPUT_I[PS.CFG.INP_NUM] <= PS.CFG.INPUT_I;
        INPUT_Q[PS.CFG.INP_NUM] <= PS.CFG.INPUT_Q;
    end
end

wire [N_INP-1:0][DELAYS*2:0] ovfl;
for(genvar inp=0; inp<N_INP; inp++) begin: INP
    ch_mul CH_MUL(
        .clk    (adc.clk),
        .adc_re (adc.data[INPUT_I[inp]]),
        .adc_im (adc.data[INPUT_Q[inp]]),
        .phase  (PHASE[31:27]),
        .i_prod (cos_prod[inp]),
        .q_prod (sin_prod[inp])
    );
    
    for(genvar dly=0; dly<DELAYS*2+1; dly++) begin: DLY_PROD
        assign cos_prod32[inp][dly]  = $signed((!mask_dly[dly]) ? ((PN_dly[dly]) ? (cos_prod[inp]) : (-cos_prod[inp])) : '0);
        assign sin_prod32[inp][dly]  = $signed((!mask_dly[dly]) ? ((PN_dly[dly]) ? (sin_prod[inp]) : (-sin_prod[inp])) : '0);
    end
    
    for(genvar d=0; d<DELAYS*2+1; d++) begin: DLY_IQ
        assign ovfl[inp][d] = (I[inp][d][IQ_DIGS-1] ^ I[inp][d][IQ_DIGS-2]) | (Q[inp][d][IQ_DIGS-1] ^ Q[inp][d][IQ_DIGS-2]);
        always_ff@(posedge adc.clk) begin
            if(epoch_pulse) begin
                I[inp][d] <= cos_prod32[inp][d];
                Q[inp][d] <= sin_prod32[inp][d];
            end else begin
                if(ovfl == '0) begin
                    I[inp][d] <= I[inp][d] + cos_prod32[inp][d];
                    Q[inp][d] <= Q[inp][d] + sin_prod32[inp][d];
                end
            end
        end
        
        always_ff@(posedge adc.clk) begin
            if(epoch_pulse) begin // как в старом корреляторе
                PL.IQ[inp][d] <= {I[inp][d][IQ_DIGS-1:IQ_DIGS-16] <<< 1, Q[inp][d][IQ_DIGS-1:IQ_DIGS-16] <<< 1};
            end
        end
    end
end

endmodule
