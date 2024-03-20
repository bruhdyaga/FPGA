#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define BASE_ADDR 0x0

int C_cpu_sim() {
    unsigned int i;
    unsigned int rc;
    unsigned int size_in, size_out;
    
    volatile unsigned int* pBASE = (unsigned int*)BASE_ADDR;
    
    printf("\n\n*****************************\n");
    printf("Hello from cpu_sim!\n");
    printf("adc_interconnect_tb\n");
    
    rc =  axi_read(pBASE, 0);
    int ID   = rc & 0xFFFF;
    int SIZE = (rc >> 16) & 0xFFFF;

    // printf("ADC_INTERCONNECT ID = 0x%04X SIZE = 0x%04X\n", ID, SIZE);

    for(i=0; i<numOfModIDs; i++) {
        if (ID == IDs[i] && ID == IDs[adc_interconnect]) {
            printf("ID 0x%04X found in ID_DB! device: %s, size: %d\n", ID, IDnamelist[i], SIZE);
            break;
        }
    }

    rc =  axi_read(pBASE, 1);
    size_in  = (rc >> 16) & 0xFF;
    size_out = (rc >> 24) & 0xFF;
    printf("size_in = %d; size_out = %d;\n",size_in, size_out);
    
    int lut[20] = {5, 11, 6, 1, 0, 2, 3, 8, 4, 6, 9, 3, 1, 1, 0, 2, 3, 2, 4, 6};
    printf("adc interconnect lut:\n");
    for(i=0; i<size_out; i++){
        axi_write(pBASE, 1, i << 8 | lut[i]); // Write
        printf("%2d -> %2d\n", i, lut[i]);
    }
        
    return 0;
}
