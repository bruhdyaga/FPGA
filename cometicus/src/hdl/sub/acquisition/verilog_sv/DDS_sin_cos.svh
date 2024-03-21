`ifndef DDS_SIN_COS_SVH
 `define DDS_SIN_COS_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:0] CODE;
} DDS_SIN_COS_STRUCT;

`define DDS_SIN_COS_ID_CONST  (16'h6237)
`define DDS_SIN_COS_SIZE      ( `size32(DDS_SIN_COS_STRUCT))
`define DDS_SIN_COS_FULL_SIZE ( `DDS_SIN_COS_SIZE + \
                                `RWREGSSIZE)

`endif