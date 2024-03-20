`timescale 1ns/10ps

module channel_adder (
    clk,
    reset_n,    
    doinit,
    intr_pulse,
    epoch,
    promt_cos_product,
    promt_sin_product,
`ifdef EARLY_I    
    early_cos_product,
`endif
`ifdef EARLY_Q    
    early_sin_product,
`endif
`ifdef EARLY_EARLY_I    
    earlyearly_cos_product,
`endif
`ifdef EARLY_EARLY_Q    
    earlyearly_sin_product,
`endif
`ifdef LATE_I    
    late_cos_product,
`endif
`ifdef LATE_Q    
    late_sin_product,
`endif
`ifdef LATE_LATE_I    
    latelate_cos_product,
`endif    
`ifdef LATE_LATE_Q    
    latelate_sin_product,
`endif    
    iq_shift,    
`ifdef EARLY_Q    
    earlyq_int,
`endif    
`ifdef EARLY_I
    earlyi_int,
`endif    
`ifdef EARLY_EARLY_Q
    earlyearlyq_int,
`endif
`ifdef EARLY_EARLY_I    
    earlyearlyi_int,
`endif    
`ifdef LATE_Q    
    lateq_int,
`endif    
`ifdef LATE_I
    latei_int,
`endif    
`ifdef LATE_LATE_Q
    latelateq_int,
`endif
`ifdef LATE_LATE_I    
    latelatei_int,
`endif
    promtq_int,
    promti_int    
    );
    
    input clk;
    input reset_n;  
    input doinit;
    input intr_pulse;
    input epoch;
    input [4 : 0] promt_cos_product;
    input [4 : 0] promt_sin_product;
`ifdef EARLY_I  
    input [4 : 0] early_cos_product;
`endif  
`ifdef EARLY_Q
    input [4 : 0] early_sin_product;
`endif    
`ifdef EARLY_EARLY_I
    input [4 : 0] earlyearly_cos_product;
`endif
`ifdef EARLY_EARLY_Q
    input [4 : 0] earlyearly_sin_product;
`endif
`ifdef LATE_I    
    input [4 : 0] late_cos_product;
`endif    
`ifdef LATE_Q
    input [4 : 0] late_sin_product;
`endif
`ifdef LATE_LATE_I    
    input [4 : 0] latelate_cos_product;
`endif
`ifdef LATE_LATE_Q    
    input [4 : 0] latelate_sin_product;
`endif    
    input [1 : 0] iq_shift;    
`ifdef EARLY_Q    
    output [15 : 0] earlyq_int;
`endif
`ifdef EARLY_I    
    output [15 : 0] earlyi_int;
`endif
`ifdef EARLY_EARLY_Q    
    output [15 : 0] earlyearlyq_int;
`endif
`ifdef EARLY_EARLY_I    
    output [15 : 0] earlyearlyi_int;
`endif
`ifdef LATE_Q    
    output [15 : 0] lateq_int;
`endif
`ifdef LATE_I    
    output [15 : 0] latei_int;
`endif
`ifdef LATE_LATE_Q   
    output [15 : 0] latelateq_int;
`endif
`ifdef LATE_LATE_I    
    output [15 : 0] latelatei_int;
`endif    
    output [15 : 0] promtq_int;
    output [15 : 0] promti_int;
  
    reg [18 : 0] promtq_adder;
    reg [15 : 0] promtq_int;
    reg [18 : 0] promti_adder;
    reg [15 : 0] promti_int;
`ifdef EARLY_Q    
    reg [18 : 0] earlyq_adder;
    reg [15 : 0] earlyq_int;
`endif
`ifdef EARLY_I    
    reg [18 : 0] earlyi_adder;
    reg [15 : 0] earlyi_int;
`endif    
`ifdef EARLY_EARLY_Q
    reg [18 : 0] earlyearlyq_adder;
    reg [15 : 0] earlyearlyq_int;
`endif    
`ifdef EARLY_EARLY_I
    reg [18 : 0] earlyearlyi_adder;
    reg [15 : 0] earlyearlyi_int;
`endif
`ifdef LATE_Q    
    reg [18 : 0] lateq_adder;
    reg [15 : 0] lateq_int;
`endif
`ifdef LATE_I    
    reg [18 : 0] latei_adder;
    reg [15 : 0] latei_int;
