`ifndef MAX_ARGS_SVH
 `define MAX_ARGS_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:0]  TAU;
    logic [31:16] FREQ_RESERVED;
    logic [15:0]  FREQ;
    logic [31:0]  R_LO;
    logic [31:0]  R_HI;
} MAX_ARGS_STRUCT;

`define MAX_ARGS_ID_CONST  (16'h1760)
`define MAX_ARGS_SIZE (`size32(MAX_ARGS_STRUCT))
`define MAX_ARGS_FULL_SIZE (`MAX_ARGS_SIZE + \
                            `RWREGSSIZE)

`endif