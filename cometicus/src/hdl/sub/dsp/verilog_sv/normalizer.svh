`ifndef NORMALIZER_SVH
`define NORMALIZER_SVH

`include "macro.svh"

// read only
typedef struct packed {
    logic [31:10] RESERVED;
    logic [4:0]   TWIDTH;
    logic [4:0]   WIDTH;
} NORMALIZER_RO_STRUCT;

// write only
typedef struct packed {
    logic        WR;
    logic        CLR;
    logic [4:0]  SHIFT;
    logic        BYPASS;
    logic [23:0] DATA;
} NORMALIZER_WO_STRUCT;

`define NORMALIZER_ID_CONST  (16'h512D)
`define NORMALIZER_SIZE      (`size32(NORMALIZER_WO_STRUCT))
`define NORMALIZER_FULL_SIZE (`HUBSIZE + \
                              `NORMALIZER_SIZE + \
                              `RWREGSSIZE \
                              `ifdef IMI_NORM_DATCOLL + 13 `endif)

`endif