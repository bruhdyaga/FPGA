#ifndef FACQ_H
#define FACQ_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include "stdbool.h"

#define HUB_REGS 1// количество регистров в хабах

// #define NREGS_SIZE 1// адрес регистра размера слейва и его пространства

#define INP_MUX_BITS_WIDTH 5 // ширина битового поля входного мультиплексора

typedef enum
{
    acq_ip_regs,
    prestore_regs,
    prestore_dds_sin_cos,
    prestore_dds_bin,
    bram_controller_regs,
    facq_prn_ram_regs,
    max_args_regs,
    fsm_controller_regs,
    facq_module_offset_list_size
}
facq_module_offset_list;

struct facq_data {
    volatile unsigned int* pBASE;
    unsigned int facq_module_offset[facq_module_offset_list_size];
    double fd;
    double fi;
    double kg_ms; // AcquisitionStrategies: T
    double kg_ms_actual;
    double nkg;
    double tau_acq_ms;
    double tau_acq_ms_actual;
    double df;// Актуальный шаг поиска по частоте, Гц
    double nf;
    double core_freq;//Hz
    double freq_acq;//Hz +/-
    double freq_acq_actual;//Hz +/-
    int N_sat; //для GPS - номер ПСП с "0";  для GLN номер литеры
    unsigned int SignType;
    double wr_depth;
    double kg;
    double ntau_zone;// в количестве ядер
    double core_size;
    bool   time_sep;
    double BRAM_depth;
    double res_R;
    double res_tau;
    double res_freq;
    unsigned int fsm_state;
    double kg_cntr;
    double nkg_cntr;
    double nf_cntr;
    double ntau_cntr;
    int disp;// разрешение на printf
    int acq_sync_en; // разрешение на задержку поиска для синхронного старта
    int acq_sync_epoch; // задержка запуска поиска
    int reset_por_en; //разрешение на сброс порога перед последующим его расчетом при перенастройке преднакопителя
    double manual_por;
    double facq_por;// порог обнаружения для поиска
    unsigned int facq_por_busy;// флаг занятости расчета порога блока поиска
    unsigned int facq_por_recent_record;// флаг свежей выборки
    unsigned int facq_por_i;// счетчик итераций поиска
    int buf_reset_por_en;
    int buf_N_sat;
    double buf_fi;
    double buf_freq_acq;
    unsigned int init_done;// инициализация и энумерация завершены
    double need_time;// оценка времени поиска в с
    unsigned int input_Re;
    unsigned int input_Im;
    bool ram_en;
    unsigned int ram_len;
};

int facq_init       (struct facq_data * dfacq);
int facq_set_input  (struct facq_data * dfacq);
int facq_ram_update (struct facq_data * dfacq);
int facq_run        (struct facq_data * dfacq);
int facq_result     (struct facq_data * dfacq);
int por_calibrate   (struct facq_data * dfacq);
int facq_reset      (struct facq_data * dfacq);
int check_state     (struct facq_data * dfacq);

typedef enum
{
    acq_ip_sizeid_off,
    acq_ip_cfg
}
acq_ip_map;

typedef enum
{
    acq_ip_cfg_re_inp,
    acq_ip_cfg_reserved_1,
    acq_ip_cfg_reserved_2,
    acq_ip_cfg_reserved_3,
    acq_ip_cfg_reserved_4,
    acq_ip_cfg_im_inp
}
acq_ip_cfg_map;

typedef enum
{
    prestore_sizeid_off,
    prestore_conf_off
}
prestore_map;

typedef enum
{
    prestore_conf_reset_sigmag
}
prestore_conf_map;

typedef enum
{
    dds_sin_cos_sizeid_off,
    dds_sin_cos_code_freq_off
}
dds_sin_cos_map;

typedef enum
{
    dds_bin_sizeid_off,
    dds_bin_code_freq_off
}
dds_bin_map;

typedef enum
{
    acq_bram_controller_sizeid_off,
    acq_bram_controller_control_off,
    acq_bram_controller_wr_depth_off,
    acq_bram_controller_ram_depth_off,
    acq_bram_controller_wr_cntr_off
}
acq_bram_controller_map;

typedef enum
{
    acq_bram_controller_control_wr_start,
    acq_bram_controller_control_wr_done,
    acq_bram_controller_control_acq_sync_en,
    acq_bram_controller_control_acq_sync_epoch,
    acq_bram_controller_control_fifo_wr = 25,
    acq_bram_controller_control_fifo_wr_en,
    acq_bram_controller_control_fifo_rd_en,
    acq_bram_controller_control_fifo_data
}
acq_bram_controller_control_map;

#define FREQ_DIV_SIZE 8       // число бит на делитель частоты ПСП
#define GPS_L5_RESET_EN_OFF 8 // смещения бита включения GPS_L5
#define SINGLE_SR_OFF       9 // смещения бита включения единого сдвигового регистра

typedef enum
{
    fsm_acq_controller_sizeid_off,
    fsm_acq_controller_core_size_off,
    fsm_acq_controller_kg_nkg_off,
    fsm_acq_controller_ntau_nf_off,
    fsm_acq_controller_control_off,
    fsm_acq_controller_bram_rd_depth_off,
    fsm_acq_controller_freq_shift_code_init,
    fsm_acq_controller_freq_shift_code_step,
    fsm_acq_controller_psp_freq_div_off,
    fsm_acq_controller_psp_code_state1_off,
    fsm_acq_controller_psp_code_reset_state1_off,
    fsm_acq_controller_psp_code_bitmask1_off,
    fsm_acq_controller_psp_code_out_bitmask1_off,
    fsm_acq_controller_psp_code_state2_off,
    fsm_acq_controller_psp_code_reset_state2_off,
    fsm_acq_controller_psp_code_bitmask2_off,
    fsm_acq_controller_psp_code_out_bitmask2_off,
    fsm_acq_controller_psp_length_off,
    fsm_acq_controller_psp_init_off,
    fsm_acq_controller_psp_ovl_off,
    fsm_acq_controller_kg_nkg_cntr,
    fsm_acq_controller_nf_ntau_cntr,
    fsm_acq_controller_target,
    fsm_acq_controller_time_separation
}
fsm_acq_controller_map;

typedef enum
{
    fsm_acq_controller_conf_do_init,
    fsm_acq_controller_conf_acq_start,
    fsm_acq_controller_conf_acq_done,
    fsm_acq_controller_conf_acq_global_resetn,
    fsm_acq_controller_conf_state,
    fsm_acq_controller_conf_reset_fsm = 31
}
fsm_acq_controller_conf_map;


typedef enum
{
    facq_prn_ram_sizeid_off,
    facq_prn_ram_cfg,
    facq_prn_ram_data
}
facq_prn_ram_map;


typedef enum
{
    max_args_sizeid_off,
    max_args_tau_off,
    max_args_freq_off,
    max_args_rlow_off,
    max_args_rhigh_off,
    max_args_acc_0_off,
    max_args_acc_1_off,
    max_args_acc_2_off
}
max_args_map;

typedef enum
{
    time_scale_cfg_fix_rqst,
    time_scale_cfg_eph_rqst
}
time_scale_cfg_map;

#endif
