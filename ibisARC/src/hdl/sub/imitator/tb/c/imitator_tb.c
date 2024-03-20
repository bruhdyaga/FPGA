#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define Fd 125e6
#define const_2_32 4294967296

#define IMI_OFF 1

#define IMI_CH_OFF (IMI_OFF + 2)
#define IMI_CH_TIME_OFF (IMI_CH_OFF + 1)


#define TM_PHASESIZE           32
#define TM_CHIPSIZE            18
#define TM_EPOCHSIZE           10
#define TM_SECSIZE             20
#define TM_TIME_PHASE          1
#define TM_TIME_CHIP_EPOCH     2
#define TM_TIME_SEC            3
#define TM_TIME_CHIP_EPOCH_MAX 4
#define TM_TIME_CODE_RATE      5


#define PRN_PRNSIZE           14
#define PRN_CNTRSIZE          23
#define PRN_BOC_REG_WIDTH     7
#define PRN_PSP_MUX_SIZE      6
#define PRN_TDMA_SIZE         2
#define PRN_BOC_SIZE          2

// #define PRN_STREAM_MASK       1
#define PRN_CODE_STATES       1
#define PRN_CODE_BITMASKS     2
#define PRN_CODE_OUT_BITMASKS 3
#define PRN_CNTR_LENGTH       4


#define OFF_PN_MUX   31
#define OFF_CH_EN    11
#define OFF_ADEVEXP  8
#define REGS_STREAM_MASK 1
#define REGS_CFG         1
#define REGS_PHASE_RATE  3
#define REGS_CAR_PHASE   4
#define REGS_CAR_CYCLES  5
#define REGS_DATA        6

/*
    // ЛАЙТ
    `define CORR_CHANNELS 1
    `define FACQ_FREQ_DIV 12
    `define FACQ_SIZE     256
    `define FACQ_MEM_SIZE (2*204600)

    // Imitator config:
    `define IMI_CHANNELS 1
    `define IMI_OUTWIDTH 12

    // `define FACQ
    // `define FACQ_DATCOLL
    // `define FACQ_DEBUG

    // `define CALIBRATION
    // `define DATCOLL
    `define IMITATOR
    // `define VITDEC
*/

