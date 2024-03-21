`timescale 1ns/10ps

`define aclk_freq     100  // MHz
`define pclk_freq     106.344 // MHz

module axi_performance_tb();

localparam AXI_PERFORMANCE_BASE = 32'h40180000/4;

logic [31:0] rdata;
reg aclk  = 1;

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;

intbus_interf  bus();

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
    
    bus.readReg(AXI_PERFORMANCE_BASE,0,rdata);

    
    // bus.readReg(RGB_BASE_ADDR,1,rdata);
    
    // bus.writeReg(AXI_PERFORMANCE_BASE,0,32'hFFFFFFFF);
    // bus.writeReg(AXI_PERFORMANCE_BASE,1,32'hFFFFFFFF);
    bus.writeReg(AXI_PERFORMANCE_BASE,2,1);
    // bus.writeReg(AXI_PERFORMANCE_BASE,3,32'hFFFFFFFF);
    
    // #8000111
    // bus.writeReg(RGB_BASE_ADDR,1,RGB_DATA2);
end

axi_performance#(
    .BASEADDR (AXI_PERFORMANCE_BASE)
) AXI_PERFORMANCE(
    .bus (bus)
);

endmodule