#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

# define UART_0_ID   1
# define UART_0_RX   2
# define UART_0_TX   3
# define UART_0_STAT 4
# define UART_0_CTRL 5

# define UART_1_ID   6
# define UART_1_RX   7
# define UART_1_TX   8
# define UART_1_STAT 9
# define UART_1_CTRL 10

int cpu_sim() {
    unsigned int i;
    
    volatile unsigned int* pBASE = BASE_ADDR;
    
    printf("\n\n*****************************\n");
    printf("Hello from cpu_sim!\n");
    printf("axi_uart_tb\n");
    
    printf("BASE_HUB size_ID = 0x%08X\n",*axi_read(pBASE, 0, 0));
    printf("AXI_UART_0_SPI size_ID = 0x%08X\n",*axi_read(pBASE, UART_0_ID, 0));
    printf("AXI_UART_1_SPI size_ID = 0x%08X\n",*axi_read(pBASE, UART_1_ID, 0));
    
    axi_write(pBASE, UART_0_CTRL, 1 << 4 | 3); // en intr | reset rx tx
    axi_write(pBASE, UART_1_CTRL, 1 << 4 | 3); // en intr | reset rx tx
    for(i=0; i<57; i++){
        while((*axi_read(pBASE, UART_0_STAT, 0)) & 0x8); 
        axi_write(pBASE, UART_0_TX, i); // Write
        printf("%2d write to UART_0\n", i);
        waitClks(100);
    }
    // return 0;
    waitClks(1000);
    printf("%GOTO read from UART_1\n");
    for(i=0; i<64; i++){
        while(!((*axi_read(pBASE, UART_1_STAT, 0)) & 0x1)); 
        printf("Read[%2d] = %2d\n", i, (*axi_read(pBASE, UART_1_RX, 0)) & 0xFF); // Read
    }
    
    // for(i=0; i<2; i++){
        // *axi_read(pBASE, UART_0_RX, 0); // Read
    // }
    
    // for(i=0; i<2; i++){
        // axi_write(pBASE, UART_0_TX, 0xAB); // Write
    // }
    
    // waitClks(100);
    
    // for(i=0; i<15; i++){
        // *axi_read(pBASE, UART_0_RX, 0); // Read
    // }
    
    // axi_write(pBASE, 9, wr_depth); // wr_depth
    // axi_write(pBASE, 7, 1 << 0); // start
    // waitClks(50);
    
    // for(i = 0; i < 3; i ++){
        // if(sigmag_compute(pBASE, i, VERBOSE)){
            // return -1;
        // }
    // }
    
    // while((*axi_read(pBASE, 7, 0)) & 0x1){
        // printf("RAM not complete\n");
        // waitClks(50);
    // }
    // printf("RAM complete\n");
    
    // printf("DATA_COLL_BUS_CHAN = %d\n",0);
    // axi_write(pBASE, 6, 0); // DATA_COLL_BUS_CHAN
    // for(i = 0; i < wr_depth; i ++){
        // printf("DAT_COL[%2d] = %08X\n",i,*axi_read(pBASE, 11, 0));
    // }
    
    // printf("DATA_COLL_BUS_CHAN = %d\n",1);
    // axi_write(pBASE, 6, 1); // DATA_COLL_BUS_CHAN
    // for(i = 0; i < wr_depth; i ++){
        // printf("DAT_COL[%2d] = %08X\n",i,*axi_read(pBASE, 11, 0));
    // }
    
    return 0;
}
