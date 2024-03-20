module bram_block_v2(
	//OUT_REG "EN" or else(def)
	wr_clk,
	rd_clk,
	we,
	re,
	dat_in,
	dat_out,
	wr_addr,
	rd_addr
);

`include "math.v"

parameter OUT_REG = 0;
parameter WIDTH = 1;
parameter DEPTH = 1;

localparam AWIDTH = log2(DEPTH);

input  wr_clk;
input  rd_clk;
input  we;
input  re;
input  [WIDTH-1:0] dat_in;
output [WIDTH-1:0] dat_out;
input  [AWIDTH-1:0] wr_addr;
input  [AWIDTH-1:0] rd_addr;

(* ram_style = "block" *)
reg [WIDTH-1:0] ram [DEPTH-1:0];


always@(posedge wr_clk)
if(we)
	ram[wr_addr] <= dat_in;


generate
	if(OUT_REG == "EN") begin
		reg [WIDTH-1:0] ram_out;

		always@(posedge rd_clk)
		if(re)
			ram_out <= ram[rd_addr];
		else
			ram_out <= 0;

		assign dat_out = ram_out;
	end else begin
		wire [WIDTH-1:0] ram_out;

		assign ram_out = ram[rd_addr];
		assign dat_out = ram_out;
	end
endgenerate



endmodule