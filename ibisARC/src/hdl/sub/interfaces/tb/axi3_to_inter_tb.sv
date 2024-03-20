`timescale 1ns/10ps

`include "axi3_to_inter_tb_struct.svh"
`include "global_param.v"

module axi3_to_inter_tb();

localparam CLK_FREQ    = 100e6; //MHz
localparam CPU_FREQ    = 59e6;  //MHz
localparam INST = 16'h1;

reg clk = 1;
reg aclk = 1;
reg resetn;


always #(1e9/CLK_FREQ/2) clk  <= !clk;
always #(1e9/CPU_FREQ/2) aclk <= !aclk;

localparam ID_OFFS = 0;
localparam R0_OFFS = 2*4;
localparam R1_OFFS = 3*4;
localparam R2_OFFS = 4*4;
localparam R3_OFFS = 5*4;

localparam BASEREG1 = `BASE_ADDR/4 + `HUBSIZE;
localparam BASEREG2 = BASEREG1 + `REGFILE_FULL_SIZE;

parameter N_BUSES = 2;

axi3_interface axi3();
intbus_interf int_bus();
intbus_interf hub_bus[N_BUSES]();

assign axi3.aclk       = aclk;
assign axi3.resetn     = resetn;

initial begin
     resetn = 1'b1;
#30  resetn = 1'b0;
#100 resetn = 1'b1;
end

reg [31:0] val [2**4];

reg [31:0] BASE_0_BYTE;
reg [31:0] BASE_1_BYTE;

initial begin
axi3.Init;

@(negedge resetn);
@(posedge resetn);
@(posedge axi3.aclk);

@(posedge axi3.aclk);
@(posedge axi3.aclk);
@(posedge axi3.aclk);
@(posedge axi3.aclk);
@(posedge axi3.aclk);
@(posedge axi3.aclk);

axi3.awid = 0;
axi3.arid = 0;

// axi3.readReg(`BASE_ADDR/4-1*4,0,7);// timeout read
// axi3.waitClks(1000);

