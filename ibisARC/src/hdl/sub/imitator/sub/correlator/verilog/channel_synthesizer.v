`timescale 1ns/10ps


module channel_synthesizer (
    clk,
    reset_n,
    phase_rate,
    doinit,
    intr_pulse,
    epoch_pulse,
    phase_rate_int,
    phase_int,
    phase_cycles_int,
    phase_addr
    );
    
  input clk;
  input reset_n;
  input [31 : 0] phase_rate;
  input doinit;
  input intr_pulse;
  input epoch_pulse;
  output [31 : 0] phase_rate_int;
  output [31 : 0] phase_int;
  output [31 : 0] phase_cycles_int;
  output [4 : 0 ] phase_addr;
  
  reg [31 : 0] phase_rate_int;
  reg [31 :0] phase_int;
  reg [31 : 0] phase_cycles_int;
  reg [31 : 0] phase_counter;
  reg [31 : 0] phase_cycles;

  wire [32 : 0] phase_counter_sum;
  
  //Frequency register
  always @ (posedge clk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      phase_rate_int <= 32'b0;
    end
    else begin
      if (((doinit == 1'b1) & (intr_pulse == 1'b1)) | epoch_pulse) begin
        phase_rate_int <= phase_rate;
      end
    end
  end
  
  //Phase counter
  always @ (posedge clk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      phase_counter <= 32'b0;
    end
    else begin
      if ((doinit == 1'b1) & (intr_pulse == 1'b1)) begin
        phase_counter[31 : 0] <= 32'b0;
      end
      else begin
        phase_counter[31 : 0] <= phase_counter_sum[31 : 0];
      end
    end
  end
  
  assign phase_counter_sum[32 : 0] = phase_counter[31 : 0] + phase_rate_int[31 : 0];
  
  assign phase_addr = phase_counter[31 : 27];
  
  //Phase_cycles counter
  always @ (posedge clk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      phase_cycles <= 32'b0;
    end
    else begin
      if (phase_rate[31] == 1'b0) begin
         if (phase_counter_sum[32]) begin
           phase_cycles <= phase_cycles + 1'b1;
         end
      end 
      else begin
         if (phase_counter_sum[32] == 1'b0) begin
            phase_cycles <= phase_cycles - 1'b1;
         end
      end
    end
  end
  
  //phase regiter is latched when interrupt pulse asserted
  always @ (posedge clk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      phase_int <= 32'b0;
    end
    else if (intr_pulse == 1'b1) begin
      phase_int[31 : 0] <= phase_counter[31 : 0];
    end
  end  
  
  //phase regiter is latched when interrupt pulse asserted
  always @ (posedge clk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      phase_cycles_int <= 32'b0;
    end
    else if (intr_pulse == 1'b1) begin
      phase_cycles_int[31 : 0] <= phase_cycles[31 : 0];
    end
  end  


endmodule
