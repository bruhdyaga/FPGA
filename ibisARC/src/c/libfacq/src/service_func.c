#include "libfacq/service_func.h"

double get_f_prestore(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("get_f_prestore\n"); fflush(stdout); }
    // функция возвращает частоту[Гц] преднакопления в зависимости от типа сигнала
    switch(dfacq->SignType){
    case GPS_L1_CA:
        return 2.046e6;// шаг 1/2 чипа
        break;
    case GLN_L1_OF:
        return 1.022e6;// шаг 1/2 чипа
        break;
    case GLN_L2_OF:
        return 1.022e6;// шаг 1/2 чипа
        break;
    case GLN_L1_SF:
        return 10.22e6;// шаг 1/2 чипа
        break;
    case GLN_L2_SF:
        return 10.22e6;// шаг 1/2 чипа
        break;
    case GPS_L2C:
        return 2.046e6;// шаг 1/4 чипа
        break;
    case GPS_L2CL:
        return 1.023e6;// шаг 1/2 чипа
        break;
    case GPS_L2CM:
        return 1.023e6;// шаг 1/2 чипа
        break;
    case GLN_L1OC:
        return 2.046e6;// шаг 1/4 чипа
        break;
    case GLN_L2OC: //SSB
        return 2.046e6;// шаг 1/4 чипа
        break;
    case GLN_L3OC:
        return 20.46e6;// шаг 1/2 чипа
        break;
    case BDS_B1I:
        return 4.092e6; // шаг 1/2 чипа
        break;
    case SBS_SDCM:
        return 2.046e6;// шаг 1/2 чипа
        break;
    case GPS_L5:
        return 20.46e6;// шаг 1/2 чипа
        break;
    case GAL_E1B:
        return 2.046e6; // шаг 1/2 чипа
        break;
    case GAL_E5A: case GAL_E5B:
        return 20.46e6; // шаг 1/2 чипа
        break;
    case LCT_ISM:
        return 20.46e6;// шаг 1/2 чипа
        break;
    case LOC_L2O: case LOC_L5O:
        return 20.46e6;// шаг 1/2 чипа
        break;
    default:
        return -1;// undefined type of signal
        break;
    }
}

int psp_init(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("psp_init, SignType=%u\n", dfacq->SignType); fflush(stdout); }
    switch(dfacq->SignType){
    case GPS_L1_CA:
        if (dfacq->ram_en) {
            return gps_l1_ca_ram(dfacq);
        } else {
            return gps_l1_ca(dfacq);
        };
        break;
    case GLN_L1_OF:
        return gln_of(dfacq);
        break;
    case GLN_L2_OF:
        return gln_of(dfacq);
        break;
    case GLN_L1_SF:
        return gln_sf(dfacq);
        break;
    case GLN_L2_SF:
        return gln_sf(dfacq);
        break;
    case GPS_L2C:
        return gps_l2_cm(dfacq,4);//поиск по CM компоненте
        break;
    case GPS_L2CL:
        return gps_l2_cl(dfacq);//поиск по CL компоненте
        break;
    case GPS_L2CM:
        return gps_l2_cm(dfacq,2);//поиск по CM компоненте
        break;
    case GLN_L1OC:
        return gln_l1oc_d(dfacq,4);// поиск по дата-компоненте
        break;
    case GLN_L2OC:
        return gln_l2oc_p(dfacq,4);// поиск по пилот-компоненте
        break;
    case GLN_L3OC:
        //            return gln_l3oc_p(dfacq);
        return gln_l3oc_d(dfacq, 2);
        break;
    case BDS_B1I:
        return bds_BxI(dfacq);
        break;
    case SBS_SDCM:
        return sbs_sdcm(dfacq);
        break;
    case GPS_L5:
        //            return gps_l5_p(dfacq);
        return gps_l5_d(dfacq, 2);
        break;
    case GAL_E1B:
        return gal_E1B(dfacq);
        break;
    case GAL_E5A:
        return gal_E5a(dfacq);
        break;
    case GAL_E5B:
        return gal_E5b(dfacq);
        break;
    case LCT_ISM:
        return lct_ism(dfacq);
        break;
    case LOC_L2O:
        return loc_l2o(dfacq);
        break;
    default:
        return -2;//non exist signal type
        break;
    }
}

