`include "global_param.v"
`include "dma.svh"

// пока что DMA сам выравнивает транзакции чтения по burst 16*4Byte и читать можно с любого адреса
// но записывать надо в адрес выровненный к burst 16*4Byte

module dma
#(
    parameter BASEADDR         = 0,
    parameter AXI_WIDTH        = 32,
    parameter STREAM_READ_MODE = 0,
    parameter FIFO             = 1
)
(
    intbus_interf.slave   bus,
    axi3_interface.master s_axi3,
    input  logic          s_axi3_aclk,
    input  logic          irq,    // должен быть достаточной для синхронизации длительности
    output logic          progress
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

localparam FIFO_DWIDTH      = 4;  // data bus FIFO SIZE = 2^FIFO_DWIDTH
localparam ADDR_4B8B_AWIDTH = 16; // addr space for offset

logic [ADDR_4B8B_AWIDTH-1:0] addr_4B8B_wr = '0; // 4/8-byte addr (one step
logic [ADDR_4B8B_AWIDTH-1:0] addr_4B8B_wr_inc;  // прибавка к адресу
logic [4:0] bresp_cntr = '0; // счетчик незакрытых транзакций записи

logic [3:0]  ARLEN;
logic [3:0]  AWLEN;
logic [15:0] left_rd; // осталось прочесть слов по шине AXI_GP
logic [15:0] left_wr; // осталось записать слов по шине AXI_GP

assign axi_ar     = s_axi3.arvalid & s_axi3.arready;
assign axi_aw     = s_axi3.awvalid & s_axi3.awready;
assign axi_r      = s_axi3.rready  & s_axi3.rvalid;
assign axi_w      = s_axi3.wready  & s_axi3.wvalid;
assign axi_wlast  = s_axi3.wlast   & axi_w;
assign axi_b      = s_axi3.bready  & s_axi3.bvalid;

if(STREAM_READ_MODE) begin
    assign s_axi3.aclk = s_axi3_aclk;
end else begin
    assign s_axi3.aclk = bus.clk;
end

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
    .clk    (s_axi3.aclk),
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

level_sync level_sync_irq(
    .clk   (s_axi3.aclk),
    .async (irq),
    .sync  (irq_syn)
);

ed_det#(
    .TYPE ("ris")
)ED_DET_IRQ_INST (
    .clk   (s_axi3.aclk),
    .in    (irq_syn),
    .out   (irq_pulse)
);

assign start    = start_pulse | irq_pulse & PS.CFG.IRQ_EN;
assign progress = PL.CFG.START;

always_ff@(posedge s_axi3.aclk)
if(reset_pulse) begin
    PL.CFG.START <= '0;
end else begin
    if(start) begin
        PL.CFG.START <= '1; // дма не завершилась
    end else begin
        if((bresp_cntr == '0) & (left_wr == '1)) begin // закончили писать по шине и все транзакции завершились
            PL.CFG.START <= '0; // дма завершилась
        end
    end
end

always_ff@(posedge s_axi3.aclk)
if(start) begin
    PL.CFG.RD_SIZE <= PS.CFG.RD_SIZE + 1'b1;
end else begin
    if(axi_w) begin
        PL.CFG.RD_SIZE <= PL.CFG.RD_SIZE - 1'b1;
    end
end

always_ff@(posedge s_axi3.aclk)
if(start) begin
    PL.TIMER <= '0;
end else begin
    if(PL.CFG.RD_SIZE) begin
        PL.TIMER <= PL.TIMER + 1'b1;
    end
end


