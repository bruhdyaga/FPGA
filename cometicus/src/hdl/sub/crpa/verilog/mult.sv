module mult
#(
    parameter  A_width = 0,
    parameter  B_width = 0,
    localparam M_width = A_width + B_width
)
(
    input                           clk,
    input                           ce,
    input  signed     [A_width-1:0] A,
    input  signed     [B_width-1:0] B,
    output reg signed [M_width-1:0] M
);

reg signed [A_width-1:0] A_reg;
reg signed [B_width-1:0] B_reg;

always_ff@(posedge clk)
if(ce) begin
    A_reg <= $signed(A);
    B_reg <= $signed(B);
    M     <= A_reg * B_reg;
end

endmodule
