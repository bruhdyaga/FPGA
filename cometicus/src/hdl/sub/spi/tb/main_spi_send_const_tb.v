`timescale 1ns/1ns
module main_spi_send_const_tb();

parameter CLK_DIV = 6;
parameter N_BITS = 16;
parameter N_PACKETS = 2;
parameter DATA =	16384'h0080 << 1*N_BITS |
					16384'h010F << 0*N_BITS;



reg clk = 1;

always #5 clk = !clk;

main_spi_send_const#(
	.CLK_DIV   (CLK_DIV),
	.N_BITS    (N_BITS),
	.N_PACKETS (N_PACKETS),
	.DATA      (DATA)
)main_spi_send_const_inst(
	.clk      (clk),
	.reset    (),
	.spi_clk  (),
	.spi_ncs  (),
	.spi_mosi ()
);

endmodule
