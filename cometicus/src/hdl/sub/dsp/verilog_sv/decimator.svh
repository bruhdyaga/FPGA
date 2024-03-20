`ifndef DECIMATOR_SVH
`define DECIMATOR_SVH

`include "macro.svh"
`include "fir.svh"

typedef struct packed {
    logic [31:1] RESERVED;
    logic        BYPASS;
} DECIMATOR_STRUCT;

`define DECIMATOR_ID_CONST  (16'h6468)
`define DECIMATOR_SIZE      (`size32(DECIMATOR_STRUCT))
`define DECIMATOR_FULL_SIZE (`HUBSIZE + \
                             `RWREGSSIZE + \
                             `DECIMATOR_SIZE + \
                             `FIR_FULL_SIZE)

`endif