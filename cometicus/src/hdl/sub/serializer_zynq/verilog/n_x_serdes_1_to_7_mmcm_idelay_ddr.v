//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
//////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Filename: n_x_serdes_1_to_7_mmcm_idelay_ddr.v
//  /   /        Date Last Modified:  May 30th 2012
// /___/   /\    Date Created: March 5 2010
// \   \  /  \
//  \___\/\___\
// 
//Device: 	7 Series
//Purpose:  	Wrapper for multiple 1 to 7 receiver clock and data receiver using one MMCM for clock multiplication
//
//Reference:	XAPP585.pdf
//    
//Revision History:
//    Rev 1.0 - First created (nicks)
//////////////////////////////////////////////////////////////////////////////
//
//  Disclaimer: 
//
//		This disclaimer is not a license and does not grant any rights to the materials 
//              distributed herewith. Except as otherwise provided in a valid license issued to you 
//              by Xilinx, and to the maximum extent permitted by applicable law: 
//              (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, 
//              AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
//              INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR 
//              FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether in contract 
//              or tort, including negligence, or under any other theory of liability) for any loss or damage 
//              of any kind or nature related to, arising under or in connection with these materials, 
//              including for any direct, or any indirect, special, incidental, or consequential loss 
//              or damage (including loss of data, profits, goodwill, or any type of loss or damage suffered 
//              as a result of any action brought by a third party) even if such damage or loss was 
//              reasonably foreseeable or Xilinx had been advised of the possibility of the same.
//
//  Critical Applications:
//
//		Xilinx products are not designed or intended to be fail-safe, or for use in any application 
//		requiring fail-safe performance, such as life-support or safety devices or systems, 
//		Class III medical devices, nuclear facilities, applications related to the deployment of airbags,
//		or any other applications that could lead to death, personal injury, or severe property or 
//		environmental damage (individually and collectively, "Critical Applications"). Customer assumes 
//		the sole risk and liability of any use of Xilinx products in Critical Applications, subject only 
//		to applicable laws and regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.
//
//////////////////////////////////////////////////////////////////////////////

`timescale 1ps/1ps
`include "global_param.v"
module n_x_serdes_1_to_7_mmcm_idelay_ddr (clkin_p,
		`ifndef SINGLE_CLK_DESER
		clkin_n,
		`endif
		datain_p, datain_n, enable_phase_detector, rxclk, idelay_rdy, reset, pixel_clk, refclk,
                                          mmcm_locked, rx_mmcm_lckdps, rx_mmcm_lckd, rx_mmcm_lckdpsbs, clk_data, rx_data, status, debug, bit_rate_value, bit_time_value) ;

parameter integer 	N = 8 ;				// Set the number of channels
parameter integer 	D = 6 ;   			// Parameter to set the number of data lines per channel
parameter integer      	MMCM_MODE = 1 ;   		// Parameter to set multiplier for MMCM either 1 or 2 to get VCO in correct operating range. 1 multiplies clock by 7, 2 multiplies clock by 14
parameter real 	  	CLKIN_PERIOD = 6.000 ;		// clock period (ns) of input clock on clkin_p
parameter real      	REF_FREQ = 200.0 ;   		// Parameter to set reference frequency used by idelay controller
parameter 		HIGH_PERFORMANCE_MODE = "FALSE";// Parameter to set HIGH_PERFORMANCE_MODE of input delays to reduce jitter
parameter         	DIFF_TERM = "FALSE" ; 		// Parameter to enable internal differential termination
parameter         	SAMPL_CLOCK = "BUFIO" ;   	// Parameter to set sampling clock buffer type, BUFIO, BUF_H, BUF_G
parameter         	INTER_CLOCK = "BUF_R" ;      	// Parameter to set intermediate clock buffer type, BUFR, BUF_H, BUF_G
parameter         	PIXEL_CLOCK = "BUF_G" ;       	// Parameter to set pixel clock buffer type, BUF_R, BUF_H, BUF_G
parameter         	USE_PLL = "FALSE" ;          	// Parameter to enable PLL use rather than MMCM use, overides SAMPL_CLOCK and INTER_CLOCK to be both BUFH
parameter         	DATA_FORMAT = "PER_CLOCK" ;     // Parameter Used to determine method for mapping input parallel word to output serial words
parameter           CLK_MULT = 1;//умножение входных клоков, если FR=ENC/2

parameter CLK_PATT_1 = 7'b1100001;
parameter CLK_PATT_2 = 7'b1100011;
parameter [D-1:0] RX_SWAP_MASK     = 16'h0000;
parameter         RX_CLK_SWAP_MASK = 1'b0;
                                       	
