module butterfly_Rad2
#(
    parameter  D_WIDTH = 0,
    parameter  W_WIDTH = 0
)
(
    input  clk,
    input  signed [D_WIDTH-1:0] A_R,
    input  signed [D_WIDTH-1:0] A_I,
    input  signed [D_WIDTH-1:0] B_R,
    input  signed [D_WIDTH-1:0] B_I,
    output signed [D_WIDTH-1:0] C_R,
    output signed [D_WIDTH-1:0] C_I,
    output signed [D_WIDTH-1:0] D_R,
    output signed [D_WIDTH-1:0] D_I,
    input  signed [W_WIDTH-1:0] W_R,
    input  signed [W_WIDTH-1:0] W_I,
    input         [W_WIDTH-1:0] cut
);

localparam MUL_WIDTH = D_WIDTH*2; // без -1; не переполнится при перемножении двух макс.отрицательных чисел

logic signed [MUL_WIDTH-1:0] Norm_A_R;
logic signed [MUL_WIDTH-1:0] Norm_A_I;

logic signed [MUL_WIDTH-1:0] B_R_W_R;
logic signed [MUL_WIDTH-1:0] B_I_W_I;
logic signed [MUL_WIDTH-1:0] B_I_W_R;
logic signed [MUL_WIDTH-1:0] B_R_W_I;

logic signed [MUL_WIDTH:0]   Mult_R;
logic signed [MUL_WIDTH:0]   Mult_I;

logic signed [MUL_WIDTH+1:0]   C_R_FULL;
logic signed [MUL_WIDTH+1:0]   C_I_FULL;
logic signed [MUL_WIDTH+1:0]   D_R_FULL;
logic signed [MUL_WIDTH+1:0]   D_I_FULL;

logic signed [MUL_WIDTH+1:0]   C_R_CUT;
logic signed [MUL_WIDTH+1:0]   C_I_CUT;
logic signed [MUL_WIDTH+1:0]   D_R_CUT;
logic signed [MUL_WIDTH+1:0]   D_I_CUT;

// ===

assign B_R_W_R = B_R * W_R;
assign B_I_W_I = B_I * W_I;
assign B_I_W_R = B_I * W_R;
assign B_R_W_I = B_R * W_I;

assign Mult_R = B_R_W_R - B_I_W_I;
assign Mult_I = B_I_W_R + B_R_W_I;

assign Norm_A_R = A_R <<< (W_WIDTH-1); //  * 2**(W_WIDTH-1) // масштабирующий множитель
assign Norm_A_I = A_I <<< (W_WIDTH-1); //  * 2**(W_WIDTH-1) // масштабирующий множитель

assign C_R_FULL = Norm_A_R + Mult_R;
assign C_I_FULL = Norm_A_I + Mult_I;
assign D_R_FULL = Norm_A_R - Mult_R;
assign D_I_FULL = Norm_A_I - Mult_I;

assign C_R_CUT = C_R_FULL >>> cut;
assign C_I_CUT = C_I_FULL >>> cut;
assign D_R_CUT = D_R_FULL >>> cut;
assign D_I_CUT = D_I_FULL >>> cut;

lim_qnt#(
    .in_width    (MUL_WIDTH+2),
    .out_width   (D_WIDTH),
    .SYMMETRICAL (1)
) lim_qnt_C_R(
    .clk   (clk),
    .WE    ('1),
    .valid (),
    .in    (C_R_CUT),
    .out   (C_R)
);
lim_qnt#(
    .in_width    (MUL_WIDTH+2),
    .out_width   (D_WIDTH),
    .SYMMETRICAL (1)
) lim_qnt_C_I(
    .clk   (clk),
    .WE    ('1),
    .valid (),
    .in    (C_I_CUT),
    .out   (C_I)
);
lim_qnt#(
    .in_width    (MUL_WIDTH+2),
    .out_width   (D_WIDTH),
    .SYMMETRICAL (1)
) lim_qnt_D_R(
    .clk   (clk),
    .WE    ('1),
    .valid (),
    .in    (D_R_CUT),
    .out   (D_R)
);
lim_qnt#(
    .in_width    (MUL_WIDTH+2),
    .out_width   (D_WIDTH),
    .SYMMETRICAL (1)
) lim_qnt_D_I(
    .clk   (clk),
    .WE    ('1),
    .valid (),
    .in    (D_I_CUT),
    .out   (D_I)
);

endmodule