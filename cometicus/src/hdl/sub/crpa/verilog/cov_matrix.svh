`ifndef COV_MATRIX_SVH
`define COV_MATRIX_SVH

`include "global_param.v"
`include "macro.svh"

typedef struct packed {
    logic [31:28] RESERVED;
    logic [ 0:0]  CONST_EN;
    logic [ 3:0]  T_B;
    logic [ 3:0]  T_A;
    logic [16:0]  WLENGTH;
    logic [ 0:0]  COMPLETE;
    logic [ 0:0]  START;
} COV_MATRIX_CFG;

typedef struct packed {
logic [7:0][3:0] I;
logic [7:0][3:0] Q;
} COV_MATRIX_CONST;

typedef struct packed {
    COV_MATRIX_CFG                             CFG;
    logic [0:`CRPA_NCH-1][0:`CRPA_NCH-1][63:0] DATA;
    COV_MATRIX_CONST                           CONST;
} COV_MATRIX_STRUCT;

`define COV_MATRIX_ID_CONST  (16'hF877)
`define COV_MATRIX_SIZE      (`size32(COV_MATRIX_STRUCT))
`define COV_MATRIX_FULL_SIZE (`HUBSIZE + \
                              `COV_MATRIX_SIZE + \
                              `RWREGSSIZE + \
                              `COV_RAM_FULL_SIZE)

`endif