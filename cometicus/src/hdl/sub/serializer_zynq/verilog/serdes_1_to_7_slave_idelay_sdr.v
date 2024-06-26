//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
//////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Filename: serdes_1_to_7_slave_idelay_sdr.v
//  /   /        Date Last Modified:  May 30th 2012
// /___/   /\    Date Created: March 5 2010
// \   \  /  \
//  \___\/\___\
// 
//Device: 	7 Series
//Purpose:  	1 to 7 receiver clock and data receiver using an MMCM for clock multiplication
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

module serdes_1_to_7_slave_idelay_sdr (clkin_p, clkin_n, datain_p, datain_n, enable_phase_detector, idelay_rdy, rxclk, reset, rxclk_div, 
                                       bitslip_finished, clk_data, rx_data, debug, bit_time_value, pd) ;

parameter integer 	D = 8 ;   			// Parameter to set the number of data lines
parameter 		HIGH_PERFORMANCE_MODE = "FALSE";// Parameter to set HIGH_PERFORMANCE_MODE of input delays to reduce jitter
parameter         	DIFF_TERM = "FALSE" ; 		// Parameter to enable internal differential termination
parameter         	DATA_FORMAT = "PER_CLOCK" ;     // Parameter Used to determine method for mapping input parallel word to output serial words
                                        	
input 			clkin_p ;			// Input from LVDS clock receiver pin
input 			clkin_n ;			// Input from LVDS clock receiver pin
input 	[D-1:0]		datain_p ;			// Input from LVDS clock data pins
input 	[D-1:0]		datain_n ;			// Input from LVDS clock data pins
input 			enable_phase_detector ;		// Enables the phase detector logic when high
input			idelay_rdy ;			// input delays are ready
input 			reset ;				// Reset line
input 			rxclk ;				// Global/BUFIO rx clock network
input 			rxclk_div ;			// Global/Regional clock input
output 			bitslip_finished ;	 	// bitslipping finished
output 	[6:0]		clk_data ;	 		// Clock Data
output 	[D*7-1:0]	rx_data ;	 		// Received Data
output 	[10*D+5:0]	debug ;	 			// debug info
input	[4:0]		bit_time_value ;		// Calculated bit time value from 'master'
input			pd ;				// Flag when pd is auto disabled

reg	[D*5-1:0]	m_delay_val_in ;
reg	[D*5-1:0]	s_delay_val_in ;
wire			rx_clk_in ;			
reg	[1:0]		bsstate ;                 	
reg 			bslip ;                 	
reg 			bslipreq ;                 	
reg 			bslipr ;                 	
reg	[3:0]		bcount ;                 	
reg	[6*D-1:0]	pdcount ;                 	
wire 	[6:0] 		clk_iserdes_data ;      	
reg 	[6:0] 		clk_iserdes_data_d ;    	
reg 			enable ;                	
reg 			flag1 ;                 	
reg 			flag2 ;                 	
reg 	[2:0] 		state2 ;			
reg 	[3:0] 		state2_count ;			
reg 	[5:0] 		scount ;			
reg 			locked_out ;	
reg 			locked_out_rt ;	
reg			chfound ;	
reg			chfoundc ;
reg	[4:0]		c_delay_in ;
reg			local_reset ;
wire 	[D-1:0]		rx_data_in_p ;			
wire 	[D-1:0]		rx_data_in_n ;			
wire 	[D-1:0]		rx_data_in_m ;			
wire 	[D-1:0]		rx_data_in_s ;		
wire 	[D-1:0]		rx_data_in_md ;			
wire 	[D-1:0]		rx_data_in_sd ;	
wire	[(7*D)-1:0] 	mdataout ;			
reg	[(7*D)-1:0] 	mdataouta ;			
reg	[D-1:0] 	mdataoutb ;			
reg	[(7*D)-1:0] 	mdataoutc ;			
reg	[(7*D)-1:0] 	mdataoutd ;			
wire	[(7*D)-1:0] 	sdataout ;			
reg	[(7*D)-1:0] 	sdataouta ;			
reg	[D-1:0] 	sdataoutb ;			
reg	[(7*D)-1:0] 	sdataoutc ;			
reg			bslip_ackr ;		
reg			bslip_ack ;		
reg	[1:0]		bstate ;
reg			data_different ;
reg 	[D-1:0]		s_ovflw ;		
reg 	[D-1:0]		s_hold ;		
reg			bs_finished ;
wire	[4:0]		bt_val ;
reg	[D-1:0]		data_mux ;
reg	[2*D-1:0]	m_delay_mux ;
reg	[2*D-1:0]	s_delay_mux ;
reg 	[D-1:0]		dec_run ;
reg 	[D-1:0]		inc_run ;
reg	[D*4-1:0]	s_state ;                 			
reg			retry ;
reg			no_clock ;
reg	[7:0]		clk_s_count ;

