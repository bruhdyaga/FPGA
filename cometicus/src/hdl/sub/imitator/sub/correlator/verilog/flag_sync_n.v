module flag_sync_n(
    sclk,
    dclk,
    reset_n,
    set_pulse,
    rst_pulse,
    flag
);

    input sclk;
    input dclk;
    input reset_n;
    input [15 : 0] set_pulse;
    input rst_pulse;
    output flag;
 
    reg flag;    

   wire [15 : 0] set_pulse_sync;

   genvar iB;
   
   generate
      for (iB=0; iB < 16; iB = iB + 1) begin:FB
	 signal_sync sync(
			  .sclk      (sclk),
			  .dclk      (dclk),
			  .reset_n   (reset_n),
			  .start     (set_pulse[iB]),
			  .ready     (set_pulse_sync[iB])
			  );
      end
   endgenerate
    
    always @ (posedge dclk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            flag <= 1'b0;      
        end
        else begin
            if (set_pulse_sync == 16'h12AB) begin
                flag <= 1'b1;
            end
            else if (rst_pulse == 1'b1) begin
                flag <= 1'b0;
            end
        end        
    end
    
endmodule
