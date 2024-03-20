#include <stdint.h>

#include "libfacq/fsm.h"
#include "libfacq/fsm_targets.h"

char const *fsm_target_names[] = {
    "FSM_RESET",
    "FSM_WAIT_START",
    "FSM_INIT",
    "FSM_N_TAU_ZONE",
    "FSM_LAST_PSP",
    "FSM_WAIT_MAX",
    
    "UNDEF_STATE",
    "UNDEF_STATE"
};

int8_t reset_fsm(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("reset fsm\n"); fflush(stdout); }
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1 << 31);
    
    return 0;
}

int8_t set_fsm_target(struct facq_data * dfacq, uint8_t * target){
    uint32_t fsm_target = 0;
    uint8_t  fsm_target_i;
    uint8_t i;
    
    for(i = 0 ; i < 10; i ++){
        fsm_target_i = target[i] & 0b111;
        fsm_target = fsm_target | (fsm_target_i << i*3);
        if(dfacq->disp){ TIMESTAMP printf("fsm_target[%d] = %s\n", i, fsm_target_names[fsm_target_i]); fflush(stdout); }
    };
    if(dfacq->disp){ TIMESTAMP printf("fsm_target = 0x%08X\n", fsm_target); fflush(stdout); }
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_target, fsm_target);
    return 0;
}