`timescale 1ns/1ns
module scaler_down_tb();

parameter IN_WIDTH = 14;//IN_WIDTH > OUT_WIDTH
parameter OUT_WIDTH = 8;
parameter SCALE_WIDTH = 5;

reg clk = 1;
reg resetn;
reg [IN_WIDTH-1:0] cntr_in;
wire [OUT_WIDTH-1:0] out;
wire [IN_WIDTH-1:0] sin_out;

always #1 clk = !clk;

initial begin
resetn = 1'b1;
#40 resetn = !resetn;
#40 resetn = !resetn;
end

always@(posedge clk or negedge resetn)
if(resetn == 0)
	cntr_in <= 0;
else
	cntr_in <= cntr_in + 1'b1;

sin_gen#(
	.NSIN      (4),
	.NTABLE    (5),
	.OUT_WIDTH (IN_WIDTH)
)
sin_gen_inst(
	.clk       (clk),
	.aresetn   (resetn),
	.syn_reset (1'b0),
	.code_freq (2**26),
	.sin_out   (sin_out),
	.scale     (IN_WIDTH-4),
	.cnt_ena   (1'b1)//разрешение на работу счетчика фазы
);

scaler_down#(
	.IN_WIDTH    (IN_WIDTH),
	.OUT_WIDTH   (OUT_WIDTH),
	.SCALE_WIDTH (SCALE_WIDTH)
)
scaler_down_inst(
	.clk    (clk),
	.resetn (resetn),
	.in     (sin_out),
	.out    (out),
	.scale  (5'd6)
);

endmodule