`include "axi_uart.svh"
`include "global_param.v"

module axi_uart#(
    parameter BASEADDR = 0
)
(
    intbus_interf.slave bus,
    output       irq,
    output       tx,
    input        rx,
    input        tx_ready,
    output reg   rx_full,
    input [15:0] prescale
);

localparam DATA_WIDTH = 8;
localparam FIFO_SIZE  = 2**8; // только 2^x!!!
localparam FIFO_ADDR_BITS = $clog2(FIFO_SIZE);

reg [DATA_WIDTH-1:0] tx_fifo [FIFO_SIZE-1:0];
reg [DATA_WIDTH-1:0] rx_fifo [FIFO_SIZE-1:0];

reg [FIFO_ADDR_BITS-1:0] tx_cntr_rd;
reg [FIFO_ADDR_BITS-1:0] tx_cntr_wr;
reg [FIFO_ADDR_BITS-1:0] tx_next_wr;

wire [FIFO_ADDR_BITS-1:0] rx_cntr_depth;
reg  [FIFO_ADDR_BITS-1:0] rx_cntr_rd;
reg  [FIFO_ADDR_BITS-1:0] rx_cntr_wr;
reg  [FIFO_ADDR_BITS-1:0] rx_next_wr;

wire irq_rx;
wire irq_tx;
wire RxFIFO_EMPTY;
wire TxFIFO_EMPTY;
wire s_axis_tvalid;

intbus_interf    bus_sl();
pipe_line_bus#(
    // .PS_FF ("y"),
    // .PL_FF ("y")
    .PS_FF ("n"),
    .PL_FF ("n")
) pipe_line_bus(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

// The generator data structure definition
AXI_UART_STRUCT PL;     // The registers from logic
AXI_UART_STRUCT PS;     // The registers from CPU

wire [`AXI_UART_SIZE-1:0] bus_wr;
wire [`AXI_UART_SIZE-1:0] bus_rd;

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`AXI_UART_ID_CONST),
    .DATATYPE (AXI_UART_STRUCT)
)RF (
    .clk    (),
    .bus    (bus_sl),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (bus_wr),
    .rd     (bus_rd)
);

assign PL.RxFIFO.RESERVED   = '0;
assign PL.TxFIFO            = '0;
assign PL.STAT.RESERVED     = '0;
assign PL.CTRL              = '0;

assign PL.STAT.PAR_ERR      = '0;
// assign PL.STAT.FRM_ERR      = '0;
// assign PL.STAT.OVER_ERR     = '0;
assign PL.STAT.INTR_EN      = PS.CTRL.EN_INTR;
assign PL.STAT.TxFIFO_EMPTY = TxFIFO_EMPTY;
assign PL.STAT.TxFIFO_FULL  = tx_next_wr == tx_cntr_rd;
assign PL.STAT.RxFIFO_FULL  = rx_next_wr == rx_cntr_rd;
assign PL.STAT.RxFIFO_VALID = !RxFIFO_EMPTY;

assign tx_next_wr = tx_cntr_wr + 1'b1;
assign rx_next_wr = rx_cntr_wr + 1'b1;

assign TxFIFO_EMPTY = tx_cntr_wr == tx_cntr_rd;
assign RxFIFO_EMPTY = rx_cntr_wr == rx_cntr_rd;

assign rx_cntr_depth = rx_cntr_rd - rx_cntr_wr - 1;

always_ff@(posedge bus_sl.clk) begin
    rx_full <= rx_cntr_depth < 7;
end

level_sync#(
    .INIT_STATE (1'b1)
)RX_SYNC (
    .clk     (bus_sl.clk),
    .async   (rx),
    .sync    (rx_syn)
);
level_sync#(
    .INIT_STATE (1'b1)
)TX_READY_SYNC (
    .clk     (bus_sl.clk),
    .async   (tx_ready),
    .sync    (tx_ready_syn)
);

wire [DATA_WIDTH-1:0] m_axis_tdata;
uart#(
    .DATA_WIDTH (DATA_WIDTH)
) UART(
    .clk    (bus_sl.clk),
    /*AXI input*/
    .s_axis_tdata  (tx_fifo[tx_cntr_rd]),
    .s_axis_tvalid (s_axis_tvalid),
    .s_axis_tready (s_axis_tready),
    /*AXI output*/
    .m_axis_tdata  (m_axis_tdata),
    .m_axis_tvalid (m_axis_tvalid),
    .m_axis_tready ('1),
    /*IO*/
    .rxd (rx_syn),
    .txd (tx),
    /*Status outputs*/
    .tx_busy          (tx_busy),
    .rx_busy          (rx_busy),
    .rx_overrun_error (PL.STAT.OVER_ERR),
    .rx_frame_error   (PL.STAT.FRM_ERR),
    .prescale         (prescale)
);

assign rx_reset = bus_wr[3] & bus_sl.wdata[1];
assign tx_reset = bus_wr[3] & bus_sl.wdata[0];

always_ff@(posedge bus_sl.clk)
if(rx_reset) begin
    rx_cntr_wr <= '0;
end else begin
    if(m_axis_tvalid) begin
        rx_cntr_wr <= rx_cntr_wr + 1'b1;
    end
end

always_ff@(posedge bus_sl.clk)
if(m_axis_tvalid)
    rx_fifo[rx_cntr_wr] <= m_axis_tdata;

assign PL.RxFIFO.DATA = rx_fifo[rx_cntr_rd];

always_ff@(posedge bus_sl.clk)
if(rx_reset) begin
    rx_cntr_rd <= '0;
end else begin
    if(bus_rd[0] & PL.STAT.RxFIFO_VALID) begin
        rx_cntr_rd <= rx_cntr_rd + 1'b1;
    end
end

ed_det#(
    .TYPE            ("fal"),
    .FLIP_EN         (1)
) ed_det_irq_rx(
    .clk   (bus_sl.clk),
    .in    (RxFIFO_EMPTY),
    .out   (irq_rx)
);

always_ff@(posedge bus_sl.clk)
if(tx_reset) begin
    tx_cntr_wr <= '0;
end else begin
    if(bus_wr[1]) begin
        tx_cntr_wr <= tx_cntr_wr + 1'b1;
    end
end

always_ff@(posedge bus_sl.clk)
if(bus_wr[1])
    tx_fifo[tx_cntr_wr] <= bus_sl.wdata[7:0];

assign s_axis_tvalid = s_axis_tready & !TxFIFO_EMPTY & tx_ready_syn; // передача данных из tx-fifo в ядро uart

always_ff@(posedge bus_sl.clk)
if(tx_reset) begin
    tx_cntr_rd <= '0;
end else begin
    if(s_axis_tvalid) begin
        tx_cntr_rd <= tx_cntr_rd + 1'b1;
    end
end

ed_det#(
    .TYPE    ("ris"),
    .FLIP_EN (1)
) ed_det_irq_tx(
    .clk   (bus_sl.clk),
    .in    (TxFIFO_EMPTY),
    .out   (irq_tx)
);

assign irq = (irq_rx | irq_tx) & PS.CTRL.EN_INTR;

endmodule