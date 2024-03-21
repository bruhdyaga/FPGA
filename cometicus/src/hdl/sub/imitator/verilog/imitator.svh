`ifndef IMI_SVH
`define IMI_SVH

`include "macro.svh"
`include "imitator_channel.svh"
`include "lim_cntr.svh"
`include "normalizer.svh"

typedef struct packed {
    logic [31:4+4+5] RESERVED;
    logic [4:0]      OUT_SHIFT;
    logic [3:0]      ADIV_WIDTH;
    logic [3:0]      AMULT_WIDTH;
} IMI_CFG_WORD;

typedef struct packed {
    IMI_CFG_WORD      CFG;
} IMI_STRUCT;

 `define IMI_ID_CONST  (16'hD95F)
 `define IMI_SIZE      (`size32(IMI_STRUCT))
`endif