parameter [D-1:0] 	RX_SWAP_MASK = 16'h0000 ;	// pinswap mask for input data bits (0 = no swap (default), 1 = swap). Allows inputs to be connected the wrong way round to ease PCB routing.

assign clk_data = clk_iserdes_data ;
assign debug = {s_delay_val_in, m_delay_val_in, bslip, c_delay_in} ;
assign bitslip_finished = bs_finished & ~reset ;
assign bt_val = bit_time_value ;

always @ (posedge rxclk_div or posedge reset) begin	// generate local sync (rxclk_div) reset
if (reset == 1'b1 || retry == 1'b1) begin
	local_reset <= 1'b1 ;
end
else begin
	if (idelay_rdy == 1'b0) begin
		local_reset <= 1'b1 ;
	end
	else begin
		local_reset <= 1'b0 ;
	end
end
end

// Bitslip state machine

always @ (posedge rxclk_div)
begin
if (locked_out == 1'b0) begin
	bslip <= 1'b0 ;
	bsstate <= 1 ;
	enable <= 1'b0 ;
	bcount <= 4'h0 ;
	bs_finished <= 1'b0 ;
	retry <= 1'b0 ;
end
else begin
	enable <= 1'b1 ;
   	if (enable == 1'b1) begin
   		if (clk_iserdes_data != 7'b1100001) begin flag1 <= 1'b1 ; end else begin flag1 <= 1'b0 ; end
   		if (clk_iserdes_data != 7'b1100011) begin flag2 <= 1'b1 ; end else begin flag2 <= 1'b0 ; end
     		if (bsstate == 0) begin
   			if (flag1 == 1'b1 && flag2 == 1'b1) begin
     		   		bslip <= 1'b1 ;						// bitslip needed
     		   		bsstate <= 1 ;
     		   	end
     		   	else begin
     		   		bs_finished <= 1'b1 ;					// bitslip done
     		   	end
		end
   		else if (bsstate == 1) begin				
     		   	bslip <= 1'b0 ; 
     		   	bcount <= bcount + 4'h1 ;
   			if (bcount == 4'hF) begin
     		   		bsstate <= 0 ;
     		   	end
   		end
   	end
end
end

// Clock input 

IBUFGDS #(
	.DIFF_TERM 		(DIFF_TERM)) 
iob_clk_in (
	.I    			(clkin_p),
	.IB       		(clkin_n),
	.O         		(rx_clk_in));

genvar i ;
genvar j ;

IDELAYE2 #(
	.HIGH_PERFORMANCE_MODE	(HIGH_PERFORMANCE_MODE),
      	.IDELAY_VALUE		(1),
      	.DELAY_SRC		("IDATAIN"),
      	.IDELAY_TYPE		("VAR_LOAD"))
idelay_cm(               	
	.DATAOUT		(rx_clk_in_d),
	.C			(rxclk_div),
	.CE			(1'b0),
	.INC			(1'b0),
	.DATAIN			(1'b0),
	.IDATAIN		(rx_clk_in),
	.LD			(1'b1),
	.LDPIPEEN		(1'b0),
	.REGRST			(1'b0),
	.CINVCTRL		(1'b0),
	.CNTVALUEIN		(c_delay_in),
	.CNTVALUEOUT		());
	
ISERDESE2 #(
	.DATA_WIDTH     	(7), 				
	.DATA_RATE      	("SDR"), 			
	.SERDES_MODE    	("MASTER"), 			
	.IOBDELAY	    	("IFD"), 			
	.INTERFACE_TYPE 	("NETWORKING")) 		
iserdes_cm (
	.D       		(1'b0),
	.DDLY     		(rx_clk_in_d),
	.CE1     		(1'b1),
	.CE2     		(1'b1),
	.CLK    		(rxclk),
	.CLKB    		(~rxclk),
	.RST     		(local_reset),
	.CLKDIV  		(rxclk_div),
	.CLKDIVP  		(1'b0),
	.OCLK    		(1'b0),
	.OCLKB    		(1'b0),
	.DYNCLKSEL    		(1'b0),
	.DYNCLKDIVSEL  		(1'b0),
	.SHIFTIN1 		(1'b0),
	.SHIFTIN2 		(1'b0),
	.BITSLIP 		(bslip),
	.O	 		(),
	.Q8 			(),
	.Q7 			(clk_iserdes_data[0]),
	.Q6 			(clk_iserdes_data[1]),
	.Q5 			(clk_iserdes_data[2]),
	.Q4 			(clk_iserdes_data[3]),
	.Q3 			(clk_iserdes_data[4]),
	.Q2 			(clk_iserdes_data[5]),
	.Q1 			(clk_iserdes_data[6]),
	.OFB 			(),
	.SHIFTOUT1 		(),
	.SHIFTOUT2 		());	

always @ (posedge rxclk_div) begin				// 
	clk_iserdes_data_d <= clk_iserdes_data ;
	if ((clk_iserdes_data != clk_iserdes_data_d) && (clk_iserdes_data != 7'h00) && (clk_iserdes_data != 7'h7F)) begin
		data_different <= 1'b1 ;
	end
	else begin
		data_different <= 1'b0 ;
	end
	if ((clk_iserdes_data == 7'h00) || (clk_iserdes_data == 7'h7F)) begin
		no_clock <= 1'b1 ;
	end
	else begin
		no_clock <= 1'b0 ;
	end
end
	
always @ (posedge rxclk_div) begin					// clock delay shift state machine
	if (local_reset == 1'b1) begin
		scount <= 6'h00 ;
		state2 <= 0 ;
		state2_count <= 4'h0 ;
		locked_out <= 1'b0 ;
		chfoundc <= 1'b1 ;
		chfound <= 1'b0 ;
		c_delay_in <= bt_val ;						// Start the delay line at the current bit period
		clk_s_count <= 8'h00 ;
	end
	else begin
		if (scount[5] == 1'b0) begin
			if (no_clock == 1'b0) begin
				scount <= scount + 6'h01 ;
			end
			else begin
				scount <= 6'h00 ;
			end
		end
		state2_count <= state2_count + 4'h1 ;
		if (chfoundc == 1'b1) begin
			chfound <= 1'b0 ;
		end
		else if (chfound == 1'b0 && data_different == 1'b1) begin
			chfound <= 1'b1 ;
		end
		if ((state2_count == 4'hF && scount[5] == 1'b1)) begin
			case(state2) 					
			0	: begin							// decrement delay and look for a change
				  if (chfound == 1'b1) begin
					chfoundc <= 1'b1 ;
					state2 <= 1 ;
					c_delay_in <= c_delay_in + 5'h01 ;
				  end
				  else if (clk_s_count == 8'hFF && pd == 1'b0) begin
				  	c_delay_in <= 5'h10 ;
					state2 <= 1 ;
				  end
				  else begin
					chfoundc <= 1'b0 ;
					clk_s_count <= clk_s_count + 8'h01 ;
					if (c_delay_in != 5'h00) begin			// check for underflow
						c_delay_in <= c_delay_in - 5'h01 ;
					end
					else begin
						c_delay_in <= bt_val ;
					end
				  end
				  end
			1	: begin							// add half a bit period using input information
				  state2 <= 2 ;
				  if (c_delay_in < {1'b0, bt_val[4:1]}) begin		// choose the lowest delay value to minimise jitter
				   	c_delay_in <= c_delay_in + {1'b0, bt_val[4:1]} ;
				  end
				  else begin
				   	c_delay_in <= c_delay_in - {1'b0, bt_val[4:1]} ;
				  end
				  end
			default	: begin							// issue locked out signal
				  locked_out <= 1'b1 ;
			 	  end
			endcase
		end
	end
end
			
generate
for (i = 0 ; i <= D-1 ; i = i+1)
begin : loop3

always @ (posedge rxclk_div) begin							// per bit delay shift state machine
	if (bs_finished == 1'b0) begin
		s_ovflw[i] <= 1'b0 ;
		pdcount[6*i+5:6*i+0] <= 6'h20 ;
		m_delay_val_in[5*i+4:5*i] <= c_delay_in ; 				// initial master delay
		s_delay_val_in[5*i+4:5*i] <= 5'h00 ; 		 			// initial slave delay
		data_mux[i] <= 1'b0 ;
		dec_run[i] <= 1'b0 ;
		inc_run[i] <= 1'b0 ;
		s_state[4*i+3:4*i] <= 5'h00 ;
		m_delay_mux[2*i+1:2*i] <= 2'h1 ;
		s_delay_mux[2*i+1:2*i] <= 2'h1 ;
	end
	else if (enable_phase_detector == 1'b1 && pd == 1'b1) begin 
		mdataouta[7*i+6:7*i] <= mdataout[7*i+6:7*i] ;
		mdataoutb[i]         <= mdataouta[7*i+6] ;
		sdataouta[7*i+6:7*i] <= sdataout[7*i+6:7*i] ;
		sdataoutb[i] 	     <= sdataouta[7*i+6] ;
		if (data_mux[i] == 1'b0) begin
			mdataoutd[7*i+6:7*i] <= mdataoutc[7*i+6:7*i] ;
		end
		else begin
			mdataoutd[7*i+6:7*i] <= sdataoutc[7*i+6:7*i] ;
		end
		case (m_delay_mux[2*i+1:2*i])
			2'h0    : mdataoutc[7*i+6:7*i] <= {mdataouta[7*i+5:7*i], mdataoutb[i]} ;
			2'h2    : mdataoutc[7*i+6:7*i] <= {mdataout[7*i],        mdataouta[7*i+6:7*i+1]} ;
			default : mdataoutc[7*i+6:7*i] <=  mdataouta[7*i+6:7*i] ;
		endcase
		case (s_delay_mux[2*i+1:2*i])
			2'h0    : sdataoutc[7*i+6:7*i] <= {sdataouta[7*i+5:7*i], sdataoutb[i]} ;
			2'h2    : sdataoutc[7*i+6:7*i] <= {sdataout[7*i],        sdataouta[7*i+6:7*i+1]} ;
			default : sdataoutc[7*i+6:7*i] <=  sdataouta[7*i+6:7*i] ;
		endcase
		if (((s_ovflw[i] == 1'b0 && mdataouta[7*i+6:7*i+0] != sdataouta[7*i+6:7*i+0]) || 
		     (s_ovflw[i] == 1'b1 && mdataouta[7*i+6:7*i+0] == sdataouta[7*i+6:7*i+0])) && 
		      mdataouta[7*i+6:7*i+0] != 7'h00 && mdataouta[7*i+6:7*i+0] != 7'h7F &&
		      pdcount[6*i+5:6*i+0] != 6'h3F) begin						// increment filter count
				pdcount[6*i+5:6*i+0] <= pdcount[6*i+5:6*i+0] + 6'h01 ; 
		end
		else if (((s_ovflw[i] == 1'b0 && mdataouta[7*i+6:7*i+0] == sdataouta[7*i+6:7*i+0]) || 
		          (s_ovflw[i] == 1'b1 && mdataouta[7*i+6:7*i+0] != sdataouta[7*i+6:7*i+0])) && 
		           mdataouta[7*i+6:7*i+0] != 7'h00 && mdataouta[7*i+6:7*i+0] != 7'h7F &&
		           pdcount[6*i+5:6*i+0] != 6'h00) begin						// decrement filter count
				pdcount[6*i+5:6*i+0] <= pdcount[6*i+5:6*i+0] - 6'h01 ; 
		end
		if (pdcount[6*i+5:6*i+0] == 6'h3F || inc_run[i] == 1'b1) begin				// increment delays, check for master delay = max
			if (m_delay_val_in[5*i+4:5*i] != bt_val && inc_run[i] == 1'b0) begin
				m_delay_val_in[5*i+4:5*i] <= m_delay_val_in[5*i+4:5*i] + 5'h01 ;
				pdcount[6*i+5:6*i+0] <= 6'h20 ;
			end
			else begin											// master is max
				s_state[4*i+3:4*i] <= s_state[4*i+3:4*i] + 4'h1 ;
				case (s_state[4*i+3:4*i]) 
				0  : begin inc_run[i] <= 1'b1 ; s_delay_val_in[5*i+4:5*i] <= bt_val ; end		// indicate state machine running and set slave delay to same as master, ie max 
				6  : begin data_mux[i] <= 1'b1 ; m_delay_val_in[5*i+4:5*i] <= 5'h00 ; end 		// change data mux over to forward slave data and set master delay to zero 
				9  : begin m_delay_mux[2*i+1:2*i] <= m_delay_mux[2*i+1:2*i] - 2'h1 ; end 		// change delay mux over to forward with a 1-bit less advance
				14 : begin data_mux[i] <= 1'b0 ; end 							// change data mux over to forward master data
				15 : begin s_delay_mux[2*i+1:2*i] <= s_delay_mux[2*i+1:2*i] - 2'h1 ;	 		// change delay mux over to forward with a 1-bit less advance
					   inc_run[i] <= 1'b0 ; pdcount[6*i+5:6*i+0] <= 6'h20 ; end
				endcase
			end
		end
		else if (pdcount[6*i+5:6*i+0] == 6'h00 || dec_run[i] == 1'b1) begin					// decrement delays, check for master delay = 0
			if (m_delay_val_in[5*i+4:5*i] != 5'h00 && dec_run[i] == 1'b0) begin
				pdcount[6*i+5:6*i+0] <= 6'h20 ; 
				m_delay_val_in[5*i+4:5*i] <= m_delay_val_in[5*i+4:5*i] - 5'h01 ;
			end
			else begin											// master is zero
				s_state[4*i+3:4*i] <= s_state[4*i+3:4*i] + 4'h1 ;
				case (s_state[4*i+3:4*i]) 
				0  : begin dec_run[i] <= 1'b1 ; s_delay_val_in[5*i+4:5*i] <= 5'h00 ; end		// indicate state machine running and set slave delay to zero 
				6  : begin data_mux[i] <= 1'b1 ; m_delay_val_in[5*i+4:5*i] <= bt_val ; end 		// change data mux over to forward slave data and set master delay to bit time 
				9  : begin m_delay_mux[2*i+1:2*i] <= m_delay_mux[2*i+1:2*i] + 2'h1 ; end 		// change delay mux over to forward with a 1-bit more advance
				14 : begin data_mux[i] <= 1'b0 ; end 							// change data mux over to forward master data
				15 : begin s_delay_mux[2*i+1:2*i] <= s_delay_mux[2*i+1:2*i] + 2'h1 ;	 		// change delay mux over to forward with a 1-bit less advance
				           dec_run[i] <= 1'b0 ; pdcount[6*i+5:6*i+0] <= 6'h20 ; end
				endcase
			end
		end
		else begin
			if (m_delay_val_in[5*i+4:5*i] >= {1'b0, bt_val[4:1]}) begin 					// set slave delay to 1/2 bit period beyond or behind the master delay
				s_delay_val_in[5*i+4:5*i] <= m_delay_val_in[5*i+4:5*i] - {1'b0, bt_val[4:1]} ;
				s_ovflw[i] <= 1'b0 ;
			end
			else begin
				s_delay_val_in[5*i+4:5*i] <= m_delay_val_in[5*i+4:5*i] + {1'b0, bt_val[4:1]} ;
				s_ovflw[i] <= 1'b1 ;
			end
		end
	end
	else begin	
		mdataoutd[7*i+6:7*i] <= mdataout[7*i+6:7*i] ;
		s_delay_val_in[5*i+4:5*i] <= 5'h00 ;
	end
end 

// Data bit Receivers 

IBUFDS_DIFF_OUT #(
	.DIFF_TERM 		(DIFF_TERM)) 
data_in (
	.I    			(datain_p[i]),
	.IB       		(datain_n[i]),
	.O         		(rx_data_in_p[i]),
	.OB         		(rx_data_in_n[i]));

assign rx_data_in_m[i] = rx_data_in_p[i]  ^ RX_SWAP_MASK[i] ;
assign rx_data_in_s[i] = ~rx_data_in_n[i] ^ RX_SWAP_MASK[i] ;

IDELAYE2 #(
	.HIGH_PERFORMANCE_MODE	(HIGH_PERFORMANCE_MODE),
      	.IDELAY_VALUE		(0),
      	.DELAY_SRC		("IDATAIN"),
      	.IDELAY_TYPE		("VAR_LOAD"))
idelay_m(               	
	.DATAOUT		(rx_data_in_md[i]),
	.C			(rxclk_div),
	.CE			(1'b0),
	.INC			(1'b0),
	.DATAIN			(1'b0),
	.IDATAIN		(rx_data_in_m[i]),
	.LD			(1'b1),
	.LDPIPEEN		(1'b0),
	.REGRST			(1'b0),
	.CINVCTRL		(1'b0),
	.CNTVALUEIN		(m_delay_val_in[5*i+4:5*i]),
	.CNTVALUEOUT		());
		
ISERDESE2 #(
	.DATA_WIDTH     	(7), 			
	.DATA_RATE      	("SDR"), 		
	.SERDES_MODE    	("MASTER"), 		
	.IOBDELAY	    	("IFD"), 		
	.INTERFACE_TYPE 	("NETWORKING")) 	
iserdes_m (
	.D       		(1'b0),
	.DDLY     		(rx_data_in_md[i]),
	.CE1     		(1'b1),
	.CE2     		(1'b1),
	.CLK	   		(rxclk),
	.CLKB    		(~rxclk),
	.RST     		(local_reset),
	.CLKDIV  		(rxclk_div),
	.CLKDIVP  		(1'b0),
	.OCLK    		(1'b0),
	.OCLKB    		(1'b0),
	.DYNCLKSEL    		(1'b0),
	.DYNCLKDIVSEL  		(1'b0),
	.SHIFTIN1 		(1'b0),
	.SHIFTIN2 		(1'b0),
	.BITSLIP 		(bslip),
	.O	 		(),
	.Q8  			(),
	.Q7  			(mdataout[7*i+0]),
	.Q6  			(mdataout[7*i+1]),
	.Q5  			(mdataout[7*i+2]),
	.Q4  			(mdataout[7*i+3]),
	.Q3  			(mdataout[7*i+4]),
	.Q2  			(mdataout[7*i+5]),
	.Q1  			(mdataout[7*i+6]),
	.OFB 			(),
	.SHIFTOUT1		(),
	.SHIFTOUT2 		());

IDELAYE2 #(
	.HIGH_PERFORMANCE_MODE	(HIGH_PERFORMANCE_MODE),
      	.IDELAY_VALUE		(0),
      	.DELAY_SRC		("IDATAIN"),
      	.IDELAY_TYPE		("VAR_LOAD"))
idelay_s(               	
	.DATAOUT		(rx_data_in_sd[i]),
	.C			(rxclk_div),
	.CE			(1'b0),
	.INC			(1'b0),
	.DATAIN			(1'b0),
	.IDATAIN		(rx_data_in_s[i]),
	.LD			(1'b1),
	.LDPIPEEN		(1'b0),
	.REGRST			(1'b0),
	.CINVCTRL		(1'b0),
	.CNTVALUEIN		(s_delay_val_in[5*i+4:5*i]),
	.CNTVALUEOUT		());
	
ISERDESE2 #(
	.DATA_WIDTH     	(7), 			
	.DATA_RATE      	("SDR"), 		
//	.SERDES_MODE    	("SLAVE"), 		
	.IOBDELAY	    	("IFD"), 		
	.INTERFACE_TYPE 	("NETWORKING")) 	
iserdes_s (
	.D       		(1'b0),
	.DDLY     		(rx_data_in_sd[i]),
	.CE1     		(1'b1),
	.CE2     		(1'b1),
	.CLK	   		(rxclk),
	.CLKB    		(~rxclk),
	.RST     		(local_reset),
	.CLKDIV  		(rxclk_div),
	.CLKDIVP  		(1'b0),
	.OCLK    		(1'b0),
	.OCLKB    		(1'b0),
	.DYNCLKSEL    		(1'b0),
	.DYNCLKDIVSEL  		(1'b0),
	.SHIFTIN1 		(1'b0),
	.SHIFTIN2 		(1'b0),
	.BITSLIP 		(bslip),
	.O	 		(),
	.Q8  			(),
	.Q7  			(sdataout[7*i+0]),
	.Q6  			(sdataout[7*i+1]),
	.Q5  			(sdataout[7*i+2]),
	.Q4  			(sdataout[7*i+3]),
	.Q3  			(sdataout[7*i+4]),
	.Q2  			(sdataout[7*i+5]),
	.Q1  			(sdataout[7*i+6]),
	.OFB 			(),
	.SHIFTOUT1		(),
	.SHIFTOUT2 		());

for (j = 0 ; j <= 6 ; j = j+1) begin : loop1			// Assign data bits to correct serdes according to required format
	if (DATA_FORMAT == "PER_CLOCK") begin
		assign rx_data[D*j+i] = mdataoutd[7*i+j] ;
	end 
	else begin
		assign rx_data[7*i+j] = mdataoutd[7*i+j] ;
	end
end
end
endgenerate
endmodule
