`ifndef PRN_RAM_SVH
`define PRN_RAM_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:23]         RESERVED;
    logic                 WR_DATA;
    logic [1:0]           TDMA_MODE;
    logic [1:0]           BOC_MODE;
    logic [13:0]          WR_ADDR;
    logic [3:0]           RAM_LENGTH;
} PRN_RAM_CFG;

typedef struct packed {
    PRN_RAM_CFG            CFG;
} PRN_RAM_STRUCT;

`define PRN_RAM_ID_CONST  (16'h826)
`define PRN_RAM_SIZE      (`size32(PRN_RAM_STRUCT))
`define PRN_RAM_FULL_SIZE (`PRN_RAM_SIZE + \
                           `RWREGSSIZE)

`endif
