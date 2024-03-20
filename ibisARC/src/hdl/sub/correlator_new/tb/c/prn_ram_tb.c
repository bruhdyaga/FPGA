#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define TIME_CH_OFFS                0xC
#define TIME_CH_PHASE_OFFS          1
#define TIME_CH_CHIP_EPOCH_OFFS     2
#define TIME_CH_SEC_OFFS            3
#define TIME_CH_CHIP_EPOCH_MAX_OFFS 4
#define TIME_CH_CODE_RATE_OFFS      5

#define PRN_RAM_OFFS     0x12
#define PRN_RAM_CFG_OFFS 1

int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int i;
    
    unsigned int RAM_LENGTH, WR_ADDR, BOC_MODE, TDMA_MODE, WR_DATA;
    
    printf("\nHello from cpu_sim!\n");
    printf("prn_ram_tb\n");
    
    BOC_MODE   = 0;
    TDMA_MODE  = 0;
    RAM_LENGTH = 0; // int LEN[6] = '{ 510, 1022, 2045, 4091, 5114, 10229 };
    
    printf("TIME_CH_ID = 0x%08X\n", *axi_read(pBASE, TIME_CH_OFFS, 0));
    printf("PRN_RAM_ID = 0x%08X\n", *axi_read(pBASE, PRN_RAM_OFFS, 0));
    
    axi_write(pBASE, TIME_CH_OFFS + TIME_CH_CHIP_EPOCH_OFFS,     0);
    axi_write(pBASE, TIME_CH_OFFS + TIME_CH_SEC_OFFS,            0);
    axi_write(pBASE, TIME_CH_OFFS + TIME_CH_CHIP_EPOCH_MAX_OFFS, 510);
    axi_write(pBASE, TIME_CH_OFFS + TIME_CH_CODE_RATE_OFFS,      1<<30);
    axi_write(pBASE, TIME_CH_OFFS + TIME_CH_PHASE_OFFS, 1); // do_init
    
    for(i = 0; i <= 510; i ++){
        WR_ADDR = i;
        WR_DATA = (i & 4) >> 2;
        axi_write(pBASE, PRN_RAM_OFFS + PRN_RAM_CFG_OFFS,
                                                            ((RAM_LENGTH & 0xF)    << 0 ) |
                                                            ((WR_ADDR    & 0x3FFF) << 4 ) |
                                                            ((BOC_MODE   & 0x3)    << 18) |
                                                            ((TDMA_MODE  & 0x3)    << 20) |
                                                            ((WR_DATA    & 0x1)    << 22)
                );
        printf("wr addr = %3d | PSP = %d\n", WR_ADDR, WR_DATA);
    }
    
    return 0;
}
