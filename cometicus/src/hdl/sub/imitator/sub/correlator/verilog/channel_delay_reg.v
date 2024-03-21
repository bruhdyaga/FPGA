`timescale 1ns/10ps

module channel_delay_reg (
    clk,
    reset_n,
    code,
    epoch_pulse,
`ifdef EARLY_I
    delay1,
`elsif EARLY_Q
    delay1,
`elsif LATE_I
    delay1,
`elsif LATE_Q
    delay1,     
//`ifdef ((EARLY_I | EARLY_Q) | (LATE_I | LATE_Q))   
//    delay1,
`endif    
`ifdef EARLY_EARLY_I
    delay2,
`elsif EARLY_EARLY_Q
    delay2,
`elsif LATE_LATE_I
    delay2,
`elsif LATE_LATE_Q
    delay2,
//`ifdef ((EARLY_EARLY_I | EARLY_EARLY_Q) | (LATE_LATE_I | LATE_LATE_Q))  
//    delay2,
`endif    
    promt_code,
`ifdef EARLY_I
    early_code,
`elsif EARLY_Q
    early_code,
//`ifdef (EARLY_I | EARLY_Q)        
//    early_code,
`endif
`ifdef EARLY_EARLY_I
    earlyearly_code,
`elsif EARLY_EARLY_Q
    earlyearly_code,
//`ifdef (EARLY_EARLY_I | EARLY_EARLY_Q)
//    earlyearly_code,
`endif
`ifdef LATE_I
    late_code,
`elsif LATE_Q 
    late_code,
//`ifdef (LATE_I | LATE_Q)    
//    late_code,
`endif
`ifdef LATE_LATE_I
    latelate_code,
`elsif LATE_LATE_Q 
    latelate_code,
//`ifdef (LATE_LATE_I | LATE_LATE_Q)    
//    latelate_code,
`endif    
    dly_epoch
    );
    
    input clk;
    input reset_n;
    input code;
    input epoch_pulse;
`ifdef EARLY_I
    input [5 : 0] delay1;
`elsif EARLY_Q
    input [5 : 0] delay1;
`elsif LATE_I      
    input [5 : 0] delay1;
`elsif LATE_Q
    input [5 : 0] delay1;     
//`ifdef ((EARLY_I | EARLY_Q) | (LATE_I | LATE_Q))  
//    input [5 : 0] delay1;
`endif
`ifdef EARLY_EARLY_I
    input [5 : 0] delay2;
`elsif EARLY_EARLY_Q
    input [5 : 0] delay2;
`elsif LATE_LATE_I
    input [5 : 0] delay2;
`elsif LATE_LATE_Q
    input [5 : 0] delay2;
//`ifdef ((EARLY_EARLY_I | EARLY_EARLY_Q) | (LATE_LATE_I | LATE_LATE_Q))      
//    input [5 : 0] delay2;
`endif    
    output promt_code;
`ifdef EARLY_I    
    output early_code;
`elsif EARLY_Q
    output early_code;     
//`ifdef (EARLY_I | EARLY_Q)    
//    output early_code;
`endif    
`ifdef EARLY_EARLY_I
    output earlyearly_code;
`elsif EARLY_EARLY_Q
    output earlyearly_code;
//`ifdef (EARLY_EARLY_I | EARLY_EARLY_Q)
//    output earlyearly_code;
`endif
`ifdef LATE_I
    output late_code;
`elsif LATE_Q
    output late_code;
//`ifdef (LATE_I | LATE_Q)
//    output late_code;
`endif
`ifdef LATE_LATE_I
    output latelate_code;
`elsif LATE_LATE_Q
    output latelate_code;
//`ifdef (LATE_LATE_I | LATE_LATE_Q)       
//    output latelate_code;
`endif    
    output dly_epoch;

`ifdef EARLY_I
    reg [128 : 0] code_delay;
`elsif EARLY_Q
    reg [128 : 0] code_delay;
`elsif EARLY_EARLY_I
    reg [128 : 0] code_delay;     
`elsif EARLY_EARLY_Q
    reg [128 : 0] code_delay;
`elsif LATE_I
    reg [128 : 0] code_delay;
`elsif LATE_Q
    reg [128 : 0] code_delay;
`elsif LATE_LATE_I
    reg [128 : 0] code_delay;
