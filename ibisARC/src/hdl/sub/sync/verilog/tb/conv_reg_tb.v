`timescale 1ns / 1ps

module conv_reg_tb();

parameter width      = 'b1111;
parameter length     = 'b0;
parameter INIT_STATE = 'b1;

reg clk = 1;
reg [width-1:0] in = 0;
wire [width-1:0] out ;

always #10 clk = !clk;
always #40 in [width-1:0] = in [width-1:0] + 1 ;

conv_reg#(
    .width        (width),
    .length       (length),
    .INIT_STATE   (INIT_STATE)
) 
CONV_REG(
    .clk    (clk),
    .in     (in),
    .out    (out)
); 
endmodule