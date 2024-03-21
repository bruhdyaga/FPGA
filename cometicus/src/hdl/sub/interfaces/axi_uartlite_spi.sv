`include "axi_uartlite_spi.svh"
`include "global_param.v"

module axi_uartlite_spi#(
    parameter BASEADDR = 0
)
(
    intbus_interf.slave bus,
    input  tx_clk,
    output irq,
    output spi_clk_out,
    output spi_cs_out,
    output spi_data_out,
    input  spi_clk_in,
    input  spi_cs_in,
    input  spi_data_in
);

localparam FIFO_SIZE = 2**8; // только 2^x!!!
localparam FIFO_ADDR_BITS = $clog2(FIFO_SIZE);

reg [7:0] tx_fifo [FIFO_SIZE-1:0];
reg [7:0] rx_fifo [FIFO_SIZE-1:0];

reg [FIFO_ADDR_BITS-1:0] tx_cntr_rd;
reg [FIFO_ADDR_BITS-1:0] tx_cntr_wr;
reg [FIFO_ADDR_BITS-1:0] tx_next_wr;

reg [FIFO_ADDR_BITS-1:0] rx_cntr_rd;
reg [FIFO_ADDR_BITS-1:0] rx_cntr_wr;
reg [FIFO_ADDR_BITS-1:0] rx_next_wr;

reg [7:0] tx_reg; // spi shift reg
reg [7:0] rx_reg;

reg [2:0] tx_shift_cntr;

wire irq_rx;
wire irq_tx;
wire RxFIFO_EMPTY_asy;
wire RxFIFO_EMPTY_syncpu;

wire TxFIFO_EMPTY_asy;
wire TxFIFO_EMPTY_syncpu;
wire TxFIFO_EMPTY_syntx;

assign spi_clk_out = tx_clk;

