module max_parallel
#(
    parameter WIDTH = 0,
    parameter N_CH  = 0,
    parameter FL_EN = 0
)
(
    input                         clk,
    input                         we,
    input        [WIDTH*N_CH-1:0] data_in,
    output logic [WIDTH-1:0]      data_out
);

`define _MAX(A,B) (A > B ? A : B)

logic [WIDTH-1:0] data       [N_CH-1:0];
logic [WIDTH-1:0] max_data;

assign {>>{data}} = data_in;

generate
if(N_CH > 1) begin
    logic [WIDTH-1:0] max_branch [N_CH-2:0];
    for(genvar i = 0; i < N_CH - 1; i = i + 1) begin: BRANCH
        if(i == 0) begin
            assign max_branch[i] = `_MAX(data[1], data[0]);
        end else begin
            assign max_branch[i] = `_MAX(max_branch[i-1], data[i + 1]);
        end
    end
    assign max_data = max_branch[N_CH-2];
end else begin
    assign max_data = data[0];
end

if(FL_EN) begin // flip flop
    logic [WIDTH-1:0] data_out = '0;
    always_ff@(posedge clk) begin
        if(we) begin
            data_out <= max_data;
        end
    end
end else begin // combinatoral
    assign data_out = max_data;
end
endgenerate

`undef _MAX

endmodule