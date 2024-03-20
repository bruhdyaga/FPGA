//вход и выход законвееризированы для урощения разводки
module mean_compens(
	//parameter width(def 14)
	clk,
	reset,
	DAT_in,
	DAT_out
);

parameter tau_RC = 5'd15;
parameter width = 14;
// parameter s_width = width+1;//разрядность в знаковом представлении

input clk;
input reset;
input  [width-1:0] DAT_in;
output signed [width-1:0] DAT_out;

reg [width-1:0] DAT_in_sign;
wire signed [width-1:0] y_k;

wire signed [31:0] y_k_32;//расширенная разрядность
reg signed [31:0] x_k_32;//32 бит
reg signed [31:0] x_k_1_32;//

wire signed [width-1:0] x_k;

reg signed [width-1:0] DAT_out;

//-------------------


// assign DAT_in_sign = {~DAT_in[width-1],DAT_in[width-2:0]};
always@(posedge clk or posedge reset)
if(reset)
	DAT_in_sign <= 0;
else
	DAT_in_sign <= {~DAT_in[width-1],DAT_in[width-2:0]};



conv_reg#(
	.width(width),
	.length(2)// number of registers
)
conv_reg_corr_inst(
	.reset(reset),
	.clk(clk),
	.in(DAT_in_sign),
	.out(y_k)
);

assign y_k_32 = {y_k,{32-width{1'b0}}};

always@(posedge clk or posedge reset)
if(reset)
	x_k_1_32 <= 0;
else
	x_k_1_32 <= x_k_32;


// wire [31:0] x_k_1_32_div;
// wire [31:0] y_k_32_div;
// assign x_k_1_32_div = ($signed(x_k_1_32)>>>tau_RC);
// assign y_k_32_div = ($signed(y_k_32)>>>tau_RC);


always@(posedge clk or posedge reset)
if(reset)
	x_k_32 <= 0;
else
	x_k_32 <= $signed(x_k_1_32) - ($signed(x_k_1_32)>>>tau_RC) + ($signed(y_k_32)>>>tau_RC);



assign x_k = x_k_32[31:31-width+1];

always@(posedge clk or posedge reset)
if(reset)
	DAT_out <= 0;
else
	DAT_out <= $signed(y_k) - $signed(x_k);





endmodule
