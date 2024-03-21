`ifndef AXI_TRIG_SVH
`define AXI_TRIG_SVH

`include "macro.svh"

//---

typedef struct packed {
    logic [31:1 ] RESERVED;
    logic [ 0:0 ] RESET;
} AXI_TRIG_CFG;

typedef struct packed {
    AXI_TRIG_CFG  CFG;
    logic [31:0]  BASEADDR;
    logic [31:0]  TIMEOUT;
} AXI_TRIG_STRUCT;

`define AXI_TRIG_ID_CONST  (16'hD090)
`define AXI_TRIG_SIZE      (`size32(AXI_TRIG_STRUCT))
`define AXI_TRIG_FULL_SIZE (`AXI_TRIG_SIZE + \
                            `RWREGSSIZE)

`endif