`ifndef DATA_COLLECTOR_SVH
`define DATA_COLLECTOR_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:10] RESERVED;
    logic [ 9:2 ] INP; // номер источника данных, 8 бит - до 256 каналов
    logic [ 1:1 ] TRIG_EN_PULSE;
    logic [ 0:0 ] RESERVED1;
} DATA_COLLECTOR_CFG;

typedef struct packed {
    logic [31:0] DATA_COLL_NUM;
    logic [31:0] DATA_COLL_NUM_PORTS;
    logic [31:0] DATA_COLL_WIDTH;
    logic [31:0] DATA_COLL_DEPTH;
    logic [31:0] DATA_COLL_SOFT_RESETN;
    logic [31:0] DATA_COLL_BUS_CHAN;
    logic [31:0] DATA_COLL_TRIG_EN;
    logic [31:0] DATA_COLL_WR_PERM;
    logic [31:0] DATA_COLL_WR_DEPTH;
    logic [31:0] DATA_COLL_RW_REG;
    logic [31:0] DATA_COLL_RAM;
    logic [31:0] DATA_COLL_WE_DIS;
} DATA_COLLECTOR;

`define DATA_COLLECTOR_ID_CONST  (16'hB0BA)
`define DATA_COLLECTOR_SIZE      (`size32(DATA_COLLECTOR))
`define DATA_COLLECTOR_FULL_SIZE (`DATA_COLLECTOR_SIZE + \
                                  `RWREGSSIZE)

`endif