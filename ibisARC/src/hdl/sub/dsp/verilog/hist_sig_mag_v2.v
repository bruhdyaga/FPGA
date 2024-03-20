module hist_sig_mag_v2(
	clk,
	resetn,
	sig,
	mag,
	lock,
	addr,//8 bit
	result,
	valid
);

parameter lines = 1;//число анализируемых линий 1...256
parameter cntr_length = 16'd65535;//длина расчетной выборки

input  clk;
input  resetn;
input  [lines-1:0] sig;
input  [lines-1:0] mag;
input  lock;
input  [7:0] addr;
output [31:0] result;
output valid;

reg  [15:0] cntr;
reg  [15:0] sig_cntr [lines-1:0];
reg  [15:0] mag_cntr [lines-1:0];
reg  [15:0] sig_result [lines-1:0];
reg  [15:0] mag_result [lines-1:0];
reg  [31:0] result;

wire lock_syn;//rf_domain
wire [7:0] addr_syn;//rf_domain

reg valid;

genvar i;

//-------------------

level_sync#(
	.WIDTH(1)
)
LEVEL_SYNC_LOCK(
	.clk     (clk),
	.reset_n (resetn),
	.async   (lock),
	.sync    (lock_syn)
);

level_sync#(
	.WIDTH(8)
)
LEVEL_SYNC_ADDR(
	.clk     (clk),
	.reset_n (resetn),
	.async   (addr),
	.sync    (addr_syn)
);

always@(posedge clk or negedge resetn)
if(resetn == 0)
	cntr <= 0;
else
	if(cntr[15:0] == cntr_length)
		cntr <= 0;
	else
		cntr <= cntr + 1'b1;

generate
for(i=0;i<lines;i=i+1)
begin: loop_lines
	always@(posedge clk)
	if((cntr == 0) | (cntr[15:0] == cntr_length))
		sig_cntr[i] <= 0;
	else
		if(sig[i])
			sig_cntr[i] <= sig_cntr[i] + 1'b1;
	
	always@(posedge clk)
	if((cntr == 0) | (cntr[15:0] == cntr_length))
		mag_cntr[i] <= 0;
	else
		if(mag[i])
			mag_cntr[i] <= mag_cntr[i] + 1'b1;
	
	always@(posedge clk)
	if(cntr[15:0] == cntr_length)
		sig_result[i] <= sig_cntr[i];
	
	always@(posedge clk)
	if(cntr[15:0] == cntr_length)
		mag_result[i] <= mag_cntr[i];
end
endgenerate



always@(posedge clk or negedge resetn)
if(resetn == 0)
	result <= 0;
else
	if(lock_syn == 0)
		result <= {sig_result[addr_syn],mag_result[addr_syn]};

always@(posedge clk or negedge resetn)
if(resetn == 0)
	valid <= 0;
else
	if(cntr[15:0] == cntr_length)
		valid <= 1'b1;

endmodule