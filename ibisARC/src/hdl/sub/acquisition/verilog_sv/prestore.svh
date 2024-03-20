`ifndef PRESTORE_SVH
`define PRESTORE_SVH

`include "macro.svh"
`include "DDS_sin_cos.svh"
`include "DDS_bin.svh"

localparam N_dig_sum_I_Q = 14;// полученная разрядность накопленной величины до квантования надо выбирать с умом!
// чем больше накапливается отсчетов на интервале преднакопления - тем больше необходимо ставить.

typedef struct packed {
    logic [31:1] RESERVED;
    logic [0:0]  RESET_SIGMAG;
} PRESTORE_CONF;

typedef struct packed {
    PRESTORE_CONF        CONF;
} PRESTORE_STRUCT;

`define PRESTORE_ID_CONST  (16'hAB2C)
`define PRESTORE_SIZE      (`size32(PRESTORE_STRUCT))
`define PRESTORE_FULL_SIZE (`HUBSIZE + \
                            `PRESTORE_SIZE + \
                            `RWREGSSIZE + \
                            `DDS_SIN_COS_FULL_SIZE + \
                            `DDS_BIN_FULL_SIZE)

`endif