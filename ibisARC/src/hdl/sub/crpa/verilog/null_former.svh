`ifndef NULL_FORMER_SVH
`define NULL_FORMER_SVH

`include "global_param.v"
`include "macro.svh"

localparam FIR_FULL_SIZE = 3; // !!! тут важно не обоср*ться

// typedef struct packed {
    // logic [31:31]             COEF_WR;
    // logic [30:`CRPA_C_WIDTH]  RESERVED;
    // logic [`CRPA_C_WIDTH-1:0] DATA;
// } NULL_FORMER_COEFF_STRUCT;

// typedef struct packed {
    // NULL_FORMER_COEFF_STRUCT [0:`CRPA_NCH-1][0:`CRPA_NT-1] COEFF;
// } NULL_FORMER_STRUCT;

// `define NULL_FORMER_ID_CONST  (16'h7C41)
// `define NULL_FORMER_SIZE      (`size32(NULL_FORMER_STRUCT))
`define NULL_FORMER_FULL_SIZE (`HUBSIZE + \
                               `CRPA_NCH * FIR_FULL_SIZE)

`endif