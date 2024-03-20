#define pBASE 0

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <unistd.h>

// #include <math.h>
// #include "ID_DB.h"
// #include "axi_rw.h"


extern int C_cpu_sim(int id) {
    unsigned int rc;
    uint8_t CODE;
    insert_time_stamp(); printf("--- multi_cpu[%d] ---\n", id);
    
    // for(uint8_t i = 0; i < 2; i ++){
        // printf("for = %d\n", i);
    // }
    while(1){
        CODE = rand() % 4;
        insert_time_stamp(); printf("CPU[%d]: CODE=%d\n", id, CODE);
        switch(CODE){
            case 0:
                rc = axi_read(pBASE, 0, 0);
                break;
            case 1:
                axi_write(pBASE, 0, rc);
                break;
            case 2:
                waitClks(rand() % 10);
                break;
            default:
                break;
        }
    }
    
    return 0;
}
