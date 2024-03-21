`timescale 1ns/10ps
module arr_accum_tb();

`define core_clk_freq 81

parameter IN_WIDTH_KG   = 12;
parameter OUT_WIDTH_KG  = IN_WIDTH_KG + 9;
parameter IN_WIDTH_NKG  = OUT_WIDTH_KG;
parameter OUT_WIDTH_NKG = IN_WIDTH_NKG + 9;
parameter N_args    = 64;
parameter KG  = 20;
parameter NKG = 5;

reg core_clk = 1;
reg resetn   = 1;

always #((1000/`core_clk_freq)/2) core_clk = !core_clk;

initial begin
#20  resetn = 1'b0;
#100 resetn = 1'b1;
end

reg signed [IN_WIDTH_KG-1:0] test_data;
reg we;

always@(posedge core_clk or negedge resetn)
if(resetn == 0)
	we <= 0;
else
    we <= 1'b1;

always@(posedge core_clk or negedge resetn)
if(resetn == 0)
	test_data <= 0;
else
    // if(we)
        // test_data <= $random%(2**IN_WIDTH_KG-1);
        test_data <= 1;

wire signed [OUT_WIDTH_KG-1:0] R_out_kg;
wire signed [OUT_WIDTH_NKG-1:0] R_out_nkg;

arr_accum#(
    .IN_WIDTH  (IN_WIDTH_KG),
    .OUT_WIDTH (OUT_WIDTH_KG),
    .N_args    (N_args),
    .KG_MODE   (1)
) arr_accum_kg_inst(
    .clk     (core_clk),
    .resetn  (resetn),
    .R_in    (test_data),
    .R_out   (R_out_kg),
    .we      (we),
    .valid   (valid_kg),
    .kg      (KG),
    .nkg     (NKG)
);

arr_accum#(
    .IN_WIDTH  (IN_WIDTH_NKG),
    .OUT_WIDTH (OUT_WIDTH_NKG),
    .N_args    (N_args),
    .KG_MODE   (0)
) arr_accum_nkg_inst(
    .clk     (core_clk),
    .resetn  (resetn),
    .R_in    (R_out_kg),
    .R_out   (R_out_nkg),
    .we      (valid_kg),
    .valid   (valid_nkg),
    .kg      (KG),
    .nkg     (NKG)
);

endmodule