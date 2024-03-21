`timescale 1ns/1ns

`include "global_param.v"

module lim_cntr_tb();

localparam IN_WIDTH  = 8;
localparam OUT_WIDTH = 7;
localparam PERIOD_2N = 10;

logic clk    = '1;
logic resetn = '1;
logic [IN_WIDTH-1:0] in = '0;

always #5 clk = !clk;

always_ff@(posedge clk)
in <= in + 1'b1;


axi3_interface   axi3();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus();

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

reg [31:0] val [2**4];

initial begin
    resetn = '0;
    repeat(10) @(posedge clk); resetn = '1;
end

initial begin
    val[0] = 1 << 31;
    @(posedge resetn)
    @(posedge clk)
    axi3.writeReg(0, 1, 0, val);
end

lim_cntr#(
    .BASEADDR  (0),
    .IN_WIDTH  (IN_WIDTH),
    .OUT_WIDTH (OUT_WIDTH),
    .PERIOD_2N (PERIOD_2N)
) lim_cntr_inst(
    .clk    (clk),
    .resetn (resetn),
    .we     ('1),
    .in     (in),
    .bus    (bus)
);

endmodule