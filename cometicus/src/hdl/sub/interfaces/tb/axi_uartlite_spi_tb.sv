`timescale 1ns/10ps
`include "axi_uartlite_spi.svh"

`define aclk_freq     100    // MHz
`define pclk_freq     105.6  // MHz

module axi_uartlite_spi_tb();

localparam BASEADDR           = 32'h40000000/4;

logic [31:0] rdata;
reg aclk  = 1;
reg pclk  = 1;
reg presetn;
reg aresetn;

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;
always #((1000/`pclk_freq)/2)     pclk     <= !pclk;

axi3_interface axi3();
intbus_interf  bus();
intbus_interf  bus_sl[2]();

initial begin
    @(posedge pclk);
    presetn = 0;
    @(posedge pclk);
    @(posedge pclk);
    @(posedge pclk);
    presetn = 1'b1;
end

initial begin
    bus.init;
    @(negedge presetn);
    aresetn = 0;
    @(posedge presetn);
    bus.waitClks(1);
    aresetn = 1'b1;
end

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (2),
    .OUTFF      ("y")
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

//=======================================
//=======================================
//=======================================
//=======================================


wire [1:0] uart_lite_irq;
localparam AXI_UARTLITE_SPI_0_BASE_ADDR = BASEADDR + 1;
wire spi_clk_out_0;
wire spi_cs_out_0;
wire spi_data_out_0;
wire spi_clk_out_1;
wire spi_cs_out_1;
wire spi_data_out_1;
axi_uartlite_spi#(
    .BASEADDR (AXI_UARTLITE_SPI_0_BASE_ADDR)
) axi_uartlite_spi_0_inst(
    .bus          (bus_sl[0]),
    .tx_clk       (bus.clk),
    .irq          (uart_lite_irq[0]),
    .spi_clk_out  (spi_clk_out_0),
    .spi_cs_out   (spi_cs_out_0),
    .spi_data_out (spi_data_out_0),
    .spi_clk_in   (spi_clk_out_0),
    .spi_cs_in    (spi_cs_out_0),
    .spi_data_in  (spi_data_out_0)
);
localparam AXI_UARTLITE_SPI_1_BASE_ADDR = AXI_UARTLITE_SPI_0_BASE_ADDR + `AXI_UARTLITE_SPI_FULL_SIZE;
axi_uartlite_spi#(
    .BASEADDR (AXI_UARTLITE_SPI_1_BASE_ADDR)
) axi_uartlite_spi_1_inst(
    .bus          (bus_sl[1]),
    .tx_clk       (bus.clk),
    .irq          (uart_lite_irq[1]),
    .spi_clk_out  (),
    .spi_cs_out   (),
    .spi_data_out (),
    .spi_clk_in   ('0),
    .spi_cs_in    ('0),
    .spi_data_in  ('0)
);

endmodule