`ifndef CALIBR_SVH
`define CALIBR_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:5]  RESERVED;
    logic [4:0]   INPUT;
} CALIBR_CONFIG;

typedef struct packed {
    CALIBR_CONFIG   CFG;
    logic [31:0]    PHASE_RATE;
    logic [31:0]    PHASE;
    logic [31:0]    CYCLE;
    logic [31:0]    I;
    logic [31:0]    Q;
} CALIBR;

`define CALIBR_ID_CONST  (16'h474B)
`define CALIBR_SIZE      (`size32(CALIBR))
`define CALIBR_FULL_SIZE (`CALIBR_SIZE + \
                          `RWREGSSIZE)
`endif
