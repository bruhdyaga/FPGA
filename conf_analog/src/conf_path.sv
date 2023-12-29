module conf_path (

input clk,
input rst,
input R1_DET1_V,
input R1_DET2_V,

output R1_PWR_EN,
output R1_FILTER_SW1,
output R1_FILTER_SW2,
output R1_ATT1_10,
output R1_ATT1_20,
output R1_PRESS_SW1
output R1_PRESS_SW2
output R1_ATT2_1,
output R1_ATT2_2,
output R1_ATT2_4,
output R1_ATT2_8,
output R1_ATT2_16,
output R1_IF_SW_BUF

);


always @(posedge clk or negedge rst)

begin
    if(!rst)
    begin
        R1_PWR_EN   <= 1'b0;

        R1_FILTER_SW1 <= 1'b0;
        R1_FILTER_SW2 <= 1'b0;
        R1_ATT1_10    <= 1'b0;
        R1_ATT1_20    <= 1'b0;
        R1_PRESS_SW1  <= 1'b0;
        R1_PRESS_SW2  <= 1'b0;
        R1_ATT2_1     <= 1'b0;
        R1_ATT2_2     <= 1'b0;
        R1_ATT2_4     <= 1'b0;
        R1_ATT2_8     <= 1'b0;
        R1_ATT2_16    <= 1'b0;
        R1_IF_SW_BUF  <= 1'b0;
    end
    else begin
// PWR  //
        R1_PWR_EN     <= 1'b0; 

// List 15 //
        R1_FILTER_SW1 <= 1'b0;  
        R1_FILTER_SW2 <= 1'b0;

// List 16 //
        R1_ATT1_10    <= 1'b0;  
        R1_ATT1_20    <= 1'b0;

// List 17 //
        R1_PRESS_SW1  <= 1'b0;
        R1_PRESS_SW2  <= 1'b0;

// List 18 //
        R1_ATT2_1     <= 1'b0;
        R1_ATT2_2     <= 1'b0;
        R1_ATT2_4     <= 1'b0;
        R1_ATT2_8     <= 1'b0;
        R1_ATT2_16    <= 1'b0;

// List 19 //
        R1_IF_SW_BUF  <= 1'b0;

    end
end
endmodule