`endif    
`ifdef LATE_LATE_Q
    reg [18 : 0] latelateq_adder;
    reg [15 : 0] latelateq_int;
`endif
`ifdef LATE_LATE_I    
    reg [18 : 0] latelatei_adder;
    reg [15 : 0] latelatei_int;
`endif    
  
  
    //Accumulators for promtq
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            promtq_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                promtq_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                promtq_adder[18 : 0] <= {{14{promt_sin_product[4]}},promt_sin_product[4 : 0]};
            end
            else begin
                    promtq_adder[18 : 0] <= promtq_adder[18 : 0] + {{14{promt_sin_product[4]}},promt_sin_product[4 : 0]};
            end
        end
    end
  
    //Latch promtq accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            promtq_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : promtq_int <= promtq_adder[15 : 0];
                2'b01 : promtq_int <= promtq_adder[16 : 1];
                2'b10 : promtq_int <= promtq_adder[17 : 2];
                2'b11 : promtq_int <= promtq_adder[18 : 3];
            endcase
        end
    end
  
    //Accumulators for promti
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            promti_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                promti_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                promti_adder[18 : 0] <= {{14{promt_cos_product[4]}},promt_cos_product[4 : 0]};
            end
            else begin
                promti_adder[18 : 0] <= promti_adder[18 : 0] + {{14{promt_cos_product[4]}},promt_cos_product[4 : 0]};
            end
        end
    end  
  
    //Latch promti accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            promti_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : promti_int <= promti_adder[15 : 0];
                2'b01 : promti_int <= promti_adder[16 : 1];
                2'b10 : promti_int <= promti_adder[17 : 2];
                2'b11 : promti_int <= promti_adder[18 : 3];
            endcase
        end
    end
    
`ifdef EARLY_Q  
    //Accumulators for earlyq
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            earlyq_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                earlyq_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                earlyq_adder[18 : 0] <= {{14{early_sin_product[4]}},early_sin_product[4 : 0]};
            end
            else begin
                earlyq_adder[18 : 0] <= earlyq_adder[18 : 0] + {{14{early_sin_product[4]}},early_sin_product[4 : 0]};
            end
        end
    end
  
    //Latch earlyq accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            earlyq_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : earlyq_int <= earlyq_adder[15 : 0];
                2'b01 : earlyq_int <= earlyq_adder[16 : 1];
                2'b10 : earlyq_int <= earlyq_adder[17 : 2];
                2'b11 : earlyq_int <= earlyq_adder[18 : 3];
            endcase
        end
    end
`endif    

`ifdef EARLY_I  
    //Accumulators for earlyi
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            earlyi_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                earlyi_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                earlyi_adder[18 : 0] <= {{14{early_cos_product[4]}},early_cos_product[4 : 0]};
            end
            else begin
                earlyi_adder[18 : 0] <= earlyi_adder[18 : 0] + {{14{early_cos_product[4]}},early_cos_product[4 : 0]};
            end
        end
    end  
  
    //Latch earlyi accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            earlyi_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : earlyi_int <= earlyi_adder[15 : 0];
                2'b01 : earlyi_int <= earlyi_adder[16 : 1];
                2'b10 : earlyi_int <= earlyi_adder[17 : 2];
                2'b11 : earlyi_int <= earlyi_adder[18 : 3];
            endcase
        end
    end
`endif    
  
`ifdef EARLY_EARLY_Q  
    //Accumulators for earlyearlyq
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            earlyearlyq_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                earlyearlyq_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                earlyearlyq_adder[18 : 0] <= {{14{earlyearly_sin_product[4]}},earlyearly_sin_product[4 : 0]};
            end
            else begin
                earlyearlyq_adder[18 : 0] <= earlyearlyq_adder[18 : 0] + {{14{earlyearly_sin_product[4]}},earlyearly_sin_product[4 : 0]};
            end
        end
    end
  
    //Latch earlyearlyq accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            earlyearlyq_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : earlyearlyq_int <= earlyearlyq_adder[15 : 0];
                2'b01 : earlyearlyq_int <= earlyearlyq_adder[16 : 1];
                2'b10 : earlyearlyq_int <= earlyearlyq_adder[17 : 2];
                2'b11 : earlyearlyq_int <= earlyearlyq_adder[18 : 3];
            endcase
        end
    end
