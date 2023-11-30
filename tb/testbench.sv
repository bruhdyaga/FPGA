`timescale 1ns / 1ps
module testbench();
    reg  [7:0] capture_data_p;
    reg  [7:0] capture_data_n;
    reg  clk_out_p;
    reg  clk_out_n;
    wire [15:0] final_output;
    reg rst;


LVDS_capture LVDS_capture(
    .capture_data_p (capture_data_p),
    .capture_data_n (capture_data_n),
    .clk_out_p (clk_out_p),
    .clk_out_n (clk_out_n),
    .final_output(final_output),
    .rst(rst)
 );  




    
initial

begin
capture_data_p = 8'b 00000000;
capture_data_n = 8'b 00000000;

clk_out_p = 0;
clk_out_n = 1;
rst = 1;
#1
rst = 0;
#10
#4
capture_data_p = 8'b 00000001;
capture_data_n = 8'b 11111110;
#4
capture_data_p = 8'b 00000000;
capture_data_n = 8'b 11111111;
#4
capture_data_p = 8'b 00000010;
capture_data_n = 8'b 11111101;
#4
capture_data_p = 8'b 00000011;
capture_data_n = 8'b 11111100;
#4
capture_data_p = 8'b 00000101;
capture_data_n = 8'b 11111010;
#4
capture_data_p = 8'b 00000110;
capture_data_n = 8'b 11111001;
#4
capture_data_p = 8'b 00000111;
capture_data_n = 8'b 11111000;
#4
capture_data_p = 8'b 00000111;
capture_data_n = 8'b 11111000;
#4
capture_data_p = 8'b 00000101;
capture_data_n = 8'b 11111010;
#4
capture_data_p = 8'b 00000011;
capture_data_n = 8'b 11111100;
#4
capture_data_p = 8'b 00000010;
capture_data_n = 8'b 11111101;
#4
capture_data_p = 8'b 00000001;
capture_data_n = 8'b 11111110;
end 
always begin
#2 clk_out_p = ! clk_out_p; 
#2 clk_out_n = ! clk_out_n;   
end
endmodule