input 	[N-1:0]		clkin_p ;			// Input from LVDS clock receiver pin
`ifndef SINGLE_CLK_DESER
input 	[N-1:0]		clkin_n ;			// Input from LVDS clock receiver pin
`endif
input 	[N*D-1:0]	datain_p ;			// Input from LVDS clock data pins
input 	[N*D-1:0]	datain_n ;			// Input from LVDS clock data pins
input 			enable_phase_detector ;		// Enables the phase detector logic when high
input 			reset ;				// Reset line
input			idelay_rdy ;			// input delays are ready
output 			rxclk ;				// Global/BUFIO rx clock network
output 			pixel_clk ;			// Global/Regional clock output
output 			refclk;
output 			mmcm_locked;
output 			rx_mmcm_lckd ; 			// MMCM locked, synchronous to rxclk_d4
output 			rx_mmcm_lckdps ; 		// MMCM locked and phase shifting finished, synchronous to rxclk_d4
output 	[N-1:0]		rx_mmcm_lckdpsbs ; 		// MMCM locked and phase shifting finished and bitslipping finished, synchronous to pixel_clk
output 	[7*N-1:0]	clk_data ;	 		// Clock Data
output 	[N*D*7-1:0]	rx_data ;	 		// Received Data
output 	[(10*D+6)*N-1:0]debug ;	 			// debug info
output 	[6:0]		status ;	 		// clock status
input 	[15:0]		bit_rate_value ;	 	// Bit rate in Mbps, for example 16'h0585
output	[4:0]		bit_time_value ;		// Calculated bit time value for slave devices

wire			rxclk_d4 ;
wire 	[N*D*7-1:0]	rx_data_mix;	 		// Received Data

serdes_1_to_7_mmcm_idelay_ddr #(
    .CLK_PATT_1             (CLK_PATT_1),
    .CLK_PATT_2             (CLK_PATT_2),
    .CLK_MULT               (CLK_MULT),
    .SAMPL_CLOCK		    (SAMPL_CLOCK),
    .INTER_CLOCK		    (INTER_CLOCK),
    .PIXEL_CLOCK		    (PIXEL_CLOCK),
    .USE_PLL		        (USE_PLL),
    .REF_FREQ		        (REF_FREQ),
    .HIGH_PERFORMANCE_MODE 	(HIGH_PERFORMANCE_MODE),
    .D			            (D),				// Number of data lines
    .CLKIN_PERIOD		    (CLKIN_PERIOD),			// Set input clock period
    .MMCM_MODE		        (MMCM_MODE),			// Set mmcm vco, either 1 or 2
    .DIFF_TERM		        (DIFF_TERM),
    .DATA_FORMAT		    (DATA_FORMAT),
    .RX_SWAP_MASK           (RX_SWAP_MASK),
    .RX_CLK_SWAP_MASK       (RX_CLK_SWAP_MASK)
)rx0 (
	.clkin_p   		(clkin_p[0]),
	`ifndef SINGLE_CLK_DESER
	.clkin_n   		(clkin_n[0]),
	`endif
	.datain_p     		(datain_p[D-1:0]),
	.datain_n     		(datain_n[D-1:0]),
	.enable_phase_detector	(enable_phase_detector),
	.rxclk    		(rxclk),
	.idelay_rdy		(idelay_rdy),
	.pixel_clk		(pixel_clk),
	.refclk			(refclk),
	.rxclk_d4		(rxclk_d4),
	.reset     		(reset),
	.mmcm_locked	(mmcm_locked),
	.rx_mmcm_lckd		(rx_mmcm_lckd),
	.rx_mmcm_lckdps		(rx_mmcm_lckdps),
	.rx_mmcm_lckdpsbs	(rx_mmcm_lckdpsbs[0]),
	.clk_data  		(clk_data[6:0]),
	.rx_data		(rx_data_mix[7*D-1:0]),
	.bit_rate_value		(bit_rate_value),
	.bit_time_value		(bit_time_value),
	.status			(status),
	.debug			(debug[10*D+5:0]));

genvar i ;
genvar j ;
genvar k ;

generate
for (i = 1 ; i <= (N-1) ; i = i+1)
begin : loop0

serdes_1_to_7_slave_idelay_ddr #(
	.CLK_PATT_1             (CLK_PATT_1),
	.CLK_PATT_2             (CLK_PATT_2),
      	.D			        (D),				// Number of data lines
	.REF_FREQ		        (REF_FREQ),
	.HIGH_PERFORMANCE_MODE 	(HIGH_PERFORMANCE_MODE),
	.DIFF_TERM		        (DIFF_TERM),
      	.DATA_FORMAT		(DATA_FORMAT))
rxn (
	.clkin_p   		(clkin_p[i]),
	`ifndef SINGLE_CLK_DESER
	.clkin_n   		(clkin_n[i]),
	`endif
	.datain_p     		(datain_p[D*(i+1)-1:D*i]),
	.datain_n     		(datain_n[D*(i+1)-1:D*i]),
	.enable_phase_detector	(enable_phase_detector),
	.rxclk    		(rxclk),
	.idelay_rdy		(idelay_rdy),
	.pixel_clk		(pixel_clk),
	.rxclk_d4		(rxclk_d4),
	.reset     		(~rx_mmcm_lckdps),
	.bitslip_finished	(rx_mmcm_lckdpsbs[i]),
	.clk_data  		(clk_data[7*i+6:7*i]),
	.rx_data		(rx_data_mix[(D*(i+1)*7)-1:D*i*7]),
	.bit_time_value		(bit_time_value),
	.debug			(debug[(10*D+6)*(i+1)-1:(10*D+6)*i]));

end
endgenerate

generate
// for(k=0;k<N;k=k+1)
// begin: loop_chan_mix
	for(j=0;j<D;j=j+1)
	begin: loop_lane_mix
		for(i=0;i<7;i=i+1)
		begin: loop_bit_mix
			assign rx_data[j*7+i] = rx_data_mix[j*7+6-i];
		end
	end
// end
endgenerate

endmodule
