module conv_reg(
	//width(1)
	//length(0)// number of registers
	//RESET_TYPE "SYN" or "ASY"(def="ASY")
	reset,
	clk,
	in,
	out
);

parameter width = 1;
parameter length = 0;
parameter RESET_TYPE = "ASY";

input reset;
input clk;
input [width-1:0] in;
output [width-1:0] out;

genvar i;

generate

if(length>0)
begin
	reg [width-1:0] reg_mem [length-1:0];
	for(i=0;i<length;i=i+1)
	begin: reg_mem_gen
	//SYN RESET
	if(RESET_TYPE == "SYN")
		always@(posedge clk)
		if(reset)
			reg_mem[i] <= {width{1'b0}};
		else
			if(i==0)
				reg_mem[i] <= in;
			else
				reg_mem[i] <= reg_mem[i-1];
	//-----------------------------
	//ASY RESET
	else
		always@(posedge clk or posedge reset)
		if(reset)
			reg_mem[i] <= {width{1'b0}};
		else
			if(i==0)
				reg_mem[i] <= in;
			else
				reg_mem[i] <= reg_mem[i-1];
		end
	assign out = reg_mem[length-1];
end
else
	assign out = in;//без конвееризации

endgenerate


endmodule
