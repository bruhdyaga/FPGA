#ifndef SERVICE_FUNC_H
#define SERVICE_FUNC_H

#include "facq.h"
#include "signal_types.h"
#include "axi_rw.h"
#include "psp_init_functions.h"

double get_f_prestore (struct facq_data * dfacq);
int psp_init          (struct facq_data * dfacq);
void prestore_set     (struct facq_data * dfacq);
void compute_params   (struct facq_data * dfacq);
int is_ram_complete   (struct facq_data * dfacq);
int is_facq_complete  (struct facq_data * dfacq);
int testRegs          (struct facq_data * dfacq);
int8_t wr_data_2_bram (struct facq_data * dfacq);

#endif
