`timescale 1ns/10ps
`include "time_scale.svh"

module test_interface_tb();

localparam BASE_ADDR  = 32'h40000000;

reg clk  = 1;
reg aclk = 1;
reg resetn  = 1;
reg aresetn = 1;

always #4 clk  = !clk;
always #5 aclk = !aclk;

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

intbus_interf bus();

localparam NBUSES = 2;
intbus_interf  bus_sl[NBUSES]();

connectbus#(
    .N_BUSES    (NBUSES),
    .OUTFF      ("y"),
    .MASTERFF   ("y")
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

TIME_SCALE PL1;
TIME_SCALE PS1;
TIME_SCALE PL2;
TIME_SCALE PS2;

localparam BASE1 = BASE_ADDR;
localparam BASE2 = BASE1 + 30'h100;
regs_file#(
    .BASE_ADDR (BASE1),
    .ID        (`TIME_ID_CONST),
    .DATATYPE  (TIME_SCALE)
)RF1 (
    .clk    (clk),
    .resetn (resetn),
    .bus    (bus_sl[0]),
    .in     (PL1),
    .out    (PS1),
    .pulse  ()
);

regs_file#(
    .BASE_ADDR (BASE2),
    .ID        (`TIME_ID_CONST),
    .DATATYPE  (TIME_SCALE)
)RF2 (
    .clk    (clk),
    .resetn (resetn),
    .bus    (bus_sl[1]),
    .in     (PL2),
    .out    (PS2),
    .pulse  ()
);

assign PL1.CFG          = '0;//PS2.CFG      ;
assign PL1.CODE_RATE    = PS1.CODE_RATE;
assign PL1.PHASE        = '0;//PS2.PHASE    ;
assign PL1.CHIP         = '0;//PS2.CHIP     ;
assign PL1.EPH          = '0;//PS2.EPH      ;
assign PL1.CHIP_MAX     = '0;//PS2.CHIP_MAX ;
assign PL1.EPOCH_MAX    = '0;//PS2.EPOCH_MAX;
assign PL1.INTR_EPH     = '0;//PS2.INTR_EPH ;

assign PL2.CFG          = '0;//PS2.CFG      ;
assign PL2.CODE_RATE    = PS2.CODE_RATE;
assign PL2.PHASE        = '0;//PS2.PHASE    ;
assign PL2.CHIP         = '0;//PS2.CHIP     ;
assign PL2.EPH          = '0;//PS2.EPH      ;
assign PL2.CHIP_MAX     = '0;//PS2.CHIP_MAX ;
assign PL2.EPOCH_MAX    = '0;//PS2.EPOCH_MAX;
assign PL2.INTR_EPH     = '0;//PS2.INTR_EPH ;

endmodule