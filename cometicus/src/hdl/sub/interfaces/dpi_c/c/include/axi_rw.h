#ifndef AXI_RW_H
#define AXI_RW_H


#ifdef SIM_SV
extern void waitClks (int num_clk);
int get_sim_time(void);
void insert_time_stamp(void);

#define TIMESTAMP insert_time_stamp();
#else
void waitClks (int num_clk);

#define TIMESTAMP ;
#endif
unsigned int axi_read(volatile unsigned int * base, int offset, int burst_len);
void axi_write(volatile unsigned int * base, int offset, int val);

#endif
