`ifndef TRCV_SVH
`define TRCV_SVH

`include "global_param.v"
`include "macro.svh"
`include "irq_ctrl.svh"
`include "time_scale_com.svh"
`include "corr_ch.svh"
`include "ref_in_interpretator.svh"
`include "acq_ip.svh"
`include "calibration.svh"
`include "imitator.svh"
`include "vitdec.svh"

typedef struct packed {
    logic [7:0]  DLY_LEN;
    logic [6:0]  DELAYS;
    logic [3:0]  N_INP;
    logic [11:0] CORR_CH;
    logic        LOCK;
} TRCV_CFG1;

typedef struct packed {
    logic [31:0] R0;
    logic [31:0] R1;
} REV_STRUCT;

typedef struct packed {
    TRCV_CFG1    CFG1;
    REV_STRUCT   REV;
} TRCV_STRUCT;

`define TRCV_ID_CONST  (16'hD627)
`define TRCV_SIZE      (`size32(TRCV_STRUCT))
`define TRCV_FULL_SIZE (`HUBSIZE + \
                        `RWREGSSIZE + \
                        `TRCV_SIZE + \
                        `IRQ_CTRL_FULL_SIZE + \
                        `TIME_SCALE_COM_FULL_SIZE + \
                        `CORR_CHANNELS * `CORR_CH_FULL_SIZE \
                        `ifdef FACQ        + `ACQ_IP_FULL_SIZE `endif \
                        `ifdef CALIBRATION + `REFINTERP_FULL_SIZE + `CALIBR_FULL_SIZE `endif \
                        `ifdef DATCOLL     + 13 `endif \
                        `ifdef IMITATOR    + `HUBSIZE + `RWREGSSIZE + `IMI_SIZE + `IMI_CHANNELS*`IMI_CHANNEL_FULL_SIZE + `LIM_CNTR_FULL_SIZE + `NORMALIZER_FULL_SIZE `endif \
                        `ifdef VITDEC      + `VITDEC_FULL_SIZE `endif)

`endif