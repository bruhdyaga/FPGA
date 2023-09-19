`timescale 1ns / 1ps
module tb();

logic clk;
logic KEY0;
logic KEY1;
logic KEY2;
// wires                                               
logic [6:0]  HEX0;
logic [6:0]  HEX1;
logic [6:0]  HEX2;
logic [6:0]  HEX3;

main tb( .clk(clk), .KEY0(KEY0), .KEY1(KEY1), .KEY2(KEY2), .LED_RED(LED_RED), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3));


initial 

begin

clk = 1'b0;
KEY0 = 1'b0;

#50;

KEY1 = 1'b1;


end

always 
  #5  clk =  ! clk; 
  
endmodule 