#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define CFG  1
#define DATA 2

#define WR_LEN (21)

#define DONE_RD 1


int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int rc;
    unsigned int N_buses;
    unsigned int i;
    unsigned int tm_size; // количество регистров под шкалу времени
    unsigned int addr;
    
    unsigned int rd_status;
    unsigned int cfg;
    unsigned int buf_size;
    
    printf("------------------------------\n");
    printf("------------------------------\n");
    printf("Hello from cpu_sim!\n");
    printf("vitdec_tb\n");
    
    printf("size_ID VITDEC = %08X\n",*axi_read(pBASE, 0, 0));
    
    // write data
    // axi_write(pBASE, DATA + 0, 0b0011100011110111);
    // axi_write(pBASE, DATA + 0, 0x38F7);
    // axi_write(pBASE, DATA + 0, 0xFFFFFFFF);
    // axi_write(pBASE, DATA + 1, 0xFFFFFFFF);
    
    rc = *axi_read(pBASE, CFG, 0);
    buf_size = ((rc >> 7) & 0x1F) + 1;
    printf("buf_size = %d\n",buf_size);
    
    unsigned int data;
    data = 0b10100111011110101111001010101110;
    axi_write(pBASE, DATA + 0, 0b01110110000011110100110101101100);
    axi_write(pBASE, DATA + 1, 0b01001011000000011000100001110101);
    // data = 0x4E32E232;
    // axi_write(pBASE, DATA + 0, 0x4F0BC4EC);
    // axi_write(pBASE, DATA + 1, 0x127BCA4E);
    
    cfg =   (2 - 1) << 2 | // колчество входных данных в регистрах
            1 << 0 |
            0 << 12 | // MODE
            15 << 14;  // количество используемых пар бит
    printf("CFG = 0x%08X\n",cfg);
    
    for(i = 0; i < 1; i ++){
        printf("START\n");
        axi_write(pBASE, CFG, cfg);
        
        waitClks(100);
        rd_status = ((*axi_read(pBASE, CFG, 0)) >> DONE_RD) & 1;
        // printf("CFG = %08X\n",i,*axi_read(pBASE, i, 0));
        
        
        printf("WAIT DONE\n");
        
        while(1){
            if(rd_status == 1){
                break;
            }
            rd_status = ((*axi_read(pBASE, CFG, 0)) >> DONE_RD) & 1;
        }
        printf("DONE\n");
        
        // for(i = 0; i<128;i++){
            // printf("DATA_%3d = %08X\n",i,*axi_read(pBASE, i, 0));
        // }
        printf("INP DATA = %08X\n",data);
        printf("DATA_0   = %08X\n",*axi_read(pBASE, DATA + buf_size, 0));
        // printf("DATA_15 = %08X\n",*axi_read(pBASE, DATA + 32 + 15, 0));
    }
    // waitClks(1000);
    
    
  /*   // for(i = 0; i < N_buses; i ++){
        // addr = TEST_SHIFT + 1 + i*tm_size;
        printf("size_ID TCOM  = %08X\n",*axi_read(pBASE, T_COM, 0));
        
        axi_write(pBASE, T_COM + 5, (15 << 18) | 10);// CHIP_EPOCH_MAX
        axi_write(pBASE, T_COM + 2, 1<<0);// do_rqst
        
        // waitClks(200);
        
        axi_write(pBASE, T_COM + 3, (5 << 18) | 3);// CHIP_EPOCH
        axi_write(pBASE, T_COM + 4, 13);// SEC
        axi_write(pBASE, T_COM + 2, 1<<1);// eph_rqst
        
        // axi_write(pBASE, addr + CHIP_EPOCH_MAX, (3 << 18) | 20);
        // axi_write(pBASE, addr + DO_REG, 1);// do rqst
    // }
    
    // rd_status = ((*axi_read(pBASE, MASTER_HP_SHIFT + 1, 0)) >> DONE_RD) & 1;
    
    // waitClks(100);
    // printf("START_RD\n");
    // axi_write(pBASE, MASTER_HP_SHIFT + 1, 1<<START_RD);// stream_intbus.copy_rd; START_RD
    
    // while(1){
        // if(rd_status != (((*axi_read(pBASE, MASTER_HP_SHIFT + 1, 0)) >> DONE_RD) & 1)){
            // break;
        // }
    // }
    // printf("START_RD DONE\n");
    
    // waitClks(100);
    
    
    // printf("START_WR\n");
    // axi_write(pBASE, MASTER_HP_SHIFT + 1, (WR_LEN << 16) | 1<<START_WR);
    // axi_write(pBASE, MASTER_HP_SHIFT + 1, (1 << 16) | 1<<START_WR);
    
    
    // int TDMA_MODE;
    int BOC_MODE;
    
    // TDMA_MODE = 0;
    BOC_MODE  = 2;
    
    waitClks(100);
    axi_write(pBASE, 0x23 + 2, 0x0000004C); // CODE_STATES;
    axi_write(pBASE, 0x23 + 3, 0x20D10240); // CODE_BITMASKS;     | TDMA_MODE
    axi_write(pBASE, 0x23 + 4, 0x00800200 | (BOC_MODE<<28)); // CODE_OUT_BITMASKS; | BOC_MODE
    axi_write(pBASE, 0x23 + 5, 0x000003FE); // CNTR_LENGTH;
    
    axi_write(pBASE, 0x1B + 5, (15 << 18) | 10);// CHIP_EPOCH_MAX
    axi_write(pBASE, 0x1B + 6, 429496729);// CODE_RATE
    axi_write(pBASE, 0x1B + 3, (5 << 18) | 3);// CHIP_EPOCH
    axi_write(pBASE, 0x1B + 4, 13);// SEC
    // axi_write(pBASE, 0x1B + 2, 1<<1);// eph_rqst
    axi_write(pBASE, 0x1B + 2, 1);// do rqst
    
    
    
    // CORR_CH
    axi_write(pBASE, 0x29 + 2, 0x00003); // CFG
    axi_write(pBASE, 0x29 + 2, 0x10005); // CFG
    axi_write(pBASE, 0x29 + 2, 0x20007); // CFG */
    
    
    
    return 0;
}