#ifndef PSP_INIT_FUNCTIONS_H
#define PSP_INIT_FUNCTIONS_H

#include "facq.h"
#include "axi_rw.h"
#include "stdbool.h"

int gps_l1_ca  (struct facq_data * dfacq);
int gps_l1_ca_ram  (struct facq_data * dfacq);
int gln_of     (struct facq_data * dfacq);
int gln_sf     (struct facq_data * dfacq);
int gps_l2_cm  (struct facq_data * dfacq, unsigned int freq_div);
int gps_l2_cl  (struct facq_data * dfacq);
int gln_l1oc_d (struct facq_data * dfacq, unsigned int freq_div);
int gln_l2oc_p (struct facq_data * dfacq, unsigned int freq_div);
int gln_l3oc_p (struct facq_data * dfacq);
int gln_l3oc_d (struct facq_data * dfacq, unsigned int freq_div);
int sbs_sdcm   (struct facq_data * dfacq);
int gps_l5_d   (struct facq_data * dfacq, unsigned int freq_div);
int gps_l5_p   (struct facq_data * dfacq);
int bds_BxI    (struct facq_data * dfacq);
int gal_E1B    (struct facq_data * dfacq);
int gal_E5a    (struct facq_data * dfacq);
int gal_E5b    (struct facq_data * dfacq);
int lct_ism    (struct facq_data * dfacq);
int loc_l2o    (struct facq_data * dfacq);

void set_ram_cfg(bool en, bool reverse, unsigned int len, struct facq_data * dfacq);
void set_ram_word(unsigned int word, struct facq_data * dfacq);

#endif
