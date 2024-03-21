//задерживает однобитовый сигнал на заданное количество тактов
module latency#(
    parameter length = 1
)
(
    input  clk,
    input  in,
    output out,
    output reg [length-1:0] out_reg//весь сдвиговый регистр для промежуточных задержек
);

if(length == 1) begin
    always_ff@(posedge clk)
        out_reg[0] <= in;
end
else begin
    always_ff@(posedge clk)
        out_reg[length-1:0] <= {out_reg[length-2:0],in};
end

assign out = out_reg[length-1];

endmodule
