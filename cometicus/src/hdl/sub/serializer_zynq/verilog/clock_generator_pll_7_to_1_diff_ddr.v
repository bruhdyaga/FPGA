///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Filename: clock_generator_pll_7_to_1_diff_ddr.v
//  /   /        Date Last Modified:  May 30th 2012
// /___/   /\    Date Created: January 5 2010
// \   \  /  \
//  \___\/\___\
// 
//Device: 	7 Series
//Purpose:  	DDR MMCM Based clock generator. Takes in a differential clock and multiplies it
//	    	appropriately 
//Reference:	XAPP585.pdf
//    
//Revision History:
//    Rev 1.0 - First created (nicks)
///////////////////////////////////////////////////////////////////////////////
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

module clock_generator_pll_7_to_1_diff_ddr (clkin_p, clkin_n, txclk, reset, pixel_clk, txclk_div, mmcm_lckd, status) ;

parameter real 	  	CLKIN_PERIOD = 6.000 ;		// clock period (ns) of input clock on clkin_p
parameter         	DIFF_TERM = "FALSE" ; 		// Parameter to enable internal differential termination
parameter integer      	MMCM_MODE = 1 ;   		// Parameter to set multiplier for MMCM either 1 or 2 to get VCO in correct operating range. 1 multiplies clock by 7, 2 multiplies clock by 14
parameter         	TX_CLOCK = "BUFIO" ;   		// Parameter to set transmission clock buffer type, BUFIO, BUF_H, BUF_G
parameter         	INTER_CLOCK = "BUF_R" ;      	// Parameter to set intermediate clock buffer type, BUFR, BUF_H, BUF_G
parameter         	PIXEL_CLOCK = "BUF_G" ;       	// Parameter to set final clock buffer type, BUF_R, BUF_H, BUF_G
parameter         	USE_PLL = "FALSE" ;          	// Parameter to enable PLL use rather than MMCM use, note, PLL does not support BUFIO and BUFR

input			reset ;				// reset (active high)
input			clkin_p, clkin_n ;		// differential clock inputs
output			txclk ;				// CLK for serdes
output			pixel_clk ;			// Pixel clock output
output			txclk_div ;			// CLKDIV for serdes, and gearbox output = pixel clock / 2
output			mmcm_lckd ;			// Locked output from BUFPLL
output 	[6:0]		status ;	 		// clock status
                	
wire 			clkint ;			// clock input from pin
wire    		mmcmout_x1 ;      		// pll generated x1 clock
wire    		mmcmout_xn ;      		// pll generated xn clock

IBUFGDS #(
	.DIFF_TERM 		(DIFF_TERM)) 
clk_iob_in (
	.I    			(clkin_p),
	.IB       		(clkin_n),
	.O         		(clkint));

generate
if (USE_PLL == "FALSE") begin : loop8					// use an MMCM
assign status[6] = 1'b1 ; 
     
