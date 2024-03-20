`ifndef FIR_SVH
`define FIR_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:22]  RESERVED;
    logic [5:0]    OUT_DIV;          // WR делитель после фильтра
    logic [4:0]    WIDTH_COEF_CONST; // разрядность коэффициентов
    logic [10:0]   ORDER;            // порядок фильтра
} FIR_CFG_STRUCT;

typedef struct packed {
    logic         WR;
    logic [10:0]  ADDR;
    logic [19:0]  COEF;
} COEF_STRUCT;

typedef struct packed {
    FIR_CFG_STRUCT  CFG;
    COEF_STRUCT     COEF;
} FIR_STRUCT;

`define FIR_ID_CONST  (16'hF5A0)
`define FIR_SIZE      (`size32(FIR_STRUCT))
`define FIR_FULL_SIZE (`FIR_SIZE + \
                       `RWREGSSIZE)

`endif