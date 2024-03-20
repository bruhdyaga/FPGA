`ifndef DATA_RECORDER_SVH
`define DATA_RECORDER_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:10] RESERVED;
    logic [ 9:2 ] INP; // номер источника данных, 8 бит - до 256 каналов
    logic [ 1:1 ] TRIG_EN_PULSE;
    logic [ 0:0 ] RESERVED1;
} DATA_RECORDER_CFG;

typedef struct packed {
    logic [31:0] DATA_RECORDER_NUM;
    logic [31:0] DATA_RECORDER_NUM_PORTS;
    logic [31:0] DATA_RECORDER_WIDTH;
    logic [31:0] DATA_RECORDER_DEPTH;
    logic [31:0] DATA_RECORDER_SOFT_RESETN;
    logic [31:0] DATA_RECORDER_BUS_CHAN;
    logic [31:0] DATA_RECORDER_TRIG_EN;
    logic [31:0] DATA_RECORDER_WR_PERM;
    logic [31:0] DATA_RECORDER_RD_DEPTH;
    logic [31:0] DATA_RECORDER_RW_REG;
    logic [31:0] DATA_RECORDER_RAM;
    logic [31:0] DATA_RECORDER_WE_DIS;
} DATA_RECORDER_STRUCT;

`define DATA_RECORDER_ID_CONST  (16'hB0BE)
`define DATA_RECORDER_SIZE      (`size32(DATA_RECORDER_STRUCT))
`define DATA_RECORDER_FULL_SIZE (`DATA_RECORDER_SIZE + \
                                 `RWREGSSIZE)

`endif