logic [AXI_WIDTH-1:0] fifo_rd;
logic                 fifo_full = '0;
logic                 fifo_empty;
if(FIFO) begin
    logic [AXI_WIDTH-1:0] fifo_wr [(2**FIFO_DWIDTH)-1:0];
    
    logic [FIFO_DWIDTH-1:0] fifo_wr_cntr = '0; // data bus
    logic [FIFO_DWIDTH:0]   fifo_wr_next1_cntr;
    logic [FIFO_DWIDTH:0]   fifo_wr_next2_cntr;
    logic [FIFO_DWIDTH-1:0] fifo_rd_cntr = '0; // data bus

    assign fifo_wr_next1_cntr = fifo_wr_cntr + 1;
    assign fifo_wr_next2_cntr = fifo_wr_cntr + 2;

    assign fifo_empty = fifo_rd_cntr == fifo_wr_cntr;

    always_ff@(posedge s_axi3.aclk)
    if(start) begin
        fifo_full <= '0;
    end else begin
        if(fifo_full == '0) begin // fifo NO full
            fifo_full <= fifo_wr_next2_cntr[FIFO_DWIDTH-1:0] == fifo_rd_cntr;
        end else begin // fifo FULL
            if(fifo_wr_next1_cntr[FIFO_DWIDTH-1:0] != fifo_rd_cntr) begin
                fifo_full <= '0;
            end
        end
    end

    always_ff@(posedge s_axi3.aclk)
    if(start) begin
        fifo_wr_cntr <= '0;
    end else begin
        if(axi_r) begin
            fifo_wr_cntr <= fifo_wr_cntr + 1'b1;
        end
    end

    always_ff@(posedge s_axi3.aclk)
    if(start) begin
        fifo_rd_cntr <= '0;
    end else begin
        if(axi_w) begin
            fifo_rd_cntr <= fifo_rd_cntr + 1'b1;
        end
    end

    always_ff@(posedge s_axi3.aclk)
    if(axi_r) begin
        fifo_wr[fifo_wr_cntr] <= s_axi3.rdata;
    end

    always_comb begin
        fifo_rd <= fifo_wr[fifo_rd_cntr];
    end
end else begin
    always_comb begin
        fifo_rd   <= s_axi3.rdata;
        fifo_full <= '0;
    end
    assign fifo_empty = !axi_r;
end

logic [ADDR_4B8B_AWIDTH-1:0] addr_4B8B_rd = '0; // 4/8-byte addr (one step = 4/8 bytes) // max width = bus_4B8B_width
logic arvalid_reg = '0;
if(!STREAM_READ_MODE) begin
    logic [ADDR_4B8B_AWIDTH-1:0] addr_4B8B_rd_inc;  // прибавка к адресу

    assign last_rd_trans = (PS.CFG.RD_SIZE + 1 - addr_4B8B_rd - addr_4B8B_rd_inc) == 0;

    always_ff@(posedge s_axi3.aclk)
    if(start) begin
        arvalid_reg <= '1;
    end else begin
        if(axi_ar & last_rd_trans) begin
            arvalid_reg <= '0;
        end
    end
    
    assign addr_4B8B_rd_inc = s_axi3.arlen + 1;
    
    always_ff@(posedge s_axi3.aclk)
    if(start) begin
        addr_4B8B_rd <= '0;
    end else begin
        if(axi_ar) begin
            addr_4B8B_rd <= addr_4B8B_rd + addr_4B8B_rd_inc;
        end
    end
    
    logic [BURST_ADDR_SIZE-1:0] len_to_allign4k_rd; // остаток транзакций до выравнивания по burst к блокам 4kB
    assign len_to_allign4k_rd = (2**BURST_ADDR_SIZE) - s_axi3.araddr[BURST_ADDR_SIZE-1+AXI_AXSIZE:AXI_AXSIZE];
    assign left_rd = PS.CFG.RD_SIZE - addr_4B8B_rd; // 4/8 Byte
    assign ARLEN   = !len_to_allign4k_rd ?
                    ((left_rd > MAX_AXLEN) ? MAX_AXLEN : left_rd) :
                    ((left_rd > (len_to_allign4k_rd-1)) ? (len_to_allign4k_rd-1) : left_rd);
end

assign last_wr_trans = (PS.CFG.RD_SIZE + 1 - addr_4B8B_wr - addr_4B8B_wr_inc) == 0;

logic awvalid_reg = '0;
always_ff@(posedge s_axi3.aclk)
if(start) begin
    awvalid_reg <= '1;
end else begin
    if(axi_aw & last_wr_trans) begin
        awvalid_reg <= '0;
    end
end

assign addr_4B8B_wr_inc = s_axi3.awlen + 1;

logic [BURST_ADDR_SIZE-1:0] len_to_allign4k_wr; // остаток транзакций до выравнивания по burst к блокам 4kB


always_ff@(posedge s_axi3.aclk)
if(start) begin
    addr_4B8B_wr <= '0;
end else begin
    if(axi_aw) begin
        addr_4B8B_wr <= addr_4B8B_wr + addr_4B8B_wr_inc;
    end
end

// первая транзакция выравнивает следующий адрес для кратности burst - блокам 4kB
assign len_to_allign4k_wr = (2**BURST_ADDR_SIZE) - s_axi3.awaddr[BURST_ADDR_SIZE-1+AXI_AXSIZE:AXI_AXSIZE];
assign left_wr = PS.CFG.RD_SIZE - addr_4B8B_wr;
assign AWLEN   = !len_to_allign4k_wr ?
                ((left_wr > MAX_AXLEN) ? MAX_AXLEN : left_wr) :
                ((left_wr > (len_to_allign4k_wr-1)) ? (len_to_allign4k_wr-1) : left_wr);
logic [3:0] awlen_reg;
always_ff@(posedge s_axi3.aclk) begin
    if(axi_aw) begin
        awlen_reg <= AWLEN;
    end
end

logic [3:0] wlast_cntr = '0;
always_ff@(posedge s_axi3.aclk)
if(axi_wlast) begin
    wlast_cntr <= '0;
end else begin
    if(axi_w) begin
        wlast_cntr <= wlast_cntr + 1'b1;
    end
end

logic wr_trans = '0;
always_ff@(posedge s_axi3.aclk)
if(axi_aw) begin
    wr_trans <= '1;
end else begin
    if(axi_wlast) begin
        wr_trans <= '0;
    end
end

always_ff@(posedge s_axi3.aclk)
if(start) begin
    bresp_cntr <= '0;
end else begin
    case({axi_b,axi_aw})
        2'b01:   bresp_cntr <= bresp_cntr + 1'b1;
        2'b10:   bresp_cntr <= bresp_cntr - 1'b1;
        default: bresp_cntr <= bresp_cntr;
    endcase
end

always_comb begin
if(STREAM_READ_MODE) begin
    // ADDR READ
        s_axi3.araddr  <= '0;
        s_axi3.arburst <= '0;
        s_axi3.arcache <= '0;
        s_axi3.arid    <= '0;
        s_axi3.arlen   <= '0; // Burst in transfer
        s_axi3.arlock  <= '0;
        s_axi3.arprot  <= '0; // Unprivileged access|Secure access|Data access
        s_axi3.arqos   <= '0;
        s_axi3.arsize  <= '0; // Bytes in transfer 2**x
        s_axi3.arvalid <= '0;

    // READ
        s_axi3.rready  <= '1;
end else begin
    // ADDR READ
        s_axi3.araddr  <= (PS.ADDR_RD[31:AXI_AXSIZE] << AXI_AXSIZE) + (addr_4B8B_rd << AXI_AXSIZE);
        s_axi3.arburst <= INCR;
        s_axi3.arcache <= NORM_NCACH_NBUF;
        s_axi3.arid    <= '0;
        s_axi3.arlen   <= ARLEN; // Burst in transfer
        s_axi3.arlock  <= NORM_ACCESS;
        s_axi3.arprot  <= '0; // Unprivileged access|Secure access|Data access
        s_axi3.arqos   <= '0;
        s_axi3.arsize  <= AXI_AXSIZE; // Bytes in transfer 2**x
        s_axi3.arvalid <= arvalid_reg;

    // READ
        s_axi3.rready  <= !fifo_full;
end


// ADDR WRITE
    s_axi3.awaddr  <= (PS.ADDR_WR[31:AXI_AXSIZE] << AXI_AXSIZE) + (addr_4B8B_wr << AXI_AXSIZE);
    s_axi3.awburst <= INCR;
    s_axi3.awcache <= NORM_NCACH_NBUF;
    s_axi3.awid    <= '0;
    s_axi3.awlen   <= AWLEN;
    s_axi3.awlock  <= NORM_ACCESS;
    s_axi3.awprot  <= '0;
    s_axi3.awqos   <= '0;
    s_axi3.awsize  <= AXI_AXSIZE;

// WRITE
    s_axi3.wdata   <= fifo_rd;
    s_axi3.wid     <= '0;
    s_axi3.wlast   <= wlast_cntr == awlen_reg;
    s_axi3.wstrb   <= '1;

// BRESP
    s_axi3.bready  <= '1;
end

always_comb begin
    s_axi3.awvalid <= awvalid_reg & (!wr_trans);
    s_axi3.wvalid  <= !fifo_empty & wr_trans;
end


endmodule