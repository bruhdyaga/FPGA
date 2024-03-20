`timescale 1ns/10ps

`define clk     105.6 // MHz
`define aclk    100   // MHz

module vitdec_tb();

localparam BASEADDR = 32'h40000000/4;

reg clk     = 1;
reg aclk    = 1;
reg aresetn = 1;

always #((1000/`clk)/2)     clk     <= !clk;
always #((1000/`aclk)/2)    aclk    <= !aclk;

axi3_interface   axi3();
intbus_interf    bus();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

vitdec#(
    .BASEADDR (BASEADDR)
) VITDEC(
    .bus    (bus),
    .clk    (clk)
);

endmodule