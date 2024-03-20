#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int i,j;
    
    printf("Hello from cpu_sim!\n");
    printf("null_former_tb\n");
    
    printf("size_ID  = %08X\n",*axi_read(pBASE, 0, 0));
    
    // axi_write(pBASE, 2, 1); // set MUX_0
    
    for(i=0;i<2;i++){
        for(j=0;j<4;j++){
            axi_write(pBASE, 2 + j + i*4, 1000*i+100*j+10); // write coeff
        }
    }
    
    axi_write(pBASE, 1, 1); // write coeff
    
    return 0;
}