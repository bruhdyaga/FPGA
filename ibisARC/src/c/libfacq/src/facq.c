#include "libfacq/facq.h"
#include "libfacq/service_func.h"
#include "libfacq/ID_DB.h"
#include "libfacq/axi_rw.h"
#include "libfacq/signal_types.h"
#include "libfacq/fsm.h"
#include "libfacq/fsm_targets.h"

#include <unistd.h>

int facq_init(struct facq_data * dfacq){
    
    unsigned int rc;
    
    if(dfacq->disp){ TIMESTAMP printf("facq init\n"); fflush(stdout); }
    
    // find main hub
    rc = axi_read(dfacq->pBASE, 0, 0) & 0xFFFF;
    if(rc != IDs[connectbus]){
        if(dfacq->disp){TIMESTAMP printf("Can't find acq_ip_HUB; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), 0,rc,IDs[connectbus]); fflush(stdout);}
        return -1;
    }

    // find acq_ip regs
    dfacq->facq_module_offset[acq_ip_regs] = HUB_REGS;
    rc = axi_read(dfacq->pBASE, dfacq->facq_module_offset[acq_ip_regs], 0) & 0xFFFF;
    if(rc != IDs[acq_ip]){
        if(dfacq->disp){TIMESTAMP printf("Can't find acq_ip regs; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[acq_ip_regs],rc,IDs[acq_ip]); fflush(stdout);}
        return -1;
    }
    
    // find prestore
    dfacq->facq_module_offset[prestore_regs] = dfacq->facq_module_offset[acq_ip_regs] + ((axi_read(dfacq->pBASE, dfacq->facq_module_offset[acq_ip_regs], 0) & 0xFFFF0000) >> 16) + HUB_REGS;
    rc = axi_read(dfacq->pBASE, dfacq->facq_module_offset[prestore_regs], 0) & 0xFFFF;
    if(rc != IDs[acq_prestore]){
        if(dfacq->disp){TIMESTAMP printf("Can't find prestore regs; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[prestore_regs],rc,IDs[acq_prestore]); fflush(stdout);}
        return -1;
    }
    
    // find prestore dds_sin_cos
    dfacq->facq_module_offset[prestore_dds_sin_cos] = dfacq->facq_module_offset[prestore_regs] + ((axi_read(dfacq->pBASE, dfacq->facq_module_offset[prestore_regs], 0) & 0xFFFF0000) >> 16);
    rc = axi_read(dfacq->pBASE, dfacq->facq_module_offset[prestore_dds_sin_cos], 0) & 0xFFFF;
    if(rc != IDs[dds_sin_cos]){
        if(dfacq->disp){TIMESTAMP printf("Can't find prestore dds_sin_cos; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[prestore_dds_sin_cos],rc,IDs[dds_sin_cos]); fflush(stdout);}
        return -1;
    }
    
    // find prestore dds_bin
    dfacq->facq_module_offset[prestore_dds_bin] = dfacq->facq_module_offset[prestore_dds_sin_cos] + ((axi_read(dfacq->pBASE, dfacq->facq_module_offset[prestore_dds_sin_cos], 0) & 0xFFFF0000) >> 16);
    rc = axi_read(dfacq->pBASE, dfacq->facq_module_offset[prestore_dds_bin], 0) & 0xFFFF;
    if(rc != IDs[dds_bin]){
        if(dfacq->disp){TIMESTAMP printf("Can't find prestore dds_bin; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[prestore_dds_bin],rc,IDs[dds_bin]); fflush(stdout);}
        return -1;
    }
    
    // find base_bram_controller_regs
    dfacq->facq_module_offset[bram_controller_regs] = dfacq->facq_module_offset[prestore_dds_bin] + ((axi_read(dfacq->pBASE, dfacq->facq_module_offset[prestore_dds_bin], 0) & 0xFFFF0000) >> 16);
    rc = axi_read(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs], 0) & 0xFFFF;
    if(rc != IDs[acq_bram_controller]){
        if(dfacq->disp){TIMESTAMP printf("Can't find bram_controller_regs; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[bram_controller_regs],rc,IDs[acq_bram_controller]); fflush(stdout);}
        return -1;
    }


    // find base_facq_prn_ram_regs
    dfacq->facq_module_offset[facq_prn_ram_regs] = dfacq->facq_module_offset[bram_controller_regs] + ((axi_read(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs], 0) & 0xFFFF0000) >> 16);
    rc = axi_read(dfacq->pBASE, dfacq->facq_module_offset[facq_prn_ram_regs], 0) & 0xFFFF;
    if(rc != IDs[facq_prn_ram]){
        if(rc != IDs[max_args]){
            if(dfacq->disp){TIMESTAMP printf("Can't find facq_prn_ram_regs; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[facq_prn_ram_regs],rc,IDs[facq_prn_ram_regs]); fflush(stdout);}
            if(dfacq->disp){TIMESTAMP printf("Can't find max_args_regs;     addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[facq_prn_ram_regs],rc,IDs[facq_prn_ram_regs]); fflush(stdout);}
            return -1;
        } else{ // max_args
            dfacq->facq_module_offset[max_args_regs] = dfacq->facq_module_offset[facq_prn_ram_regs];
        }
    } else{
        // find base_max_args_regs
        dfacq->facq_module_offset[max_args_regs] = dfacq->facq_module_offset[facq_prn_ram_regs] + ((axi_read(dfacq->pBASE, dfacq->facq_module_offset[facq_prn_ram_regs], 0) & 0xFFFF0000) >> 16);
        rc = axi_read(dfacq->pBASE, dfacq->facq_module_offset[max_args_regs], 0) & 0xFFFF;
        if(rc != IDs[max_args]){
            if(dfacq->disp){TIMESTAMP printf("Can't find max_args_regs; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[max_args_regs],rc,IDs[max_args]); fflush(stdout);}
            return -1;
        }
    }
    
    // find base_fsm_controller_regs
    dfacq->facq_module_offset[fsm_controller_regs] = dfacq->facq_module_offset[max_args_regs] + ((axi_read(dfacq->pBASE, dfacq->facq_module_offset[max_args_regs], 0) & 0xFFFF0000) >> 16);
    rc = axi_read(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs], 0) & 0xFFFF;
    if(rc != IDs[fsm_acq_controller]){
        if(dfacq->disp){TIMESTAMP printf("Can't find fsm_controller_regs; addr = 0x%p + 0x%08X | read ID = 0x%08X | validID = 0x%08X\n", (void*)(dfacq->pBASE), dfacq->facq_module_offset[fsm_controller_regs],rc,IDs[fsm_acq_controller]); fflush(stdout);}
        return -1;
    }
    
    reset_fsm(dfacq);
    uint8_t target[10] = {FSM_WAIT_START, FSM_INIT, FSM_N_TAU_ZONE, FSM_LAST_PSP, FSM_INIT, FSM_WAIT_MAX, FSM_INIT, FSM_WAIT_START};
    set_fsm_target(dfacq, target);
    
    if(dfacq->disp){ TIMESTAMP printf("HW specification:\n"); fflush(stdout); }
    if(dfacq->disp){ TIMESTAMP printf("Core freq  = %f MHz\n",dfacq->core_freq/1.0e6); fflush(stdout); }
    dfacq->core_size  = axi_read(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_core_size_off, 0);
    dfacq->BRAM_depth = axi_read(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_ram_depth_off, 0);
    if(dfacq->disp){ TIMESTAMP printf("core_size  = %.0f\n",dfacq->core_size); fflush(stdout); }
    if(dfacq->disp){ TIMESTAMP printf("BRAM_depth = %.0f (in takts)\n",dfacq->BRAM_depth); fflush(stdout); }
    
    dfacq->facq_por_busy = 0;
    dfacq->acq_sync_en   = 0;
    
    if(testRegs(dfacq)) {
        return -1;
    }
    
    if(dfacq->disp){ TIMESTAMP printf("facq init done\n"); fflush(stdout); }
    if(dfacq->disp){ TIMESTAMP printf("------\n"); fflush(stdout); }
    
    dfacq->init_done = 1;
    return 0;
}

int facq_set_input(struct facq_data * dfacq){
    unsigned int value = 0;

    if((dfacq->input_Re > ((1<<INP_MUX_BITS_WIDTH)-1)) || (dfacq->input_Im > ((1<<INP_MUX_BITS_WIDTH)-1))){
        return -1;
    }

    value  = (dfacq->input_Re & ((1<<INP_MUX_BITS_WIDTH)-1))<<acq_ip_cfg_re_inp;
    value |= (dfacq->input_Im & ((1<<INP_MUX_BITS_WIDTH)-1))<<acq_ip_cfg_im_inp;
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[acq_ip_regs] + acq_ip_cfg, value);
    return 0;
}

int facq_ram_update(struct facq_data * dfacq){
    
    if(dfacq->init_done == 0)
        return -6;// init is not complete
    
    if(is_ram_complete(dfacq) == 0)
        return -2;// ram update is not complete

    if(dfacq->SignType >= SIGNAL_TYPES_SIZE)
        return -5;// non exist signal type

    if(dfacq->disp){ TIMESTAMP printf("ram update\n"); fflush(stdout); }fflush(stdout);

    prestore_set(dfacq);

    compute_params(dfacq);// пересчет kg,nkg,nf,df,ntau_zone,wr_depth

    if(dfacq->wr_depth > dfacq->BRAM_depth){
        if(dfacq->disp){TIMESTAMP printf("ERROR! SMALL MEMORY, use %.0f/%.0f\n",dfacq->wr_depth,dfacq->BRAM_depth); fflush(stdout);}
        return -4;// small memory
    }
    if((int)(dfacq->wr_depth) == 0){
        if(dfacq->disp){TIMESTAMP printf("try to write zero-length record\n"); fflush(stdout);}
        return -3;// wr_depth == 0
    }

    // запись выборки в память
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_wr_depth_off, dfacq->wr_depth);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_control_off,
    1                               << acq_bram_controller_control_wr_start       |
    (dfacq->acq_sync_en    & 0x1)   << acq_bram_controller_control_acq_sync_en    |
    (dfacq->acq_sync_epoch & 0x3FF) << acq_bram_controller_control_acq_sync_epoch
    ); // wr start and sync cfg
    if(dfacq->disp){ TIMESTAMP printf("use BRAM %.0f/%0.f\n",dfacq->wr_depth,dfacq->BRAM_depth); fflush(stdout); }

    return 0;
}

int facq_run(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("facq_run\n"); fflush(stdout); }
    double fprestore; //частота преднакопления
    
    if(dfacq->init_done == 0) {
        if(dfacq->disp){ TIMESTAMP printf("facq_run -> init is not complete\n"); fflush(stdout); }
        return -6;// init is not complete
    }
    
    if(is_ram_complete(dfacq) == 0) {
        if(dfacq->disp){ TIMESTAMP printf("facq_run -> ram update is not complete\n"); fflush(stdout); }
        return -2;// ram update is not complete
    }
    
    if(is_facq_complete(dfacq) == 0) {
        if(dfacq->disp){ TIMESTAMP printf("facq_run -> facq is not complete\n"); fflush(stdout); }
        return -3;// facq is not complete
    }
    
    compute_params(dfacq);
    fprestore = get_f_prestore(dfacq);
    
    unsigned int record_size  = axi_read(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_wr_depth_off, 0);// объем выборки в памяти
    unsigned int y_size = (unsigned int )(dfacq->core_size*dfacq->kg*dfacq->nkg);// required record length
    if(y_size > record_size){
        if(dfacq->disp){TIMESTAMP printf("You have: %u | you want: %u\n",record_size,y_size); fflush(stdout);}
        return -4;//bram record is too short, need to update
    }
    
    if(dfacq->time_sep) if (dfacq->nkg > dfacq->kg) {
      if(dfacq->disp){TIMESTAMP printf("ERROR! Non coherence accumulating is not supported for time separated signals\n"); fflush(stdout);}
      return -7;
    }
    
    // время[с], необходимое для поиска
    dfacq->need_time = (dfacq->kg*dfacq->nkg+1)*dfacq->ntau_zone*dfacq->nf*dfacq->core_size/dfacq->core_freq;
    if(dfacq->disp){ TIMESTAMP printf("Need %f ms real time to facq\n",dfacq->need_time*1000.0); fflush(stdout); }
    
    //configure freq_shifter
    int code_dds_df = (int)(pow(2,32)/fprestore*dfacq->df);// код частоты между каналами по частоте
    int code_dds_init_freq_shift = (int)((dfacq->nf-1)/2.0*code_dds_df);// код частоты первого канала поиска по частоте (крайний снизу)
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_freq_shift_code_step, code_dds_df);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_freq_shift_code_init, code_dds_init_freq_shift);
    if(dfacq->disp){ TIMESTAMP printf("code_step = 0x%08X\n",code_dds_df); fflush(stdout); }
    if(dfacq->disp){ TIMESTAMP printf("code_init = 0x%08X\n",code_dds_init_freq_shift); fflush(stdout); }
    
    // main part for acq
    if(psp_init(dfacq)) {
        if(dfacq->disp){ TIMESTAMP printf("facq_run -> non valid signal type\n"); fflush(stdout); }
        return -5;//non valid signal type
    }
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_kg_nkg_off, ((int)dfacq->kg << 16) | (int)dfacq->nkg);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_ntau_nf_off,     ((int)dfacq->ntau_zone << 16) | (int)dfacq->nf );
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_time_separation,  (int)dfacq->time_sep);
    // acq start
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_bram_rd_depth_off, dfacq->core_size*dfacq->kg*dfacq->nkg);// set bram size rd
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, (1<<fsm_acq_controller_conf_acq_start));// bram start    
    return 0;
}

int facq_result(struct facq_data * dfacq){
    const double _2e32 = 4294967296.0;

    double R_low;
    double R_high;
    double res_tau_lim;
    
    if(dfacq->init_done == 0)
        return -6;// init is not complete
    
    if(is_ram_complete(dfacq) == 0) {
        if(dfacq->disp){ TIMESTAMP printf("facq_result -> ram update is not complete\n"); fflush(stdout); }
        return -2;// ram update is not complete
    }
    
    if(is_facq_complete(dfacq) == 0) {
//        if(dfacq->disp){ TIMESTAMP printf("facq_result -> facq is not complete\n"); fflush(stdout); }
        return -3;// facq is not complete
    }

    R_low  = axi_read(dfacq->pBASE, dfacq->facq_module_offset[max_args_regs] + max_args_rlow_off, 0);
    R_high = axi_read(dfacq->pBASE, dfacq->facq_module_offset[max_args_regs] + max_args_rhigh_off, 0);

    dfacq->res_R   = R_high*_2e32 + R_low;
    dfacq->res_tau = axi_read(dfacq->pBASE, dfacq->facq_module_offset[max_args_regs] + max_args_tau_off,  0);
    
    // Коррекция для сигналов с временным разделением
      // интервал поиска ограничен периодом сигнала (для сигнала с временным разделением поиск идет на плюс одну зону больше).
      res_tau_lim = dfacq->core_size * (dfacq->ntau_zone - 1);
      // корректируем значение в пределах периода сигнала
      if (dfacq->time_sep) if (dfacq->res_tau > res_tau_lim) dfacq->res_tau = 2*res_tau_lim - dfacq->res_tau;
    
    dfacq->res_freq = ((((axi_read(dfacq->pBASE, dfacq->facq_module_offset[max_args_regs] + max_args_freq_off, 0)) \
                    & 0xFFFF) \
                    - (dfacq->nf-1)/2) \
                    * dfacq->df);
    if(dfacq->disp){
        TIMESTAMP printf("facq result done\n");
        TIMESTAMP printf("res_R    = %.0f\n",dfacq->res_R);
        TIMESTAMP printf("res_tau  = %f\n",dfacq->res_tau);
        TIMESTAMP printf("res_freq = %f\n",dfacq->res_freq);
    }
    return 0;// all done
}

int por_calibrate(struct facq_data * dfacq){
    const unsigned int N_exp = 10;// число экспериментов обнаружения
    
    if(dfacq->init_done == 0)
        return -6;// init is not complete
    
    if(dfacq->facq_por_busy == 0){// первый вызов калибровки, буфферизируем параметры поиска
        dfacq->buf_reset_por_en = dfacq->reset_por_en;// запомнили состояние флага разрешения сброса квантователя
        dfacq->buf_freq_acq     = dfacq->freq_acq;// запомнили диапазон поиска по частоте
        dfacq->buf_N_sat        = dfacq->N_sat;// запомнили номер спутника/литеру
        dfacq->buf_fi           = dfacq->fi;// запомнили промежуточную частоту
        //----
        
        dfacq->reset_por_en = 1;             // перед расчетом порога перекалибруем квантователь
        dfacq->freq_acq     = 0;// не ищем по частоте
        dfacq->N_sat        = 0;             // для частотного разделения работаем по центральной литере
        dfacq->fi           = dfacq->buf_fi + 100e3;// внесли доплер для калибровки (имитация отсутствия сигнала)
        
        dfacq->facq_por_busy = 1;// блок занят, пока не будет найден порог
        dfacq->facq_por_recent_record = 0;// необходимо обновить выборку
        dfacq->facq_por_i = 0;// сбросили счетчик итераций поиска
        dfacq->facq_por = 0;

        compute_params(dfacq);// рассчитали все параметры
    }
    
    
    if(is_ram_complete(dfacq)){
        if(dfacq->facq_por_recent_record){// выборка свежая
            if(is_facq_complete(dfacq)){
                if(dfacq->facq_por_i != 0){
                    if(facq_result(dfacq))// чтение корр.максимума
                        return -2;// надо смореть причину выхода; проблемный выход
                    dfacq->facq_por = fmax(dfacq->facq_por,dfacq->res_R*1.3);
                }
                if(dfacq->facq_por_i == N_exp){
                    dfacq->facq_por_busy = 0;// блок завершил работу
                }
                else{
                    dfacq->facq_por_i ++;// показывает порядковое число запущенных поисков
                    if(facq_run(dfacq) < 0)// запустили поиск
                        return -2;// надо смореть причину выхода; проблемный выход
                    dfacq->facq_por_recent_record = 0;// необходимо далее обновить выборку
                }
            }
            else
                return -1;// поиск еще не завершен; рабочий режим
        }
        else{// выборку требуется обновить
            if(facq_ram_update(dfacq))// обновили выборку в памяти
                return -2;// надо смореть причину выхода; проблемный выход
            dfacq->facq_por_recent_record = 1;
            dfacq->reset_por_en = 0;// далее не сбрасываем квантователь преднакопителя
        }
    }
    else
        return -1;// запись еще не завершена; рабочий режим
    
    
    if(dfacq->facq_por_busy == 0){// восстановление параметров поиска
        dfacq->reset_por_en = dfacq->buf_reset_por_en;// восстановили состояние флага сброса квантователя
        dfacq->freq_acq           = dfacq->buf_freq_acq; // восстановили диапазон поиска по частоте
        dfacq->N_sat        = dfacq->buf_N_sat;       // восстановили номер спутника/литеру
        dfacq->fi           = dfacq->buf_fi;          // восстановили промежуточную частоту
    }
    //----
    
    return 0;// расчет порога завершен
}

int facq_reset(struct facq_data * dfacq){
    
    if(dfacq->init_done == 0)
        return -6;// init is not complete
    
    if(dfacq->disp){ TIMESTAMP printf("facq_reset\n"); fflush(stdout); }
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, (1<<fsm_acq_controller_conf_acq_global_resetn));// acq reset
    
    return 0;
}

int check_state(struct facq_data * dfacq){
    
    if(dfacq->init_done == 0)
        return -6;// init is not complete
    
    dfacq->fsm_state = (axi_read(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 0)
        & (0x7<<fsm_acq_controller_conf_state))>>fsm_acq_controller_conf_state;
    dfacq->kg_cntr   = (axi_read(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_kg_nkg_cntr, 0) & 0xFFFF0000)>>16;
    dfacq->nkg_cntr  = (axi_read(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_kg_nkg_cntr, 0) & 0xFFFF);
    dfacq->nf_cntr   = (axi_read(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_nf_ntau_cntr, 0) & 0xFFFF0000)>>16;
    dfacq->ntau_cntr = (axi_read(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_nf_ntau_cntr, 0) & 0xFFFF);
    
    return 0;
}
