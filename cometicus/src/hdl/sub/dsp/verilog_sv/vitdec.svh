`ifndef VITDEC_SVH
`define VITDEC_SVH

`include "global_param.v"
`include "macro.svh"

localparam VIT_BUF_SIZE  = 32; // число регистров под кодированные данные (количество в штуках, должно быть четное!)
localparam VIT_DEC_SIZE  = VIT_BUF_SIZE/2; // число регистров под ДЕкодированные данные

typedef struct packed {
    logic [31:18] RESERVED;
    logic [3:0]   BIT2_USE; // сколько младших пар бит использовать в старшем регистре входного буфера (записывать -1)
    logic [1:0]   MODE;     // режим декодера 0 - (171,133)-GPS; 1 - (133,171)-GLN; 2 - (171,~133)-GAL
    logic [4:0]   DAT_BUF;  // объем входного буфера - 1
    logic [4:0]   DAT_REGS; // сколько регистров данных декодировать
    logic         DONE;
    logic         START;
} VITDEC_CFG;

typedef struct packed {
    VITDEC_CFG    CFG;
    logic [0:VIT_BUF_SIZE-1][15:0][1:0]  ENC_DATA;
    logic [0:VIT_DEC_SIZE-1][31:0]       DEC_DATA;
} VITDEC_STRUCT;

`define VITDEC_ID_CONST  (16'hEA6C)
`define VITDEC_SIZE      (`size32(VITDEC_STRUCT))
`define VITDEC_FULL_SIZE (`RWREGSSIZE + \
                          `VITDEC_SIZE)

`endif