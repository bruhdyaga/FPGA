`ifndef AXI_HP_MASTER_SVH
`define AXI_HP_MASTER_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:16] WR_LEN;
    logic [15:4]  RESERVED;
    logic [3:3]   DONE_WR;
    logic [2:2]   START_WR;
    logic [1:1]   DONE_RD;
    logic [0:0]   START_RD;
} AXI_HP_MASTER_CFG;

typedef struct packed {
    AXI_HP_MASTER_CFG    CFG;
} AXI_HP_MASTER_STRUCT;

`define AXI_HP_MASTER_ID_CONST  (16'h2859)
`define AXI_HP_MASTER_SIZE      (`size32(AXI_HP_MASTER_STRUCT))
`define AXI_HP_MASTER_FULL_SIZE (`AXI_HP_MASTER_SIZE + \
                                 `RWREGSSIZE)

`endif