module axi3_to_inter
#(
    parameter D_WIDTH    = 32,
    parameter ADDR_WIDTH = 28,
    parameter TIMEOUT    = 32 // timeout for read (in clks)
)
(
    axi3_interface.slave axi3,
    intbus_interf.master int_bus
);

localparam INT_BUS_BYTES      = D_WIDTH/8;
localparam INT_BUS_BYTES_LOG2 = $clog2(INT_BUS_BYTES);

initial begin
    axi3.arready <= '1;
    axi3.awready <= '1;
    // axi3.bid     <= '0;
    // axi3.bresp   <= '0;
    // axi3.bvalid  <= '0;
    // axi3.rdata   <= '0;
    // axi3.rid     <= '0;
    // axi3.rlast   <= '0;
    // axi3.rresp   <= '0;
    // axi3.rvalid  <= '0;
    // axi3.wready  <= '0;
end

reg [D_WIDTH-1:0] rdata_fifo [15:0]; // fifo depth is 16 for AXI3
logic [4:0]  rdata_fifo_addr_rd = '0;// rdata fifo
logic [4:0]  rdata_fifo_addr_wr = '0;

reg [1:0]  rresp_fifo [15:0]; // fifo depth is 16 for AXI3, rresp fifo

// read/write states ---
logic read_phase  = '0;   // открыта фаза чтения
logic write_phase = '0;   // открыта фаза записи

