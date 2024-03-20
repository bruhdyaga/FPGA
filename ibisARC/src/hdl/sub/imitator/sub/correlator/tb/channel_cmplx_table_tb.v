`timescale 1ns/1ns
module channel_cmplx_table_tb();

reg clk = 1;
reg reset;
reg [4:0] cntr;

always #5 clk = !clk;

initial
begin
reset = 0;
#50 reset = 1;
#50 reset = 0;
end

always@(posedge clk or posedge reset)
if(reset)
	cntr <= 0;
else
	cntr <= cntr + 1'b1;

channel_cmplx_table CHCMPLT (
	.clk               (clk),
	.reset_n           (!reset),
	.adc_re            (0),
	.adc_im            (0),
	.cos_product       (cntr),
	.sin_product       (cntr),		
	.phase_addr        (0),
	.cmplx_product_re  (),  
	.cmplx_product_im  ()
);

endmodule