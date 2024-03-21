`ifndef FSM_CONTROLLER_SVH
 `define FSM_CONTROLLER_SVH

`include "macro.svh"
`include "facq_prn_gen.svh"

typedef struct packed {
    logic [31:31] RESET_FSM;
    logic [30:8]  RESERVED;
    logic [7:7]   RESERVED_FOR_STATE;
    logic [6:4]   STATE;
    logic [3:3]   ACQ_GLOBAL_RESETN;
    logic [2:2]   ACQ_DONE;
    logic [1:1]   ACQ_START;
    logic [0:0]   DO_INIT;
} FSM_CONTROLLER_CONTROL;

typedef struct packed {
    logic [31:30]    RESERVED;
    logic [9:0][2:0] STATE;
} FSM_TARGET_STRUCT;

typedef struct packed {
    logic [31:10] RESERVED;                                // offset 0x20
    logic [ 9: 9] SINGLE_SR;
    logic [ 8: 8] GPS_L5_RESET_EN;
    logic [ 7: 0] FREQ_DIV;
    
    logic [31:FACQ_PRNSIZE]    CODE_STATE1_RESERVED;       // offset 0x24
    logic [FACQ_PRNSIZE-1:0]   CODE_STATE1;
    logic [31:FACQ_PRNSIZE]    CODE_RESET_STATE1_RESERVED; // offset 0x28
    logic [FACQ_PRNSIZE-1:0]   CODE_RESET_STATE1;
    logic [31:FACQ_PRNSIZE]    CODE_BITMASK1_RESERVED;     // offset 0x2c
    logic [FACQ_PRNSIZE-1:0]   CODE_BITMASK1;
    logic [31:FACQ_PRNSIZE]    CODE_OUT_BITMASK1_RESERVED; // offset 0x30
    logic [FACQ_PRNSIZE-1:0]   CODE_OUT_BITMASK1;
    logic [31:FACQ_PRNSIZE]    CODE_STATE2_RESERVED;       // offset 0x34
    logic [FACQ_PRNSIZE-1:0]   CODE_STATE2;
    logic [31:FACQ_PRNSIZE]    CODE_RESET_STATE2_RESERVED; // offset 0x38
    logic [FACQ_PRNSIZE-1:0]   CODE_RESET_STATE2;
    logic [31:FACQ_PRNSIZE]    CODE_BITMASK2_RESERVED;     // offset 0x3c
    logic [FACQ_PRNSIZE-1:0]   CODE_BITMASK2;
    logic [31:FACQ_PRNSIZE]    CODE_OUT_BITMASK2_RESERVED; // offset 0x40
    logic [FACQ_PRNSIZE-1:0]   CODE_OUT_BITMASK2;
    logic [31:FACQ_CNTRSIZE]   PRN_LENGTH_RESERVED;        // offset 0x44
    logic [FACQ_CNTRSIZE-1:0]  PRN_LENGTH;
    logic [31:FACQ_CNTRSIZE]   PRN_INIT_RESERVED;          // offset 0x48
    logic [FACQ_CNTRSIZE-1:0]  PRN_INIT;
    logic [31:25]              OVL_RESERVED;               // offset 0x4c
    logic [4:0]                OVL_LENGTH;
    logic [19:0]               OVL;
} FSM_PSP_REGS;

typedef struct packed {
    logic [31:16]          RESERVED_CORE_SIZE; // offset 0x04
    logic [15:0]           CORE_SIZE;
    logic [31:16]          KG;         // offset 0x08
    logic [15:0]           NKG;
    logic [31:16]          N_TAU_ZONE;// число зон поиска по задержке в размере ядра      // offset 0x0c
    logic [15:0]           N_F;// число канало поиска по частоте
    FSM_CONTROLLER_CONTROL CONTROL;    // offset 0x10
    logic [31:0]           BRAM_RD_DEPTH;// порядковое число (32 - чтение 32-х отсчетов)  // offset 0x14
    logic [31:0]           FREQ_SHIFT_CODE_INIT;// код начального смещения частоты        // offset 0x18
    logic [31:0]           FREQ_SHIFT_CODE_STEP;// код шага смещения частоты              // offset 0x1c
    FSM_PSP_REGS           PSP;
    logic [31:16]          KG_CNTR;   // offset 0x50
    logic [15:0]           NKG_CNTR;
    logic [31:16]          NF_CNTR;   // offset 0x54
    logic [15:0]           NTAU_CNTR;
    FSM_TARGET_STRUCT      TARGET;    // offset 0x58
    logic [31:1]           RESERVED;  // offset 0x5c
    logic [0:0]            TIME_SEPARATION;
} FSM_CONTROLLER_STRUCT;

`define FSM_CONTROLLER_ID_CONST  (16'hF646)
`define FSM_CONTROLLER_SIZE      ( `size32(FSM_CONTROLLER_STRUCT))
`define FSM_CONTROLLER_FULL_SIZE ( `FSM_CONTROLLER_SIZE + \
                                   `RWREGSSIZE)

`endif