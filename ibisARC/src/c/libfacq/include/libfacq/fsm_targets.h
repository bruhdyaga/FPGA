#ifndef FSM_TARGETS_H
#define FSM_TARGETS_H

typedef enum
{
    FSM_RESET       = 0, 
    FSM_WAIT_START  = 1, 
    FSM_INIT        = 2, 
    FSM_N_TAU_ZONE  = 3, // стадия непрерывного вычитывания из памяти
    FSM_LAST_PSP    = 4, // стадия завершения свертки
    FSM_WAIT_MAX    = 5  // ожидание окончания поиска
}
fsm_targets;

#endif
