#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define BASE_ADDR 0x0

void printStats(int regVal);

int C_cpu_sim() {
    unsigned int i;
    unsigned int rc;
    
    volatile unsigned int* pBASE = (unsigned int*)BASE_ADDR;
    
    printf("\n\n*****************************\n");
    printf("Hello from cpu_sim!\n");
    printf("regsfile_tb\n");
    
    rc =  axi_read(pBASE, 0);
    int ID   = rc & 0xFFFF;
    int SIZE = (rc >> 16) & 0xFFFF;

    printf("ID = 0x%04X SIZE = 0x%04X\n", ID, SIZE);

    rc =  axi_read(pBASE, 1);
    int WR_ONLY   = rc & 0xF;
    int RD_ONLY   = (rc>>4 ) & 0xF;
    int RD_WR     = (rc>>8 ) & 0xF;
    int RESERVED  = (rc>>12) & 0xFFFFF;

    printf("REG1: WR_ONLY = 0x%04X | RD_ONLY = 0x%04X | RD_WR = 0x%04X | RESERVED = 0x%04X\n", 
            WR_ONLY,
            RD_ONLY,
            RD_WR,
            RESERVED);

    printf("Change RD_WR and RD_ONLY fields values; set WR_ONLY field value\n");
    RD_WR += 2;
    WR_ONLY = 9;
    RD_ONLY = 1;

    int word = 0;
    word |= (WR_ONLY        & 0x0000000F);
    word |= ((RD_ONLY<<4)   & 0x000000F0);
    word |= ((RD_WR  <<8)   & 0x00000F00);
    word |= ((RESERVED<<12) & 0xFFFFF000);
    
    axi_write(pBASE, 1, word); // Write

    rc =  axi_read(pBASE, 1);
    WR_ONLY   = rc & 0xF;
    RD_ONLY   = (rc>>4 ) & 0xF;
    RD_WR     = (rc>>8 ) & 0xF;
    RESERVED  = (rc>>12) & 0xFFFFF;

    printf("REG1: WR_ONLY = 0x%04X | RD_ONLY = 0x%04X | RD_WR = 0x%04X | RESERVED = 0x%04X\n", 
            WR_ONLY,
            RD_ONLY,
            RD_WR,
            RESERVED);


    printStats(axi_read(pBASE, 3));

    printf("Let's pulse via pulse 0!\n");
    for (i=0; i<6; i++) {
        axi_write(pBASE, 2, 0x1);
        rc =  axi_read(pBASE, 2);
        while (axi_read(pBASE, 2) & 0x1) {}
    }

    printStats(axi_read(pBASE, 3));

    printf("Let's pulse via pulse 1!\n");
    for (i=0; i<21; i++) {
        axi_write(pBASE, 2, 0x2);
        rc =  axi_read(pBASE, 2);
        while (axi_read(pBASE, 2) & 0x2) {}
    }

    printStats(axi_read(pBASE, 3));
        
    return 0;
}


void printStats(int regVal) {
    int WRITES    = regVal & 0xFF;
    int READS     = (regVal>>8 ) & 0xFF;
    int PULSES_0  = (regVal>>16) & 0xFF;
    int PULSES_1  = (regVal>>24) & 0xFF;
    printf("STATS: READS = %2d | WRITES = %2d | PULSES_0 = %2d | PULSES_1 = %2d\n",
            READS,
            WRITES,
            PULSES_0,
            PULSES_1);
}