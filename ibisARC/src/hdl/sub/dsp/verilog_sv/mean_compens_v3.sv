module mean_compens_v3
#(
    parameter WIDTH   = 14,
    parameter PERIODN = 14
)
(
    input  clk,
    input  we,
    input signed [WIDTH-1:0] data_in,
    output logic signed [WIDTH-1:0] data_out,
    output logic valid
);

logic [PERIODN-1:0] mean_cntr;
logic signed [WIDTH-1+PERIODN:0] mean;
logic signed [WIDTH-2:0] mean_reg;

localparam MAX_LIM = 2**(WIDTH-1)-1;

always_ff@(posedge clk) begin
    mean_cntr <= mean_cntr + 1'b1;
end

always_ff@(posedge clk)
if(mean_cntr == '1)
    mean <= 0;
else
    mean <= mean + data_in;

always_ff@(posedge clk)
if(mean_cntr == '1) begin
    mean_reg <= mean >>> PERIODN;
end

logic signed [WIDTH:0] data_compens;
assign data_compens = data_in - mean_reg;

always_ff@(posedge clk)
if(data_compens > 0) begin
    data_out <= (data_compens >  MAX_LIM) ?  MAX_LIM : data_compens;
end else begin
    data_out <= (data_compens < -MAX_LIM) ? -MAX_LIM : data_compens;
end

always_ff@(posedge clk) begin
    valid <= we;
end

endmodule