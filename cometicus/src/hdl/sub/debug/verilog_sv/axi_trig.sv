// модуль позволяет подключить шину axi и при обращении к определенному адресу по int_bus
// начинает мониторить активность на шине, при отсутствии активности заданное количество
// клоков - формируется сигнал trig для защелкивания в ila

`include "axi_trig.svh"

module axi_trig
#(
    parameter BASEADDR = 0
)
(
    axi3_interface.debug axi3,
    output reg trig,
    intbus_interf.slave bus
);

localparam CNTRWIDTH = 20;
localparam SEL_BASE_ADDR = (BASEADDR == 0) ? 0 : 1;

reg  [CNTRWIDTH-1:0] cntr;
reg axi_active;
reg en;
reg [251:0] axi_curr;
reg [251:0] axi_prev;

// The generator data structure definition
AXI_TRIG_STRUCT PS;     // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 0} // reset_pulse
};

regs_file#(
    .BASEADDR  (BASEADDR),
    .ID        (`AXI_TRIG_ID_CONST),
    .DATATYPE  (AXI_TRIG_STRUCT),
    .NPULSE    (NPULSE),
    .PULSE     (PULSE)
)RF (
    .clk    (axi3.aclk),
    .bus    (bus),
    .in     ('0),
    .out    (PS),
    .pulse  (reset_pulse),
    .wr     (),
    .rd     ()
);

assign rd_event = axi3.arvalid & axi3.arready & (axi3.araddr == PS.BASEADDR);
assign wr_event = axi3.awvalid & axi3.awready & (axi3.awaddr == PS.BASEADDR);

// при обращении к определенному адресу запускается вотчдог
always@(posedge axi3.aclk or negedge axi3.resetn)
if(axi3.resetn == 0) begin
    en <= 0;
end else begin
    if(reset_pulse) begin
        en <= 0;
    end else begin
        if(rd_event | wr_event) begin
            en <= 1'b1;
        end
    end
end

always@(posedge axi3.aclk or negedge axi3.resetn)
if(axi3.resetn == 0) begin
    axi_curr <= 0;
    axi_prev <= 0;
end else begin
    axi_curr <= {axi3.araddr,axi3.arburst,axi3.arcache,axi3.arid,axi3.arlen,axi3.arlock,axi3.arprot,axi3.arqos,axi3.arready,axi3.arsize,axi3.arvalid,axi3.awaddr,axi3.awburst,axi3.awcache,axi3.awid,axi3.awlen,axi3.awlock,axi3.awprot,axi3.awqos,axi3.awready,axi3.awsize,axi3.awvalid,axi3.bid,axi3.bready,axi3.bresp,axi3.bvalid,axi3.rdata,axi3.rid,axi3.rlast,axi3.rready,axi3.rresp,axi3.rvalid,axi3.wdata,axi3.wid,axi3.wlast,axi3.wready,axi3.wstrb,axi3.wvalid};
    axi_prev <= axi_curr;
end

// если на axi хоть один сигнал менеется - считаем это активностью и сбрасываем счетчик
always@(posedge axi3.aclk or negedge axi3.resetn)
if(axi3.resetn == 0) begin
    axi_active <= 0;
end else begin
    if(axi_curr == axi_prev) begin// нет активности на шине
        axi_active <= 0;
    end else begin
        axi_active <= 1'b1;// есть активность на шине
    end
end

always@(posedge axi3.aclk or negedge axi3.resetn)
if(axi3.resetn == 0) begin
    cntr <= 0;
end else begin
    if(axi_active) begin
        cntr <= 0;
    end else begin
        if((cntr != PS.TIMEOUT[CNTRWIDTH-1:0]) & en) begin
            cntr <= cntr + 1'b1;
        end
    end
end

always@(posedge axi3.aclk or negedge axi3.resetn)
if(axi3.resetn == 0) begin
    trig <= 0;
end else begin
    if((cntr == PS.TIMEOUT[CNTRWIDTH-1:0]) & (cntr != '0)) begin
        trig <= 1'b1;
    end else begin
        trig <= 0;
    end
end

endmodule