`ifndef CRPA_SVH
`define CRPA_SVH

`include "macro.svh"
`include "cov_matrix.svh"
`include "null_former.svh"
`include "cov_ram.svh"
`include "heterodyne.svh"
`include "data_collector.svh"
`include "adc_interconnect.svh"

typedef struct packed {
    logic [0:0] NULL_COEF_MIRR;
    logic [0:0] HETERODYNE_ENABLE;
    logic [4:0] CRPA_D_WIDTH;
    logic [4:0] CRPA_C_WIDTH;
    logic [4:0] CRPA_NCH;
    logic [3:0] CRPA_NT;
    logic [4:0] CRPA_NNF;
    logic [5:0] CRPA_ACCUM_WIDTH;
} CRPA_CFG;

typedef struct packed {
    logic         NULL_DIV_WR;
    logic [4:0]   NULL_DIV_ADDR;
    logic [25:11] RESERVED;
    logic [2:0]   CRPA_NUMB;
    logic [7:0]   NULL_DIV;
} CRPA_CFG2;

typedef struct packed {
    CRPA_CFG     CFG;
    CRPA_CFG2    CFG2;
} CRPA_STRUCT;

`define CRPA_ID_CONST  (16'hCCDE)
`define CRPA_SIZE      (`size32(CRPA_STRUCT))
`define CRPA_FULL_SIZE  (`HUBSIZE + \
                         `CRPA_SIZE + \
                         `RWREGSSIZE + \
                         `COV_MATRIX_FULL_SIZE + \
                         `CRPA_NNF*`NULL_FORMER_FULL_SIZE)

`endif