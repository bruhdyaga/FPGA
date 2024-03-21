`ifndef SIGMAG_TEST_SVH
`define SIGMAG_TEST_SVH

`include "macro.svh"

localparam CNTR_LENGTH = 10; // <= 15

typedef struct packed {
    logic [31:12] RESERVED;
    logic [11:7 ] LENGTH;
    logic [ 6:2 ] HIST_INP;
    logic [ 1:1 ] RESETP;
    logic [ 0:0 ] DONE;
} SIGMAG_TEST_CFG;

typedef struct packed {
    logic [31:2*CNTR_LENGTH]            RESERVED;
    logic [2*CNTR_LENGTH-1:CNTR_LENGTH] SIG;
    logic [CNTR_LENGTH-1:0 ]            MAG;
} SIGMAG_TEST_RESULT;

typedef struct packed {
    SIGMAG_TEST_CFG      CFG;
    SIGMAG_TEST_RESULT   RESULT;
} SIGMAG_TEST;

`define SIGMAG_TEST_ID_CONST  (16'hE004)
`define SIGMAG_TEST_SIZE      (`size32(SIGMAG_TEST))
`define SIGMAG_TEST_FULL_SIZE ( `SIGMAG_TEST_SIZE + \
                                `RWREGSSIZE)

`endif