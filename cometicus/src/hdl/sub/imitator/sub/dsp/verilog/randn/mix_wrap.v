module mix_wrap(clk, reset_n, mag_O, sig_O);
`include "test_params.inc"
   
   input clk;
   input reset_n;
   output mag_O;
   output sig_O;

   reg 	 mag_O;
   reg 	 sig_O;
   wire  clk;
   
   wire signed [NRes-1:0]  out;  

   mix mix(.clk(clk), .out(out), .RESET(reset_n));    
   
   always @(posedge clk) begin
      if (out > 0) begin
	 if (out >= Por) begin
	    sig_O <= 0;
	    mag_O <= 1;
	 end else begin
	    sig_O <= 0;
	    mag_O <= 0;
	 end
      end else begin
	 if (out < -Por) begin
	    sig_O <= 1;
	    mag_O <= 1;
	 end else begin
	    sig_O <= 1;
	    mag_O <= 0;
	 end
      end
   end

endmodule // mix_wrap
