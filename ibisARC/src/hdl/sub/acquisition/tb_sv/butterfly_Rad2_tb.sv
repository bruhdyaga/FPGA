`timescale 1ns/10ps

`include "global_param.v"

`define pclk 105.6  // MHz
`define aclk 100    // MHz

module butterfly_Rad2_tb();

localparam BASEADDR    = 0;

reg  pclk = 1;
reg  aclk = 1;
reg  aresetn = 1;
wire presetn;

always #((1000/`pclk)/2) pclk <= !pclk;
always #((1000/`aclk)/2) aclk <= !aclk;


axi3_interface axi3();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH-2)
)bus();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

//-----------------------
typedef struct packed {
    logic [3:0]  RESERVED_Q;
    logic [11:0] Q;
    logic [3:0]  RESERVED_I;
    logic [11:0] I;
} REG_STRUCT;

typedef struct packed {
    logic [31:12] RESERVED;
    logic [3:0]   AD_CTRL_IN;
    logic [7:0]   AD_CTRL_OUT;
} AD_CTRL_STRUCT;

typedef struct packed {
    logic [3:0]   W_R;
    logic [13:0]  D0_R;
    logic [13:0]  D1_R;
    logic [3:0]   W_I;
    logic [13:0]  D0_I;
    logic [13:0]  D1_I;
    logic [31:4]  RESERVED;
    logic [3:0]   CUT;
} RADIX_STRUCT;

typedef struct packed {
    REG_STRUCT     REG;
    AD_CTRL_STRUCT AD_CTRL;
    logic [31:0]   RW;
    RADIX_STRUCT   RADIX;
} TEST_STRUCT;

TEST_STRUCT PL;
TEST_STRUCT PS;

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (16'hABCD),
    .DATATYPE (TEST_STRUCT)
)RF (
    .clk    (),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

butterfly_Rad2#(
    .D_WIDTH (14),
    .W_WIDTH (4)
) RADIX_2(
    .clk (axi3.aclk),
    .A_R (PS.RADIX.D0_R),
    .A_I (PS.RADIX.D0_I),
    .B_R (PS.RADIX.D1_R),
    .B_I (PS.RADIX.D1_I),
    .C_R (PL.RADIX.D0_R),
    .C_I (PL.RADIX.D0_I),
    .D_R (PL.RADIX.D1_R),
    .D_I (PL.RADIX.D1_I),
    .W_R (PS.RADIX.W_R),
    .W_I (PS.RADIX.W_I),
    .cut (PS.RADIX.CUT)
);
assign PL.RADIX.W_R      = '0;
assign PL.RADIX.W_I      = '0;
assign PL.RADIX.CUT      = '0;
assign PL.RADIX.RESERVED = '0;

endmodule