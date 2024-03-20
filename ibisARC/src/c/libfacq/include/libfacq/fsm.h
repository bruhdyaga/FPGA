#ifndef FSM_H
#define FSM_H

#include "facq.h"
#include "axi_rw.h"

int8_t reset_fsm(struct facq_data * dfacq);
int8_t set_fsm_target(struct facq_data * dfacq, uint8_t * target);

#endif
