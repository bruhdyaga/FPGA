// #define BASE_ADDR           0x40000000
#define BASE_ADDR           0

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define T_OFFS 2
#define PHASE_OFFS 2
#define CHIP_EPOCH_MAX_OFFS 5
#define CODE_RATE_OFFS 6

int C_cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int i;
    
    
    printf("\nHello from C_cpu_sim!\n");
    printf("corr_ch_test_tb\n");


    // printf("BASE_ID         = 0x%08X\n", *axi_read(pBASE, 0, 0));
    // printf("T SIZE_ID       = 0x%08X\n", *axi_read(pBASE, T_OFFS, 0));
    // printf("PRN_RAM SIZE_ID = 0x%08X\n", *axi_read(pBASE, 8, 0));
    // printf("CORR_CH SIZE_ID = 0x%08X\n", *axi_read(pBASE, 10, 0));
    
    printf("start burst\n");
    axi_read(pBASE, 1, 15);
    axi_read(pBASE, 1, 15);
    axi_read(pBASE, 1, 15);
    axi_read(pBASE, 1, 15);
    printf("end burst\n");
    
    // *axi_read(pBASE, TCOM_OFFS, 15);
    
    // axi_write(pBASE, T_OFFS + CODE_RATE_OFFS  , 0x0FFFFFFF);
    // axi_write(pBASE, T_OFFS + CHIP_EPOCH_MAX_OFFS  , 9000);
    // axi_write(pBASE, T_OFFS + PHASE_OFFS  , 1); // do_rqst
    // axi_write(pBASE, ACP_OFFS + AXSIZE_OFFS , 2);
    // axi_write(pBASE, ACP_OFFS + AXADDR_OFFS , BASE_ADDR + (WSTRB_OFFS + 1)*4);
    // axi_write(pBASE, ACP_OFFS + RD_SIZE_OFFS, 3);
    // axi_write(pBASE, ACP_OFFS + CFG_OFFS    , 1); // start

    // for(i = 0; i < 15; i ++){
        // printf("rd 0x%02X (%3d) = 0x%08X\n", i, i, *axi_read(pBASE, i, 0));
    // }
    
    // printf("DMA SIZE_ID = 0x%08X\n", *axi_read(pBASE, MASTER_HP_SHIFT, 0));
    
    // printf("RD_LEN = %d\n", RD_LEN);
    // printf("send start pulse...\n");
    // axi_write(pBASE, MASTER_HP_SHIFT + MASTER_HP_CFG_OFF, RD_LEN << 16 | START_ADDR << 4 | 1);
    
    return 0;
}
