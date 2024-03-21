`timescale 1ns/10ps
`include "../verilog_sv/rgb.svh"

module rgb_tb();

`define aclk 100    // MHz
localparam RGB_BASE_ADDR = 32'h40000000/4;

localparam R = 0;
localparam G = 128;
localparam B = 255;

localparam R2 = 1;
localparam G2 = 0;
localparam B2 = 255;

localparam RGB_DATA = ((R*((2**WIDTH)-1)/255) & ((1<<8)-1)) | (((G*((2**WIDTH)-1)/255) & ((1<<8)-1)) << 8) | (((B*((2**WIDTH)-1)/255) & ((1<<8)-1)) << 8*2);
localparam RGB_DATA2 = ((R2*((2**WIDTH)-1)/255) & ((1<<8)-1)) | (((G2*((2**WIDTH)-1)/255) & ((1<<8)-1)) << 8) | (((B2*((2**WIDTH)-1)/255) & ((1<<8)-1)) << 8*2);

reg aclk = 1;

always #((1000/`aclk)/2) aclk <= !aclk;

intbus_interf  bus();
logic [31:0] rdata;

initial begin
    bus.resetn = '1;
    bus.init;
    bus.waitClks(5);
    bus.resetn = '0;
    bus.waitClks(5);
    bus.resetn = '1;
end

assign bus.clk      = aclk;

always@(posedge bus.resetn) begin
    
    bus.readReg(RGB_BASE_ADDR,0,rdata);
    // if(rdata[15:0] != `TIME_SCALE_CH_ID_CONST) begin
        // $display ("ERROR read IRQ_ID; read = %08X",rdata);
    // end else begin
        // $display ("VALID IRQ_ID");
    // end
    
    bus.readReg(RGB_BASE_ADDR,1,rdata);
    
    bus.writeReg(RGB_BASE_ADDR,1,RGB_DATA);
    
    #8000111
    bus.writeReg(RGB_BASE_ADDR,1,RGB_DATA2);
end

rgb#(
    .BASEADDR (RGB_BASE_ADDR)
) RGB(
    .bus (bus),
    .R   (),
    .G   (),
    .B   ()
);

endmodule