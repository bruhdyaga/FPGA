#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define MASTER_HP_SHIFT 1
#define T_COM           12

// #define DO_REG         (1 + 0)
// #define CHIP_EPOCH_MAX (1 + 3)

#define START_RD 0
#define DONE_RD  1
#define START_WR 2
#define DONE_WR  3


#define WR_LEN (21)

int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int rc;
    unsigned int N_buses;
    unsigned int i;
    unsigned int tm_size; // количество регистров под шкалу времени
    unsigned int addr;
    
    unsigned int rd_status;
    
    printf("Hello from cpu_sim!\n");
    printf("xadc_7000_tb\n");
    
    addr = 0x400000F8;
    printf("rd from addr = 0x%08X | data = 0x%08X\n",addr,*axi_read(pBASE, (addr - BASE_ADDR)/4, 0));
    
    addr = 0x400002FC;
    printf("rd from addr = 0x%08X | data = 0x%08X\n",addr,*axi_read(pBASE, (addr - BASE_ADDR)/4, 0));
    
/*     // for(i = 0; i < N_buses; i ++){
        // addr = TEST_SHIFT + 1 + i*tm_size;
        printf("size_ID TCOM  = %08X\n",*axi_read(pBASE, T_COM, 0));
        
        axi_write(pBASE, T_COM + 4, (15 << 18) | 10);// CHIP_EPOCH_MAX
        axi_write(pBASE, T_COM + 1, 1<<0);// do_rqst
        
        // waitClks(200);
        
        axi_write(pBASE, T_COM + 2, (5 << 18) | 3);// CHIP_EPOCH
        axi_write(pBASE, T_COM + 3, 13);// SEC
        axi_write(pBASE, T_COM + 1, 1<<1);// eph_rqst
        
        // axi_write(pBASE, addr + CHIP_EPOCH_MAX, (3 << 18) | 20);
        // axi_write(pBASE, addr + DO_REG, 1);// do rqst
    // }
    rd_status = ((*axi_read(pBASE, MASTER_HP_SHIFT + 1, 0)) >> DONE_RD) & 1;
    rd_status = ((*axi_read(pBASE, MASTER_HP_SHIFT + 1, 0)) >> DONE_RD) & 1;
    
    waitClks(100);
    printf("START_RD\n");
    axi_write(pBASE, MASTER_HP_SHIFT + 1, 1<<START_RD);// stream_intbus.copy_rd; START_RD
    
    while(1){
        if(rd_status != (((*axi_read(pBASE, MASTER_HP_SHIFT + 1, 0)) >> DONE_RD) & 1)){
            break;
        }
    }
    printf("START_RD DONE\n");
    
    waitClks(100);
    
    
    printf("START_WR\n");
    // axi_write(pBASE, MASTER_HP_SHIFT + 1, (WR_LEN << 16) | 1<<START_WR);
    axi_write(pBASE, MASTER_HP_SHIFT + 1, (1 << 16) | 1<<START_WR);
    
    
    waitClks(100);
    axi_write(pBASE, 0x23 + 2, 0x11111111); // PRN classic init
    axi_write(pBASE, 0x23 + 3, 0x22222222); // PRN classic init
    axi_write(pBASE, 0x23 + 4, 0x33333333); // PRN classic init
    axi_write(pBASE, 0x23 + 5, 0x44444444); // PRN classic init */
    
    return 0;
}