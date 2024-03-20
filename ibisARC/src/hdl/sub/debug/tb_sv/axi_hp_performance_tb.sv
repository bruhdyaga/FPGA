`timescale 1ns/10ps

`define aclk_freq     100  // MHz

module axi_hp_performance_tb();

localparam AXI_HP_PERFORMANCE_BASE = 32'h40180000/4;

logic [31:0] rdata;
reg aclk  = 1;

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;

intbus_interf    bus();
axi_hp_interface axi_hp_0();

initial begin
    bus.resetn = '1;
    bus.init;
    bus.waitClks(5);
    bus.resetn = '0;
    bus.waitClks(5);
    bus.resetn = '1;
end

assign bus.clk = aclk;

always@(posedge bus.resetn) begin
    
    bus.readReg(AXI_HP_PERFORMANCE_BASE,0,rdata);

    bus.writeReg(AXI_HP_PERFORMANCE_BASE,3,2047);
    bus.writeReg(AXI_HP_PERFORMANCE_BASE,1,1);
end

axi_hp_performance#(
    .BASEADDR (AXI_HP_PERFORMANCE_BASE)
) AXI_HP_PERFORMANCE(
    .bus    (bus),
    .axi_hp (axi_hp_0)
);

// always_ff@(posedge bus.clk or negedge bus.resetn)
// if(bus.resetn == '0) begin
    // axi_hp_0.wready <= '0;
// end else begin
        // axi_hp_0.wready <= !axi_hp_0.wready;
// end

// always_ff@(posedge bus.clk or negedge bus.resetn)
// if(bus.resetn == '0) begin
    // axi_hp_0.awready <= '0;
// end else begin
        // axi_hp_0.awready <= !axi_hp_0.awready;
// end

assign axi_hp_0.wready  = '1;
assign axi_hp_0.awready = '1;

endmodule