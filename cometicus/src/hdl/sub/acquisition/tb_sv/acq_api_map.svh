`ifndef ACQ_IP_MAP_SVH
`define ACQ_IP_MAP_SVH

typedef struct {
    int  BASE;
    // int  INST_ID;
    // int  SIZE;
} ACQ_IP_REGS_MAP;

typedef struct {
    int  BASE;
    // int  REGS;
    // int  DDS_SIN_COS;
    // int  DDS_BIN;
} PRESTORE_MAP;

typedef struct {
    int  BASE;
} BRAM_CONTROLLER_MAP;

typedef struct {
    int  BASE;
} FREQ_SHIFT_MAP;

typedef struct {
    int  BASE;
} PSP_GEN_MAP;

typedef struct {
    int  BASE;
} MAX_ARGS_MAP;

typedef struct {
    int  BASE;
} FSM_CONTROLLER_MAP;

typedef struct {
    ACQ_IP_REGS_MAP      ACQ_IP_REGS;
    PRESTORE_MAP         PRESTORE;
    BRAM_CONTROLLER_MAP  BRAM_CONTROLLER;
    FREQ_SHIFT_MAP       FREQ_SHIFT;
    PSP_GEN_MAP          PSP_GEN;
    MAX_ARGS_MAP         MAX_ARGS;
    FSM_CONTROLLER_MAP   FSM_CONTROLLER;
} ACQ_IP_MAP;

`endif