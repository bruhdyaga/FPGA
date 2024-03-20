`timescale 1ns/10ps

`include "global_param.v"

module signal_mux_adc (
		pclk,
		reset_n,
		input_reg_re,
		input_reg_im,
		imi_in,
		adc0_in_re,
		adc1_in_re,
		adc2_in_re,
		adc3_in_re,
		adc4_in_re,
		adc5_in_re,
		adc6_in_re,
		adc7_in_re,
		adc8_in_re,
		adc9_in_re,
		adc10_in_re,
		adc11_in_re,
		adc0_in_im,
		adc1_in_im,
		adc2_in_im,
		adc3_in_im,
		adc4_in_im,
		adc5_in_im,
		adc6_in_im,
		adc7_in_im,
		adc8_in_im,
		adc9_in_im,
		adc10_in_im,
		adc11_in_im,
		signal_out_re,
		signal_out_im
		);
	
	input pclk;
	input reset_n;
	input [4 : 0] input_reg_re;
	input [4 : 0] input_reg_im;
	input [1 : 0] imi_in;
	input [2 * `NUM_ACCUM - 1 : 0] adc0_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc1_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc2_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc3_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc4_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc5_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc6_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc7_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc8_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc9_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc10_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc11_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc0_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc1_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc2_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc3_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc4_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc5_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc6_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc7_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc8_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc9_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc10_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc11_in_im;
	output [2 * `NUM_ACCUM - 1 : 0] signal_out_re;    
	output [2 * `NUM_ACCUM - 1 : 0] signal_out_im;
    
	reg [2 * `NUM_ACCUM - 1 : 0] signal_out_re_int; 
	reg [2 * `NUM_ACCUM - 1 : 0] signal_out_im_int;
	reg [2 * `NUM_ACCUM - 1 : 0] signal_out_re; 
	reg [2 * `NUM_ACCUM - 1 : 0] signal_out_im;
    
	always @(*) begin
		case (input_reg_re)
			4'b0000   : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, imi_in};
			4'b0001   : signal_out_re_int = adc0_in_re;
			4'b0010   : signal_out_re_int = adc1_in_re;
			4'b0011   : signal_out_re_int = adc2_in_re;
			4'b0100   : signal_out_re_int = adc3_in_re;
			4'b0101   : signal_out_re_int = adc4_in_re;
			4'b0110   : signal_out_re_int = adc5_in_re;
			4'b0111   : signal_out_re_int = adc6_in_re;
			4'b1000   : signal_out_re_int = adc7_in_re;
			4'b1001   : signal_out_re_int = adc8_in_re;
			4'b1010   : signal_out_re_int = adc9_in_re;
			4'b1011   : signal_out_re_int = adc10_in_re;
			4'b1100   : signal_out_re_int = adc11_in_re;
			default : signal_out_re_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, imi_in};
		endcase
	end
    
	always @(*) begin
		case (input_reg_im)
			4'b0000   : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, imi_in};
			4'b0001   : signal_out_im_int = adc0_in_im;
			4'b0010   : signal_out_im_int = adc1_in_im;
			4'b0011   : signal_out_im_int = adc2_in_im;
			4'b0100   : signal_out_im_int = adc3_in_im;
			4'b0101   : signal_out_im_int = adc4_in_im;
			4'b0110   : signal_out_im_int = adc5_in_im;
			4'b0111   : signal_out_im_int = adc6_in_im;
			4'b1000   : signal_out_im_int = adc7_in_im;
			4'b1001   : signal_out_im_int = adc8_in_im;
			4'b1010   : signal_out_im_int = adc9_in_im;
			4'b1011   : signal_out_im_int = adc10_in_im;
			4'b1100   : signal_out_im_int = adc11_in_im;
			default : signal_out_im_int = {{(2 * `NUM_ACCUM - 2){1'b0}}, imi_in};
		endcase
	end
    
	always @ (posedge pclk or negedge reset_n) begin
		if (reset_n == 1'b0) begin
			signal_out_re <= {(2 * `NUM_ACCUM){1'b0}};
			signal_out_im <= {(2 * `NUM_ACCUM){1'b0}};
		end
		else begin
			signal_out_re <= signal_out_re_int;            
			signal_out_im <= signal_out_im_int;
		end
	end

endmodule
