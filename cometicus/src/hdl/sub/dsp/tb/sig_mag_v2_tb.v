`timescale 1ns/1ns
module sig_mag_v2_tb();

parameter N_dig_in = 14;
parameter LENGTH_N = 14;
parameter LENGTH = 2**LENGTH_N;//длина тестовой выборки

reg [LENGTH_N-1:0] in_adr;
reg signed [N_dig_in-1:0] in_dat [LENGTH-1:0];
reg signed [N_dig_in-1:0] in_dat_reg;
reg [15:0] k_scale;

parameter SIG_CNTR_SIZE = 12;
reg [SIG_CNTR_SIZE-1:0] sigmag_cntr_period;
reg [SIG_CNTR_SIZE-1:0] sig_cntr;
reg [SIG_CNTR_SIZE-1:0] mag_cntr;
reg [6:0] sig_res;
reg [6:0] mag_res;

reg clk = 1;
reg resetn;

always #5 clk = !clk;

initial begin
resetn = 1'b1;
#50 resetn = 1'b0;
#50 resetn = 1'b1;
end

initial
$readmemh ("noise.txt", in_dat);

always@(posedge clk or negedge resetn)
if(resetn == 0)
	in_adr <= 0;
else
	in_adr <= in_adr + 1'b1;

initial begin
k_scale = 1;
#3000000 k_scale = 2;
end

always@(posedge clk or negedge resetn)
if(resetn == 0)
	in_dat_reg <= 0;
else
	in_dat_reg <= in_dat[in_adr] * k_scale;

sig_mag_v2#(
	.width(N_dig_in)
)
sig_mag_v2_inst(
	.clk     (clk),
	.resetn  (resetn),
	.data_in (0),//signed
	.sig     (sig),
	.mag     (mag)
);

always@(posedge clk or negedge resetn)
if(resetn == 0)
	sigmag_cntr_period <= 0;
else
	sigmag_cntr_period <= sigmag_cntr_period + 1'b1;

assign sigmag_lch = (sigmag_cntr_period == 0);

always@(posedge clk or negedge resetn)
if(resetn == 0)
	sig_cntr <= 0;
else
	if(sigmag_lch)
		sig_cntr <= 0;
	else
		if(sig)
			sig_cntr <= sig_cntr + 1'b1;

always@(posedge clk or negedge resetn)
if(resetn == 0)
	mag_cntr <= 0;
else
	if(sigmag_lch)
		mag_cntr <= 0;
	else
		if(mag)
			mag_cntr <= mag_cntr + 1'b1;

always@(posedge clk or negedge resetn)
if(resetn == 0) begin
	sig_res <= 0;
	mag_res <= 0;
end else
	if(sigmag_lch) begin
		sig_res <= (sig_cntr*100)/(2**SIG_CNTR_SIZE);
		mag_res <= (mag_cntr*100)/(2**SIG_CNTR_SIZE);
	end

endmodule