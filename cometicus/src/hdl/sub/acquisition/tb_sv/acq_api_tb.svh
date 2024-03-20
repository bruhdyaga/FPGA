`ifndef ACQ_IP_TB_STRUCT_SVH
 `define ACQ_IP_TB_STRUCT_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:1]  RESERVED;
    logic [0:0]   RECORD_START;
} ACQ_IP_TB_CONTROL;

typedef struct packed {
    logic [31:0]           N_RECORD;
    ACQ_IP_TB_CONTROL      CONTROL;
} ACQ_IP_TB_STRUCT;

`define ACQ_IP_TB_ID_CONST  (16'h1234)
`define ACQ_IP_TB_SIZE      (`size32(ACQ_IP_TB_STRUCT))
`define ACQ_IP_TB_FULL_SIZE (   `ACQ_IP_TB_SIZE + \
                                `RWREGSSIZE)

`endif