`timescale 1ns/1ns
module sig_mag_v3_tb();

localparam WIDTH = 8;
localparam N_CH  = 2;
// parameter LENGTH_N = 14;
// parameter LENGTH = 2**LENGTH_N;//длина тестовой выборки

// logic [LENGTH_N-1:0] in_adr = '0;
// logic signed [WIDTH-1:0] in_dat [LENGTH-1:0];
logic signed [WIDTH-1:0]      data [N_CH-1:0] = '{default:'0};
logic signed [WIDTH*N_CH-1:0] data_flat;
logic [15:0] k_scale;

parameter SIG_CNTR_SIZE = 12;
logic [SIG_CNTR_SIZE-1:0] sigmag_cntr_period = '0;

logic [N_CH-1:0]          sig;
logic [N_CH-1:0]          mag;
logic [SIG_CNTR_SIZE-1:0] sig_cntr [N_CH-1:0] = '{default:{'0}};
logic [SIG_CNTR_SIZE-1:0] mag_cntr [N_CH-1:0] = '{default:{'0}};
logic [6:0]               sig_res  [N_CH-1:0] = '{default:{'0}};
logic [6:0]               mag_res  [N_CH-1:0] = '{default:{'0}};
logic signed [2:0]        out      [N_CH-1:0] = '{default:{'0}};

logic clk = 1;
logic clr = '0;

always #5 clk = !clk;

// initial
// $readmemh ("noise.txt", in_dat);
// $readmemh ("sin_ref.txt", in_dat);

// always_ff@(posedge clk)
    // in_adr <= in_adr + 1'b1;


initial begin
k_scale = 1;
#1000000 @(posedge clk)
clr <= '1;
k_scale = 2;
@(posedge clk)
clr <= '0;
end

logic [1:0] we_cntr = '0;
assign we = we_cntr == 2;

always_ff@(posedge clk)
if(we)
    we_cntr <= '0;
else
    we_cntr <= we_cntr + 1'b1;

for(genvar i = 0; i < N_CH; i = i + 1) begin
    always_ff@(posedge clk)
    // data_flat <= in_dat[in_adr] * k_scale;
    data[i] <= ($random%120 - 60) * k_scale / (i+1);
end
assign data_flat = {>>{data}};

sig_mag_v3#(
    .WIDTH   (WIDTH),
    .N_CH    (N_CH)
)
sig_mag_v3_inst(
    .clk        (clk),
    .data_in    (data_flat),//signed
    .we         (we),
    .clr        (clr),
    .sig        (sig),
    .mag        (mag),
    .valid      (),
    .por_out    (),
    .por_in     ('0),
    .por_manual (1'b0)
);

always_ff@(posedge clk)
sigmag_cntr_period <= sigmag_cntr_period + 1'b1;

assign sigmag_lch = (sigmag_cntr_period == 0);

for(genvar i = 0; i < N_CH; i = i + 1) begin
    always_ff@(posedge clk)
    if(sigmag_lch)
        sig_cntr[i] <= 0;
    else
        if(sig[i])
            sig_cntr[i] <= sig_cntr[i] + 1'b1;

    always_ff@(posedge clk)
    if(sigmag_lch)
        mag_cntr[i] <= 0;
    else
        if(mag[i])
            mag_cntr[i] <= mag_cntr[i] + 1'b1;

    always_ff@(posedge clk)
    if(sigmag_lch) begin
        sig_res[i] <= (sig_cntr[i]*100)/(2**SIG_CNTR_SIZE);
        mag_res[i] <= (mag_cntr[i]*100)/(2**SIG_CNTR_SIZE);
    end

    always_ff@(posedge clk)
    out[i] <= (sig[i]) ? ((mag[i]) ? 3 : 1) : ((mag[i]) ? -3 : -1);
end
endmodule