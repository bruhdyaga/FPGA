`timescale 1ns/1ns
module max_parallel_tb();

localparam WIDTH = 8;
localparam N_CH  = 10;

logic clk = 1;

always #5 clk = !clk;

logic [WIDTH-1:0]      data [N_CH-1:0];
logic [WIDTH*N_CH-1:0] data_flat;

for(genvar i = 0; i < N_CH; i = i + 1) begin
    assign data[i] = $urandom();
end

assign data_flat = {>>{data}};

max_parallel#(
    .WIDTH (WIDTH),
    .N_CH  (N_CH),
    .FL_EN (1)
) MAX_INST(
    .clk      (clk),
    .data_in  (data_flat),
    .data_out ()
);

endmodule