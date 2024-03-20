`ifndef AXI3_TO_INTER_TB_STRUCT_SVH
`define AXI3_TO_INTER_TB_STRUCT_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:0]        R0;
    logic [31:0]        R1;
    logic [31:0]        R2;
    logic [31:0]        R3;
    logic [31:0]        R4;
    logic [31:0]        R5;
    logic [31:0]        R6;
    logic [31:0]        R7;
} REGFILE;

`define REGFILE_ID_CONST  (16'h17)
`define REGFILE_SIZE      (`size32(REGFILE))
`define REGFILE_FULL_SIZE (`REGFILE_SIZE + \
                           `RWREGSSIZE)

`endif