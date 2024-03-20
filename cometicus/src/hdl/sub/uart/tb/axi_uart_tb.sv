`timescale 1ns/10ps
`include "axi_uart.svh"

`define aclk_freq     100    // MHz
`define pclk_freq     105.6  // MHz

module axi_uart_tb();

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
reg [2:0] srach_cntr;
always_ff@(posedge axi3.aclk or negedge axi3.resetn)
if(axi3.resetn == '0) begin
    srach_cntr <= '0;
end else begin
    srach_cntr <= srach_cntr + 1'b1;
end

// assign srach = srach_cntr == '1;
assign srach = '0;

wire [1:0] uart_irq;
localparam AXI_UART_0_BASE_ADDR = BASEADDR + 1;
wire [1:0] tx;
wire [1:0] rx_full;
axi_uart#(
    .BASEADDR (AXI_UART_0_BASE_ADDR)
) axi_uart_0_inst(
    .bus          (bus_sl[0]),
    .irq          (uart_irq[0]),
    .tx           (tx[0]),
    .rx           (tx[1] ^ srach),
    .tx_ready     (!rx_full[1]),
    .rx_full      (rx_full[0]),
    .prescale     (1)
);
localparam AXI_UART_1_BASE_ADDR = AXI_UART_0_BASE_ADDR + `AXI_UART_FULL_SIZE;
axi_uart#(
    .BASEADDR (AXI_UART_1_BASE_ADDR)
) axi_uart_1_inst(
    .bus          (bus_sl[1]),
    .irq          (uart_irq[1]),
    .tx           (tx[1]),
    .rx           (tx[0] ^ srach),
    .tx_ready     (!rx_full[0]),
    .rx_full      (rx_full[1]),
    .prescale     (1)
);

endmodule