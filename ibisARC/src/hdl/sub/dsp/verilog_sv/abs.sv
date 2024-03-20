module abs
#(
    parameter WIDTH = 0,
    parameter FF    = 1
)
(
    input                     clk,
    input  signed [WIDTH-1:0] in,
    output logic  [WIDTH-2:0] out,
    input                     we,
    output                    valid
);

logic [WIDTH-1:0] in_abs;

assign in_abs = in > 0 ? in : -$signed(in);

conv_reg#(
    .width  (WIDTH),
    .length ()
) conv_reg_data_inst(
    .clk (clk),
    .in  ({we,in_abs[0+:WIDTH-1]}),
    .out ({valid,out})
);

endmodule