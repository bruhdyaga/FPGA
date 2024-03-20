//ограничивает число от переполнениЯ и отбрасывает старшие разрЯды
//работает, как компрессор
//работает со знаковыми числами в доп. коде
//выходная разрядность <= входной
module lim_qnt#(
    parameter in_width    = 1,
    parameter out_width   = 1,
    parameter SYMMETRICAL = 0  // макс/мин симметричны, например -127/+127 (вместо -128/+127)
)
(
    input                        clk,
    input                        WE,
    output                       valid,
    input        [in_width-1:0]  in,
    output logic [out_width-1:0] out
);

localparam cut_dig = in_width - out_width;//сколько разрядов отбросим
localparam lat_valid = 1;//задержка сигнала на выходе

latency#(
    .length  (lat_valid)
) latency_inst(
    .clk     (clk),
    .in      (WE),
    .out     (valid),
    .out_reg ()//весь сдвиговый регистр для промежуточных задержек
);

generate
if(cut_dig == 0)//не ограничиваем входное число
begin
    always@(posedge clk) begin
    if(WE)
        out <= in;
    end
end
else//компрессия числа
begin
    always@(posedge clk) begin
    if(WE)
        if(in[in_width-1] == 0)//число положительное
            if(in[in_width-2:in_width-1-cut_dig] == 0)//число не превышает предел
                out[out_width-1:0] <= {1'b0,in[out_width-2:0]};//отбросили страшие разряды
            else//число превышает предел, ограничиваем его
                out[out_width-1:0] <= {1'b0,{out_width-1{1'b1}}};
        else//число отрицательное
            if(in[in_width-2:in_width-1-cut_dig] == {cut_dig{1'b1}})//число не превышает предел
                if((in[out_width-2:0] == '0) & SYMMETRICAL) // число равно максимально отрицательному выходному
                    out[out_width-1:0] <= {1'b1,{out_width-2{1'b0}},1'b1};
                else
                    out[out_width-1:0] <= {1'b1,in[out_width-2:0]};//отбросили страшие разряды
            else//число превышает предел, ограничиваем его
                if(SYMMETRICAL)
                    out[out_width-1:0] <= {1'b1,{out_width-2{1'b0}},1'b1};
                else
                    out[out_width-1:0] <= {1'b1,{out_width-1{1'b0}}};
    end
end
endgenerate

endmodule