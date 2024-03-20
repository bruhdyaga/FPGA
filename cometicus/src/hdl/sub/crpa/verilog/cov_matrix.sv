`include "cov_matrix.svh"

module cov_matrix
#(
    parameter  BASEADDR    = 0
)
(
    adc_interf.slave     data_in,
    intbus_interf.slave  bus,
    input                ce    // используется только для глобального отключения логики
);

localparam NBUSES = 2;
intbus_interf bus_sl[NBUSES]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

adc_interf_3d#(
    .PORTS (`CRPA_NCH),
    .GROUP (`CRPA_NT),
    .R     (`CRPA_D_WIDTH)
)data_dly_A ();

adc_interf_3d#(
    .PORTS (`CRPA_NCH),
    .GROUP (`CRPA_NT),
    .R     (`CRPA_D_WIDTH)
)data_dly_B ();

adc_interf#(
    .PORTS (`CRPA_NCH),
    .R     (`CRPA_D_WIDTH)
)data_ram ();

adc_interf#(
    .PORTS (`CRPA_NCH),
    .R     (`CRPA_D_WIDTH)
)crpa_in_mux (); // мультиплексор: данные-тестовые константы

// The generator data structure definition
COV_MATRIX_STRUCT PL;     // The registers from logic
COV_MATRIX_STRUCT PS;     // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 0} // start
};

localparam REG_BASE_ADDR = BASEADDR + `HUBSIZE;
wire start;
regs_file#(
    .BASEADDR (REG_BASE_ADDR),
    .ID       (`COV_MATRIX_ID_CONST),
    .DATATYPE (COV_MATRIX_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (data_in.clk),
    .bus    (bus_sl[0]),
    .in     (PL),
    .out    (PS),
    .pulse  (start),
    .wr     (),
    .rd     ()
);

assign PL.CFG.RESERVED  = '0;
assign PL.CFG.CONST_EN  = '0;
assign PL.CFG.T_A       = '0;
assign PL.CFG.T_B       = '0;
assign PL.CFG.WLENGTH   = '0;
assign PL.CFG.START     = '0;
assign PL.CONST         = '0;

reg  [16:0] cntr;
reg  rd_data;
wire complete;
always_ff@(posedge data_in.clk)
if(ce) begin
    if(start) begin
        cntr <= '0;
    end else begin
        if((complete == '0)) begin
            cntr <= cntr + 1'b1;
        end
    end
end

assign complete = (cntr == PS.CFG.WLENGTH - 1);

always_ff@(posedge data_in.clk)
if(start) begin
    rd_data <= '1;
end else begin
    if(complete) begin
        rd_data <= '0;
    end
end

assign crpa_in_mux.clk    = data_in.clk;
assign crpa_in_mux.valid  = data_in.valid;

logic signed [`CRPA_D_WIDTH-1:0] const_cvm_inp [15:0];
for(genvar i = 0; i < `CRPA_NCH/2; i ++) begin
    assign const_cvm_inp[i]             = $signed(PS.CONST.I[i]);
    assign const_cvm_inp[i+`CRPA_NCH/2] = $signed(PS.CONST.Q[i]);
end

for(genvar i = 0; i < `CRPA_NCH; i ++) begin
    assign crpa_in_mux.data[i] = PS.CFG.CONST_EN ? $signed(const_cvm_inp[i]) : data_in.data[i];
end

localparam RAM_BASE_ADDR = REG_BASE_ADDR + `COV_MATRIX_SIZE + `RWREGSSIZE;
cov_ram#(
    .BASEADDR    (RAM_BASE_ADDR),
    .NCH         (`CRPA_NCH),
    .WIDTH       (`CRPA_D_WIDTH),
    .RAM_SIZE    (`RAM_SIZE),
    .RAM_BLOCKS  (`RAM_BLOCKS)
)RAM (
    .data_in  (crpa_in_mux),
    .data_out (data_ram),
    .bus      (bus_sl[1]),
    .we       ('1),
    .ce       (ce),
    .rd       (rd_data)
);

delays_array#(
    .Nin   (`CRPA_NCH),
    .NT    (`CRPA_NT)
)DLA_A (
    .data_in   (data_ram),
    .data_dly  (data_dly_A),
    .ce        (ce)
);

delays_array#(
    .Nin   (`CRPA_NCH),
    .NT    (`CRPA_NT)
)DLA_B (
    .data_in   (data_ram),
    .data_dly  (data_dly_B),
    .ce        (ce)
);

assign valid2macc = data_dly_A.valid & data_ram.valid;

ed_det#(
    .TYPE      ("ris"),
    .FLIP_EN   (1)
)MACC_CLR (
    .clk   (data_dly_A.clk),
    .in    (valid2macc),
    .out   (macc_clr)
);

reg [1:0] valid_dla_lat;
always_ff@(posedge data_dly_A.clk)
if(ce) begin
    valid_dla_lat <= {valid_dla_lat[0],valid2macc};
end

wire [2:0] macc_we;
assign macc_we = {valid_dla_lat,valid2macc};

wire [`CRPA_ACCUM_WIDTH-1:0] accum [`CRPA_NCH-1:0][`CRPA_NCH-1:0];
for(genvar iA = 0; iA < `CRPA_NCH; iA ++) begin: MACS_A
    for(genvar iB = 0; iB < `CRPA_NCH; iB ++) begin: MACS_B
        macc2#(
            .SIZEIN  (`CRPA_D_WIDTH),
            .SIZEACC (`CRPA_ACCUM_WIDTH)
        )MA (
            .clk      (data_dly_A.clk),
            .ce       (ce),
            .clr      (macc_clr),
            .a        (data_dly_A.data[PS.CFG.T_A][iA]),
            .b        (data_dly_B.data[PS.CFG.T_B][iB]),
            .we       (macc_we),
            .accum    (accum[iA][iB])
        );
        assign PL.DATA[iA][iB] = $signed(accum[iA][iB]);
    end
end

always_ff@(posedge data_in.clk)
if(ce) begin
    PL.CFG.COMPLETE <= !macc_we[2];
end

endmodule