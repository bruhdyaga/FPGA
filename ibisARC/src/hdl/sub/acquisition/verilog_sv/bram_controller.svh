`ifndef BRAM_CONTROLLER_SVH
`define BRAM_CONTROLLER_SVH

`include "macro.svh"
`include "time_scale_com.svh"

typedef struct packed {
    logic WE_RAM;
    logic WR_ALLOW;
    logic WR_END_ADDR;
    logic TIMEGEN_WR;
    logic TIME_WR_ALLOW;
    logic ACQ_SYNC;
    logic WE_SUM;
    logic RD_DONE;
    logic RD_ALLOW;
    logic RE_RAM;
} BRAM_CONTROLLER_DEBUG_STRUCT;

typedef struct packed {                         // offset 0x04
    logic [31:28]                 DATA; // 4-bit
    logic [27:27]                 FIFO_RD_EN;
    logic [26:26]                 FIFO_WR_EN;
    logic [25:25]                 FIFO_WR;
    logic [24:23]                 RESERVED;
    BRAM_CONTROLLER_DEBUG_STRUCT  DEBUG;
    logic [ 9:0 ]                 ACQ_SYNC_EPOCH;
    logic [ 0:0 ]                 ACQ_SYNC_EN;
    logic [ 0:0 ]                 WR_DONE;
    logic [ 0:0 ]                 WR_START;
} BRAM_CONTROLLER_CONTROL_STRUCT;

typedef struct packed {
    BRAM_CONTROLLER_CONTROL_STRUCT  CONTROL;
    logic [31:0]                    WR_DEPTH;  // offset 0x08 // порядковое число (32 - запись 32-х отсчетов)
    logic [31:0]                    RAM_DEPTH; // offset 0x0c
    logic [31:0]                    WR_CNTR;   // offset 0x10
} BRAM_CONTROLLER_STRUCT;

`define BRAM_CONTROLLER_ID_CONST  (16'h655C)   // offset 0x0
`define BRAM_CONTROLLER_SIZE      (`size32(BRAM_CONTROLLER_STRUCT))
`define BRAM_CONTROLLER_FULL_SIZE (`BRAM_CONTROLLER_SIZE + \
                                   `RWREGSSIZE)

`endif