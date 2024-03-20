`timescale 1ns/10ps

`include "global_param.v"

module correlator (
    clk,
    pclk,
    reset_n,
    wr_en,
    rd_en,
    reg_addr,
    wdata,
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
    intr_pulse,
    fix_pulse,
    rdata    
    );

    input clk;
    input pclk;
    input reset_n;
    input wr_en;
    input rd_en;
    input [`ADDR_WIDTH - 1 : 0] reg_addr;
    input [31 : 0] wdata;
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
    input intr_pulse;
    input fix_pulse;
    output [31 : 0] rdata;

    parameter BASE_ADDR = `ADDR_WIDTH'h8000;

    wire [31 : 0] rdata_int [`CHANNELS - 1 : 0];
    wire [31 : 0] rdata_ch [`CHANNELS - 1 : 0];
    
    genvar iCh;  
    
    generate
        for (iCh = 0; iCh < `CHANNELS; iCh = iCh + 1) begin:CH
            correlator_channel
            #(BASE_ADDR + (iCh << 6)) CH ( 
                .clk          (clk),
                .pclk         (pclk),
                .reset_n      (reset_n),
                .we_en        (wr_en),
                .rd_en        (rd_en),
                .reg_addr     (reg_addr),
                .wdata        (wdata),
                .imi_in       (imi_in),
                .adc0_in_re   (adc0_in_re),
				.adc1_in_re   (adc1_in_re),
				.adc2_in_re   (adc2_in_re),
				.adc3_in_re   (adc3_in_re),
				.adc4_in_re   (adc4_in_re),
				.adc5_in_re   (adc5_in_re),
				.adc6_in_re   (adc6_in_re),
				.adc7_in_re   (adc7_in_re),
				.adc8_in_re   (adc8_in_re),
				.adc9_in_re   (adc9_in_re),
				.adc10_in_re  (adc10_in_re),
				.adc11_in_re  (adc11_in_re),
				.adc0_in_im   (adc0_in_im),
				.adc1_in_im   (adc1_in_im),
				.adc2_in_im   (adc2_in_im),
				.adc3_in_im   (adc3_in_im),
				.adc4_in_im   (adc4_in_im),
				.adc5_in_im   (adc5_in_im),
				.adc6_in_im   (adc6_in_im),
				.adc7_in_im   (adc7_in_im),
				.adc8_in_im   (adc8_in_im),
				.adc9_in_im   (adc9_in_im),
				.adc10_in_im  (adc10_in_im),
				.adc11_in_im  (adc11_in_im),                
                .intr_pulse   (intr_pulse), 
                .fix_pulse    (fix_pulse),
                .rdata        (rdata_ch[iCh])
            );
    
            if (iCh != 0) begin
                assign rdata_int[iCh] = rdata_int[iCh - 1] | rdata_ch[iCh];
            end
            else begin
                assign rdata_int[iCh] = rdata_ch[iCh];
            end
        end
    endgenerate
    
    assign rdata = rdata_int[`CHANNELS - 1];  
  
endmodule
