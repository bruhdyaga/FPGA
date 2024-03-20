`timescale 1ns/10ps

`include "global_param.v"
`include "channel_param.v"

module channel_shift_reg (
    clk,
    reset_n,
    code_state1,
	code_reset_state1,
    code_bitmask1,
    code_out_bitmask1,
    code_state2,
	code_reset_state2,
    code_bitmask2,
    code_out_bitmask2,
    prn_length,
    prn_init,
    prn_length1,
    prn_init1,
	sr1,
	sr2,
`ifdef BOC_MOD    
    sub_cnt_init,
    sub_code_init,
    sub_ratio,
    shift_ratio,
`endif    
    doinit,    
    intr_pulse,
    shift,
    code_out,
    prn_reset
    );
    
    input clk;
    input reset_n;
    input [31 : 0] code_state1;
	input [31 : 0] code_reset_state1;
    input [31 : 0] code_bitmask1;
    input [31 : 0] code_out_bitmask1;
    input [31 : 0] code_state2;
	input [31 : 0] code_reset_state2;
    input [31 : 0] code_bitmask2;
    input [31 : 0] code_out_bitmask2;    
    input [31 : 0] prn_length;
    input [31 : 0] prn_init;
    input [31 : 0] prn_length1;
    input [31 : 0] prn_init1;
	output [31:0] sr1;
	output [31:0] sr2;
`ifdef BOC_MOD
    input [`BOC_REG_WIDTH - 1 : 0] sub_cnt_init;
    input sub_code_init;
    input [`BOC_REG_WIDTH - 1 : 0] sub_ratio;
    input [`BOC_REG_WIDTH - 1 : 0] shift_ratio;
`endif         
    input doinit;  
    input intr_pulse;
    input shift;
    output code_out;
    output  prn_reset;
  
    reg [31 : 0] sr1;
    reg [31 : 0] sr2;        
  
    reg [31 : 0] prn_counter;
    reg [31 : 0] prn_counter1;        
    
`ifdef BOC_MOD
    reg [`BOC_REG_WIDTH - 1 : 0] sub_cnt;
    reg sub_code;
    
    wire sub_shift;
    wire [`BOC_REG_WIDTH - 1 : 0] sub_cnt_sum;

    reg [`BOC_REG_WIDTH - 1 : 0] shift_cnt;
    wire [`BOC_REG_WIDTH - 1 : 0] shift_cnt_sum;
    wire shift_shift;
`endif        
  
    wire sr1_xor;
    wire sr2_xor;
    wire sr1_out;
    wire sr2_out;
    wire sr_shift;
    wire prn_reset;
    wire prn_reset1;  
    
`ifdef BOC_MOD
    // shift frequency divider
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            shift_cnt <= 4'b0;
        end
        else begin
            if ((doinit == 1'b1) & (intr_pulse == 1'b1)) begin
                shift_cnt <= 4'b0;
            end        
            else if (shift_ratio == 0) begin
                shift_cnt <= 4'b0;
            end
            else if (shift) begin            
                if (shift_cnt_sum == shift_ratio) begin
                    shift_cnt <= 4'b0;
                end
                else begin            
                    shift_cnt <= shift_cnt_sum;
                end
            end
        end            
    end
    assign shift_cnt_sum = shift_cnt + 1'b1;

    // sub_shift frequency divider
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            sub_cnt <= 4'b0;
        end
        else begin
            if ((doinit == 1'b1) & (intr_pulse == 1'b1)) begin
                sub_cnt <= sub_cnt_init;
            end        
            else if (sub_ratio == 0) begin
                sub_cnt <= 4'b0;
            end
            else if (sub_shift) begin            
                if (sub_cnt_sum == sub_ratio) begin
                    sub_cnt <= 4'b0;
                end
                else begin            
                    sub_cnt <= sub_cnt_sum;
                end
            end
        end            
    end
    assign sub_cnt_sum = sub_cnt + 1'b1;

    // Subcarrier generator
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            sub_code <= 0;
        end
        else begin
            if ((doinit == 1'b1) & (intr_pulse == 1'b1)) begin
                 sub_code <= sub_code_init;
            end
            else if (sub_ratio != 0) begin
                if (sub_shift) begin
                    sub_code <= ~sub_code;
                end
            end
        end
    end                
          

    // sub_shift pulse generation
    assign sub_shift = (shift_ratio == 0) ? shift : ((shift_cnt_sum == shift_ratio) & shift);

    // sr_shift generation
    assign sr_shift = (sub_ratio == 0) ? sub_shift : ((sub_cnt_sum == sub_ratio) & sub_shift);
`else  
    assign sr_shift = shift;    
`endif    
  
    //prn_counter
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            prn_counter <= 32'b0;
        end
        else begin
            if ((doinit == 1'b1) & (intr_pulse == 1'b1)) begin
                prn_counter <= prn_init;
            end
			else if(prn_reset1 == 1'b1) begin
				prn_counter <= 32'b0;
			end
            else if (prn_reset == 1'b1) begin
                prn_counter <= 32'b0;
            end
            else if (sr_shift == 1'b1) begin
                prn_counter <= prn_counter + 1'b1;
            end
        end
    end
  
    assign prn_reset = (prn_counter == prn_length) & sr_shift;
  
    //prn_counter
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            prn_counter1 <= 32'b0;
        end
        else begin
            if ((doinit == 1'b1) & (intr_pulse == 1'b1)) begin
                prn_counter1 <= prn_init1;
            end
			else if(prn_reset1 == 1'b1) begin
				prn_counter1 <= 32'b0;
			end
            else if (prn_reset == 1'b1) begin
                prn_counter1 <= 32'b0;
            end
            else if (sr_shift == 1'b1) begin
                prn_counter1 <= prn_counter1 + 1'b1;
            end
        end
    end
  
    assign prn_reset1 = (prn_counter1 == prn_length1) & sr_shift;    
  
    //First sfift register
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            sr1 <= 32'b0;           
        end
        else begin
            if ((doinit == 1'b1) & (intr_pulse == 1'b1)) begin
                sr1 <= code_state1;       
            end
			else if(prn_reset | prn_reset1) begin
				sr1 <= code_reset_state1;
			end
            else if (sr_shift == 1'b1) begin
                sr1 <= {sr1_xor,sr1[31 : 1]};      
            end
        end
    end 
  
    //Second shift register
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin      
            sr2 <= 32'b0;
        end
        else begin   
            if ((doinit == 1'b1) & (intr_pulse == 1'b1)) begin
                sr2 <= code_state2;       
            end
			else if(prn_reset | prn_reset1) begin
				sr2 <= code_reset_state2;
			end
            else if (sr_shift == 1'b1) begin
                sr2 <= {sr2_xor,sr2[31 : 1]};
            end         
        end
    end 
  
    assign sr1_xor = (code_bitmask1[0] & sr1[0]) ^ (code_bitmask1[1] & sr1[1]) ^ (code_bitmask1[2] & sr1[2]) ^ (code_bitmask1[3] & sr1[3]) ^
        (code_bitmask1[4] & sr1[4]) ^ (code_bitmask1[5] & sr1[5]) ^ (code_bitmask1[6] & sr1[6]) ^ (code_bitmask1[7] & sr1[7]) ^
        (code_bitmask1[8] & sr1[8]) ^ (code_bitmask1[9] & sr1[9]) ^ (code_bitmask1[10] & sr1[10]) ^ (code_bitmask1[11] & sr1[11]) ^
        (code_bitmask1[12] & sr1[12]) ^ (code_bitmask1[13] & sr1[13]) ^ (code_bitmask1[14] & sr1[14]) ^ (code_bitmask1[15] & sr1[15]) ^
        (code_bitmask1[16] & sr1[16]) ^ (code_bitmask1[17] & sr1[17]) ^ (code_bitmask1[18] & sr1[18]) ^ (code_bitmask1[19] & sr1[19]) ^
        (code_bitmask1[20] & sr1[20]) ^ (code_bitmask1[21] & sr1[21]) ^ (code_bitmask1[22] & sr1[22]) ^ (code_bitmask1[23] & sr1[23]) ^
        (code_bitmask1[24] & sr1[24]) ^ (code_bitmask1[25] & sr1[25]) ^ (code_bitmask1[26] & sr1[26]) ^ (code_bitmask1[27] & sr1[27]) ^
        (code_bitmask1[28] & sr1[28]) ^ (code_bitmask1[29] & sr1[29]) ^ (code_bitmask1[30] & sr1[30]) ^ (code_bitmask1[31] & sr1[31]);
    assign sr2_xor = (code_bitmask2[0] & sr2[0]) ^ (code_bitmask2[1] & sr2[1]) ^ (code_bitmask2[2] & sr2[2]) ^ (code_bitmask2[3] & sr2[3]) ^
        (code_bitmask2[4] & sr2[4]) ^ (code_bitmask2[5] & sr2[5]) ^ (code_bitmask2[6] & sr2[6]) ^ (code_bitmask2[7] & sr2[7]) ^
        (code_bitmask2[8] & sr2[8]) ^ (code_bitmask2[9] & sr2[9]) ^ (code_bitmask2[10] & sr2[10]) ^ (code_bitmask2[11] & sr2[11]) ^
        (code_bitmask2[12] & sr2[12]) ^ (code_bitmask2[13] & sr2[13]) ^ (code_bitmask2[14] & sr2[14]) ^ (code_bitmask2[15] & sr2[15]) ^
        (code_bitmask2[16] & sr2[16]) ^ (code_bitmask2[17] & sr2[17]) ^ (code_bitmask2[18] & sr2[18]) ^ (code_bitmask2[19] & sr2[19]) ^
        (code_bitmask2[20] & sr2[20]) ^ (code_bitmask2[21] & sr2[21]) ^ (code_bitmask2[22] & sr2[22]) ^ (code_bitmask2[23] & sr2[23]) ^
        (code_bitmask2[24] & sr2[24]) ^ (code_bitmask2[25] & sr2[25]) ^ (code_bitmask2[26] & sr2[26]) ^ (code_bitmask2[27] & sr2[27]) ^
        (code_bitmask2[28] & sr2[28]) ^ (code_bitmask2[29] & sr2[29]) ^ (code_bitmask2[30] & sr2[30]) ^ (code_bitmask2[31] & sr2[31]);
  
  
    assign sr1_out = (code_out_bitmask1[0] & sr1[0]) ^ (code_out_bitmask1[1] & sr1[1]) ^ (code_out_bitmask1[2] & sr1[2]) ^ (code_out_bitmask1[3] & sr1[3]) ^
        (code_out_bitmask1[4] & sr1[4]) ^ (code_out_bitmask1[5] & sr1[5]) ^ (code_out_bitmask1[6] & sr1[6]) ^ (code_out_bitmask1[7] & sr1[7]) ^
        (code_out_bitmask1[8] & sr1[8]) ^ (code_out_bitmask1[9] & sr1[9]) ^ (code_out_bitmask1[10] & sr1[10]) ^ (code_out_bitmask1[11] & sr1[11]) ^
        (code_out_bitmask1[12] & sr1[12]) ^ (code_out_bitmask1[13] & sr1[13]) ^ (code_out_bitmask1[14] & sr1[14]) ^ (code_out_bitmask1[15] & sr1[15]) ^
        (code_out_bitmask1[16] & sr1[16]) ^ (code_out_bitmask1[17] & sr1[17]) ^ (code_out_bitmask1[18] & sr1[18]) ^ (code_out_bitmask1[19] & sr1[19]) ^
        (code_out_bitmask1[20] & sr1[20]) ^ (code_out_bitmask1[21] & sr1[21]) ^ (code_out_bitmask1[22] & sr1[22]) ^ (code_out_bitmask1[23] & sr1[23]) ^
        (code_out_bitmask1[24] & sr1[24]) ^ (code_out_bitmask1[25] & sr1[25]) ^ (code_out_bitmask1[26] & sr1[26]) ^ (code_out_bitmask1[27] & sr1[27]) ^
        (code_out_bitmask1[28] & sr1[28]) ^ (code_out_bitmask1[29] & sr1[29]) ^ (code_out_bitmask1[30] & sr1[30]) ^ (code_out_bitmask1[31] & sr1[31]);
    assign sr2_out = (code_out_bitmask2[0] & sr2[0]) ^ (code_out_bitmask2[1] & sr2[1]) ^ (code_out_bitmask2[2] & sr2[2]) ^ (code_out_bitmask2[3] & sr2[3]) ^
        (code_out_bitmask2[4] & sr2[4]) ^ (code_out_bitmask2[5] & sr2[5]) ^ (code_out_bitmask2[6] & sr2[6]) ^ (code_out_bitmask2[7] & sr2[7]) ^
        (code_out_bitmask2[8] & sr2[8]) ^ (code_out_bitmask2[9] & sr2[9]) ^ (code_out_bitmask2[10] & sr2[10]) ^ (code_out_bitmask2[11] & sr2[11]) ^
        (code_out_bitmask2[12] & sr2[12]) ^ (code_out_bitmask2[13] & sr2[13]) ^ (code_out_bitmask2[14] & sr2[14]) ^ (code_out_bitmask2[15] & sr2[15]) ^
        (code_out_bitmask2[16] & sr2[16]) ^ (code_out_bitmask2[17] & sr2[17]) ^ (code_out_bitmask2[18] & sr2[18]) ^ (code_out_bitmask2[19] & sr2[19]) ^
        (code_out_bitmask2[20] & sr2[20]) ^ (code_out_bitmask2[21] & sr2[21]) ^ (code_out_bitmask2[22] & sr2[22]) ^ (code_out_bitmask2[23] & sr2[23]) ^
        (code_out_bitmask2[24] & sr2[24]) ^ (code_out_bitmask2[25] & sr2[25]) ^ (code_out_bitmask2[26] & sr2[26]) ^ (code_out_bitmask2[27] & sr2[27]) ^
        (code_out_bitmask2[28] & sr2[28]) ^ (code_out_bitmask2[29] & sr2[29]) ^ (code_out_bitmask2[30] & sr2[30]) ^ (code_out_bitmask2[31] & sr2[31]);

`ifdef BOC_MOD  
    assign code_out = sub_code ^ (sr1_out ^ sr2_out);
`else
    assign code_out = sr1_out ^ sr2_out;
`endif
      
endmodule