`elsif LATE_LATE_Q
    reg [128 : 0] code_delay;                         
//`ifdef (EARLY_I | EARLY_Q | EARLY_EARLY_I | EARLY_EARLY_Q | LATE_I | LATE_Q | LATE_LATE_I | LATE_LATE_Q)      
//    reg [128 : 0] code_delay;
`else
    reg [64 : 0] code_delay; 
`endif       
    reg [64 : 0] epoch_delay;    
  
    always @ (posedge clk or negedge reset_n) begin        
        if (reset_n == 1'b0) begin
            code_delay <= 129'b0;
        end
        else begin
`ifdef EARLY_I
            code_delay <= {code,code_delay[128 : 1]};
`elsif EARLY_Q
            code_delay <= {code,code_delay[128 : 1]};
`elsif EARLY_EARLY_I
            code_delay <= {code,code_delay[128 : 1]};
`elsif EARLY_EARLY_Q
            code_delay <= {code,code_delay[128 : 1]};
`elsif LATE_I
            code_delay <= {code,code_delay[128 : 1]};
`elsif LATE_Q
            code_delay <= {code,code_delay[128 : 1]};
`elsif LATE_LATE_I
            code_delay <= {code,code_delay[128 : 1]};
`elsif LATE_LATE_Q
            code_delay <= {code,code_delay[128 : 1]};                                                                        
//`ifdef (EARLY_I | EARLY_Q | EARLY_EARLY_I | EARLY_EARLY_Q | LATE_I | LATE_Q | LATE_LATE_I | LATE_LATE_Q)        
//            code_delay <= {code,code_delay[128 : 1]};
`else
            code_delay <= {code,code_delay[64 : 1]};
`endif            
        end
    end

`ifdef EARLY_I
    assign promt_code = code_delay[64];
`elsif EARLY_Q
    assign promt_code = code_delay[64];
`elsif EARLY_EARLY_I
    assign promt_code = code_delay[64];
`elsif EARLY_EARLY_Q
    assign promt_code = code_delay[64];        
`elsif LATE_I
    assign promt_code = code_delay[64];
`elsif LATE_Q
    assign promt_code = code_delay[64];
`elsif LATE_LATE_I
    assign promt_code = code_delay[64];
`elsif LATE_LATE_Q
    assign promt_code = code_delay[64];                
//`ifdef (EARLY_I | EARLY_Q | EARLY_EARLY_I | EARLY_EARLY_Q | LATE_I | LATE_Q | LATE_LATE_I | LATE_LATE_Q)
//    assign promt_code = code_delay[64];
`else
    assign promt_code = code_delay[0];
`endif    
  
`ifdef EARLY_I
    assign early_code = code_delay[64 + (delay1 + 1)];
`elsif EARLY_Q
    assign early_code = code_delay[64 + (delay1 + 1)];     
//`ifdef (EARLY_I | EARLY_Q)   
//    assign early_code = code_delay[64 + (delay1 + 1)];
`endif
`ifdef EARLY_EARLY_I
    assign earlyearly_code = code_delay[64 + (delay2 + 1)];
`elsif EARLY_EARLY_Q
    assign earlyearly_code = code_delay[64 + (delay2 + 1)];
//`ifdef ((EARLY_EARLY_I | EARLY_EARLY_Q) | (LATE_LATE_I | LATE_LATE_Q))    
//    assign earlyearly_code = code_delay[64 + (delay2 + 1)];
`endif
`ifdef LATE_I
    assign late_code = code_delay[64 - (delay1 + 1)];
`elsif LATE_Q     
    assign late_code = code_delay[64 - (delay1 + 1)];
//`ifdef (LATE_I | LATE_Q)    
//    assign late_code = code_delay[64 - (delay1 + 1)];
`endif
`ifdef LATE_LATE_I
    assign latelate_code = code_delay[64 - (delay2 + 1)];
`elsif LATE_LATE_Q     
    assign latelate_code = code_delay[64 - (delay2 + 1)];
//`ifdef (LATE_LATE_I | LATE_LATE_Q)  
//    assign latelate_code = code_delay[64 - (delay2 + 1)];
`endif    
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_delay <= 65'b0;
        end
        else begin      
            epoch_delay <= {epoch_pulse,epoch_delay[64 : 1]};
        end
    end
  
    assign dly_epoch = epoch_delay[0];

endmodule
