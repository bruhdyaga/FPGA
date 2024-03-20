`include "normalizer.svh"
`include "global_param.v"

module normalizer
#(
    parameter BASEADDR  = 0,
    parameter WIDTH     = 0,
    parameter TWIDTH    = 0  // разрядность таблицы
)
(
    intbus_interf.slave             bus,
    input                           clk,
    input        signed [WIDTH-1:0] i_in,
    input        signed [WIDTH-1:0] q_in,
    output logic signed [WIDTH-1:0] i_out,
    output logic signed [WIDTH-1:0] q_out,
    input                           we,
    output logic                    valid
);

localparam WIDTH_SQ = (WIDTH - 1) * 2; // разрядность квадрата

logic signed [WIDTH-1:0]        I_pipe;
logic signed [WIDTH-1:0]        Q_pipe;
logic signed [WIDTH-1:0]        I_pipe_K;
logic signed [WIDTH-1:0]        Q_pipe_K;
logic        [WIDTH*2-2:0]      I2_sign;
logic        [WIDTH*2-2:0]      Q2_sign;
logic        [WIDTH_SQ-1:0]     I2;
logic        [WIDTH_SQ-1:0]     Q2;
logic        [WIDTH_SQ:0]       I2Q2; // I^2+Q^2
logic signed [WIDTH+TWIDTH-1:0] In;   // normalized
logic signed [WIDTH+TWIDTH-1:0] Qn;
logic signed [WIDTH-1:0]        Insc; // normalized_scaled
logic signed [WIDTH-1:0]        Qnsc;

logic [TWIDTH-1:0] addr_wr;
logic [TWIDTH-1:0] A;                   // table address (огибающая сигнала)
logic [TWIDTH-1:0] RAM [2**TWIDTH-1:0]; // 1/sqrt(x) RAM
logic [TWIDTH-1:0] K; // normalized coefficient

localparam NBUSES = `ifdef IMI_NORM_DATCOLL 1 + `endif
                    1;

intbus_interf  bus_sl[NBUSES]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

NORMALIZER_RO_STRUCT PL;
NORMALIZER_WO_STRUCT PS;

//Define which bits will be pulsed
localparam NPULSE = 2;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 31},// wr_ram
    '{0, 30} // clr
};

localparam BASEREG = BASEADDR + `HUBSIZE;
regs_file#(
    .BASEADDR (BASEREG),
    .ID       (`NORMALIZER_ID_CONST),
    .DATATYPE (NORMALIZER_WO_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
) regs_file_fsm_controller_inst(
    .clk    (clk),
    .bus    (bus_sl[0]),
    .in     (PL),
    .out    (PS),
    .pulse  ({clr,wr_ram}),
    .wr     (),
    .rd     ()
);

assign PL.RESERVED = '0;
assign PL.WIDTH    = WIDTH;
assign PL.TWIDTH   = TWIDTH;

always_ff@(posedge clk)
if(clr) begin
    addr_wr <= '0;
end else begin
    if(wr_ram) begin
        addr_wr <= addr_wr + 1'b1;
    end
end

always_ff@(posedge clk)
if(wr_ram) begin
    RAM[addr_wr] <= PS.DATA[0+:TWIDTH];
end

logic pipe_valid;
always_ff@(posedge clk)
if(we) begin
    I_pipe     <= i_in;
    Q_pipe     <= q_in;
    pipe_valid <= we;
end

logic mul_valid;
always_ff@(posedge clk)
if(pipe_valid) begin
    I2_sign <= $signed(I_pipe) * $signed(I_pipe);
    Q2_sign <= $signed(Q_pipe) * $signed(Q_pipe);
    mul_valid <= pipe_valid;
end

assign I2 = I2_sign[WIDTH_SQ-1:0];
assign Q2 = Q2_sign[WIDTH_SQ-1:0];

logic sum_valid;
always_ff@(posedge clk)
if(mul_valid) begin
    I2Q2 <= I2 + Q2;
    sum_valid <= mul_valid;
end

assign A = I2Q2 >> (WIDTH_SQ + 1 - TWIDTH);

logic k_valid;
always_ff@(posedge clk)
if(sum_valid) begin
    K <= RAM[A];
    k_valid <= sum_valid;
end

conv_reg#(
    .width  (WIDTH*2),
    .length (3)
) IQ_pipe_K(
    .clk (clk),
    .in  ({I_pipe,Q_pipe}),
    .out ({I_pipe_K,Q_pipe_K})
);

logic IQn_valid;
always_ff@(posedge clk)
if(k_valid) begin
    In <= $signed(I_pipe_K) * $signed({1'b0,K});
    Qn <= $signed(Q_pipe_K) * $signed({1'b0,K});
    IQn_valid <= k_valid;
end

always_ff@(posedge clk)
if(IQn_valid) begin
    Insc <= $signed($signed(In) >>> PS.SHIFT);
    Qnsc <= $signed($signed(Qn) >>> PS.SHIFT);
    valid <= IQn_valid;
end

assign i_out = PS.BYPASS ? i_in : Insc;
assign q_out = PS.BYPASS ? q_in : Qnsc;

localparam BASEDATCOLL = BASEREG + `NORMALIZER_SIZE + `RWREGSSIZE;
`ifdef IMI_NORM_DATCOLL
data_collector#(
    .BASEADDR   (BASEDATCOLL),
    .NUM_PORTS  (4),
    .DATA_WIDTH (WIDTH),
    .DATA_DEPTH (`ifndef NORM_DATCOLL_SIZE 100 `else `NORM_DATCOLL_SIZE `endif)
) DATA_COLLECTOR(
    .clk    (clk),
    .we     ('1),
    .data   ({q_out,i_out,q_in,i_in}),
    .bus    (bus_sl[1])
);
`endif

`ifndef SYNTHESIS
logic [WIDTH*2-1:0]  I2n_sign;
logic [WIDTH*2-1:0]  Q2n_sign;
logic [WIDTH_SQ:0]   I2n;
logic [WIDTH_SQ:0]   Q2n;
logic [WIDTH_SQ:0]   I2Q2n; // I^2+Q^2
logic [TWIDTH-1:0]   An;

assign I2n_sign = $signed(i_out) * $signed(i_out);
assign Q2n_sign = $signed(q_out) * $signed(q_out);

assign I2n = I2n_sign[WIDTH_SQ:0];
assign Q2n = Q2n_sign[WIDTH_SQ:0];

assign I2Q2n = I2n + Q2n;

assign An = I2Q2n >> (WIDTH_SQ + 1 - TWIDTH);
`endif

endmodule