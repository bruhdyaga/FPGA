`ifndef ACQ_IP_SVH
`define ACQ_IP_SVH

`include "macro.svh"
`include "prestore.svh"
`include "bram_controller.svh"
`include "max_args.svh"
`include "fsm_controller.svh"
`include "facq_prn_ram.svh"
`include "data_collector.svh"

typedef struct packed {
    logic [31:10] RESERVED;
    logic [ 9:5 ] IM_INP;
    logic [ 4:0 ] RE_INP;
} ACQ_IP_CFG;

typedef struct packed {
    ACQ_IP_CFG           CFG;
} ACQ_IP_STRUCT;

`define ACQ_IP_ID_CONST  (16'h18F8)
`define ACQ_IP_SIZE (`size32(ACQ_IP_STRUCT))
`define ACQ_IP_FULL_SIZE (  `HUBSIZE + \
                            `ACQ_IP_SIZE + \
                            `RWREGSSIZE + \
                            `PRESTORE_FULL_SIZE + \
                            `BRAM_CONTROLLER_FULL_SIZE + \
                            `FACQ_PRN_RAM_FULL_SIZE + \
                            `MAX_ARGS_FULL_SIZE + \
                            `FSM_CONTROLLER_FULL_SIZE + \
                            `DATA_COLLECTOR_FULL_SIZE \
                            `ifdef FACQ_DATCOLL + `DATA_COLLECTOR_FULL_SIZE `endif)

`endif