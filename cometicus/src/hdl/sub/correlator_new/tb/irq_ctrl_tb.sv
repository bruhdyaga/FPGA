`timescale 1ns/10ps
`include "irq_ctrl.svh"

module irq_ctrl_tb();

localparam BASE_ADDR = 32'h40000000;

localparam PERIOD    = 32'd50;
localparam DURATION  = 32'd5;
localparam enable    = 1;
localparam sensitive = 0;
localparam polarity  = 0;

localparam UNIQ_OFFS     = 0;
localparam MAP_OFFS      = 1;
localparam CFG_OFFS      = 2;
localparam PERIOD_OFFS   = 3;
localparam DURATION_OFFS = 4;

localparam ENABLE_BIT    = 0;
localparam SENSITIVE_BIT = 1;
localparam POLARITY_BIT  = 2;
localparam RELEASE_BIT   = 3;

localparam CFG = ((enable << ENABLE_BIT) | (sensitive << SENSITIVE_BIT) | (polarity << POLARITY_BIT));

reg clk  = 1;
reg aclk = 1;
reg resetn  = 1;
reg aresetn = 1;
wire irq;

logic [31:0] rdata;

intbus_interf bus();

always #5 clk  = !clk;
always #3 aclk = !aclk;

initial begin
    @(posedge clk);
    resetn = 0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    resetn = 1'b1;
end

initial begin
    bus.init;
    @(negedge resetn);
    aresetn = 0;
    @(posedge resetn);
    bus.waitClks(1);
    aresetn = 1'b1;
end

assign bus.clk      = aclk;
assign bus.resetn   = aresetn;

initial begin
    @(negedge bus.resetn);
    @(posedge bus.resetn);
    
    bus.readReg(BASE_ADDR/4,UNIQ_OFFS,rdata);
    if(rdata[15:0] != `IRQ_ID_CONST) begin
        $display ("ERROR read ID; read = %08X",rdata);
    end else begin
        $display ("VALID ID");
    end
    
    // bus.waitClks(10);
    // bus.writeReg(BASE_ADDR/4,CFG_OFFS,32'b1000); // send pulse release_pulse
    
    bus.waitClks(20);
    bus.writeReg(BASE_ADDR/4,PERIOD_OFFS,PERIOD);
    bus.writeReg(BASE_ADDR/4,DURATION_OFFS,DURATION);
    bus.writeReg(BASE_ADDR/4,CFG_OFFS,CFG);
    
    forever begin
        bus.waitClks(20);
        while(irq == polarity) begin
            bus.waitClks(1);
        end
        bus.writeReg(BASE_ADDR/4,CFG_OFFS,CFG | (1 << RELEASE_BIT)); // send pulse release_pulse
    end
    
end

irq_ctrl#(
    .BASEADDR (BASE_ADDR/4)
) irq_ctrl_inst(
    .bus    (bus),
    .clk    (clk),
    .resetn (resetn),
    .irq    (irq)
);

endmodule