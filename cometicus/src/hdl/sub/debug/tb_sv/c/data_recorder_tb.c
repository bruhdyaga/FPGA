#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

# define rd_depth 32

int cpu_sim() {
    unsigned int i, j;
    
    volatile unsigned int* pBASE = BASE_ADDR;
    
    printf("\n\n*****************************\n");
    printf("Hello from cpu_sim!\n");
    printf("data_recorder\n");
    
    printf("DAT_COL size_ID = 0x%08X\n",*axi_read(pBASE, 0, 0));
    
    for(j = 0; j < 10; j ++){
        
        axi_write(pBASE, 5, 1 << 0); // soft_reset
        axi_write(pBASE, 6, 0); // port number
        for(i = 0; i < rd_depth; i ++){
            axi_write(pBASE, 11, i + j*rd_depth);
        }
        axi_write(pBASE, 5, 1 << 0); // soft_reset
        axi_write(pBASE, 6, 1); // port number
        for(i = 0; i < rd_depth; i ++){
            axi_write(pBASE, 11, i+100 + j*rd_depth);
        }
        
        
        axi_write(pBASE, 9, rd_depth); // rd_depth
        axi_write(pBASE, 5, 1 << 0); // soft_reset
        axi_write(pBASE, 7, 1 << 0); // start
        waitClks(50);
        
        // for(i = 0; i < 3; i ++){
            // if(sigmag_compute(pBASE, i, VERBOSE)){
                // return -1;
            // }
        // }
        
        while((*axi_read(pBASE, 7, 0)) & 0x1){
            printf("RAM not complete\n");
            waitClks(50);
        }
        printf("RAM complete\n");
    }
    
    // printf("DATA_COLL_BUS_CHAN = %d\n",0);
    // axi_write(pBASE, 6, 0); // DATA_COLL_BUS_CHAN
    // for(i = 0; i < rd_depth; i ++){
        // printf("DAT_COL[%2d] = %08X\n",i,*axi_read(pBASE, 11, 0));
    // }
    
    // printf("DATA_COLL_BUS_CHAN = %d\n",1);
    // axi_write(pBASE, 6, 1); // DATA_COLL_BUS_CHAN
    // for(i = 0; i < rd_depth; i ++){
        // printf("DAT_COL[%2d] = %08X\n",i,*axi_read(pBASE, 11, 0));
    // }
    
    return 0;
}
