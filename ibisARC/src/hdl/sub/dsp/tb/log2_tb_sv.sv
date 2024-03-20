`timescale 1ns/1ns
module log2_tb_sv();
`include "math.v"

reg clk = 1;

always #5 clk = !clk;

integer x=1;
integer log_x;
integer log_x_clog2;

initial begin
	forever begin
		log_x       = log2(x);
		log_x_clog2 = $clog2(x);
		@(posedge clk)
		x = x + 1;
	end
end

endmodule