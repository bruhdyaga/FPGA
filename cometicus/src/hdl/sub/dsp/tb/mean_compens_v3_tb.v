`timescale 1ns/1ns
module mean_compens_v3_tb();

parameter N_dig_in = 14;
parameter LENGTH_N = 14;
// parameter LENGTH = 2**LENGTH_N;//длина тестовой выборки
parameter LENGTH = 1000;//длина тестовой выборки

reg [LENGTH_N-1:0] in_adr;
reg signed [31:0] in_dat32 [LENGTH-1:0];
reg signed [N_dig_in-1:0] in_dat [LENGTH-1:0];
wire signed [31:0] in_dat_add_full;
wire signed [N_dig_in-1:0] in_dat_add;
wire signed [N_dig_in-1:0] out_dat;
wire valid;

reg signed [15:0] err_mean;

reg clk = 1;
reg resetn = 0;


always #5 clk = !clk;

initial
begin
    // resetn = 1'b1;
#50 resetn = 1'b0;
#40 resetn = 1'b1;
end

initial
// $readmemh ("noise.txt", in_dat);
// $readmemh ("sin_ref.txt", in_dat);
$readmemh ("bad.txt", in_dat32);

initial begin
err_mean = 0;
#700000 err_mean = 0;
end

always@(posedge clk or negedge resetn)
if(resetn == 0)
    in_adr <= 0;
else
    if(in_adr == LENGTH-1)
        in_adr <= 0;
    else
        in_adr <= in_adr + 1'b1;

// assign in_dat_add_full = $signed($signed(in_dat[in_adr])+$signed(err_mean));
assign in_dat_add = $signed(in_dat32[in_adr]);

// lim_qnt#(
    // .in_width  (31),
    // .out_width (N_dig_in)
// ) lim_qnt_inst(
    // .clk   (clk),
    // .reset (!resetn),
    // .WE    (1'b1),
    // .valid (),
    // .in    (in_dat_add_full>>>1),
    // .out   (in_dat_add)
// );

mean_compens_v3#(
    // .tau_RC (15),
    .WIDTH  (N_dig_in)
)
mean_compens_v2_inst(
    .clk      (clk),
    .resetn   (resetn),
    .we       (1'b1),
    .data_in  (in_dat_add),
    .data_out (out_dat),
    .valid    (valid)
);

endmodule