void prestore_set(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("prestore_set\n");fflush(stdout);}
    
    unsigned int k;
    double prestore_fi; //рабочая частота опорного сигнала в преднакопителе
    double fprestore; //частота преднакопления
    
    fprestore = get_f_prestore(dfacq);
    
    switch(dfacq->SignType){
        case GLN_L1_OF:
            prestore_fi = dfacq->fi + 562.5e3*dfacq->N_sat;
        break;
        case GLN_L2_OF:
            prestore_fi = dfacq->fi + 437.5e3*dfacq->N_sat;
        break;
        case GLN_L1_SF:
            prestore_fi = dfacq->fi + 562.5e3*dfacq->N_sat;
        break;
        case GLN_L2_SF:
            prestore_fi = dfacq->fi + 437.5e3*dfacq->N_sat;
        break;
        default:
            prestore_fi = dfacq->fi;
        break;
    }

    if(dfacq->disp){ TIMESTAMP printf("fi    = %f Hz\n",prestore_fi);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("f_pre = %f Hz\n",fprestore);fflush(stdout);}
    
    //reset sigmag por // set fi positive/negative // set manual por
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[prestore_regs] + prestore_conf_off,
        dfacq->reset_por_en << prestore_conf_reset_sigmag
    );//я перетираю весь конф. регистр// исправить

    // ВАЖНО вначале настраивать DDS_prestore, затем DDS_sin_cos!
    //set dds freq prestore
    k = (unsigned int)(pow(2,32)/dfacq->fd*fprestore/2.0);
    if(dfacq->disp){ TIMESTAMP printf("dds freq prestore | k = %u\n",k);fflush(stdout);}
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[prestore_dds_bin] + dds_bin_code_freq_off, k);
    //set dds freq sin/cos
    if (prestore_fi > 0) {
        k = (unsigned int)(pow(2,32)/dfacq->fd*fabs(prestore_fi));
    } else {
        k = (unsigned int)(pow(2,32) - pow(2,32)/dfacq->fd*fabs(prestore_fi));
    }

    if(dfacq->disp){ TIMESTAMP printf("dds freq sin/cos | k = %u\n",k);fflush(stdout);}
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[prestore_dds_sin_cos] + dds_sin_cos_code_freq_off, k);// set code freq
}

void compute_params(struct facq_data * dfacq){
    double fprestore; //частота преднакопления
    double tau_acq_ms;
    
    fprestore = get_f_prestore(dfacq);
    
    if(dfacq->disp){ TIMESTAMP printf("compute_params\n");fflush(stdout);}
    tau_acq_ms = dfacq->tau_acq_ms;
    dfacq->kg = round((dfacq->kg_ms/1000.0*fprestore) / dfacq->core_size);// количество когерентных накоплений ядер
    dfacq->kg = fmax(1,dfacq->kg);
    dfacq->ntau_zone = round(tau_acq_ms/1000.0*fprestore/dfacq->core_size);// количество зон поиска в размерах ядра
    if (dfacq->time_sep) dfacq->ntau_zone = 1*(dfacq->ntau_zone + 1); // + одна зона поиска на случай начала выборки в середине искомого сигнала
    dfacq->ntau_zone = fmax(1,dfacq->ntau_zone);
    dfacq->df = fprestore/(dfacq->core_size*dfacq->kg);
    dfacq->nf = round(dfacq->freq_acq/dfacq->df)*2+1;// полное количество частотных каналов в обе стороны
    if(dfacq->time_sep) // при временном разделении сигнала ищем сигнал в выборке: время всех слотов + время 1 слота (на случай, если искомый сигнал не оказался в выборке полностью)
      dfacq->wr_depth = ceil(dfacq->kg*dfacq->nkg*dfacq->core_size * ((dfacq->tau_acq_ms+dfacq->kg_ms)/dfacq->kg_ms));// расчет длины выборки по величинам kg;nkg (дробных долях ms)
    else
      dfacq->wr_depth = ceil(dfacq->kg*dfacq->nkg*dfacq->core_size);// расчет длины выборки по величинам kg;nkg

    dfacq->kg_ms_actual      =  dfacq->kg*dfacq->core_size/fprestore*1000.0; // реальное время когерентного накопления в мс
    dfacq->tau_acq_ms_actual =  dfacq->ntau_zone*dfacq->core_size/fprestore*1000.0; // реальное диапазон поиска по задержке в мс
    dfacq->freq_acq_actual   = (dfacq->nf-1)/2.0*dfacq->df; // реальный диапазон поиска по частоте в Гц
    
    if(dfacq->disp){ TIMESTAMP printf("freq_prestore     = %f Hz\n",fprestore);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("KG_ms (set)       = %f ms\n",dfacq->kg_ms);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("KG_ms (actual)    = %f ms\n",dfacq->kg_ms_actual);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("tau acq (set)     = %f ms\n",dfacq->tau_acq_ms);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("tau acq (actual)  = %f ms\n",dfacq->tau_acq_ms_actual);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("freq acq (set)    = +/-%.0f Hz\n",dfacq->freq_acq);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("freq acq (actual) = +/-%.0f Hz\n",dfacq->freq_acq_actual);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("freq resolution   = %.0f Hz\n",dfacq->df);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("KG        = %.0f\n",dfacq->kg);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("NKG       = %.0f\n",dfacq->nkg);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("ntau_zone = %.0f\n",dfacq->ntau_zone);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("NF        = %.0f\n",dfacq->nf);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("wr_depth  = %.0f\n",dfacq->wr_depth);fflush(stdout);}
    if(dfacq->disp){ TIMESTAMP printf("\n");fflush(stdout);}
}

