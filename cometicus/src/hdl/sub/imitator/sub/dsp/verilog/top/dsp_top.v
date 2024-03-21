`timescale 1ns / 1ps

module dsp_top();
	
    reg clk = 0;
    reg reset_n = 1;
    wire signed [9:0] awgn;

    randn   
    AWGN (
        .clk        (clk),          // [in] 
        .reset_n    (reset_n), 
        .out        (awgn)          // [out]
    );
endmodule
