`timescale 1ns/10ps

`include "global_param.v"

module signal_mux (
	pclk,
	reset_n,
    input_reg,
    dig0_in,
    dig1_in,
    adc0_in,
    adc1_in,
    adc2_in,
    adc3_in,
    adc4_in,
    adc5_in,
    adc6_in,
    imi_in,
    rej_in,
    re_in,
    im_in,
    signal_out_re,
    signal_out_im
    );
	
	input pclk;
	input reset_n;
    input [3 : 0] input_reg;
    input [1 : 0] dig0_in;
    input [1 : 0] dig1_in;
    input [1 : 0] adc0_in;
    input [1 : 0] adc1_in;
    input [1 : 0] adc2_in;
    input [1 : 0] adc3_in;
    input [1 : 0] adc4_in;
    input [1 : 0] adc5_in;
    input [1 : 0] adc6_in;
    input [1 : 0] imi_in;
    input [1 : 0] rej_in;
    input [2 * `NUM_ACCUM - 1 : 0] re_in;
    input [2 * `NUM_ACCUM - 1 : 0] im_in;
    output [2 * `NUM_ACCUM - 1 : 0] signal_out_re;    
    output [2 * `NUM_ACCUM - 1 : 0] signal_out_im;
    
    reg [2 * `NUM_ACCUM - 1 : 0] signal_out_re_int; 
    reg [2 * `NUM_ACCUM - 1 : 0] signal_out_im_int;
    reg [2 * `NUM_ACCUM - 1 : 0] signal_out_re; 
    reg [2 * `NUM_ACCUM - 1 : 0] signal_out_im;
    
    always @(*) begin
        case (input_reg)
            4'b0000   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, imi_in};
            4'b0001   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, dig0_in};
            4'b0010   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, dig1_in};
            4'b0100   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, rej_in};
            4'b1000   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc0_in};
            4'b1001   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc1_in};
            4'b1010   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc2_in};
            4'b1100   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc3_in};
            4'b1101   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc4_in};
            4'b1110   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc5_in};
            4'b1111   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc6_in};
            4'b1011   : signal_out_re_int = re_in;
            default : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, imi_in};
        endcase
    end
    
    always @(*) begin
        case (input_reg)
            4'b0000   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, imi_in};
            4'b0001   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, dig0_in};
            4'b0010   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, dig1_in};
            4'b0100   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, rej_in};
            4'b1000   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc0_in};
            4'b1001   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc1_in};
            4'b1010   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc2_in};            
            4'b1100   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc3_in};
            4'b1101   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc4_in};
            4'b1110   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc5_in};
            4'b1111   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, adc6_in};
            4'b1011   : signal_out_im_int = im_in;
            default : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, imi_in};
        endcase
    end
    
    always @ (posedge pclk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            signal_out_re <= {(2 * `NUM_ACCUM - 2){1'b0}};
            signal_out_im <= {(2 * `NUM_ACCUM - 2){1'b0}};
        end
        else begin
        	signal_out_re <= signal_out_re_int;            
        	signal_out_im <= signal_out_im_int;
        end
    end

endmodule
