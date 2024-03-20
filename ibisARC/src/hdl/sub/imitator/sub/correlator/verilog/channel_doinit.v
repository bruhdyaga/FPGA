`timescale 1ns/10ps
module channel_doinit (
    clk,
    reset_n,
    doinit_pulse,
    intr_pulse,
    doinit
    );
    
  input clk;
  input reset_n;
  input doinit_pulse;
  input intr_pulse;
  output doinit;
  
  reg doinit;
  
  //do_init is asserted when we write 1 to do_init bit and clear when interrupt pulse is asserted
  always @ (posedge clk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      doinit <= 1'b0;      
    end
    else begin
      if (doinit_pulse == 1'b1) begin
        doinit <= 1'b1;
      end
      else if (intr_pulse == 1'b1) begin
        doinit <= 1'b0;
      end
    end        
  end
  
endmodule
