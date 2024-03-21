`timescale 1ns/1ns

module log2_alu_tb();

logic clk = 1;

always #5 clk = !clk;


logic [31:0] in = 1;

always_ff@(posedge clk)
in = in << 1;

log2_alu log2_alu_inst(
    .in  (in),
    .out ()
);

endmodule