int is_ram_complete(struct facq_data * dfacq){
    waitClks(100);//delay for level sync and sygnal sync
    if(axi_read(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_control_off, 0) & (1<<acq_bram_controller_control_wr_done))
        return 1;
    else
        return 0;
}

int is_facq_complete(struct facq_data * dfacq){
    waitClks(4);//delay for level sync
    if(axi_read(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 0) & 1<<fsm_acq_controller_conf_acq_done)
        return 1;
    else
        return 0;
}

int testRegs(struct facq_data * dfacq){
    unsigned int i;
    unsigned int cntrData = 0xFFFFFFFF;
    unsigned int rc1;
    const unsigned int N_test = 100;
    if(dfacq->disp){ TIMESTAMP printf("tesetRegs\n");fflush(stdout);}

    for(i=0;i<N_test;i++) {
        axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_wr_depth_off, cntrData-13*i);
        waitClks(100);//delay for level sync and sygnal sync
        rc1 = axi_read(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_wr_depth_off, 0);
        if(rc1 != cntrData-13*i){
            TIMESTAMP printf("tesetRegs ERROR iter = %d/%d\n",i,N_test);fflush(stdout);
            return -1;
        }
    }

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_wr_depth_off, 0);
    if(dfacq->disp){ TIMESTAMP printf("tesetRegs done\n");fflush(stdout);}
    return 0;

}

int8_t wr_data_2_bram(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("wr_data_2_bram START\n");fflush(stdout);}
    uint32_t bram_control_reg;
    uint32_t i, len;
    uint8_t data;
    
    len = 30;
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_wr_depth_off, len);
    
    // if(dfacq->disp){ TIMESTAMP printf("0 bram_control_reg = 0x%08X\n", bram_control_reg);fflush(stdout);}
    bram_control_reg = 1 << acq_bram_controller_control_fifo_wr_en; // переключили мультиплексор на шину процессора
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_control_off, bram_control_reg);
    waitClks(5); // снятие сигналов valid с фронтенда
    
    // if(dfacq->disp){ TIMESTAMP printf("0 bram_control_reg = 0x%08X\n", bram_control_reg);fflush(stdout);}
    bram_control_reg |= 1 << acq_bram_controller_control_wr_start; // контроллер памяти ждет данные
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_control_off, bram_control_reg);
    waitClks(20); // пройдет синхронизация старта в домер фронтенда
    
    // if(dfacq->disp){ TIMESTAMP printf("0 bram_control_reg = 0x%08X\n", bram_control_reg);fflush(stdout);}
    bram_control_reg &= ~(1 << acq_bram_controller_control_wr_start); // сняли сигнал на старт
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_control_off, bram_control_reg);
    
    for(i = 0; i < len; i ++){
        data = i;
        // if(dfacq->disp){ TIMESTAMP printf("wr[%d] = 0x%04X\n", i, data);fflush(stdout);}
        // if(dfacq->disp){ TIMESTAMP printf("0 bram_control_reg = 0x%08X\n", bram_control_reg);fflush(stdout);}
        bram_control_reg &= ~(0xF << acq_bram_controller_control_fifo_data);
        bram_control_reg |= ((data & 0xF) << acq_bram_controller_control_fifo_data) | (1 << acq_bram_controller_control_fifo_wr);
        axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_control_off, bram_control_reg);
        waitClks(20); // пройдет синхронизация старта в домер фронтенда
    }
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_control_off, 0);
    
    // if(dfacq->disp){ TIMESTAMP printf("wr_data_2_bram END\n");fflush(stdout);}
    return 0;
}
