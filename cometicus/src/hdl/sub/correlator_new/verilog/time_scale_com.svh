`ifndef TIME_SCALE_COM_SVH
`define TIME_SCALE_COM_SVH

`include "macro.svh"
`include "time_scale_ch.svh"

typedef struct packed {
    CHIP_EPOCH_WORD        CHIP_EPOCH;
    logic                  TRIG;
    logic [30:SECSIZE]     RESERVED_SEC;
    logic [SECSIZE-1:0]    SEC;
} TIME_TRIG_WORD;

typedef struct packed {
    logic [31:30]      RESERVED;
    logic [29:27]      LEN;
    logic [26:0]       DLY;
} PPS_CFG_WORD;

typedef struct packed {
    TIME_SCALE_CH_STRUCT          TM_CH;
    TIME_TRIG_WORD                TM_TRIG_FACQ;
    TIME_TRIG_WORD                TM_TRIG_PPS;
    PPS_CFG_WORD                  PPS_CFG;
} TIME_SCALE_COM_STRUCT;

 `define TIME_SCALE_COM_ID_CONST  (16'hE9D2)     // Time regs ID
 `define TIME_SCALE_COM_SIZE      (`size32(TIME_SCALE_COM_STRUCT))
 `define TIME_SCALE_COM_FULL_SIZE (`TIME_SCALE_COM_SIZE + `RWREGSSIZE)

`endif
