`timescale 1ns/10ps
module frequency_counter_tb();

`define FREQ_CNTR_BASE_ADDR 30'h10000000

reg aclk = 1;
reg clk_33 = 1;
reg clk_83 = 1;
reg clk_200 = 1;
reg clk_5 = 1;
reg resetn;

reg  rd = 0;
reg  wr = 0;
wire [31:0] rdata;
reg  [29:0] addr;

always #8 aclk = !aclk;
always #15 clk_33 = !clk_33;
always #6 clk_83 = !clk_83;
always #2.5 clk_200 = !clk_200;
always #100 clk_5 = !clk_5;


initial begin
resetn = 1'b1;
#40 resetn = 1'b0;
#1000 resetn = 1'b1;
end


initial begin
#200015
addr <= `FREQ_CNTR_BASE_ADDR + 0;
rd <= 1'b1;
#30
addr <= 0;
rd <= 1'b0;
#90
addr <= `FREQ_CNTR_BASE_ADDR + 1;
rd <= 1'b1;
#30
addr <= 0;
rd <= 1'b0;
#90
addr <= `FREQ_CNTR_BASE_ADDR + 2;
rd <= 1'b1;
#30
addr <= 0;
rd <= 1'b0;
#90
addr <= `FREQ_CNTR_BASE_ADDR + 3;
rd <= 1'b1;
#30
addr <= 0;
rd <= 1'b0;

#900000

#90
addr <= `FREQ_CNTR_BASE_ADDR + 4 + 0;
rd <= 1'b1;
#30
addr <= 0;
rd <= 1'b0;
#90
addr <= `FREQ_CNTR_BASE_ADDR + 4 + 1;
rd <= 1'b1;
#30
addr <= 0;
rd <= 1'b0;
#90
addr <= `FREQ_CNTR_BASE_ADDR + 4 + 2;
rd <= 1'b1;
#30
addr <= 0;
rd <= 1'b0;
#90
addr <= `FREQ_CNTR_BASE_ADDR + 4 + 3;
rd <= 1'b1;
#30
addr <= 0;
rd <= 1'b0;
end


parameter FREQ_CNTR_BASE_ADDR = 0;// 4-byte
parameter ADDR_WIDTH          = 0;
parameter CHANNELS            = 0;// число измеряемых клоков
parameter FREQ_REF_HZ         = 0;// [Гц]; опорная частота

frequency_counter#(
    .FREQ_CNTR_BASE_ADDR (`FREQ_CNTR_BASE_ADDR),
	.CHANNELS    (4),
	.PERIOD_MEAS (14),
	.FREQ_REF_HZ (33333333)
)
frequency_counter(
	.resetn  (resetn),
	.aclk    (aclk),
	.ref_clk (clk_33),
	.in_clk  ({clk_5,clk_200,clk_83,clk_33}),
	.rdata   (rdata),
    .rvalid  (),
	.addr    (addr),
	.rd      (rd)
);

endmodule