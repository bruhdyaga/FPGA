`include "axi_hp_performance.svh"

module axi_hp_performance
#(
    parameter BASEADDR = 0
)
(
    intbus_interf.slave     bus,
    axi_hp_interface.master axi_hp
);

// The generator data structure definition
AXI_HP_PERFORMANCE PL; // The registers from logic
AXI_HP_PERFORMANCE PS; // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 0} //reset // CFG REG
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`AXI_HP_PERFORMANCE_ID_CONST),
    .DATATYPE (AXI_HP_PERFORMANCE),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk     (bus.clk),
    .bus     (bus),
    .in      (PL),
    .out     (PS),
    .pulse   (reset),
    .wr      (),
    .rd      ()
);

assign PL.CFG             = '0;
assign PL.WR_NUM_RESERVED = '0;
assign PL.WR_NUM          = PS.WR_NUM;

wire wr;
wire awr;
wire new_wr;
reg  [10:0] cntr;   // счетчик берст-транзакций
reg  [17:0] awaddr; // рабочая часть шины адреса
reg  [15:0] wdata;  // рабочая часть шины данных
reg  en_time; // разрешение счета времени

always_ff@(posedge bus.clk)
if(reset) begin
    en_time <= '1;
end else begin
    if(wr & axi_hp.wlast & (PS.WR_NUM == cntr)) begin
        en_time <= '0;
    end
end

always_ff@(posedge bus.clk)
if(reset) begin
    PL.TIME <= '0;
end else begin
    if(en_time) begin
        PL.TIME <= PL.TIME + 1'b1;
    end
end

//====================================================================

always_ff@(posedge bus.clk)
if(reset) begin
    cntr <= '0;
end else begin
    if(new_wr) begin
        cntr <= cntr + 1'b1;
    end
end

assign wr      = axi_hp.wvalid  & axi_hp.wready;
assign awr     = axi_hp.awvalid & axi_hp.awready;
assign new_wr  = axi_hp.wlast   & wr             & cntr != PS.WR_NUM;

assign axi_hp.araddr       = '0;
assign axi_hp.arburst      = '0;
assign axi_hp.arcache      = '0;
assign axi_hp.arid         = '0;
assign axi_hp.arlen        = '0;
assign axi_hp.arlock       = '0;
assign axi_hp.arprot       = '0;
assign axi_hp.arqos        = '0;
assign axi_hp.arsize       = '0;
assign axi_hp.arvalid      = '0;
// input  arready      ,

assign axi_hp.awaddr       = {14'h3FFF,awaddr};
assign axi_hp.wdata        = { {8'hA0,wdata,8'h0A} , {8'hB0,wdata,8'h0B} };
assign axi_hp.awburst      = 2'b01;   // Burst type = INCR
assign axi_hp.awcache      = 4'b0010; // Normal Non-cacheable Non-bufferable
assign axi_hp.awid         = '0;
assign axi_hp.awlen        = 4'b1111; // Burst length
assign axi_hp.awlock       = 2'b00;
assign axi_hp.awprot       = 3'b000;
assign axi_hp.awqos        = 4'b0000;
assign axi_hp.awsize       = 3'b011;  // Bytes in transfer

assign axi_hp.bready       = '1;
// input  axi_hp.bid          ;
// input  axi_hp.bresp        ;
// input  axi_hp.bvalid       ;

assign axi_hp.rready       = '0;
// input  axi_hp.rdata        ,
// input  axi_hp.rid          ,
// input  axi_hp.rlast        ,
// input  axi_hp.rresp        ,
// input  axi_hp.rvalid       ,

assign axi_hp.wid          = '0;
assign axi_hp.wstrb        = 8'hFF;

always_ff@(posedge bus.clk)
if(reset | new_wr) begin
    axi_hp.awvalid <= '1;
end else begin
    if(awr) begin
        axi_hp.awvalid <= '0;
    end
end

always_ff@(posedge bus.clk)
if(reset) begin
    awaddr <= '0;
end else begin
    if(awr) begin
        awaddr <= awaddr + 8*16;
    end
end

always_ff@(posedge bus.clk)
if(reset) begin
    wdata <= '0;
end else begin
    if(wr) begin
        wdata <= wdata + 1'b1;
    end
end

reg [3:0] burst_cntr;
always_ff@(posedge bus.clk)
if(reset | new_wr) begin
    burst_cntr <= '0;
end else begin
    if((burst_cntr != '1) & (axi_hp.wvalid == '1) & wr) begin
        burst_cntr <= burst_cntr + 1'b1;
    end
end

always_ff@(posedge bus.clk)
if(reset | new_wr) begin
    axi_hp.wvalid <= '1;
end else begin
    if((burst_cntr == '1) & wr) begin
        axi_hp.wvalid <= '0;
    end
end

always_ff@(posedge bus.clk)
if((burst_cntr == 4'd14) & wr) begin
    axi_hp.wlast <= '1;
end else begin
    if(wr) begin
        axi_hp.wlast <= '0;
    end
end

endmodule