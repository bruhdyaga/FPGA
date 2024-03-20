`include "global_param.v"
`include "dma.svh"

module dma_dsp
#(
    parameter BASEADDR         = 0,
    parameter AXI_WIDTH        = 32
)
(
    intbus_interf.slave          bus,
    axi3_interface.master        axi3,
    input                        s_axi3_aclk,
    axi4_stream_interface.master m_axis,
    axi4_stream_interface.slave  s_axis
);

enum logic [1:0] {FIXED  = 2'b00,
                  INCR   = 2'b01,
                  WRAP   = 2'b10} BURST_TYPE;

enum logic [3:0] {DEV_NBUF        = 4'b0000,
                  DEV_BUF         = 4'b0001,
                  NORM_NCACH_NBUF = 4'b0010,
                  NORM_NCACH_BUF  = 4'b0011} AxCACHE;

enum logic [0:0] {NORM_ACCESS = 1'b0,
                  EXCL_ACCESS = 1'b1} AxLOCK;

localparam MAX_AXLEN       = 15; // maximum for AXI3 (from 0)
localparam AXI_AXSIZE      = $clog2(AXI_WIDTH/8);
localparam BURST_ADDR_SIZE = $clog2(MAX_AXLEN+1); // число бит адреса полной burst-транзакции

// localparam FIFO_DWIDTH      = 4;  // data bus FIFO SIZE = 2^FIFO_DWIDTH
localparam ADDR_4B8B_AWIDTH = 16; // addr space for offset

logic [ADDR_4B8B_AWIDTH-1:0] addr_4B8B_wr = '0; // 4/8-byte addr (one step
logic [ADDR_4B8B_AWIDTH-1:0] addr_4B8B_wr_inc;  // прибавка к адресу
logic [4:0] bresp_cntr = '0; // счетчик незакрытых транзакций записи

logic [3:0]  ARLEN;
logic [3:0]  AWLEN;
logic [15:0] left_rd; // осталось прочесть слов по шине AXI_GP
logic [15:0] left_wr; // осталось записать слов по шине AXI_GP

assign axi_ar     = axi3.arvalid & axi3.arready;
assign axi_aw     = axi3.awvalid & axi3.awready;
assign axi_r      = axi3.rready  & axi3.rvalid;
assign axi_w      = axi3.wready  & axi3.wvalid;
assign axi_wlast  = axi3.wlast   & axi_w;
assign axi_b      = axi3.bready  & axi3.bvalid;

// if(STREAM_READ_MODE) begin
    assign axi3.aclk = s_axi3_aclk;
// end else begin
    // assign axi3.aclk = bus.clk;
// end

DMA_STRUCT PL;
DMA_STRUCT PS;

//Define which bits will be pulsed
localparam NPULSE = 2;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 31},// START_PULSE //{reg,bit}
    '{0, 30} // RESET_PULSE //{reg,bit}
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`DMA_ID_CONST),
    .DATATYPE (DMA_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (axi3.aclk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  ({reset_pulse,start_pulse}),
    .wr     (),
    .rd     ()
);

assign PL.CFG.RESET    = '0;
assign PL.CFG.IRQ_EN   = '0;
assign PL.CFG.RESERVED = '0;
assign PL.ADDR_RD      = '0;
assign PL.ADDR_WR      = '0;

always_ff@(posedge axi3.aclk)
if(reset_pulse) begin
    PL.CFG.START <= '0;
end else begin
    if(start_pulse) begin
        PL.CFG.START <= '1; // дма не завершилась
    end else begin
        if((bresp_cntr == '0) & (left_wr == '1)) begin // закончили писать по шине и все транзакции завершились
            PL.CFG.START <= '0; // дма завершилась
        end
    end
end

always_ff@(posedge axi3.aclk)
if(start_pulse) begin
    PL.CFG.RD_SIZE <= PS.CFG.RD_SIZE + 1'b1;
end else begin
    if(axi_w) begin
        PL.CFG.RD_SIZE <= PL.CFG.RD_SIZE - 1'b1;
    end
end

always_ff@(posedge axi3.aclk)
if(start_pulse) begin
    PL.TIMER <= '0;
end else begin
    if(PL.CFG.RD_SIZE) begin
        PL.TIMER <= PL.TIMER + 1'b1;
    end
end

assign m_axis.aclk   = axi3.aclk;
assign m_axis.tdata  = axi3.rdata;
assign m_axis.tvalid = axi3.rvalid;

logic [ADDR_4B8B_AWIDTH-1:0] addr_4B8B_rd = '0; // 4/8-byte addr (one step = 4/8 bytes) // max width = bus_4B8B_width
logic arvalid_reg = '0;

logic [ADDR_4B8B_AWIDTH-1:0] addr_4B8B_rd_inc;  // прибавка к адресу

assign last_rd_trans = (PS.CFG.RD_SIZE + 1 - addr_4B8B_rd - addr_4B8B_rd_inc) == 0;

always_ff@(posedge axi3.aclk)
if(reset_pulse) begin
    arvalid_reg <= '0;
end else if(start_pulse) begin
    arvalid_reg <= '1;
end else begin
    if(axi_ar & last_rd_trans) begin
        arvalid_reg <= '0;
    end
end

assign addr_4B8B_rd_inc = axi3.arlen + 1;

always_ff@(posedge axi3.aclk)
if(start_pulse | reset_pulse) begin
    addr_4B8B_rd <= '0;
end else begin
    if(axi_ar) begin
        addr_4B8B_rd <= addr_4B8B_rd + addr_4B8B_rd_inc;
    end
end

logic [BURST_ADDR_SIZE-1:0] len_to_allign4k_rd; // остаток транзакций до выравнивания по burst к блокам 4kB
assign len_to_allign4k_rd = (2**BURST_ADDR_SIZE) - axi3.araddr[BURST_ADDR_SIZE-1+AXI_AXSIZE:AXI_AXSIZE];
assign left_rd = PS.CFG.RD_SIZE - addr_4B8B_rd; // 4/8 Byte
assign ARLEN   = !len_to_allign4k_rd ?
                ((left_rd > MAX_AXLEN) ? MAX_AXLEN : left_rd) :
                ((left_rd > (len_to_allign4k_rd-1)) ? (len_to_allign4k_rd-1) : left_rd);

assign last_wr_trans = (PS.CFG.RD_SIZE + 1 - addr_4B8B_wr - addr_4B8B_wr_inc) == 0;

logic awvalid_reg = '0;
always_ff@(posedge axi3.aclk)
if(reset_pulse) begin
    awvalid_reg <= '0;
end else if(start_pulse) begin
    awvalid_reg <= '1;
end else begin
    if(axi_aw & last_wr_trans) begin
        awvalid_reg <= '0;
    end
end

assign addr_4B8B_wr_inc = axi3.awlen + 1;

logic [BURST_ADDR_SIZE-1:0] len_to_allign4k_wr; // остаток транзакций до выравнивания по burst к блокам 4kB


always_ff@(posedge axi3.aclk)
if(start_pulse | reset_pulse) begin
    addr_4B8B_wr <= '0;
end else begin
    if(axi_aw) begin
        addr_4B8B_wr <= addr_4B8B_wr + addr_4B8B_wr_inc;
    end
end

// первая транзакция выравнивает следующий адрес для кратности burst - блокам 4kB
assign len_to_allign4k_wr = (2**BURST_ADDR_SIZE) - axi3.awaddr[BURST_ADDR_SIZE-1+AXI_AXSIZE:AXI_AXSIZE];
assign left_wr = PS.CFG.RD_SIZE - addr_4B8B_wr;
assign AWLEN   = !len_to_allign4k_wr ?
                ((left_wr > MAX_AXLEN) ? MAX_AXLEN : left_wr) :
                ((left_wr > (len_to_allign4k_wr-1)) ? (len_to_allign4k_wr-1) : left_wr);
logic [3:0] awlen_reg;
always_ff@(posedge axi3.aclk) begin
    if(axi_aw) begin
        awlen_reg <= AWLEN;
    end
end

logic [3:0] wlast_cntr = '0;
always_ff@(posedge axi3.aclk)
if(axi_wlast) begin
    wlast_cntr <= '0;
end else begin
    if(axi_w) begin
        wlast_cntr <= wlast_cntr + 1'b1;
    end
end

logic wr_trans = '0;
always_ff@(posedge axi3.aclk)
if(axi_aw) begin
    wr_trans <= '1;
end else begin
    if(axi_wlast) begin
        wr_trans <= '0;
    end
end

always_ff@(posedge axi3.aclk)
if(start_pulse | reset_pulse) begin
    bresp_cntr <= '0;
end else begin
    case({axi_b,axi_aw})
        2'b01:   bresp_cntr <= bresp_cntr + 1'b1;
        2'b10:   bresp_cntr <= bresp_cntr - 1'b1;
        default: bresp_cntr <= bresp_cntr;
    endcase
end

always_comb begin
    // ADDR READ
    axi3.araddr  <= (PS.ADDR_RD[31:AXI_AXSIZE] << AXI_AXSIZE) + (addr_4B8B_rd << AXI_AXSIZE);
    axi3.arburst <= INCR;
    axi3.arcache <= NORM_NCACH_NBUF;
    axi3.arid    <= '0;
    axi3.arlen   <= ARLEN; // Burst in transfer
    axi3.arlock  <= NORM_ACCESS;
    axi3.arprot  <= '0; // Unprivileged access|Secure access|Data access
    axi3.arqos   <= '0;
    axi3.arsize  <= AXI_AXSIZE; // Bytes in transfer 2**x
    axi3.arvalid <= arvalid_reg;

    // READ
    axi3.rready  <= m_axis.tready;


// ADDR WRITE
    axi3.awaddr  <= (PS.ADDR_WR[31:AXI_AXSIZE] << AXI_AXSIZE) + (addr_4B8B_wr << AXI_AXSIZE);
    axi3.awburst <= INCR;
    axi3.awcache <= NORM_NCACH_NBUF;
    axi3.awid    <= '0;
    axi3.awlen   <= AWLEN;
    axi3.awlock  <= NORM_ACCESS;
    axi3.awprot  <= '0;
    axi3.awqos   <= '0;
    axi3.awsize  <= AXI_AXSIZE;

// WRITE
    axi3.wdata   <= s_axis.tdata;
    axi3.wid     <= '0;
    axi3.wlast   <= wlast_cntr == awlen_reg;
    axi3.wstrb   <= '1;

// BRESP
    axi3.bready  <= '1;
end

always_comb begin
    axi3.awvalid <= awvalid_reg & (!wr_trans);
    axi3.wvalid  <= s_axis.tvalid & wr_trans;
end

assign s_axis.tready = axi3.wready;

endmodule