MMCME2_ADV #(
      .BANDWIDTH		("OPTIMIZED"),  		// "high", "low" or "optimized"
      .CLKFBOUT_MULT_F		(7*MMCM_MODE),       		// multiplication factor for all output clocks
      .CLKFBOUT_PHASE		(0.0),     			// phase shift (degrees) of all output clocks
      .CLKIN1_PERIOD		(CLKIN_PERIOD),  		// clock period (ns) of input clock on clkin1
      .CLKIN2_PERIOD		(CLKIN_PERIOD),  		// clock period (ns) of input clock on clkin2
      .CLKOUT0_DIVIDE_F		(2*MMCM_MODE),       		// division factor for clkout0 (1 to 128)
      .CLKOUT0_DUTY_CYCLE	(0.5), 				// duty cycle for clkout0 (0.01 to 0.99)
      .CLKOUT0_PHASE		(0.0), 				// phase shift (degrees) for clkout0 (0.0 to 360.0)
      .CLKOUT1_DIVIDE		(14*MMCM_MODE),   		// division factor for clkout1 (1 to 128)
      .CLKOUT1_DUTY_CYCLE	(0.5), 				// duty cycle for clkout1 (0.01 to 0.99)
      .CLKOUT1_PHASE		(0.0), 				// phase shift (degrees) for clkout1 (0.0 to 360.0)
      .CLKOUT2_DIVIDE		(7*MMCM_MODE),   		// division factor for clkout2 (1 to 128)
      .CLKOUT2_DUTY_CYCLE	(0.5), 				// duty cycle for clkout2 (0.01 to 0.99)
      .CLKOUT2_PHASE		(0.0), 				// phase shift (degrees) for clkout2 (0.0 to 360.0)
      .CLKOUT3_DIVIDE		(8),   				// division factor for clkout3 (1 to 128)
      .CLKOUT3_DUTY_CYCLE	(0.5), 				// duty cycle for clkout3 (0.01 to 0.99)
      .CLKOUT3_PHASE		(0.0), 				// phase shift (degrees) for clkout3 (0.0 to 360.0)
      .CLKOUT4_DIVIDE		(8),   				// division factor for clkout4 (1 to 128)
      .CLKOUT4_DUTY_CYCLE	(0.5), 				// duty cycle for clkout4 (0.01 to 0.99)
      .CLKOUT4_PHASE		(0.0),      			// phase shift (degrees) for clkout4 (0.0 to 360.0)
      .CLKOUT5_DIVIDE		(8),       			// division factor for clkout5 (1 to 128)
      .CLKOUT5_DUTY_CYCLE	(0.5), 				// duty cycle for clkout5 (0.01 to 0.99)
      .CLKOUT5_PHASE		(0.0),      			// phase shift (degrees) for clkout5 (0.0 to 360.0)
      .COMPENSATION		("ZHOLD"), 			// 
      .DIVCLK_DIVIDE		(1),        			// division factor for all clocks (1 to 52)
      .REF_JITTER1		(0.100))       			// input reference jitter (0.000 to 0.999 ui%)
