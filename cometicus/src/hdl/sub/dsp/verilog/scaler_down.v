//модуль управляемого понижения разрядности
module scaler_down(
	clk,
	resetn,
	in,
	out,
	scale
);

parameter IN_WIDTH = 1;//IN_WIDTH > OUT_WIDTH
parameter OUT_WIDTH = 1;
parameter SCALE_WIDTH = 1;

input  clk;
input  resetn;
input  signed [IN_WIDTH-1:0] in;
output signed [OUT_WIDTH-1:0] out;
input  [SCALE_WIDTH-1:0] scale;

reg signed [OUT_WIDTH-1:0] out;

always@(posedge clk or negedge resetn)
if(resetn == 0)
	out <= 0;
else
	out <= $signed($signed(in) >>> scale);


endmodule