#include "libfacq/axi_rw.h"

// #define SIM_SV
#ifdef SIM_SV
extern void waitClks (int num_clk);
extern void readReg (int base, int offset, int burst_len, int *rdata, int *stime);
extern void writeReg (int base, int offset, int burst_len, int *val, int *stime);
extern void get_sim_time_sv(int *stime);

unsigned int axi_read(volatile unsigned int * base, int offset, int burst_len){
    int rdata[16];
    int stime;

    readReg (base, offset*4, burst_len, &rdata, &stime);

    return (unsigned)rdata[0];
};

void axi_write_burst(volatile unsigned int * base, int offset, int burst_len, int* val){
    int val_out[16] = {0,};
    int stime;
    int i;

     for(i=0;i<=burst_len;i++){
        val_out[i] = val[i];
     }

    writeReg (base, offset*4, burst_len, val_out, &stime);
};

void axi_write(volatile unsigned int * base, int offset, int val){
    int val_out[16] = {0,};
    int stime;
    int i;

    val_out[0] = val;

    writeReg (base, offset*4, 0, val_out, &stime);
};

int get_sim_time(void){
    int stime;
    
    get_sim_time_sv(&stime);
    
    return stime;
};

void insert_time_stamp(void){
    double time_us = get_sim_time()*10e-12/1e-6; // ТОЛЬКО ДЛЯ КВАНТА 10пс, доработать!
    printf("[%.3f us] ", time_us);
};
#else
unsigned int axi_read(volatile unsigned int * base, int offset, int burst_len){

    return *(base + offset + burst_len*0);//+ burst_len*0 - заглушка
}

// void axi_write_burst(int base, int offset, int burst_len, int* val){
    // int val_out[16] = {0,};
    // int stime;
    // int i;

     // for(i=0;i<=burst_len;i++){
        // val_out[i] = val[i];
     // }

    // writeReg (base, offset, burst_len, val_out, &stime);
// };

void axi_write(volatile unsigned int * base, int offset, int val){

    *(base + offset) = val;
}

void waitClks (int num_clk){
    int i;
    for(i=0;i<num_clk;i++)
        __asm__ volatile("nop");
}

#endif
