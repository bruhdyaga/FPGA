`timescale 1ns / 1ps
module latency_tb(

);

parameter LENGTH =8;
reg clk = 1;        
reg in_asy=0;
reg in;
wire out_reg;
                         


//always #50 length = !length;
always #5 clk = !clk;  // задаётся частота клока
always #200 in_asy = !in_asy;    // частота входных импульсов
always@(posedge clk)            
in <= in_asy;

latency#(
    .length(LENGTH)
)
latency_inst (
	.clk   (clk),
	.in    (in),
	.out   (out_reg)
);
    
endmodule