intbus_interf    bus_sl();
pipe_line_bus#(
    .PS_FF ("y"),
    .PL_FF ("y")
) pipe_line_bus(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

// The generator data structure definition
AXI_UARTLITE_SPI_STRUCT PL;     // The registers from logic
AXI_UARTLITE_SPI_STRUCT PS;     // The registers from CPU

wire [`AXI_UARTLITE_SPI_SIZE-1:0] bus_wr;
wire [`AXI_UARTLITE_SPI_SIZE-1:0] bus_rd;

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`AXI_UARTLITE_SPI_ID_CONST),
    .DATATYPE (AXI_UARTLITE_SPI_STRUCT)
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
assign PL.STAT.FRM_ERR      = '0;
assign PL.STAT.OVER_ERR     = '0;
assign PL.STAT.INTR_EN      = PS.CTRL.EN_INTR;
assign PL.STAT.TxFIFO_EMPTY = TxFIFO_EMPTY_syncpu;
assign PL.STAT.TxFIFO_FULL  = tx_next_wr == tx_cntr_rd;
assign PL.STAT.RxFIFO_FULL  = rx_next_wr == rx_cntr_rd;
assign PL.STAT.RxFIFO_VALID = !RxFIFO_EMPTY_asy; // возможно нужно сделать syn

assign tx_next_wr = tx_cntr_wr + 1'b1;
assign rx_next_wr = rx_cntr_wr + 1'b1;

assign TxFIFO_EMPTY_asy = tx_cntr_wr == tx_cntr_rd;
assign RxFIFO_EMPTY_asy = rx_cntr_wr == rx_cntr_rd;

// ==RX==
// ------ rx domain ------
ed_det#(
    .TYPE            ("fal"),
    .FLIP_EN         (0)
) ed_det_rx_reg_upd(
    .clk   (spi_clk_in),
    .in    (spi_cs_in),
    .out   (rx_reg_upd)
);

always_ff@(posedge spi_clk_in)
if(PL.CTRL.RST_RxFIFO) begin
    rx_cntr_wr <= '0;
end else begin
    if(rx_reg_upd) begin
        rx_cntr_wr <= rx_cntr_wr + 1'b1;
    end
end

always_ff@(posedge spi_clk_in)
if(spi_cs_in) begin
    rx_reg <= {spi_data_in,rx_reg} >> 1;
end

always_ff@(posedge spi_clk_in)
if(rx_reg_upd)
    rx_fifo[rx_cntr_wr] <= rx_reg;

// ------ cpu domain ------
assign PL.RxFIFO.DATA = rx_fifo[rx_cntr_rd];

always_ff@(posedge bus_sl.clk)
if(PL.CTRL.RST_RxFIFO) begin
    rx_cntr_rd <= '0;
end else begin
    if(bus_rd[0]) begin
        rx_cntr_rd <= rx_cntr_rd + 1'b1;
    end
end

level_sync#(
    .INIT_STATE (1'b1)
) level_sync_cpu_rxfifo_empty(
    .clk     (bus_sl.clk),
    .async   (RxFIFO_EMPTY_asy),
    .sync    (RxFIFO_EMPTY_syncpu)
);

ed_det#(
    .TYPE            ("fal"),
    .FLIP_EN         (1)
) ed_det_irq_rx(
    .clk   (bus_sl.clk),
    .in    (RxFIFO_EMPTY_syncpu),
    .out   (irq_rx)
);
// ==RX END==

// ==TX==
    // ------ cpu domain ------
    always_ff@(posedge bus_sl.clk)
    if(PL.CTRL.RST_TxFIFO) begin
        tx_cntr_wr <= '0;
    end else begin
        if(bus_wr[1]) begin
            tx_cntr_wr <= tx_cntr_wr + 1'b1;
        end
    end

    always_ff@(posedge bus_sl.clk)
    if(bus_wr[1])
        tx_fifo[tx_cntr_wr] <= bus_sl.wdata[7:0];

    // ------ tx domain ------
    reg tx_shift;
    assign tx_reg_upd   = (tx_shift == '0) & !TxFIFO_EMPTY_syntx;
    assign spi_cs_out   = tx_shift;
    assign spi_data_out = tx_reg[0]; // lsb first

    always_ff@(posedge spi_clk_out)
    if(PL.CTRL.RST_TxFIFO) begin
        tx_shift <= '0;
    end else begin
        if(tx_reg_upd) begin
            tx_shift <= '1;
        end else begin
            if(tx_shift_cntr == '1) begin
                tx_shift <= '0;
            end
        end
    end

    always_ff@(posedge spi_clk_out)
    if(PL.CTRL.RST_TxFIFO) begin
        tx_shift_cntr <= '0;
    end else begin
        if(tx_shift) begin
            tx_shift_cntr <= tx_shift_cntr + 1'b1;
        end
    end

    always_ff@(posedge spi_clk_out)
    if(PL.CTRL.RST_TxFIFO) begin
        tx_cntr_rd <= '0;
    end else begin
        if(tx_reg_upd) begin
            tx_cntr_rd <= tx_cntr_rd + 1'b1;
        end
    end

    always_ff@(posedge spi_clk_out)
    if(tx_reg_upd) begin
        tx_reg <= tx_fifo[tx_cntr_rd];
    end else begin
        if(tx_shift) begin
            tx_reg <= tx_reg >> 1;
        end
    end
    
    level_sync#(
        .INIT_STATE (1'b1)
    ) level_sync_cpu_txfifo_empty(
        .clk     (bus_sl.clk),
        .async   (TxFIFO_EMPTY_asy),
        .sync    (TxFIFO_EMPTY_syncpu)
    );

    level_sync#(
        .INIT_STATE (1'b1)
    ) level_sync_tx_txfifo_empty(
        .clk     (spi_clk_out),
        .async   (TxFIFO_EMPTY_asy),
        .sync    (TxFIFO_EMPTY_syntx)
    );

    ed_det#(
        .TYPE            ("ris"),
        .FLIP_EN         (1)
    ) ed_det_irq_tx(
        .clk   (bus_sl.clk),
        .in    (TxFIFO_EMPTY_syncpu),
        .out   (irq_tx)
    );
// ==TX END==

assign irq = irq_rx | irq_tx;

endmodule