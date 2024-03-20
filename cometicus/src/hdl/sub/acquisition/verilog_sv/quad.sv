module quad
#(
    parameter IN_WIDTH = 0
)
(
    input  clk,
    input  resetn,
    input  signed [IN_WIDTH-1:0] I_in,
    input  signed [IN_WIDTH-1:0] Q_in,
    output logic signed [IN_WIDTH*2-1:0] R = '0,
    input  we,
    output valid
);

(* MULT_STYLE="BLOCK" *)
logic signed [IN_WIDTH*2-2:0] I_sq = '0;
(* MULT_STYLE="BLOCK" *)
logic signed [IN_WIDTH*2-2:0] Q_sq = '0;

latency#(
    .length(2)
    )
latency_WE_qnt_inst(
    .clk(clk),
    .in(we),
    .out(valid),
    .out_reg()//весь сдвиговый регистр для промежуточных задержек
);


always@(posedge clk or negedge resetn)
if(resetn == 0)
    I_sq <= 0;
else
    I_sq <= $signed(I_in)*$signed(I_in);

always@(posedge clk or negedge resetn)
if(resetn == 0)
    Q_sq <= 0;
else
    Q_sq <= $signed(Q_in)*$signed(Q_in);

always@(posedge clk or negedge resetn)
if(resetn == 0)
    R <= 0;
else
    R <= $unsigned(I_sq) + $unsigned(Q_sq);

endmodule
