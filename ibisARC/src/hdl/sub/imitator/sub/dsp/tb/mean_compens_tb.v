`timescale 1ns/1ns
module mean_compens_tb(
);

reg clk = 1;
reg reset;
reg [13:0] cntr;

always #5 clk = !clk;

initial
begin
    reset = 0;
#50 reset = 1;
#40 reset = 0;
end

always@(posedge clk or posedge reset)
if(reset)
	cntr <= 0;
else
	cntr <= cntr + 1'b1;


mean_compens mean_compens_inst(
	.clk     (clk),
	.reset   (reset),
	.DAT_in  (cntr),
	.DAT_out ()
);


endmodule