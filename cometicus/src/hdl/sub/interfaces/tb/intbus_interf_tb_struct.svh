// `include "macro.svh"

typedef struct packed {
    logic [31:16]       ID;
    logic [15:0]        INST;
} ID_INST;

typedef struct packed {
    ID_INST             ID_INST;
    logic [31:0]        RW;
} REGFILE;

`define REGFILE_ID_CONST  (16'h17)
// `define IRQ_CTRL_SIZE (`size32(IRQ_CTRL))
