`timescale 1ns/1ns
`include "global_param.v"
`include "channel_param.v"
module channel_shift_reg_tb();

reg clk = 1;
reg reset = 1;
reg doinit = 0;
reg [31:0] shift_cnt=0;

always #5 clk = !clk;

initial begin
#200 reset = 0;
#200 reset = 1;
#100 doinit = 1;
#100 doinit = 0;
end

always@(posedge clk)
if(shift_cnt == 3)
	shift_cnt <= 0;
else
	shift_cnt <= shift_cnt + 1'b1;

assign shift = (shift_cnt==1);

channel_shift_reg channel_shift_reg_inst(
    .clk               (clk),
    .reset_n           (reset),
    .code_state1       (32'hFFFFFFFF),
	.code_reset_state1 (32'hFFFFFFFF),
    .code_bitmask1     (32'h08800000),
    .code_out_bitmask1 (32'h02000000),
    .code_state2       (0),
	.code_reset_state2 (0),
    .code_bitmask2     (0),
    .code_out_bitmask2 (0),
    .prn_length        (32'd510),
    .prn_init          (0),
    .prn_length1       (32'd510),
    .prn_init1         (0),
	.sr1               (),
	.sr2               (),
`ifdef BOC_MOD    
    .sub_cnt_init      (0),
    .sub_code_init     (0),
    .sub_ratio         (4),
    .shift_ratio       (2),
`endif    
    .doinit            (doinit),    
    .intr_pulse        (1'b1),
    .shift             (shift),
    .code_out          (),
    .prn_reset         ()
);


endmodule