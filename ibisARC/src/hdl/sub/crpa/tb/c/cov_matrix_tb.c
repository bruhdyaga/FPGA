#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    
    printf("Hello from cpu_sim!\n");
    
    printf("size_ID  = %08X\n",*axi_read(pBASE, 0, 0));
    printf("MACS_NUM = %d\n",((*axi_read(pBASE, 1, 0)) >> 1) & 0xFFF);
    
    axi_write(pBASE, 2, 1); // set MUX_0
    
    axi_write(pBASE, 1, (9 << 14) | 1); // start CVM
    
    return 0;
}