//вход и выход законвееризированы для урощения разводки
module mean_compens_v2(
	//parameter width(def 14)
	clk,
	resetn,
	data_in,
	data_out,
	valid
);

`include "math.v"

parameter tau_RC = 15;
parameter width = 14;

localparam TAU_RC_ADPT_W = log2(2**tau_RC);

input clk;
input resetn;
input signed  [width-1:0] data_in;
output signed [width-1:0] data_out;
output valid;

wire signed [width-1:0] y_k;

wire signed [31:0] y_k_32;//расширенная разрядность
reg signed [31:0] x_k_32;//32 бит
reg signed [31:0] x_k_1_32;//
wire signed [width-1:0] x_k;
reg signed  [width:0] data_out_full;
wire signed [width-1:0] data_out;

reg  [TAU_RC_ADPT_W+2:0] mean_cntr;
wire up_RC_adpt;
reg  valid_full;

reg [TAU_RC_ADPT_W-1:0] tau_RC_adpt;//управляемая постоянная времени RC фильтра
//-------------------

conv_reg_n#(
	.width(width),
	.length(2)// number of registers
)
conv_reg_n_corr_inst(
	.resetn(resetn),
	.clk(clk),
	.in(data_in),
	.out(y_k)
);

assign y_k_32 = {y_k,{32-width{1'b0}}};

always@(posedge clk or negedge resetn)
if(resetn == 0)
	x_k_1_32 <= 0;
else
	x_k_1_32 <= x_k_32;

always@(posedge clk or negedge resetn)
if(resetn == 0)
	x_k_32 <= 0;
else begin
	// if(valid == 0)
		x_k_32 <= $signed(x_k_1_32) - ($signed(x_k_1_32)>>>tau_RC_adpt) + ($signed(y_k_32)>>>tau_RC_adpt);
	// else
		// x_k_32 <= x_k_32;
end


assign x_k = x_k_32[31:31-width+1];

always@(posedge clk or negedge resetn)
if(resetn == 0)
	data_out_full <= 0;
else
	data_out_full <= $signed(y_k) - $signed(x_k);

lim_qnt#(
    .in_width  (width+1),
    .out_width (width)
) lim_qnt_inst(
    .clk   (clk),
    .reset (!resetn),
    .WE    (valid_full),
    .valid (valid),
    .in    (data_out_full),
    .out   (data_out)
);

always@(posedge clk or negedge resetn)
if(resetn == 0)
	tau_RC_adpt <= 0;
else
	if(up_RC_adpt)
		if(tau_RC_adpt[TAU_RC_ADPT_W-1:0] == tau_RC)
			tau_RC_adpt <= tau_RC_adpt;
		else
			tau_RC_adpt <= tau_RC_adpt + 1'b1;

assign up_RC_adpt = (mean_cntr[TAU_RC_ADPT_W+2:0] == (2**tau_RC_adpt));

always@(posedge clk or negedge resetn)
if(resetn == 0)
	mean_cntr <= 0;
else
	if(valid_full == 0)
		if(up_RC_adpt)
			mean_cntr <= 0;
		else
			mean_cntr <= mean_cntr + 1'b1;

always@(posedge clk or negedge resetn)
if(resetn == 0)
	valid_full <= 0;
else
	if((tau_RC_adpt == tau_RC) & (up_RC_adpt))
		valid_full <= 1'b1;


endmodule
