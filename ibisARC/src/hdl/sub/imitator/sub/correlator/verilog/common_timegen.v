`timescale 1ns/10ps

`include "common_param.v"


module common_timegen(
    clk,
    reset_n,
    time_enable,
    intr_period,
    intr_enable,
    intr_type,
    intr_polarity,
    intr_duration,
`ifdef INTERRUPT_DIV2    
    intr_div2_duration,
`endif    
    intr_release,
`ifdef INTERRUPT_DIV2      
    fix_div2_clear,
`endif      
    fix_pulse,
`ifdef INTERRUPT_DIV2      
    fix_div2,
`endif      
    time_0,
    time_1,
`ifdef DATA_COLLECTOR    
    time_int,
`endif    
    intr_cnt,
`ifdef INTERRUPT_DIV2      
    intr,
    intr_div2
`else
    intr
`endif      
    );
      
    input clk;
    input reset_n;
    input time_enable;
    input [`INTR_PERIOD_WIDTH - 1 : 0] intr_period;
    input intr_enable;
    input intr_type;
    input intr_polarity;
    input [`INTR_PULSE_DURATION_WIDTH - 1 : 0] intr_duration;
`ifdef INTERRUPT_DIV2  
    input [7 : 0] intr_div2_duration;
`endif      
    input intr_release;
`ifdef INTERRUPT_DIV2      
    input fix_div2_clear;
`endif      
    output fix_pulse;
`ifdef INTERRUPT_DIV2       
    output fix_div2;
`endif      
    output [31 : 0] time_0;  
    output [31 : 0] time_1;
    output [31 : 0] intr_cnt;
`ifdef DATA_COLLECTOR    
    output [63 : 0] time_int;
`endif    
    output intr;
`ifdef INTERRUPT_DIV2      
    output intr_div2;
`endif      
  
    reg [63 : 0] time_int;
    reg [`INTR_PERIOD_WIDTH - 1 : 0] intr_counter;
    reg [`INTR_PULSE_DURATION_WIDTH - 1 : 0] intr_duration_counter;
    reg intr_duration_enable;
    reg intr_int;
    reg [31 : 0] time_0;
    reg [31 : 0] time_1;
    reg [31 : 0] intr_cnt;
`ifdef INTERRUPT_DIV2    
    reg fix_pulse_cnt;
    reg [7 : 0] intr_div2_counter;
    reg intr_div2;
    reg fix_div2;
`endif      
      
    wire intr_counter_rst;  
    wire intr;  
  
    // Count time when time_enable is 1  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            time_int <= 64'b0;
        end
        else begin
            if (time_enable == 1'b1) begin
                time_int <= time_int + 1'b1;
            end
            else begin
                time_int <= 64'b0;
            end
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_cnt <= 32'b0;
        end
        else begin
            if (fix_pulse == 1'b1) begin
                intr_cnt <= intr_cnt + 1'b1;
            end            
        end
    end
  
    // Counter for forming interrupt
    // Reset counter when interrupt is disabled or counter is equal to intr_period register.
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_counter <= {`INTR_PERIOD_WIDTH{1'b0}};
        end
        else begin
            if (intr_counter_rst == 1'b1) begin
                intr_counter <= {`INTR_PERIOD_WIDTH{1'b0}};
            end
            else begin
                intr_counter <= intr_counter + 1'b1;
            end        
        end
    end
  
    assign intr_counter_rst = intr_enable ? (intr_counter == intr_period) : 1'b1;
     
    //Forming enable signal for interrupt pulse duration
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_duration_enable <= 1'b0;
        end
        else begin
            if ((~intr_enable) | (intr_type) | (intr_duration_counter == intr_duration) | (intr_duration == {`INTR_PULSE_DURATION_WIDTH{1'b0}})) begin
                intr_duration_enable <= 1'b0;
            end
            else if (fix_pulse) begin
                intr_duration_enable <= 1'b1;
            end
        end
    end           
  
    // Counter for forming interrupt pulse duration  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_duration_counter <= {`INTR_PULSE_DURATION_WIDTH{1'b0}};
        end
        else begin
            if (intr_duration_enable == 1'b1) begin
                intr_duration_counter <= intr_duration_counter + 1'b1;
            end        
            else begin
                intr_duration_counter <= {`INTR_PULSE_DURATION_WIDTH{1'b0}};
            end
        end
    end  
  
    //Interrupt forming
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_int <= 1'b0;
        end
        else begin
            if ((~intr_enable) | (~intr_type & (intr_duration_counter == intr_duration)) | (intr_type & intr_release)) begin
                intr_int <= 1'b0;
            end
            else if (fix_pulse) begin
                intr_int <= 1'b1;        
            end      
        end
    end
  
    assign intr = intr_polarity ? intr_int : ~intr_int;
  
    assign fix_pulse = intr_enable ? (intr_counter == intr_period) : 1'b0;

`ifdef INTERRUPT_DIV2
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            fix_pulse_cnt <= 1'b0;
        end
        else begin
            if (~intr_enable) begin
                fix_pulse_cnt <= 1'b0;
            end
            else if (fix_pulse) begin
                fix_pulse_cnt <= ~fix_pulse_cnt;        
            end      
        end
    end

    assign fix_pulse_div2 = intr_enable ? (fix_pulse_cnt & fix_pulse) : 1'b0;

    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_div2 <= 1'b0;
        end
        else begin
            if ((~(intr_enable)) | (intr_div2_counter == intr_div2_duration)) begin
                intr_div2 <= 1'b0;
            end
            else if (fix_pulse_div2) begin
                intr_div2 <= 1'b1;        
            end      
        end
    end

    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_div2_counter <= 8'b0;
        end
        else begin
            if ((~(intr_enable)) | (intr_div2_counter == intr_div2_duration)) begin
                intr_div2_counter <= 8'b0;
            end
            else if (fix_pulse_div2 | intr_div2) begin
                intr_div2_counter <= intr_div2_counter + 1'b1;        
            end      
        end
    end

    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            fix_div2 <= 1'b0;
        end
        else begin
            if (fix_div2_clear) begin
                fix_div2 <= 1'b0;
            end
            else if (fix_pulse_div2) begin
                fix_div2 <= 1'b1;        
            end      
        end
    end
`endif    
  
    // Fix data when interrupt is assert
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            time_0 <= 32'b0;
            time_1 <= 32'b0;
        end
        else begin
            if (fix_pulse) begin
                time_0 <= time_int[31 : 0];
                time_1 <= time_int[63 : 32];  
            end
        end
    end

endmodule
