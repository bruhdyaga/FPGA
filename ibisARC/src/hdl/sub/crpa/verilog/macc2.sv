module macc2
#(
    parameter SIZEIN  = 0,
    parameter SIZEACC = 0
)
(
    input                           clk,
    input                           ce,
    input                           clr,
    input      signed [SIZEIN-1:0]  a,
    input      signed [SIZEIN-1:0]  b,
    input             [2:0]         we,
    output reg signed [SIZEACC-1:0] accum
);

reg signed [SIZEIN-1:0]   a_reg, b_reg;
reg signed [2*SIZEIN-1:0] mult_reg;

always_ff@(posedge clk)
if(ce) begin
    if(we[0]) begin
        a_reg <= a;
        b_reg <= b;
    end
end

always_ff@(posedge clk)
if(ce) begin
    if(we[1]) begin
        mult_reg  <= a_reg * b_reg;
    end
end

always_ff@(posedge clk)
if(ce) begin
    if(clr) begin
        accum <= '0;
    end else begin
        if(we[2]) begin
            accum <= accum + mult_reg;
        end
    end
end

endmodule