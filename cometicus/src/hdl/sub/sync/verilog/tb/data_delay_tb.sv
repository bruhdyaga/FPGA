`timescale 1ns/1ps
module data_delay_tb();

parameter WIDTH       = 4;
parameter MAX_DELAY   = 7;

reg clk    = 0;
reg resetn = 0;

always #5 clk = !clk;

initial begin
     resetn = 1'b1;
#30  resetn = 1'b0;
#100 resetn = 1'b1;
end

reg [WIDTH-1:0] cntr;
wire [WIDTH-1:0] out;
always_ff@(posedge clk or negedge resetn)
if(resetn == '0) begin
    cntr <= '0;
end else begin
    cntr <= cntr + 1'b1;
end

data_delay#(
    .WIDTH       (WIDTH      ),
    .MAX_DELAY   (MAX_DELAY  )
) DATA_DELAY(
    .resetn (resetn),
    .clk    (clk),
    .delay  (0),
    .in     (cntr),
    .out    (out)
);

endmodule