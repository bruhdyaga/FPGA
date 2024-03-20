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

#define CALIBRATION_OFFS 1
#define CALIBRATION_CFG_OFFS 1
#define CALIBRATION_PHASE_RATE_OFFS 2

int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int i;
    
    
    printf("\nHello from cpu_sim!\n");
    printf("calibration_tb\n");


    printf("CALIBRATION_SIZE_ID = 0x%08X\n", axi_read(pBASE, CALIBRATION_OFFS, 0));
    
    // *axi_read(pBASE, TCOM_OFFS, 15);
    
    axi_write(pBASE, CALIBRATION_OFFS + CALIBRATION_CFG_OFFS, 0);
    axi_write(pBASE, CALIBRATION_OFFS + CALIBRATION_PHASE_RATE_OFFS, 403874905);
    
    return 0;
}
