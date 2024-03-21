`ifndef TIME_SCALE_CH_SVH
`define TIME_SCALE_CH_SVH

`include "macro.svh"

localparam PHASESIZE   = 32;
localparam CHIPSIZE_CH = 14; // для каналов
localparam CHIPSIZE    = 18; // для time_common
localparam EPOCHSIZE   = 10;
localparam SECSIZE     = 20;

typedef struct packed {
    logic [31:CHIPSIZE/* +4 */+EPOCHSIZE] RESERVED; // Current second
    logic [EPOCHSIZE-1:0]           EPOCH;    // Current epoch
    // logic [3:0]                     CHIP_RESERVED;
    logic [CHIPSIZE-1:0]            CHIP;     // Chip number
} CHIP_EPOCH_WORD;

typedef struct packed {
    logic [31:CHIPSIZE/* +4 */+EPOCHSIZE] CHIP_MAX_RESERVED;
    logic [EPOCHSIZE-1:0]           EPOCH_MAX;          // Epochs in second
    // logic [3:0]                     CHIP_RESERVED;
    logic [CHIPSIZE-1:0]            CHIP_MAX;           // Epoch length
} CHIP_EPOCH_MAX_WORD;

typedef struct packed {
    logic [SECSIZE-1:0]   SEC;      // Current second
    logic [EPOCHSIZE-1:0] EPOCH;    // Current epoch
    // logic [3:0]           CHIP_RESERVED;
    logic [CHIPSIZE-1:0]  CHIP;     // Chip number
} TIME_WORD;

typedef struct packed {
    logic [PHASESIZE-1:0]  PHASE;          // 0x04
    CHIP_EPOCH_WORD        CHIP_EPOCH;     // 0x08
    logic [31:SECSIZE]     RESERVED_SEC;   // 0x0c
    logic [SECSIZE-1:0]    SEC;
    CHIP_EPOCH_MAX_WORD    CHIP_EPOCH_MAX; // 0x10
    logic [PHASESIZE-1:0]  CODE_RATE;      // 0x14
} TIME_SCALE_CH_STRUCT;
// изменение количества регистров сместит pulse в TIME_COM!

`define TIME_SCALE_CH_ID_CONST  (16'h74)     // Time regs ID
`define TIME_SCALE_CH_SIZE      (`size32(TIME_SCALE_CH_STRUCT))
`define TIME_SCALE_CH_FULL_SIZE (`TIME_SCALE_CH_SIZE + `RWREGSSIZE)
`define SEC_IN_WEEK       (604800)

`endif
