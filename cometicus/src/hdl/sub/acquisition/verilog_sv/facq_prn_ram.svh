`ifndef FACQ_PRN_RAM_SVH
`define FACQ_PRN_RAM_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:31]         PRN_RAM_EN;
    logic [30:30]         REVERSE; // УДАЛИТЬ! 04,04,2022!
    logic [29:14]         RESERVED;
    logic [13:0]          RAM_LENGTH; // длина ПСП считая с нуля (1022 для длины ПСП 1023чипа)
} FACQ_PRN_RAM_CFG;

typedef struct packed {
    FACQ_PRN_RAM_CFG  CFG;
    logic [31:0]      DATA;
} FACQ_PRN_RAM_STRUCT;

`define FACQ_PRN_RAM_ID_CONST  (16'hCE4E)
`define FACQ_PRN_RAM_SIZE      (`size32(FACQ_PRN_RAM_STRUCT))
`define FACQ_PRN_RAM_FULL_SIZE (`FACQ_PRN_RAM_SIZE + \
                                `RWREGSSIZE)

`endif
