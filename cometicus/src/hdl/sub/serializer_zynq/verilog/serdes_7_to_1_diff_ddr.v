//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
//////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Filename: serdes_7_to_1_diff_ddr.v
//  /   /        Date Last Modified:  May 30th 2012
// /___/   /\    Date Created: September 2 2011
// \   \  /  \
//  \___\/\___\
// 
//Device: 	7-Series
//Purpose:  	DDR D-bit generic 7:1 transmitter module via 14:1 serdes mode
// 		Takes in 7*D bits of data and serialises this to D bits
// 		data is transmitted LSB first
//		Data formatting is set by the DATA_FORMAT parameter. 
//		PER_CLOCK format transmits bits 0, 7, 14 .. at the same time
//		PER_CHANL format transmits bits 0, 1, 2 at the same time
//		Data inversion can be accomplished via the TX_SWAP_MASK 
//		parameter if required.
//		Also generates clock output
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

module serdes_7_to_1_diff_ddr (txclk, reset, pixel_clk, txclk_div, datain, clk_pattern, dataout_p, dataout_n, clkout_p, clkout_n) ;

parameter integer 	D = 16 ;			// Set the number of outputs
parameter         	DATA_FORMAT = "PER_CLOCK" ;     // Parameter Used to determine method for mapping input parallel word to output serial words
parameter         	USE_FIFO = "FALSE" ;     	// Parameter to enable use of IN_FIFO primitive to save fabric logic - only available when D = 5
                                        	
input 			txclk ;				// IO Clock network
input 			reset ;				// Reset
input 			pixel_clk ;			// clock at pixel rate
input			txclk_div ;			// 1/2 rate clock output for gearbox
input 	[(D*7)-1:0]	datain ;  			// Data for output
input 	[6:0]		clk_pattern ;  			// clock pattern for output
output 	[D-1:0]		dataout_p ;			// output data
output 	[D-1:0]		dataout_n ;			// output data
output 			clkout_p ;			// output clock
output 			clkout_n ;			// output clock

wire	[D-1:0]		cascade_di ;	
wire	[D-1:0]		cascade_ti ;	
wire	[D-1:0]		tx_data_out ;	
wire	[D*14-1:0]	mdataina ;	
wire	[D*14-1:0]	mdatainb ;	
reg			clockb2 ;
reg			clockb2d_a ;
reg			clockb2d_b ;
reg			sync ;
reg	[D*7-1:0]	holdreg ;	
wire	[14*D-1:0]	dataint ;	
reg			reset_intr ;
wire	[3:0]		fifo_d0in ;
wire	[3:0]		fifo_d1in ;
wire	[3:0]		fifo_d2in ;
wire	[3:0]		fifo_d3in ;
wire	[3:0]		fifo_d4in ;
wire	[7:0]		fifo_d5in ;
wire	[7:0]		fifo_d6in ;
wire	[3:0]		fifo_d7in ;
wire	[3:0]		fifo_d8in ;
wire	[3:0]		fifo_d9in ;
wire	[7:0]		fifo_d0out ;
wire	[7:0]		fifo_d1out ;
wire	[7:0]		fifo_d2out ;
wire	[7:0]		fifo_d3out ;
wire	[7:0]		fifo_d4out ;
wire	[7:0]		fifo_d5out ;
wire	[7:0]		fifo_d6out ;
wire	[7:0]		fifo_d7out ;
wire	[7:0]		fifo_d8out ;
wire	[7:0]		fifo_d9out ;
reg			fifo_rden ;
reg			fifo_wren ;
reg			fifo_wrend ;
reg	[3:0]		count ;

parameter [D-1:0] TX_SWAP_MASK = 16'h0000 ;		// pinswap mask for output bits (0 = no swap (default), 1 = swap). Allows outputs to be connected the 'wrong way round' to ease PCB routing.

genvar i ;
genvar j ;

initial reset_intr = 1'b1 ;

