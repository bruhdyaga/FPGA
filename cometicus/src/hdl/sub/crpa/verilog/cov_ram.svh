`ifndef COV_RAM_SVH
`define COV_RAM_SVH

`include "global_param.v"
`include "macro.svh"

typedef struct packed {
    logic [12:0]  W_BLOCKS; // количество блоков с 0 (0 - значит записать 1 блок)
    logic [12:0]  RAM_BLOCKS;
    logic [3:0]   RAM_SIZE;
    logic [0:0]   COMPLETE_WR;
    logic [0:0]   START_WR;
} COV_RAM_CFG;

typedef struct packed {
    logic [31:6]  RESERVED;
    logic [0:0]   BLOCK_RD_ADDR;
    logic [4:0]   RAM_CH;
} COV_RAM_CFG2;

typedef struct packed {
    COV_RAM_CFG   CFG;
    COV_RAM_CFG2  CFG2;
    logic [31:0]  RAM;
} COV_RAM_STRUCT;

`define COV_RAM_ID_CONST  (16'h0924)
`define COV_RAM_SIZE      (`size32(COV_RAM_STRUCT))
`define COV_RAM_FULL_SIZE (`COV_RAM_SIZE + \
                           `RWREGSSIZE)

`endif