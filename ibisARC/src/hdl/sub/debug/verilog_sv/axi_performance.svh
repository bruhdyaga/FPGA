`ifndef AXI_PERFORMANCE_SVH
`define AXI_PERFORMANCE_SVH

`include "macro.svh"

localparam RW_SIZE = 256;

typedef struct packed {
    logic [31:16] RESERVED;
    logic [15:0]  RW_SIZE;
} AXI_PERFORMANCE_CFG;

typedef struct packed {
    AXI_PERFORMANCE_CFG        CFG;
    logic [31:0]               TIME;
    logic [RW_SIZE-1:0][31:0]  REG;
} AXI_PERFORMANCE;

`define AXI_PERFORMANCE_ID_CONST  (16'hF51E)
`define AXI_PERFORMANCE_SIZE      (`size32(AXI_PERFORMANCE))
`define AXI_PERFORMANCE_FULL_SIZE (`AXI_PERFORMANCE_SIZE + \
                                   `RWREGSSIZE)

`endif