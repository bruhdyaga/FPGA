module randn#(
    parameter number = 0 // Порядковый номер блока (отличаются зерном)
)
(
    input                     clk,
    input                     set,
    output logic signed [9:0] out
);

logic signed [7:0] rand_u [3:0];

logic signed [9:0] X_1;
logic signed [9:0] X_2;
logic signed [9:0] X_3;
logic signed [9:0] X_4;

for(genvar i = 0; i < 4; i = i + 1) begin
    randn_u#(
        .number (i + number*4)
    ) RANDN_U(
        .clk (clk),
        .set (set),
        .out (rand_u[i])
    );
end

always_ff@(posedge clk)
if(set) begin
    X_1 <= 0;
    X_2 <= 0;
    X_3 <= 200;
    X_4 <= -100;
end else begin
    X_1 <=       rand_u[0];
    X_2 <= X_1 + rand_u[1];
    X_3 <= X_2 + rand_u[2];
    X_4 <= X_3 + rand_u[3];
    out <= X_4;
end

endmodule