int C_cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int rc;
    unsigned int i;
    
    printf("------------------------------\n");
    printf("------------------------------\n");
    printf("Hello from cpu_sim!\n");
    printf("imitator_tb\n");
       
    rc = axi_read(pBASE, 0, 0);
    printf("IMI_HUB = 0x%08X\n", rc);
    if((rc & 0xFFFF) != 0x46E4){
        printf("NON VALID ID IMI_HUB!\n");
        return -1;
    }
    rc = axi_read(pBASE, IMI_OFF, 0);
    printf("IMI = 0x%08X\n", rc);
    if((rc & 0xFFFF) != 0xD95F){
        printf("NON VALID ID IMI!\n");
        return -1;
    }
    rc = axi_read(pBASE, IMI_CH_OFF, 0);
    printf("IMI_CH_HUB = 0x%08X\n", rc);
    if((rc & 0xFFFF) != 0x46E4){
        printf("NON VALID ID IMI_CH_HUB!\n");
        return -1;
    }
    rc = axi_read(pBASE, IMI_CH_TIME_OFF, 0);
    printf("IMI_CH_TIME = 0x%08X\n", rc);
    if((rc & 0xFFFF) != 0x74){
        printf("NON VALID ID IMI_CH_TIME!\n");
        return -1;
    }

    //-----------------
    //time_ch for imi
    unsigned int time_size;
    unsigned int tm_code_rate;
    unsigned int code_length;
    unsigned int chip_rate;
    unsigned int chips_in_eph;
    unsigned int ephs_in_sec;
    unsigned int time_slots_en;
    unsigned int time_slot_active_num;
    
    // GPS L1 CA (L=1023 bit, T=1 ms, bitrate=1.023e6 bit/s)
    // code_length          = 1023;
    // chip_rate            = 1.023e6;
    // chips_in_eph         = 1;
    // ephs_in_sec          = 1000;
    // time_slots_en        = 0;
    // time_slot_active_num = n\a;
    
    // GPS L1 CA modified
    code_length          = 1023;
    chip_rate            = 1.023e6;
    chips_in_eph         = 4;
    time_slots_en        = 1;
    time_slot_active_num = 1;
    ephs_in_sec          = 3;
    
    //
    tm_code_rate = chip_rate/Fd*const_2_32;
    printf("tm_code_rate = %d\n",tm_code_rate);
    
    time_size = (axi_read(pBASE, IMI_CH_TIME_OFF, 0)) >> 16;
    printf("time_size = %d\n",time_size);
    
    axi_write(pBASE, IMI_CH_TIME_OFF + TM_TIME_CODE_RATE, tm_code_rate);
    axi_write(pBASE, IMI_CH_TIME_OFF + TM_TIME_CHIP_EPOCH_MAX, (chips_in_eph*code_length-1) | ephs_in_sec << TM_CHIPSIZE);
    
    //-----------------
    //prn_gen_ch for imi
    unsigned int IMI_CH_PRN_GEN_OFF;
    unsigned int prn_gen_size;
    IMI_CH_PRN_GEN_OFF = IMI_CH_TIME_OFF + time_size;
    rc = axi_read(pBASE, IMI_CH_PRN_GEN_OFF, 0);
    printf("size_ID IMI_CH_PRN_GEN = %08X\n",rc);
    prn_gen_size = rc >> 16;
    printf("prn_gen_size = %d\n",prn_gen_size);
    if((rc & 0xFFFF) != 0x37){
        printf("NON VALID IMI_CH_PRN_GEN!\n");
        return -1;
    }
    
    axi_write(pBASE, IMI_CH_PRN_GEN_OFF + PRN_CODE_STATES      , 0x3FF | 0x3FF << PRN_PRNSIZE);
    axi_write(pBASE, IMI_CH_PRN_GEN_OFF + PRN_CODE_BITMASKS    , 0x204 | 0x3A6 << PRN_PRNSIZE);
    axi_write(pBASE, IMI_CH_PRN_GEN_OFF + PRN_CODE_OUT_BITMASKS, 0x200 | 0x022 << PRN_PRNSIZE); // GPS_L1_CA_0
    axi_write(pBASE, IMI_CH_PRN_GEN_OFF + PRN_CNTR_LENGTH      , code_length-1  | time_slots_en << 31 | time_slot_active_num << 24);  // length : time slot enable : active time slot number
    
    //-----------------
    //prn_gen_ch for imi
    unsigned int IMI_CH_PRN_RAM_OFF;
    unsigned int prn_ram_size;
    IMI_CH_PRN_RAM_OFF = IMI_CH_PRN_GEN_OFF + prn_gen_size;
    rc = axi_read(pBASE, IMI_CH_PRN_RAM_OFF, 0);
    printf("size_ID IMI_CH_PRN_RAM = %08X\n",rc);
    prn_ram_size = rc >> 16;
    printf("prn_ram_size = %d\n",prn_ram_size);
    if((rc & 0xFFFF) != 0x826){
        printf("NON VALID IMI_CH_PRN_RAM!\n");
        return -1;
    }
    
    //-----------------
    //regs_ch for imi
    unsigned int IMI_CH_REGS_OFF;
    unsigned int regs_size;
    unsigned int imi_code_rate;
    unsigned int fi_imi;
    fi_imi = 1e6;
    IMI_CH_REGS_OFF = IMI_CH_PRN_RAM_OFF + prn_ram_size;
    rc = axi_read(pBASE, IMI_CH_REGS_OFF, 0);
    printf("size_ID IMI_CH_REGS = %08X\n",rc);
    regs_size = rc >> 16;
    printf("regs_size = %d\n",regs_size);
    if((rc & 0xFFFF) != 0x6BF8){
        printf("NON VALID IMI_CH_REGS!\n");
        return -1;
    }
    
    imi_code_rate = fi_imi/Fd*const_2_32;
    printf("imi_code_rate = %d\n",imi_code_rate);
    
    axi_write(pBASE, IMI_CH_REGS_OFF + REGS_PHASE_RATE , imi_code_rate);
    axi_write(pBASE, IMI_CH_REGS_OFF + REGS_CFG , 2+3 << OFF_ADEVEXP | 1 | 1 << OFF_CH_EN | 1 << OFF_PN_MUX);
    
    //-----------------
    axi_write(pBASE, IMI_CH_TIME_OFF + TM_TIME_PHASE, 1 ); // do_rqst
    //-----------------

    for(i = 0; i < 8; i ++){
        axi_write(pBASE, IMI_CH_REGS_OFF + REGS_DATA + i, 0xAAAA0000 | i); // wr data
    }
    // axi_write(pBASE, IMI_CH_REGS_OFF + REGS_DATA + 1, 0xAAAA0001); // wr data


    // just pause
    for(i = 0; i < 1100; i ++) rc = axi_read(pBASE, 0, 0);
    // do_rqst again
    axi_write(pBASE, IMI_CH_TIME_OFF + TM_TIME_PHASE, 1 ); // do_rqst

    return 0;
}
