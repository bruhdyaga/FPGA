module bram_block(
	wr_clk,
	rd_clk,
	we,
	re,
	dat_in,
	dat_out,
	wr_addr,
	rd_addr
);

parameter WIDTH = 1;
parameter AWIDTH = 1;

input  wr_clk;
input  rd_clk;
input  we;
input  re;
input  [WIDTH-1:0] dat_in;
output [WIDTH-1:0] dat_out;
input  [AWIDTH-1:0] wr_addr;
input  [AWIDTH-1:0] rd_addr;

reg [WIDTH-1:0] ram [(2**AWIDTH)-1:0];
reg [WIDTH-1:0] dat_out;

always@(posedge wr_clk)
if(we)
	ram[wr_addr] <= dat_in;

always@(posedge rd_clk)
if(re)
	dat_out <= ram[rd_addr];
else
	dat_out <= 0;



endmodule