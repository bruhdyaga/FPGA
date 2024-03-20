#define BASE_ADDR           0x0

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "axi_rw.h"

int cpu_sim() {
    
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int rc;
    uint8_t in_width, out_width, i, k_size;
    uint8_t k, max_k;

    printf("Hello from cpu_sim!\n");
    
    rc = axi_read(pBASE, 0, 0);
    if((rc & 0xFFFF) != 0xB1DF){
        printf("non valid ID; rc = 0x%04X\n", (rc & 0xFFFF));
        return -1;
    }
    
    rc = axi_read(pBASE, 1, 0);
    in_width  = rc & 0x1F;
    out_width = (rc >> 5) & 0x1F;
    printf("in_width = %d, out_width = %d\n", in_width, out_width);
    
    printf("clr RAM\n");
    axi_write(pBASE, 1, 1 << 30);
    
    k_size = 1 << (in_width - 1);
    max_k  = 1 << (out_width - 1);
    for(i = 0; i < k_size; i ++){
        k = sin(M_PI/2.0*i/k_size) * max_k;
        axi_write(pBASE, 1, (1 << 31) | k);
        printf("K[%d] = %d\n", i, k);
        waitClks(10);
    }
    
    waitClks(100);
    axi_write(pBASE, 1, 1 << 29); // en compressor
    
    
    return 0;
}