always @ (posedge txclk_div or posedge reset) begin	// local reset
if (reset == 1'b1) begin
	reset_intr <= 1'b1 ;
	count <= 4'h0 ;
end
else begin
	count <= count + 4'h1 ;
	if (count == 4'hF) begin
		reset_intr <= 1'b0 ;
	end
end
end

generate 
if (D == 5 && USE_FIFO == "TRUE") begin : loop2

assign fifo_d0in = datain[3:0] ;        
assign fifo_d1in = {1'b0, datain[6:4]} ;
assign fifo_d2in = datain[10:7] ;       
assign fifo_d3in = {1'b0, datain[13:11]} ;
assign fifo_d4in = datain[17:14] ;      
assign fifo_d5in = {5'h00, datain[20:18]} ;
assign fifo_d6in = {4'h0, datain[24:21]} ;      
assign fifo_d7in = {1'b0, datain[27:25]} ;
assign fifo_d8in = datain[31:28] ;      
assign fifo_d9in = {1'b0, datain[34:32]} ;

initial fifo_rden = 1'b0 ;

always @ (posedge txclk_div) begin
if (reset_intr == 1'b1) begin
	fifo_rden <= 1'b0 ;
end
else begin
	fifo_wrend <= fifo_wren ;
	fifo_rden <= fifo_wrend ;
end
end

initial fifo_wren = 1'b0 ;

always @ (posedge pixel_clk) begin
if (reset_intr == 1'b1) begin
	fifo_wren <= 1'b0 ;
end
else begin
	fifo_wren <= 1'b1 ;
end
end

IN_FIFO #(                                      
	.ARRAY_MODE 	("ARRAY_MODE_4_X_8"))   
in_fifo_inst  (                                 
  	.ALMOSTEMPTY	(),                     
  	.ALMOSTFULL	(),                     
  	.EMPTY		(),                     
  	.FULL		(),                     
  	.Q0		(fifo_d0out),                     
  	.Q1		(fifo_d1out),                     
  	.Q2		(fifo_d2out),
  	.Q3		(fifo_d3out),
  	.Q4		(fifo_d4out),
  	.Q5		(fifo_d5out),
  	.Q6		(fifo_d6out),
  	.Q7		(fifo_d7out),
  	.Q8		(fifo_d8out),
  	.Q9		(fifo_d9out),
  	.D0		(fifo_d0in),
  	.D1		(fifo_d1in),
  	.D2		(fifo_d2in),
  	.D3		(fifo_d3in),
  	.D4		(fifo_d4in),
  	.D5		(fifo_d5in),
  	.D6		(fifo_d6in),
  	.D7		(fifo_d7in),
  	.D8		(fifo_d8in),
  	.D9		(fifo_d9in),
  	.RDCLK		(txclk_div),
  	.RDEN		(fifo_rden),
  	.RESET		(reset_intr),
  	.WRCLK		(pixel_clk),
  	.WREN		(fifo_wren));

end
else begin

// Timing generator

always @ (posedge txclk_div) begin
if (reset == 1'b1) begin
	clockb2 <= 1'b0 ;
end
else begin
	clockb2 <= ~clockb2 ;
end
end

always @ (posedge pixel_clk) begin
	clockb2d_a <= clockb2 ;
	clockb2d_b <= clockb2d_a ;
	sync <= clockb2d_a ^ clockb2d_b ;
	if (sync == 1'b1) begin
		holdreg <= datain ;
	end
end

assign dataint = {datain, holdreg} ;

end 
endgenerate

generate
for (i = 0 ; i <= (D-1) ; i = i+1) begin : loop0

OBUFDS io_data_out (
	.O    			(dataout_p[i]),
	.OB       		(dataout_n[i]),
	.I         		(tx_data_out[i]));

// re-arrange data bits for transmission and invert lines as given by the mask
// NOTE If pin inversion is required (non-zero SWAP MASK) then inverters will occur in fabric, as there are no inverters in the OSERDESE2
// This can be avoided by doing the inversion (if necessary) in the user logic
// TX_SWAP_MASK not available when IN_FIFO is used

if (D == 5 && USE_FIFO == "TRUE") begin : loop3
  	if (DATA_FORMAT == "PER_CLOCK") begin
  		assign mdataina = {fifo_d9out[6], fifo_d8out[5], fifo_d6out[7], fifo_d5out[5], fifo_d4out[4], fifo_d2out[6], fifo_d1out[4], fifo_d9out[2], fifo_d8out[1], fifo_d6out[3], fifo_d5out[1], fifo_d4out[0], fifo_d2out[2], fifo_d1out[0],
  		                   fifo_d9out[5], fifo_d8out[4], fifo_d6out[6], fifo_d5out[4], fifo_d3out[6], fifo_d2out[5], fifo_d0out[7], fifo_d9out[1], fifo_d8out[0], fifo_d6out[2], fifo_d5out[0], fifo_d3out[2], fifo_d2out[1], fifo_d0out[3],
  		                   fifo_d9out[4], fifo_d7out[6], fifo_d6out[5], fifo_d4out[7], fifo_d3out[5], fifo_d2out[4], fifo_d0out[6], fifo_d9out[0], fifo_d7out[2], fifo_d6out[1], fifo_d4out[3], fifo_d3out[1], fifo_d2out[0], fifo_d0out[2],
  		                   fifo_d8out[7], fifo_d7out[5], fifo_d6out[4], fifo_d4out[6], fifo_d3out[4], fifo_d1out[6], fifo_d0out[5], fifo_d8out[3], fifo_d7out[1], fifo_d6out[0], fifo_d4out[2], fifo_d3out[0], fifo_d1out[2], fifo_d0out[1],
  		                   fifo_d8out[6], fifo_d7out[4], fifo_d5out[6], fifo_d4out[5], fifo_d2out[7], fifo_d1out[5], fifo_d0out[4], fifo_d8out[2], fifo_d7out[0], fifo_d5out[2], fifo_d4out[1], fifo_d2out[3], fifo_d1out[1], fifo_d0out[0]} ;
  	end
  	else begin
  		assign mdataina = {fifo_d9out[6:4], fifo_d8out[7:4], fifo_d9out[2:0], fifo_d8out[3:0],
  		                   fifo_d7out[6:4], fifo_d6out[7:4], fifo_d7out[2:0], fifo_d6out[3:0], 
  		                   fifo_d5out[6:4], fifo_d4out[7:4], fifo_d5out[2:0], fifo_d4out[3:0],
  		                   fifo_d3out[6:4], fifo_d2out[7:4], fifo_d3out[2:0], fifo_d2out[3:0], 
  		                   fifo_d1out[6:4], fifo_d0out[7:4], fifo_d1out[2:0], fifo_d0out[3:0]} ;
  	end
end
else begin
  for (j = 0 ; j <= 13 ; j = j+1) begin : loop1
  	if (DATA_FORMAT == "PER_CLOCK") begin
  		assign mdataina[14*i+j] = dataint[D*j+i] ^ TX_SWAP_MASK[i] ;
  	end
  	else begin
  		if (j < 7) begin
  			assign mdataina[14*i+j] = dataint[(7*i)+j] ^ TX_SWAP_MASK[i] ;
  		end
  		else begin
  			assign mdataina[14*i+j] = dataint[(7*i)+j-7+D*7] ^ TX_SWAP_MASK[i];
  		end
  	end
  end
end

OSERDESE2 #(
	.DATA_WIDTH     	(14), 			// SERDES word width
	.TRISTATE_WIDTH     	(1), 
	.DATA_RATE_OQ      	("DDR"), 		// <SDR>, DDR
	.DATA_RATE_TQ      	("SDR"), 		// <SDR>, DDR
	.SERDES_MODE    	("MASTER"))  		// <DEFAULT>, MASTER, SLAVE
oserdes_m (
	.OQ       		(tx_data_out[i]),
	.OCE     		(1'b1),
	.CLK    		(txclk),
	.RST     		(reset_intr),
	.CLKDIV  		(txclk_div),
	.D8  			(mdataina[(14*i)+7]),
	.D7  			(mdataina[(14*i)+6]),
	.D6  			(mdataina[(14*i)+5]),
	.D5  			(mdataina[(14*i)+4]),
	.D4  			(mdataina[(14*i)+3]),
	.D3  			(mdataina[(14*i)+2]),
	.D2  			(mdataina[(14*i)+1]),
	.D1  			(mdataina[(14*i)+0]),
	.TQ  			(),
	.T1 			(1'b0),
	.T2 			(1'b0),
	.T3 			(1'b0),
	.T4 			(1'b0),
	.TCE	 		(1'b1),
	.TBYTEIN		(1'b0),
	.TBYTEOUT		(),
	.OFB	 		(),
	.TFB	 		(),
	.SHIFTOUT1 		(),			
	.SHIFTOUT2 		(),			
	.SHIFTIN1 		(cascade_di[i]),	
	.SHIFTIN2 		(cascade_ti[i])) ;	

OSERDESE2 #(
	.DATA_WIDTH     	(14), 			// SERDES word width.
	.TRISTATE_WIDTH     	(1), 
	.DATA_RATE_OQ      	("DDR"), 		// <SDR>, DDR
	.DATA_RATE_TQ      	("SDR"), 		// <SDR>, DDR
	.SERDES_MODE    	("SLAVE"))  		// <DEFAULT>, MASTER, SLAVE
oserdes_s (
	.OQ       		(),
	.OCE     		(1'b1),
	.CLK    		(txclk),
	.RST     		(reset_intr),
	.CLKDIV  		(txclk_div),
	.D8  			(mdataina[(14*i)+13]),
	.D7  			(mdataina[(14*i)+12]),
	.D6  			(mdataina[(14*i)+11]),
	.D5  			(mdataina[(14*i)+10]),
	.D4  			(mdataina[(14*i)+9]),
	.D3  			(mdataina[(14*i)+8]),
	.D2  			(1'b0),
	.D1  			(1'b0),
	.TQ  			(),
	.T1 			(1'b0),
	.T2 			(1'b0),
	.T3  			(1'b0),
	.T4  			(1'b0),
	.TCE	 		(1'b1),
	.TBYTEIN		(1'b0),
	.TBYTEOUT		(),
	.OFB	 		(),
	.TFB	 		(),
	.SHIFTOUT1 		(cascade_di[i]),	
	.SHIFTOUT2 		(cascade_ti[i]),	
	.SHIFTIN1 		(1'b0),			
	.SHIFTIN2 		(1'b0)) ;			

end
endgenerate

OBUFDS io_clk_out (
	.O    			(clkout_p),
	.OB       		(clkout_n),
	.I         		(tx_clk_out));

OSERDESE2 #(
	.DATA_WIDTH     	(14), 			// SERDES word width
	.TRISTATE_WIDTH     	(1), 
	.DATA_RATE_OQ      	("DDR"), 		// <SDR>, DDR
	.DATA_RATE_TQ      	("SDR"), 		// <SDR>, DDR
	.SERDES_MODE    	("MASTER"))  		// <DEFAULT>, MASTER, SLAVE
oserdes_cm (
	.OQ       		(tx_clk_out),
	.OCE     		(1'b1),
	.CLK    		(txclk),
	.RST     		(reset_intr),
	.CLKDIV  		(txclk_div),
	.D8  			(clk_pattern[0]),
	.D7  			(clk_pattern[6]),
	.D6  			(clk_pattern[5]),
	.D5  			(clk_pattern[4]),
	.D4  			(clk_pattern[3]),
	.D3  			(clk_pattern[2]),
	.D2  			(clk_pattern[1]),
	.D1  			(clk_pattern[0]),
	.TQ  			(),
	.T1 			(1'b0),
	.T2 			(1'b0),
	.T3 			(1'b0),
	.T4 			(1'b0),
	.TCE	 		(1'b1),
	.TBYTEIN		(1'b0),
	.TBYTEOUT		(),
	.OFB	 		(),
	.TFB	 		(),
	.SHIFTOUT1 		(),			
	.SHIFTOUT2 		(),			
	.SHIFTIN1 		(cascade_cdi),	
	.SHIFTIN2 		(cascade_cti)) ;	

OSERDESE2 #(
	.DATA_WIDTH     	(14), 			// SERDES word width.
	.TRISTATE_WIDTH     	(1), 
	.DATA_RATE_OQ      	("DDR"), 		// <SDR>, DDR
	.DATA_RATE_TQ      	("SDR"), 		// <SDR>, DDR
	.SERDES_MODE    	("SLAVE"))  		// <DEFAULT>, MASTER, SLAVE
oserdes_cs (
	.OQ       		(),
	.OCE     		(1'b1),
	.CLK    		(txclk),
	.RST     		(reset_intr),
	.CLKDIV  		(txclk_div),
	.D8  			(clk_pattern[6]),
	.D7  			(clk_pattern[5]),
	.D6  			(clk_pattern[4]),
	.D5  			(clk_pattern[3]),
	.D4  			(clk_pattern[2]),
	.D3  			(clk_pattern[1]),
	.D2  			(1'b0),
	.D1  			(1'b0),
	.TQ  			(),
	.T1 			(1'b0),
	.T2 			(1'b0),
	.T3  			(1'b0),
	.T4  			(1'b0),
	.TCE	 		(1'b1),
	.TBYTEIN		(1'b0),
	.TBYTEOUT		(),
	.OFB	 		(),
	.TFB	 		(),
	.SHIFTOUT1 		(cascade_cdi),	
	.SHIFTOUT2 		(cascade_cti),	
	.SHIFTIN1 		(1'b0),			
	.SHIFTIN2 		(1'b0)) ;
		
endmodule
