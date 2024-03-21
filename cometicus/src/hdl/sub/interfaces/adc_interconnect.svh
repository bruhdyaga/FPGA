`ifndef ADC_INTERCONNECT_SVH
`define ADC_INTERCONNECT_SVH

`include "macro.svh"

typedef struct packed {
    logic [7:0]  OUT_SIZE;
    logic [7:0]  IN_SIZE;
    logic [7:0]  ADDR;
    logic [7:0]  MUX;
} ADC_INTERCONNECT_CFG;

typedef struct packed {
    ADC_INTERCONNECT_CFG    CFG;
} ADC_INTERCONNECT_STRUCT;

`define ADC_INTERCONNECT_ID_CONST  (16'hBE3D)
`define ADC_INTERCONNECT_SIZE      (`size32(ADC_INTERCONNECT_STRUCT))
`define ADC_INTERCONNECT_FULL_SIZE (`ADC_INTERCONNECT_SIZE + \
                                    `RWREGSSIZE)

`endif