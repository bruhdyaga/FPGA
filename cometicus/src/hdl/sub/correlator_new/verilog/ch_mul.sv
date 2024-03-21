module ch_mul (
    input       clk,
    input [1:0] adc_re,
    input [1:0] adc_im,
    input [4:0] phase,
    output reg signed [4:0] i_prod,
    output reg signed [4:0] q_prod
);

logic [9:0] data;

ch_mul_rom ROM(
    .clk  (clk),
    .data (data),
    .addr ({adc_re, adc_im, phase})
);

assign i_prod = data[4:0];
assign q_prod = data[9:5];

endmodule
