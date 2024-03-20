`timescale 1ns/1ns
module lim_qnt_tb();

localparam IN_WIDTH  = 6;
localparam OUT_WIDTH = 4;

logic clk = 1'b1;

always #5 clk = !clk;

logic signed [IN_WIDTH-1:0]  in_data = '0;
logic signed [OUT_WIDTH-1:0] out_data;

always_ff@(posedge clk)
    in_data <= in_data + 1'b1;

lim_qnt#(
    .in_width    (IN_WIDTH),
    .out_width   (OUT_WIDTH),
    .SYMMETRICAL (0)
) lim_qnt_inst(
    .clk   (clk),
    .WE    ('1),
    .valid (),
    .in    (in_data),
    .out   (out_data)
);

endmodule