`endif    
  
`ifdef EARLY_EARLY_I  
    //Accumulators for earlyearlyi
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            earlyearlyi_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                earlyearlyi_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                earlyearlyi_adder[18 : 0] <= {{14{earlyearly_cos_product[4]}},earlyearly_cos_product[4 : 0]};
            end
            else begin
                earlyearlyi_adder[18 : 0] <= earlyearlyi_adder[18 : 0] + {{14{earlyearly_cos_product[4]}},earlyearly_cos_product[4 : 0]};
            end
        end
    end  
  
    //Latch earlyearlyi accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            earlyearlyi_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : earlyearlyi_int <= earlyearlyi_adder[15 : 0];
                2'b01 : earlyearlyi_int <= earlyearlyi_adder[16 : 1];
                2'b10 : earlyearlyi_int <= earlyearlyi_adder[17 : 2];
                2'b11 : earlyearlyi_int <= earlyearlyi_adder[18 : 3];
            endcase
        end
    end
`endif    

`ifdef LATE_Q  
    //Accumulators for lateq
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            lateq_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                lateq_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                lateq_adder[18 : 0] <= {{14{late_sin_product[4]}},late_sin_product[4 : 0]};
            end
            else begin
                lateq_adder[18 : 0] <= lateq_adder[18 : 0] + {{14{late_sin_product[4]}},late_sin_product[4 : 0]};
            end
        end
    end
  
    //Latch earlyearlyq accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            lateq_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : lateq_int <= lateq_adder[15 : 0];
                2'b01 : lateq_int <= lateq_adder[16 : 1];
                2'b10 : lateq_int <= lateq_adder[17 : 2];
                2'b11 : lateq_int <= lateq_adder[18 : 3];
            endcase
        end
    end
`endif    
  
`ifdef LATE_I  
    //Accumulators for latei
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            latei_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                latei_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                latei_adder[18 : 0] <= {{14{late_cos_product[4]}},late_cos_product[4 : 0]};
            end
            else begin
                latei_adder[18 : 0] <= latei_adder[18 : 0] + {{14{late_cos_product[4]}},late_cos_product[4 : 0]};
            end
        end
    end  
  
    //Latch latei accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
              latei_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : latei_int <= latei_adder[15 : 0];
            2'b01 : latei_int <= latei_adder[16 : 1];
            2'b10 : latei_int <= latei_adder[17 : 2];
            2'b11 : latei_int <= latei_adder[18 : 3];
            endcase
        end
    end
`endif    

`ifdef LATE_LATE_Q  
    //Accumulators for latelateq
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            latelateq_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                latelateq_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                latelateq_adder[18 : 0] <= {{14{latelate_sin_product[4]}},latelate_sin_product[4 : 0]};
            end
            else begin
                latelateq_adder[18 : 0] <= latelateq_adder[18 : 0] + {{14{latelate_sin_product[4]}},latelate_sin_product[4 : 0]};
            end
        end
    end
  
    //Latch latelateq accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            latelateq_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : latelateq_int <= latelateq_adder[15 : 0];
                2'b01 : latelateq_int <= latelateq_adder[16 : 1];
                2'b10 : latelateq_int <= latelateq_adder[17 : 2];
                2'b11 : latelateq_int <= latelateq_adder[18 : 3];
            endcase
        end
    end
`endif

`ifdef LATE_LATE_I  
    //Accumulators for latelatei
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            latelatei_adder[18 : 0] <= 19'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1))) begin
                latelatei_adder[18 : 0] <= 19'b0;
            end
            else if (epoch) begin
                latelatei_adder[18 : 0] <= {{14{latelate_cos_product[4]}},latelate_cos_product[4 : 0]};
            end
            else begin
                latelatei_adder[18 : 0] <= latelatei_adder[18 : 0] + {{14{latelate_cos_product[4]}},latelate_cos_product[4 : 0]};
            end
        end
    end  
  
    //Latch latelatei accumulator value when epoch is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            latelatei_int <= 16'b0;
        end
        else if (epoch) begin
            case (iq_shift)
                2'b00 : latelatei_int <= latelatei_adder[15 : 0];
                2'b01 : latelatei_int <= latelatei_adder[16 : 1];
                2'b10 : latelatei_int <= latelatei_adder[17 : 2];
                2'b11 : latelatei_int <= latelatei_adder[18 : 3];
            endcase
        end
    end
`endif    


endmodule
