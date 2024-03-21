`ifndef DDS_BIN_SVH
 `define DDS_BIN_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:0] CODE_FREQ;
} DDS_BIN_STRUCT;

`define DDS_BIN_ID_CONST  (16'h4E46)
`define DDS_BIN_SIZE (`size32(DDS_BIN_STRUCT))
`define DDS_BIN_FULL_SIZE ( `DDS_BIN_SIZE + \
                            `RWREGSSIZE)

`endif