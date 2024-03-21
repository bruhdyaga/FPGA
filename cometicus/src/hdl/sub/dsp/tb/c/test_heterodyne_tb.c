#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define HETERODYNE 1 // OFFSET
#define HETERODYNE_CFG_OFFSET 1
#define HETERODYNE_CODE_OFFSET 2
#define FIR_OFFSET 4

#define RECORDER 7 // OFFSET

#define RECORDER_EN 1

#define RECORDER_LEN 100

int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int rc;
    unsigned int N_buses;
    unsigned int i, j;
    unsigned int tm_size; // количество регистров под шкалу времени
    unsigned int addr;
    
    unsigned int rd_status;
    unsigned int cfg;
    unsigned int buf_size;
    
    printf("------------------------------\n");
    printf("------------------------------\n");
    printf("Hello from cpu_sim!\n");
    printf("heterodyne_tb\n");
    
    printf("HUB heterodyne = %08X\n",*axi_read(pBASE, 0, 0));
    printf("size_ID heterodyne = %08X\n",*axi_read(pBASE, HETERODYNE, 0));
    printf("size_ID RECORDER = %08X\n",*axi_read(pBASE, RECORDER, 0));
    printf("size_ID FIR = %08X\n",*axi_read(pBASE, FIR_OFFSET, 0));
    
    printf("IQ_WIDTH = %d\n",(*axi_read(pBASE, HETERODYNE + HETERODYNE_CFG_OFFSET, 0)) & 0xF);
    printf("PHASE_WIDTH = %d\n",((*axi_read(pBASE, HETERODYNE + HETERODYNE_CFG_OFFSET, 0)) >> 4) & 0xF);
    axi_write(pBASE, HETERODYNE + HETERODYNE_CFG_OFFSET, RECORDER_EN << 8); // RECORDER_EN
    
    //configure DDS
    axi_write(pBASE, HETERODYNE + HETERODYNE_CODE_OFFSET, 26843545);
    
    printf("ORDER = %d\n",(*axi_read(pBASE, FIR_OFFSET + 1, 0)) & 0x3F);
    printf("COEF_WIDTH = %d\n",((*axi_read(pBASE, FIR_OFFSET + 1, 0)) >> 6) & 0x1F);
    
    // write data
    for(j=0; j < 11; j++){
        axi_write(pBASE, FIR_OFFSET + 2, 1  | j <<14 | 1<<31); waitClks(30);
    }
    // axi_write(pBASE, FIR_OFFSET + 2, 1  | 1 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 2  | 2 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 3  | 3 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 4  | 4 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 5  | 5 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 6  | 6 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 7  | 7 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 8  | 8 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 9  | 9 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 10 | 10<<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, FIR_OFFSET + 2, 11 | 11<<14 | 1<<31); waitClks(30);
    
    
    axi_write(pBASE, RECORDER + 9, RECORDER_LEN); // recorder length
        
    for(j=0; j < 4; j++){
        axi_write(pBASE, RECORDER + 6, j); // chan
        axi_write(pBASE, RECORDER + 5, 1); // soft reset
        for(i=0; i < RECORDER_LEN; i++){
            axi_write(pBASE, RECORDER + 11, 0); // wr
        }
    }
    printf("RECORDER complete\n");
    
    axi_write(pBASE, RECORDER + 5, 1); // soft reset
    axi_write(pBASE, RECORDER + 7, 1); // play recorder
    
    while(!(*axi_read(pBASE, RECORDER + 7, 0)) & 0x1){ // is RAM complete
        waitClks(50);
    }
    printf("RECORDER RAM end\n");
    
    for(j=0; j < 2; j++){
        axi_write(pBASE, RECORDER + 6, j); // chan
        axi_write(pBASE, RECORDER + 5, 1); // soft reset
        for(i=0; i < RECORDER_LEN; i++){
            axi_write(pBASE, RECORDER + 11, 1); // wr
        }
    }
    printf("RECORDER complete\n");
    
    axi_write(pBASE, RECORDER + 5, 1); // soft reset
    axi_write(pBASE, RECORDER + 7, 1); // play recorder
    
    return 0;
}