tx_mmcme2_adv_inst (
      .CLKFBOUT			(mmcmout_x1),              	// x1 clock
      .CLKFBOUTB		(),              		// 
      .CLKFBSTOPPED		(),              		// 
      .CLKINSTOPPED		(),              		// 
      .CLKOUT0			(mmcmout_xn),      		// xn clock for transmitter
      .CLKOUT0B			(),      			// 
      .CLKOUT1			(mmcmout_d2),      		//
      .CLKOUT1B			(),      			// 
      .CLKOUT2			(), 				// 
      .CLKOUT2B			(),      			// 
      .CLKOUT3			(),              		// one of six general clock output signals
      .CLKOUT3B			(),      			// 
      .CLKOUT4			(),              		// one of six general clock output signals
      .CLKOUT5			(),              		// one of six general clock output signals
      .CLKOUT6			(),              		// one of six general clock output signals
      .DO			(),                    		// dynamic reconfig data output (16-bits)
      .DRDY			(),                  		// dynamic reconfig ready output
      .PSDONE			(),  
      .PSCLK			(1'b0),  
      .PSEN			(1'b0),  
      .PSINCDEC			(1'b0),  
      .PWRDWN			(1'b0),  
      .LOCKED			(mmcm_lckd),        		// active high pll lock signal
      .CLKFBIN			(pixel_clk),			// clock feedback input
      .CLKIN1			(clkint),     			// primary clock input
      .CLKIN2			(1'b0),		     		// secondary clock input
      .CLKINSEL			(1'b1),             		// selects '1' = clkin1, '0' = clkin2
      .DADDR			(7'h00),            		// dynamic reconfig address input (7-bits)
      .DCLK			(1'b0),               		// dynamic reconfig clock input
      .DEN			(1'b0),                		// dynamic reconfig enable input
      .DI			(16'h0000),        		// dynamic reconfig data input (16-bits)
      .DWE			(1'b0),                		// dynamic reconfig write enable input
      .RST			(reset)) ;               	// asynchronous pll reset

   if (PIXEL_CLOCK == "BUF_G") begin 						// Final clock selection
      BUFG	bufg_mmcm_x1 (.I(mmcmout_x1), .O(pixel_clk)) ;
      assign status[1:0] = 2'b00 ;
   end
   else if (PIXEL_CLOCK == "BUF_R") begin
      BUFR #(.BUFR_DIVIDE("1"),.SIM_DEVICE("7SERIES"))bufr_mmcm_x1 (.I(mmcmout_x1),.CE(1'b1),.O(pixel_clk),.CLR(1'b0)) ;
      assign status[1:0] = 2'b01 ;
   end
   else begin 
      BUFH	bufh_mmcm_x1 (.I(mmcmout_x1), .O(pixel_clk)) ;
      assign status[1:0] = 2'b10 ;
   end

   if (INTER_CLOCK == "BUF_G") begin 						// Intermediate clock selection
      BUFG	bufg_mmcm_d2 (.I(mmcmout_d2), .O(txclk_div)) ;
      assign status[3:2] = 2'b00 ;
   end
   else if (INTER_CLOCK == "BUF_R") begin
      BUFR #(.BUFR_DIVIDE("1"),.SIM_DEVICE("7SERIES"))bufr_mmcm_d2 (.I(mmcmout_d2),.CE(1'b1),.O(txclk_div),.CLR(1'b0)) ;
      assign status[3:2] = 2'b01 ;
   end
   else begin 
      BUFH	bufh_mmcm_d2 (.I(mmcmout_d2), .O(txclk_div)) ;
      assign status[3:2] = 2'b10 ;
   end
      
   if (TX_CLOCK == "BUF_G") begin						// Sample clock selection
      BUFG	bufg_mmcm_xn (.I(mmcmout_xn), .O(txclk)) ;
      assign status[5:4] = 2'b00 ;
   end
   else if (TX_CLOCK == "BUFIO") begin
      BUFIO  	bufio_mmcm_xn (.I (mmcmout_xn), .O(txclk)) ;
      assign status[5:4] = 2'b11 ;
   end
   else begin 
      BUFH	bufh_mmcm_xn (.I(mmcmout_xn), .O(txclk)) ;
      assign status[5:4] = 2'b10 ;
   end
   
end 
else begin

assign status[6] = 1'b0 ; 

PLLE2_ADV #(
      .BANDWIDTH		("OPTIMIZED"),  		// "high", "low" or "optimized"
      .CLKFBOUT_MULT		(7*MMCM_MODE),       		// multiplication factor for all output clocks
      .CLKFBOUT_PHASE		(0.0),     			// phase shift (degrees) of all output clocks
      .CLKIN1_PERIOD		(CLKIN_PERIOD),  		// clock period (ns) of input clock on clkin1
      .CLKIN2_PERIOD		(CLKIN_PERIOD),  		// clock period (ns) of input clock on clkin2
      .CLKOUT0_DIVIDE		(2*MMCM_MODE),       		// division factor for clkout0 (1 to 128)
      .CLKOUT0_DUTY_CYCLE	(0.5), 				// duty cycle for clkout0 (0.01 to 0.99)
      .CLKOUT0_PHASE		(0.0), 				// phase shift (degrees) for clkout0 (0.0 to 360.0)
      .CLKOUT1_DIVIDE		(14*MMCM_MODE),   		// division factor for clkout1 (1 to 128)
      .CLKOUT1_DUTY_CYCLE	(0.5), 				// duty cycle for clkout1 (0.01 to 0.99)
      .CLKOUT1_PHASE		(0.0), 				// phase shift (degrees) for clkout1 (0.0 to 360.0)
      .CLKOUT2_DIVIDE		(7*MMCM_MODE),   		// division factor for clkout2 (1 to 128)
      .CLKOUT2_DUTY_CYCLE	(0.5), 				// duty cycle for clkout2 (0.01 to 0.99)
      .CLKOUT2_PHASE		(0.0), 				// phase shift (degrees) for clkout2 (0.0 to 360.0)
      .CLKOUT3_DIVIDE		(8),   				// division factor for clkout3 (1 to 128)
      .CLKOUT3_DUTY_CYCLE	(0.5), 				// duty cycle for clkout3 (0.01 to 0.99)
      .CLKOUT3_PHASE		(0.0), 				// phase shift (degrees) for clkout3 (0.0 to 360.0)
      .CLKOUT4_DIVIDE		(8),   				// division factor for clkout4 (1 to 128)
      .CLKOUT4_DUTY_CYCLE	(0.5), 				// duty cycle for clkout4 (0.01 to 0.99)
      .CLKOUT4_PHASE		(0.0),      			// phase shift (degrees) for clkout4 (0.0 to 360.0)
      .CLKOUT5_DIVIDE		(8),       			// division factor for clkout5 (1 to 128)
      .CLKOUT5_DUTY_CYCLE	(0.5), 				// duty cycle for clkout5 (0.01 to 0.99)
      .CLKOUT5_PHASE		(0.0),      			// phase shift (degrees) for clkout5 (0.0 to 360.0)
      .COMPENSATION		("ZHOLD"), 			// 
      .DIVCLK_DIVIDE		(1),        			// division factor for all clocks (1 to 52)
      .REF_JITTER1		(0.100))       			// input reference jitter (0.000 to 0.999 ui%)
tx_mmcme2_adv_inst (
      .CLKFBOUT			(mmcmout_x1),              	// general output feedback signal
      .CLKOUT0			(mmcmout_xn),      		// xn clock for transmitter
      .CLKOUT1			(mmcmout_d2),      		//
      .CLKOUT2			(), 				//
      .CLKOUT3			(),              		// one of six general clock output signals
      .CLKOUT4			(),              		// one of six general clock output signals
      .CLKOUT5			(),              		// one of six general clock output signals
      .DO			(),                    		// dynamic reconfig data output (16-bits)
      .DRDY			(),                  		// dynamic reconfig ready output
      .PWRDWN			(1'b0),  
      .LOCKED			(mmcm_lckd),        		// active high pll lock signal
      .CLKFBIN			(pixel_clk),			// clock feedback input
      .CLKIN1			(clkint),     			// primary clock input
      .CLKIN2			(1'b0),		     		// secondary clock input
      .CLKINSEL			(1'b1),             		// selects '1' = clkin1, '0' = clkin2
      .DADDR			(7'h00),            		// dynamic reconfig address input (7-bits)
      .DCLK			(1'b0),               		// dynamic reconfig clock input
      .DEN			(1'b0),                		// dynamic reconfig enable input
      .DI			(16'h0000),        		// dynamic reconfig data input (16-bits)
      .DWE			(1'b0),                		// dynamic reconfig write enable input
      .RST			(reset)) ;               	// asynchronous pll reset

   if (PIXEL_CLOCK == "BUF_G") begin 						// Final clock selection
      BUFG	bufg_mmcm_x1 (.I(mmcmout_x1), .O(pixel_clk)) ;
      assign status[1:0] = 2'b00 ;
   end
   else if (PIXEL_CLOCK == "BUF_R") begin
      BUFR #(.BUFR_DIVIDE("1"),.SIM_DEVICE("7SERIES"))bufr_mmcm_x1 (.I(mmcmout_x1),.CE(1'b1),.O(pixel_clk),.CLR(1'b0)) ;
      assign status[1:0] = 2'b01 ;
   end
   else begin 
      BUFH	bufh_mmcm_x1 (.I(mmcmout_x1), .O(pixel_clk)) ;
      assign status[1:0] = 2'b10 ;
   end

   if (INTER_CLOCK == "BUF_G") begin 						// Intermediate clock selection
      BUFG	bufg_mmcm_d2 (.I(mmcmout_d2), .O(txclk_div)) ;
      assign status[3:2] = 2'b00 ;
   end
   else if (INTER_CLOCK == "BUF_R") begin
      BUFR #(.BUFR_DIVIDE("1"),.SIM_DEVICE("7SERIES"))bufr_mmcm_d2 (.I(mmcmout_d2),.CE(1'b1),.O(txclk_div),.CLR(1'b0)) ;
      assign status[3:2] = 2'b01 ;
   end
   else begin 
      BUFH	bufh_mmcm_d2 (.I(mmcmout_d2), .O(txclk_div)) ;
      assign status[3:2] = 2'b10 ;
   end
      
   if (TX_CLOCK == "BUF_G") begin						// Sample clock selection
      BUFG	bufg_mmcm_xn (.I(mmcmout_xn), .O(txclk)) ;
      assign status[5:4] = 2'b00 ;
   end
   else if (TX_CLOCK == "BUFIO") begin
      BUFIO  	bufio_mmcm_xn (.I (mmcmout_xn), .O(txclk)) ;
      assign status[5:4] = 2'b11 ;
   end
   else begin 
      BUFH	bufh_mmcm_xn (.I(mmcmout_xn), .O(txclk)) ;
      assign status[5:4] = 2'b10 ;
   end
   
end 
endgenerate
endmodule
