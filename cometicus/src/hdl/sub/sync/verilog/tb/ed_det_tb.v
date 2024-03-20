`timescale 1ns/1ns
module ed_det_tb();

parameter TYPE = "ed";
parameter RESET_TYPE = "SYN";
parameter RESET_POL = "NEG";
parameter IN_RESET_VALUE = 0;
parameter OUT_RESET_VALUE = 1'b1;
parameter FLIP_EN = 1;

reg clk = 1;
reg reset;
reg in_asy=0;
reg in;

always #5 clk = !clk;

initial begin
if(RESET_POL=="POS")
reset = 0;
else
reset = 1'b1;
#22
reset = !reset;
#20
reset = !reset;
end

always #200 in_asy = !in_asy;
always@(posedge clk)
in <= in_asy;


ed_det#(
	.TYPE            (TYPE),           //"ed"-default,"ris","fal"
	.RESET_TYPE      (RESET_TYPE),     // "SYN" or "ASY"(def="ASY")
	.RESET_POL       (RESET_POL),      // "POS" or "NEG"(def="POS")
	.IN_RESET_VALUE  (IN_RESET_VALUE), // 0(def) or 1'b1//значение на входе во время reset
	.OUT_RESET_VALUE (OUT_RESET_VALUE) // 0(def) or 1'b1//значение на выходе во время reset
)
ed_det_inst(
	.clk   (clk),
	.reset (reset),
	.in    (in),
	.out   ()
);

endmodule