`timescale 1ns/1ns
module mean_compens_v2_tb();

parameter N_dig_in = 14;
parameter LENGTH_N = 14;
parameter LENGTH = 2**LENGTH_N;//длина тестовой выборки

reg [LENGTH_N-1:0] in_adr;
reg signed [N_dig_in-1:0] in_dat [LENGTH-1:0];
wire signed [N_dig_in-1:0] in_dat_add;
wire signed [N_dig_in-1:0] out_dat;
wire valid;

reg [15:0] err_mean;

reg clk = 1;
reg resetn;

parameter SIG_CNTR_SIZE = 12;
reg [SIG_CNTR_SIZE-1:0] sigmag_cntr_period;
reg [SIG_CNTR_SIZE-1:0] sig_cntr;
reg [SIG_CNTR_SIZE-1:0] mag_cntr;
reg [6:0] sig_res;
reg [6:0] mag_res;

always #5 clk = !clk;

initial
begin
    resetn = 1'b1;
#50 resetn = 1'b0;
#40 resetn = 1'b1;
end

initial
$readmemh ("noise.txt", in_dat);

initial begin
err_mean = 100;
#700000 err_mean = 100;
end

always@(posedge clk or negedge resetn)
if(resetn == 0)
	in_adr <= 0;
else
	in_adr <= in_adr + 1'b1;

assign in_dat_add = in_dat[in_adr]+err_mean;

mean_compens_v2#(
	.tau_RC(15),
	.width(N_dig_in)
)
mean_compens_v2_inst(
	.clk     (clk),
	.resetn  (resetn),
	.data_in  (in_dat_add),
	.data_out (out_dat),
	.valid    (valid)
);

sig_mag_v2#(
	.width(N_dig_in)
)
sig_mag_v2_inst(
	.clk     (clk),
	.resetn  (resetn & valid),
	.data_in (out_dat),//signed
	.sig     (sig),
	.mag     (mag),
	.valid   (valid_sigmag)
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

// Output results 
integer Res_file;   // file handler
integer nclk = 0;
initial begin
	Res_file = $fopen("res_mean_compens_tb.txt", "w");
	// @ (resetdone);
	$fwrite(Res_file, "%8s %8s %8s %8s %8s\n","clk","in","out","valid","resetn");
	forever begin
		@(posedge clk)
			nclk = nclk + 1;
			$fwrite(Res_file, "%8d %8d %8d %8d %8d", nclk, $signed(in_dat_add), $signed(out_dat), valid, resetn);
			$fwrite(Res_file, "\n");
			$fflush(Res_file);
	end
end


endmodule