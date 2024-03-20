`ifndef DMA_SVH
`define DMA_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:31]  START;
    logic [30:30]  RESET;
    logic [29:29]  IRQ_EN;
    logic [28:16]  RESERVED;
    logic [15:0]   RD_SIZE;  // 0 == one transaction
} DMA_CFG_STRUCT;

typedef struct packed {
    DMA_CFG_STRUCT   CFG;
    logic [31:0]     ADDR_RD; // rd start addr 1-Byte
    logic [31:0]     ADDR_WR; // wr start addr 1-Byte
    logic [31:0]     TIMER;   // debug timer
} DMA_STRUCT;

`define DMA_ID_CONST         (16'hBD1)
`define DMA_STRUCT_SIZE      (`size32(DMA_STRUCT))
`define DMA_STRUCT_FULL_SIZE (`DMA_STRUCT_SIZE + `RWREGSSIZE)

`endif
