`timescale 1ns / 1ps
module testbench();
    reg  [7:0] capture_data_p;
    reg  [7:0] capture_data_n;
//    reg  [7:0] iddr_data_even;
//    reg  [7:0] iddr_data_odd;
    reg  clk_out_p;
    reg  clk_out_n;
    reg [15:0] ADC_data;
    reg rst;
    


LVDS_capture LVDS_capture(
    .capture_data_p (capture_data_p),
    .capture_data_n (capture_data_n),
    .clk_out_p (clk_out_p),
    .clk_out_n (clk_out_n),
    .ADC_data(ADC_data),
    .rst(rst)
 );  




    
initial

begin
rst = 1;
#5
rst = 0;
#150
//iddr_data_even  = 8'b 00000000;
//iddr_data_odd  = 8'b 00000000;
capture_data_p = 8'b 00000000;
capture_data_n = 8'b 00000000;

clk_out_p = 0;
clk_out_n = 1;

#10

#2
capture_data_p = 8'b 00000001;
capture_data_n = 8'b 11111110;
#2
capture_data_p = 8'b 00000000;
capture_data_n = 8'b 11111111;
#2
capture_data_p = 8'b 00000010;
capture_data_n = 8'b 11111101;
#2
capture_data_p = 8'b 00000011;
capture_data_n = 8'b 11111100;
#2
capture_data_p = 8'b 00000101;
capture_data_n = 8'b 11111010;
#2
capture_data_p = 8'b 00000110;
capture_data_n = 8'b 11111001;
#2
capture_data_p = 8'b 00000111;
capture_data_n = 8'b 11111000;
#2
capture_data_p = 8'b 00000111;
capture_data_n = 8'b 11111000;
#2
capture_data_p = 8'b 00000101;
capture_data_n = 8'b 11111010;
#2
capture_data_p = 8'b 00000011;
capture_data_n = 8'b 11111100;
#2
capture_data_p = 8'b 00000010;
capture_data_n = 8'b 11111101;
#2
capture_data_p = 8'b 00000001;
capture_data_n = 8'b 11111110;
#2
capture_data_p = 8'b 00000001;
capture_data_n = 8'b 11111110;
#2
capture_data_p = 8'b 00000000;
capture_data_n = 8'b 11111111;
#2
capture_data_p = 8'b 00000010;
capture_data_n = 8'b 11111101;
#2
capture_data_p = 8'b 00000011;
capture_data_n = 8'b 11111100;
#2
capture_data_p = 8'b 00000101;
capture_data_n = 8'b 11111010;
#2
capture_data_p = 8'b 00000110;
capture_data_n = 8'b 11111001;
#2
capture_data_p = 8'b 00000111;
capture_data_n = 8'b 11111000;
#2
capture_data_p = 8'b 00000111;
capture_data_n = 8'b 11111000;
#2
capture_data_p = 8'b 00000101;
capture_data_n = 8'b 11111010;
#2
capture_data_p = 8'b 00000011;
capture_data_n = 8'b 11111100;
#2
capture_data_p = 8'b 00000010;
capture_data_n = 8'b 11111101;
#2
capture_data_p = 8'b 00000001;
capture_data_n = 8'b 11111110;
end 


always begin
#1 clk_out_p = ! clk_out_p; 
#1 clk_out_n = ! clk_out_n;   
end
endmodule
