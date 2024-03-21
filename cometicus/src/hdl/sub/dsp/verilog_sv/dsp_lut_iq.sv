`include "dsp_lut_iq.svh"

module dsp_lut_iq
#(
    parameter BASEADDR  = 0,
    parameter IN_WIDTH  = 0,
    parameter OUT_WIDTH = 0
)
(
    intbus_interf.slave                 bus,
    input                               clk,
    input        signed [IN_WIDTH -1:0] i_in,
    input        signed [IN_WIDTH -1:0] q_in,
    output logic signed [OUT_WIDTH-1:0] i_out,
    output logic signed [OUT_WIDTH-1:0] q_out,
    input                               we,
    output logic                        valid
);

localparam DEPTH = 2**(IN_WIDTH-1);

logic [OUT_WIDTH-2:0] ram [DEPTH-1:0];
logic [OUT_WIDTH-2:0] ram_out_a;
logic [OUT_WIDTH-2:0] ram_out_b;
logic [IN_WIDTH-2:0]  addr_a;
logic [IN_WIDTH-2:0]  addr_b;
logic [IN_WIDTH-2:0]  addr_wr;

DSP_LUT_IQ_RO_STRUCT PL;
DSP_LUT_IQ_WO_STRUCT PS;

//Define which bits will be pulsed
localparam NPULSE = 2;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 31},// wr_ram
    '{0, 30} // clr
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`DSP_LUT_IQ_ID_CONST),
    .DATATYPE (DSP_LUT_IQ_WO_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
) regs_file_fsm_controller_inst(
    .clk    (clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  ({clr,wr_ram}),
    .wr     (),
    .rd     ()
);

assign PL.RESERVED  = '0;
assign PL.IN_WIDTH  = IN_WIDTH;
assign PL.OUT_WIDTH = OUT_WIDTH;

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
    ram[addr_wr] <= PS.DATA[0+:OUT_WIDTH-1];
end

abs#(
    .WIDTH (IN_WIDTH),
    .FF    (1)
) abs_i_in_inst(
    .clk   (clk),
    .in    (i_in),
    .out   (addr_a),
    .we    (we),
    .valid (abs_valid)
);
abs#(
    .WIDTH (IN_WIDTH),
    .FF    (1)
) abs_q_in_inst(
    .clk   (clk),
    .in    (q_in),
    .out   (addr_b),
    .we    (we),
    .valid ()
);

always_ff@(posedge clk)
if(abs_valid) begin
    ram_out_a <= ram[addr_a];
end

always_ff@(posedge clk)
if(abs_valid) begin
    ram_out_b <= ram[addr_b];
end

logic ram_valid;
always_ff@(posedge clk)
ram_valid <= abs_valid;

conv_reg#(
    .width  (2),
    .length (2)
) conv_reg_data_inst(
    .clk (clk),
    .in  ({q_in[IN_WIDTH-1],i_in[IN_WIDTH-1]}),
    .out ({q_sign,i_sign})
);

logic signed [OUT_WIDTH-1:0] i_in_lim; // 1-clock delay of input
logic signed [OUT_WIDTH-1:0] q_in_lim;
// limiter (default mode for Compressor module)
lim_qnt#(
    .in_width  (IN_WIDTH),
    .out_width (OUT_WIDTH)
)LIM_QNT_I (
    .clk   (clk),
    .WE    (we),
    .valid (lim_valid),
    .in    (i_in),
    .out   (i_in_lim)
);
lim_qnt#(
    .in_width  (IN_WIDTH),
    .out_width (OUT_WIDTH)
)LIM_QNT_Q (
    .clk   (clk),
    .WE    (we),
    .valid (),
    .in    (q_in),
    .out   (q_in_lim)
);

logic signed [OUT_WIDTH-1:0] i_in_lim_delay; // 2-clock delay of input
logic signed [OUT_WIDTH-1:0] q_in_lim_delay;
always_ff@(posedge clk)
if(lim_valid) begin
    i_in_lim_delay <= i_in_lim;
    q_in_lim_delay <= q_in_lim;
end

logic signed [OUT_WIDTH-1:0] i_mux;
logic signed [OUT_WIDTH-1:0] q_mux;
always_comb
if(PS.EN) begin
    i_mux <= i_sign ? -$signed(ram_out_a) : ram_out_a;
    q_mux <= q_sign ? -$signed(ram_out_b) : ram_out_b;
end else begin
    i_mux <= i_in_lim_delay;
    q_mux <= q_in_lim_delay;
end

always_ff@(posedge clk)
if(ram_valid) begin
    i_out <= i_mux;
    q_out <= q_mux;
end

always_ff@(posedge clk)
valid <= ram_valid;

endmodule