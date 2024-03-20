`ifndef LIM_CNTR_CH
`define LIM_CNTR_CH

`include "macro.svh"

typedef struct packed {
    logic [31:20] RESERVED;
    logic [19:16] PERIOD_2N;
    logic [15:0]  CNTR;
} LIM_CNTR_CFG;

typedef struct packed {
    LIM_CNTR_CFG  CFG;
} LIM_CNTR_STRUCT;

`define LIM_CNTR_ID_CONST  (16'hF340)
`define LIM_CNTR_SIZE      (`size32(LIM_CNTR_STRUCT))
`define LIM_CNTR_FULL_SIZE ( `LIM_CNTR_SIZE + \
                             `RWREGSSIZE)

`endif
