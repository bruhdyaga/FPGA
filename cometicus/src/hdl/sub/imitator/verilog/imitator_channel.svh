`ifndef IMI_CHANNEL_SVH
`define IMI_CHANNEL_SVH

`include "macro.svh"
`include "corr_ch.svh"

localparam IMI_SYMB_PER_PACK       = 100;
localparam IMI_SYMB_PER_PACK_WIDTH = $clog2(IMI_SYMB_PER_PACK);
localparam EPCH_PER_SYMB_WIDTH     = 10;
localparam DDS_TABLE_NAME          = "dds_iq_hd_ph9_iq_10.txt";
localparam SIN_COS_WIDTH           = 10; // внутренняя разрядность DDS, пользователь о ней не знает
localparam PHASE_WIDTH             = 9;  // внутренняя разрядность DDS, пользователь о ней не знает
localparam AMULT_WIDTH             = 8;  // доступно для чтения
localparam ADIV_WIDTH              = 3;  // доступно для чтения
localparam IMI_CHNL_OUT_WIDTH      = SIN_COS_WIDTH + AMULT_WIDTH; // Разрядность квадратур каждого канала

typedef struct packed {
    logic [31:31]                        PN_MUX;
    logic [30:AMULT_WIDTH+ADIV_WIDTH+1]  RESERVED;
    logic                                CH_EN;
    logic [ADIV_WIDTH-1:0]               ADIVEXP;
    logic [AMULT_WIDTH-1:0]              AMULT;
} IMI_CH_CFG_WORD;

typedef struct packed {
    logic [127:IMI_SYMB_PER_PACK]  DATA_0_RESERVED;
    logic [IMI_SYMB_PER_PACK-1:0]  DATA_0;
    logic [127:IMI_SYMB_PER_PACK]  DATA_1_RESERVED;
    logic [IMI_SYMB_PER_PACK-1:0]  DATA_1;
} IMI_DATA_STRUCT;

typedef struct packed {
    IMI_CH_CFG_WORD        CFG;
    logic [31:0]           PHASE_RATE;
    logic [31:0]           CAR_PHASE;
    logic [31:0]           CAR_CYCLES;
    logic [31:EPOCHSIZE]   RESERVED_EPOCH_IRQ;
    logic [EPOCHSIZE-1:0]  EPOCH_IRQ;
    IMI_DATA_STRUCT        DATA;
} IMI_CHANNEL_STRUCT;

 `define IMI_CHANNEL_ID_CONST  (16'h6BF8)
 `define IMI_CHANNEL_SIZE      (`size32(IMI_CHANNEL_STRUCT))
 `define IMI_CHANNEL_FULL_SIZE (`HUBSIZE + \
                                `IMI_CHANNEL_SIZE + \
                                `RWREGSSIZE + \
                                `TIME_SCALE_CH_FULL_SIZE + \
                                `PRN_RAM_FULL_SIZE + \
                                `PRN_GEN_FULL_SIZE)
`endif
