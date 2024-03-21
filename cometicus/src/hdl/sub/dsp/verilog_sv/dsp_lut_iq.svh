`ifndef DSP_LUT_IQ_SVH
`define DSP_LUT_IQ_SVH

`include "macro.svh"

// read only
typedef struct packed {
    logic [31:10] RESERVED;
    logic [4:0]   OUT_WIDTH;
    logic [4:0]   IN_WIDTH;
} DSP_LUT_IQ_RO_STRUCT;

// write only
typedef struct packed {
    logic        WR;
    logic        CLR;
    logic        EN;
    logic [28:0] DATA;
} DSP_LUT_IQ_WO_STRUCT;

`define DSP_LUT_IQ_ID_CONST  (16'hB1DF)
`define DSP_LUT_IQ_SIZE      (`size32(DSP_LUT_IQ_WO_STRUCT))
`define DSP_LUT_IQ_FULL_SIZE (`DSP_LUT_IQ_SIZE + \
                              `RWREGSSIZE)

`endif