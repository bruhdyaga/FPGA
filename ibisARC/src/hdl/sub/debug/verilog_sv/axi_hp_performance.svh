`ifndef AXI_HP_PERFORMANCE_SVH
`define AXI_HP_PERFORMANCE_SVH

`include "macro.svh"

// localparam RW_SIZE = 256;

typedef struct packed {
    logic [31:1] RESERVED;
    logic [0:0]  RESET;
} AXI_HP_PERFORMANCE_CFG;

typedef struct packed {
    AXI_HP_PERFORMANCE_CFG     CFG;
    logic [31:0]               TIME;
    logic [31:11]              WR_NUM_RESERVED;
    logic [10:0]               WR_NUM;
} AXI_HP_PERFORMANCE;

`define AXI_HP_PERFORMANCE_ID_CONST  (16'hF701)
`define AXI_HP_PERFORMANCE_SIZE      (`size32(AXI_HP_PERFORMANCE))
`define AXI_HP_PERFORMANCE_FULL_SIZE (`AXI_HP_PERFORMANCE_SIZE + \
                                      `RWREGSSIZE)

`endif