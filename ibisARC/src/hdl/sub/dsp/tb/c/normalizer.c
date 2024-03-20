#define BASE_ADDR           0x4

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "axi_rw.h"

int C_cpu_sim(int ID) {
    volatile unsigned int * pBase;
    uint8_t WIDTH, TWIDTH;
    uint32_t rc;
    uint16_t K;
    uint8_t shift;
    
    pBase = (volatile unsigned int * )BASE_ADDR;
    
    rc = axi_read(pBase, 1, 0);
    WIDTH = rc & 0x1F;
    TWIDTH = (rc >> 5) & 0x1F;
    printf("WIDTH=%d, TWIDTH=%d\n", WIDTH, TWIDTH);
    
    shift = TWIDTH/2;
    printf("shift = %d\n", shift);
    
    axi_write(pBase, 1, 1 << 30); // clr fifo addr
    for(uint32_t i = 0; i < (1 << TWIDTH); i ++){
        K = sqrt(2) / sqrt(i+1) * (1 << (TWIDTH-1));
        if(i % 100 == 0) printf("K[%u] = %u\n", i, K);
        axi_write(pBase, 1, (1 << 31) |
                        (shift << 25) |
                        K);
        waitClks(20);
    }
    
    // volatile unsigned int* pBASE = BASE_ADDR;
    // unsigned int rc;
    // uint8_t in_width, out_width, i, k_size;
    // uint8_t k, max_k;

    // printf("Hello from cpu_sim[%d]!\n", ID);
    
    // rc = axi_read(pBASE, 0, 0);
    // if((rc & 0xFFFF) != 0xB1DF){
        // printf("non valid ID; rc = 0x%04X\n", (rc & 0xFFFF));
        // return -1;
    // }
    
    // rc = axi_read(pBASE, 1, 0);
    // in_width  = rc & 0x1F;
    // out_width = (rc >> 5) & 0x1F;
    // printf("in_width = %d, out_width = %d\n", in_width, out_width);
    
    // printf("clr RAM\n");
    // axi_write(pBASE, 1, 1 << 30);
    
    // k_size = 1 << (in_width - 1);
    // max_k  = 1 << (out_width - 1);
    // for(i = 0; i < k_size; i ++){
        // k = sin(M_PI/2.0*i/k_size) * max_k;
        // axi_write(pBASE, 1, (1 << 31) | k);
        // printf("K[%d] = %d\n", i, k);
        // waitClks(10);
    // }
    
    // waitClks(100);
    // axi_write(pBASE, 1, 1 << 29); // en compressor
    
    
    return 0;
}

