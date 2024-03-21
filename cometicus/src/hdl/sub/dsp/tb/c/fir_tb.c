#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

int cpu_sim() {
    
    volatile unsigned int* pBASE = 0;
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
    printf("fir_tb\n");
    
    printf("size_ID FIR = %08X\n",*axi_read(pBASE, 0, 0));
    printf("size_ID FIR_CFG = %08X\n",*axi_read(pBASE, 1, 0));
    
    printf("ORDER = %d\n",(*axi_read(pBASE, 1, 0)) & 0x3F);
    
    // write data
    axi_write(pBASE, 2, 0  | 0 <<20 | 1<<31); waitClks(30);
    axi_write(pBASE, 2, 1  | 1 <<20 | 1<<31); waitClks(30);
    axi_write(pBASE, 2, 2  | 2 <<20 | 1<<31); waitClks(30);
    axi_write(pBASE, 2, 3  | 3 <<20 | 1<<31); waitClks(30);
    // axi_write(pBASE, 2, 4  | 4 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, 2, 5  | 5 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, 2, 6  | 6 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, 2, 7  | 7 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, 2, 8  | 8 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, 2, 9  | 9 <<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, 2, 10 | 10<<14 | 1<<31); waitClks(30);
    // axi_write(pBASE, 2, 11 | 11<<14 | 1<<31); waitClks(30);
    
    
    
    return 0;
}