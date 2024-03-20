#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define MASTER_HP_SHIFT   1
#define MASTER_HP_CFG_OFF 1

#define START_RD 0
#define DONE_RD  1
#define START_WR 2
#define DONE_WR  3

#define ACP_OFFS      1
#define CFG_OFFS      1
#define AXLEN_OFFS    2
#define AXSIZE_OFFS   3
#define AXADDR_OFFS   4
#define RDATA_HI_OFFS 5
#define RDATA_LO_OFFS 6
#define RD_SIZE_OFFS  7
#define WSTRB_OFFS    8

// #define START_ADDR 0xFF // стартовый адрес для тестирования
// #define RD_LEN     8   // длина чтения для тестирования

#define TCOM_OFFS 9

int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int i;
    
    
    printf("\nHello from cpu_sim!\n");
    printf("test_ocm_tb\n");


    // printf("TCOM SIZE_ID = 0x%08X\n", *axi_read(pBASE, TCOM_OFFS, 0));
    
    // *axi_read(pBASE, TCOM_OFFS, 15);
    
    axi_write(pBASE, ACP_OFFS + AXLEN_OFFS  , 15);
    axi_write(pBASE, ACP_OFFS + AXSIZE_OFFS , 2);
    axi_write(pBASE, ACP_OFFS + AXADDR_OFFS , BASE_ADDR + (WSTRB_OFFS + 1)*4);
    axi_write(pBASE, ACP_OFFS + RD_SIZE_OFFS, 3);
    axi_write(pBASE, ACP_OFFS + CFG_OFFS    , 1); // start

    // for(i = 0; i < 15; i ++){
        // printf("rd 0x%02X (%3d) = 0x%08X\n", i, i, *axi_read(pBASE, i, 0));
    // }
    
    // printf("DMA SIZE_ID = 0x%08X\n", *axi_read(pBASE, MASTER_HP_SHIFT, 0));
    
    // printf("RD_LEN = %d\n", RD_LEN);
    // printf("send start pulse...\n");
    // axi_write(pBASE, MASTER_HP_SHIFT + MASTER_HP_CFG_OFF, RD_LEN << 16 | START_ADDR << 4 | 1);
    
    return 0;
}
