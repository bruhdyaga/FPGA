`ifndef HETERODYNE_SVH
`define HETERODYNE_SVH

`include "global_param.v"
`include "macro.svh"
`include "data_recorder.svh"
`include "fir.svh"

typedef struct packed {
    logic [31:9] RESERVED;
    logic [0:0]  RECORDER_EN;
    logic [3:0]  PHASE_WIDTH;
    logic [3:0]  IQ_WIDTH;
} HETERODYNE_CFG_STRUCT;

typedef struct packed {
    HETERODYNE_CFG_STRUCT  CFG;
    logic [31:0]           CODE;
} HETERODYNE_STRUCT;

`define HETERODYNE_ID_CONST  (16'hA7DD)
`define HETERODYNE_SIZE      ( `size32(HETERODYNE_STRUCT))
`define HETERODYNE_FULL_SIZE ( `HUBSIZE + \
                               `RWREGSSIZE + \
                               `FIR_FULL_SIZE + \
                               `FIR_FULL_SIZE + \
                               `ifdef HETERODYNE_DATCOLL  `DATA_COLLECTOR_FULL_SIZE + `endif \
                               `ifdef HETERODYNE_RECORDER `DATA_RECORDER_FULL_SIZE + `endif \
                               `HETERODYNE_SIZE)

`endif