// арбитр чтения/записи 1-read; 0-write
enum logic {ARBITER_WR = 1'b0,
            ARBITER_RD = 1'b1} state_arbiter = ARBITER_RD;

always@(posedge axi3.aclk)
if(axi3.arvalid & axi3.arready) begin
    read_phase <= 1'b1;
end else begin
    if(axi3.rlast & axi3.rready) begin
        read_phase <= 0;
    end
end

always@(posedge axi3.aclk)
if(axi3.awvalid & axi3.awready) begin
    write_phase <= 1'b1;
end else begin
    if(axi3.bvalid & axi3.bready) begin
        write_phase <= 0;
    end
end

always@(posedge axi3.aclk)
case({axi3.awvalid & axi3.awready,axi3.arvalid & axi3.arready})
2'b01 : begin // read ask
    state_arbiter <= ARBITER_RD;
end
2'b10 : begin // write ask
    state_arbiter <= ARBITER_WR;
end
2'b11 : begin // read and write ask
    state_arbiter <= ARBITER_RD; // read
end
2'b00 : begin
    if((read_phase == 0) & (write_phase == 1'b1)) begin
        state_arbiter <= ARBITER_WR; // complete write
    end
end
endcase
//---

// Если мастер дает одновременно несколько данных на запись - я их принимаю по-одиночке после получения адреса.
// Готовность получения данных снимается после получения последней (last) транзации данных на запись
logic wready = '0;
always@(posedge axi3.aclk)
if(axi3.awvalid & axi3.awready) begin // slave get waddr
    wready <= '1;
end else begin
    if(axi3.wvalid & axi3.wready & axi3.wvalid & axi3.wlast) begin
        wready <= '0;
    end
end
assign axi3.wready = wready & (state_arbiter == ARBITER_WR);

// если начинается хотя бы одна транзакция, то мы не готовы начинать ни одной новой
// если мастер одновременно начнет и чтение и запись, то мы завершим последовательно обе и станем готовы снова
always@(posedge axi3.aclk)
if((axi3.arvalid & axi3.arready) | (axi3.awvalid & axi3.awready)) begin // slave get araddr or awaddr
    axi3.arready <= 1'b0; // busy
    axi3.awready <= 1'b0; // busy
end else begin
    if((read_phase==0) & (write_phase==0)) begin // master complete all transactions
        axi3.arready <= 1'b1;
        axi3.awready <= 1'b1;
    end
end

logic [7:0] cntr_timeout = '0;
assign timeout = cntr_timeout == TIMEOUT;

always@(posedge axi3.aclk)
if(/* axi3.arvalid |  */axi3.rlast & axi3.rready) begin
    cntr_timeout <= 0;
end else begin
    if(read_phase & (!axi3.rvalid)) begin
        if(!timeout) begin
            cntr_timeout <= cntr_timeout + 1'b1;
        end
    end
end

//read fifo caching ---
always@(posedge axi3.aclk)
if(/* axi3.arvalid |  */axi3.rlast & axi3.rready) begin
    rdata_fifo_addr_wr <= 0;
end else begin
    if(int_bus.rvalid | timeout) begin
        rdata_fifo_addr_wr <= rdata_fifo_addr_wr + 1'b1;
    end
end

assign axi3.rvalid = (rdata_fifo_addr_wr != rdata_fifo_addr_rd); // fifo not empty

always@(posedge axi3.aclk)
if(/* axi3.arvalid |  */axi3.rlast & axi3.rready) begin
    rdata_fifo_addr_rd <= 0;
end else begin
    if(axi3.rvalid & axi3.rready) begin
        rdata_fifo_addr_rd <= rdata_fifo_addr_rd + 1'b1;
    end
end

// если в burst чтении по шине int_bus попадем в неправильный адрес, то ошибка rresp будет не соответствовать
// адресу чтения, т.е. вся burst перемешается
always@(posedge axi3.aclk)
if(int_bus.rvalid) begin
    rdata_fifo[rdata_fifo_addr_wr] <= int_bus.rdata;
    rresp_fifo[rdata_fifo_addr_wr] <= 2'b00; // OKAY
end else if(timeout) begin
    rdata_fifo[rdata_fifo_addr_wr] <= 0;
    rresp_fifo[rdata_fifo_addr_wr] <= 2'b10; // SLVERR
end

assign axi3.rdata = rdata_fifo[rdata_fifo_addr_rd];
assign axi3.rresp = rresp_fifo[rdata_fifo_addr_rd];
//---

//address computing and control---
logic [ADDR_WIDTH-1:0] araddr = '0;
logic [ADDR_WIDTH-1:0] awaddr = '0;
logic [4:0] addr_count        = '0;
logic [3:0] arlen             = '0;
logic [3:0] awlen             = '0;
logic [11:0] arid             = '0;
logic [11:0] awid             = '0;

always@(posedge axi3.aclk)
if(axi3.arvalid & axi3.arready) begin
    arlen  <= axi3.arlen;
    araddr <= axi3.araddr[ADDR_WIDTH - 1 + INT_BUS_BYTES_LOG2 : INT_BUS_BYTES_LOG2];
    arid   <= axi3.arid;
end

always@(posedge axi3.aclk)
if(axi3.awvalid & axi3.awready) begin
    awlen  <= axi3.awlen;
    awaddr <= axi3.awaddr[ADDR_WIDTH - 1 + INT_BUS_BYTES_LOG2 : INT_BUS_BYTES_LOG2];
    awid   <= axi3.awid;
end

always@(posedge axi3.aclk)
if(((state_arbiter == ARBITER_RD) & axi3.rlast & axi3.rready) | ((state_arbiter == ARBITER_WR) & axi3.wlast & axi3.wvalid & axi3.wready)) begin
    addr_count <= 0;
end else begin
    if((int_bus.wr & (addr_count <= awlen)) | (int_bus.rd & (addr_count <= arlen))) begin
        addr_count <= addr_count + 1'b1;
    end
end
//---

assign axi3.rlast = axi3.rvalid & (rdata_fifo_addr_rd == arlen);
assign axi3.rid   = arid;
assign axi3.bid   = awid;

//response ---
logic bvalid = '0;

// при записи - шина int_bus никак не отвечает и контролировать ошибку адреса
// или чего-то еще невозможно, ответ всегда ОК
assign axi3.bresp   = 2'b00; // OKAY response write


assign axi3.bvalid = bvalid;

always@(posedge axi3.aclk)
if(axi3.wvalid & axi3.wready & axi3.wlast) begin
    bvalid <= 1'b1;
end else begin
    if(bvalid & axi3.bready) begin
        bvalid <= 0;
    end
end
//---

always_comb int_bus.addr     = ((state_arbiter == ARBITER_RD) ? araddr : awaddr) + addr_count;
always_comb int_bus.wdata    = axi3.wdata;
always_comb int_bus.wr       = axi3.wvalid & axi3.wready;
always_comb int_bus.rd       = (state_arbiter == ARBITER_RD) & read_phase & (addr_count <= arlen);

always_comb int_bus.clk      = axi3.aclk;

endmodule