val[0] = 32'hB0BADED;
axi3.readwriteReg(BASEREG1*4,100,0, BASEREG1*4,R0_OFFS,0,val);
end
/* $display ("after break");

$display ("bus hub ID");
axi3.readReg(`BASE_ADDR/4,0,0);

BASE_0_BYTE = `BASE_ADDR/4+3*4;

$display ("REG_0 ID");
axi3.readReg(BASE_0_BYTE,0,0);
$display ("BASE_1_BYTE");
axi3.readReg(BASE_0_BYTE,1*4,0);
BASE_1_BYTE = BASE_0_BYTE + ((axi3.rdata)&32'hFFFF)*4;
$display ("BASE_1_BYTE : 0x%h", BASE_1_BYTE);
$display ("REG_1 ID");
axi3.readReg(BASE_1_BYTE,0,0);
$display ("**********");


axi3.writeReg(BASE_0_BYTE,0*4,0,val);
axi3.writeReg(BASE_0_BYTE,1*4,0,val);
axi3.writeReg(BASE_0_BYTE,2*4,0,val);
axi3.writeReg(BASE_0_BYTE,3*4,0,val);





axi3.readReg(`BASE_ADDR/4,0,0);   //test read valid non-burst
axi3.readReg(`BASE_ADDR/4,1*4,3); //test read valid burst

val[0] = 32'hAAAA1111;
// axi3.writeReg(0,0,0,val);               //test write non-valid address
$display ("+++++");
for(int i=0;i<8;i++)begin
val[i] = 32'hAAAA0000+i;
end
axi3.writeReg(`BASE_ADDR/4,R0_OFFS,7,val);   //test write valid burst

axi3.readReg(`BASE_ADDR/4,ID_OFFS,0);   //check
axi3.readReg(`BASE_ADDR/4,R0_OFFS,7);
$display ("+++++");


// axi3.readReg(`BASE_ADDR/4,ID_OFFS,0);// axi3.waitClks(10);
// axi3.readReg(`BASE_ADDR/4,R0_OFFS,0);// axi3.waitClks(10);
// axi3.readReg(`BASE_ADDR/4,R1_OFFS,0);// axi3.waitClks(10);
// axi3.readReg(`BASE_ADDR/4,R2_OFFS,0);// axi3.waitClks(10);
// axi3.readReg(`BASE_ADDR/4,R3_OFFS,0);// axi3.waitClks(10);

// val[0] = 32'hAAAA1111; axi3.writeReg(`BASE_ADDR/4,R0_OFFS,0,val);// axi3.waitClks(10);
// val[0] = 32'hAAAA2222; axi3.writeReg(`BASE_ADDR/4,R1_OFFS,0,val);// axi3.waitClks(10);
// val[0] = 32'hAAAA3333; axi3.writeReg(`BASE_ADDR/4,R2_OFFS,0,val);// axi3.waitClks(10);
// val[0] = 32'hAAAA4444; axi3.writeReg(`BASE_ADDR/4,R3_OFFS,0,val);// axi3.waitClks(10);

// axi3.readReg(`BASE_ADDR/4,R0_OFFS,0);// axi3.waitClks(10);
// axi3.readReg(`BASE_ADDR/4,R1_OFFS,0);// axi3.waitClks(10);
// axi3.readReg(`BASE_ADDR/4,R2_OFFS,0);// axi3.waitClks(10);
// axi3.readReg(`BASE_ADDR/4,R3_OFFS,0);// axi3.waitClks(10);


$display ("--------");
for(int i=0;i<8;i++)begin
val[i] = 32'hBBBB0000+i;
end
// axi3.readReg(`BASE_ADDR/4,R0_OFFS,3); //test read valid burst
axi3.writeReg(`BASE_ADDR,R0_OFFS,7,val);   //test write valid burst
// axi3.readReg(`BASE_ADDR/4,R0_OFFS,7); //test read valid burst

// $display ("");
// $display ("**********");
// #500
// val[0] = 32'h12345678;
// axi3.writeReg(BASE_0_BYTE,R0_OFFS,0,val);
// val[0] = 32'hB0BA6663;
// axi3.writeReg(BASE_0_BYTE,R1_OFFS,0,val);

// #1000
// axi3.readReg(BASE_0_BYTE,R0_OFFS,0);

// #1000
// axi3.readReg_2(BASE_0_BYTE,R0_OFFS);

#1000
val[0] = 32'hAAAA1111; axi3.writeReg(`BASE_ADDR,R0_OFFS,0,val);// axi3.waitClks(10);

#10000
val[0] = 32'hB0BA1111;
val[1] = 32'hB0BA2222;
axi3.write_addr_2data_addr(`BASE_ADDR,R0_OFFS,val);

$display ("****Finish****");
end */

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (int_bus)
);

connectbus#(
    .BASEADDR   (`BASE_ADDR/4),
    .N_BUSES    (N_BUSES)
) connectbus_0_inst(
    .master_bus (int_bus),
    .slave_bus  (hub_bus)
);

// The generator data structure definition
REGFILE PS1;     // The registers from CPU
REGFILE PS2;     // The registers from CPU

regs_file#(
    .BASEADDR  (BASEREG1),
    .ID        (`REGFILE_ID_CONST),
    .DATATYPE  (REGFILE)
)RF1 (
    .clk    (),
    .resetn (),
    .bus    (hub_bus[0]),
    .in     (PS1),
    .out    (PS1),
    .pulse  (),
    .wr     (),
    .rd     ()
);
regs_file#(
    .BASEADDR  (BASEREG2),
    .ID        (`REGFILE_ID_CONST),
    .DATATYPE  (REGFILE)
)RF2 (
    .clk    (),
    .resetn (),
    .bus    (hub_bus[1]),
    .in     (PS2),
    .out    (PS2),
    .pulse  (),
    .wr     (),
    .rd     ()
);

endmodule