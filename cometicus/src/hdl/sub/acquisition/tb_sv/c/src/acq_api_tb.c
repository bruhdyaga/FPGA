#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
// #include "ID_DB.h"
#include "acq_api_tb.h"
#include "libfacq/libfacq/axi_rw.h"

// #include "libfacq/libfacq/acq_api.h"
#include "libfacq/libfacq/facq.h"
#include "libfacq/libfacq/signal_types.h"
#include "libfacq/libfacq/fsm.h"

#define RE_IN 0
#define IM_IN 1
// #define IM_IN 0


void start_record(volatile unsigned int * base, int off_acq_tb_regs_base, int start);


int C_cpu_sim() {
    
    
    volatile unsigned int* pBASE = BASE_ADDR;
    int off_acq_tb_regs_base;
    unsigned int rc;
    
    TIMESTAMP printf("Hello from cpu_sim!\n");
    
    unsigned int i_facq;
    int sleep_time;
    i_facq = 0;
    
    struct facq_data dfacq_malloc;
    struct facq_data * dfacq = &dfacq_malloc;
    
    off_acq_tb_regs_base = HUB_REGS;
    rc = axi_read(pBASE, off_acq_tb_regs_base, 0);
    TIMESTAMP printf("tb ID read = 0x%08X\n",rc);
    rc = axi_read(pBASE, off_acq_tb_regs_base + 1, 0);
    TIMESTAMP printf("tb size_reg = 0x%08X\n",rc);
    TIMESTAMP printf("tb offset = 0x%08X\n",(axi_read(pBASE, off_acq_tb_regs_base + 1, 0) & 0xFFFF0000)>>16);
    // int off_acq_base = off_acq_tb_regs_base + ((axi_read(pBASE, off_acq_tb_regs_base + 1, 0) & 0xFFFF0000)>>16);
    // TIMESTAMP printf("off_acq_base = d'%d\n",off_acq_base);
    dfacq->pBASE = pBASE + /* off_acq_base */(HUB_REGS + 1)*2;
    
    if(facq_init(dfacq)){
        TIMESTAMP printf("Init problem\n");fflush(stdout);
        return -1;
    }
    
/*
//
// GLN_L1_OF
//
  dfacq->SignType   = GLN_L1_OF;
  dfacq->N_sat      = 0;
  dfacq->fi         = 10.000e6;
  dfacq->kg_ms      = 1;   // когерентное время накопления в мс
  dfacq->nkg        = 2;
  dfacq->tau_acq_ms = 1;   // диапазон поиска по задержке в мс
  dfacq->time_sep   = 0;   // разделение времени не когерентного приема на слоты для ПСП с временным разделением
/**/

/*
//
// GPS_L1_CA
//
  dfacq->SignType   = GPS_L1_CA;
  dfacq->N_sat      = 0;
  dfacq->fi         = 10.000e6;
  dfacq->kg_ms      = 1;   // когерентное время накопления в мс
  dfacq->nkg        = 1;
  dfacq->tau_acq_ms = 1;   // диапазон поиска по задержке в мс
  dfacq->time_sep   = 0;   // разделение времени не когерентного приема на слоты для ПСП с временным разделением
/**/

/*
//
// LOC_L2O
//
  dfacq->SignType   = LCT_ISM; // LOC_L2O;
  dfacq->N_sat      = 0;
  dfacq->fi         = 0;
  dfacq->kg_ms      = 0.1;  // когерентное время накопления в мс
  dfacq->nkg        = 1;    // 1
  dfacq->tau_acq_ms = 0.1;  // диапазон поиска по задержке в мс // 10
  dfacq->time_sep   = 0;    // разделение времени не когерентного приема на слоты для ПСП с временным разделением
/**/

/**/
//
// GLN_L1_OF modify   GLN_L1_OF: T=1ms, S=0.511 Mbit/s, L=511,
//                    GLN_L3OC:  T=1ms, S=10.23 Mbit/s, L=10230,
//                    LOC_L2O:   T=1ms, S=10.23 Mbit/s, L=10230,
//                    LCT_ISM:   T=1ms, S=10.23 Mbit/s, L=1023,
//
  // acq_api_tb.sv, line 25: N_record = ...
  dfacq->SignType   = LCT_ISM;
  dfacq->N_sat      = 0;
  dfacq->fi         = 0;
  dfacq->kg_ms      = 0.1; // когерентное время накопления в мс    // = 0.1
  dfacq->nkg        = 1; // количество неконкретных накоплений   // = 1
  dfacq->tau_acq_ms = 0.3; // диапазон поиска по задержке в мс     // = 0.3
  dfacq->time_sep   = 1; // разделение времени не когерентного приема на слоты для ПСП с временным разделением
/**/
    
    dfacq->fd        = 100e6;
    dfacq->core_freq = 100e6;

    dfacq->acq_sync_en    = 0;
    dfacq->acq_sync_epoch = 0;
    dfacq->ram_en         = 0;

    dfacq->freq_acq = 0*1e3;// диапазон поиска по частоте в каждую сторону в Гц
    
    dfacq->disp = 1;
    // dfacq->manual_por_en = 1;
    // dfacq->manual_por = 8190;
    dfacq->reset_por_en = 0;
    int need_ram_update = 1;
    // dfacq->ram_en = 1;
    // dfacq->ram_len = 1023-1;
    
/*         // dfacq->SignType = GAL_E1B;
        dfacq->SignType = GAL_E5A;
        // dfacq->N_sat = (int) sgn.getSatNum()-1;
        // dfacq->fi = fe->wi/2/pi + 1.023e6;
        dfacq->ram_en = 1;
        dfacq->ram_len = 4092-1;
        // dfacq->tau_acq_ms = 4;// диапазон поиска по задержке в мс
        dfacq->kg_ms = 2; */
    
    int N_record = axi_read(pBASE, off_acq_tb_regs_base + acq_ip_tb_n_record, 0);
    
    
    unsigned int i;
    // for(i=0;i<20;i++){
        // TIMESTAMP printf("%d : 0x%08X\n",i,axi_read(pBASE, i, 0));
    // }
    
    // return 0;
    // int N_record = 0;


//
// RAM initialization. GpsL1CA initialization for verification.
//
  dfacq->ram_en  = 0; // set to 0 keep run prn_gen and prn_ram simultaneously
  dfacq->ram_len = 1023 - 1;
  set_ram_cfg(dfacq->ram_en, 1, dfacq->ram_len, dfacq);
  uint32_t GpsL1CA_prn[32] = {
    0xC83949E5, 0x13EAD115, 0x591E9FB7, 0x37CAA100,
    0xEA44DE0F, 0x5CCF602F, 0x3EA62DC6, 0xF5158201,
    0x031D81C6, 0xFFA74B61, 0x56272DD8, 0xEEF0D864,
    0x906D2DE2, 0xE0527E0A, 0xB9F5F331, 0xC6D56C6E,
    0xE002CD9D, 0xA0ABAE94, 0x7389452D, 0x0ADAD8E7,
    0xB21F9688, 0x7D5CC925, 0xFF87DE37, 0x2C3950A5,
    0x7E3DA767, 0xEFA31F01, 0x28B444D8, 0x1DA3448E,
    0x2CC9E6FC, 0xCA69AF36, 0xA778D442, 0x24E1CA21};
  
  for(i = 0; i < 32; i ++){
    set_ram_word(GpsL1CA_prn[i], dfacq);
  }
    
/*
    set_ram_cfg(dfacq->ram_en, 1, dfacq->ram_len, dfacq);
    if(dfacq->ram_en){
        uint32_t GpsL1CA_prn[32] = {
        0xC83949E5, 0x13EAD115, 0x591E9FB7, 0x37CAA100,
        0xEA44DE0F, 0x5CCF602F, 0x3EA62DC6, 0xF5158201,
        0x031D81C6, 0xFFA74B61, 0x56272DD8, 0xEEF0D864,
        0x906D2DE2, 0xE0527E0A, 0xB9F5F331, 0xC6D56C6E,
        0xE002CD9D, 0xA0ABAE94, 0x7389452D, 0x0ADAD8E7,
        0xB21F9688, 0x7D5CC925, 0xFF87DE37, 0x2C3950A5,
        0x7E3DA767, 0xEFA31F01, 0x28B444D8, 0x1DA3448E,
        0x2CC9E6FC, 0xCA69AF36, 0xA778D442, 0x24E1CA20};

        uint32_t  E1B_prn[128] = {
        0xF5D71013, 0x0573541B, 0x9DBD4FD9, 0xE9B20A0D,
        0x59D144C5, 0x4BC79355, 0x39D2E758, 0x10FB51E4,
        0x94093A0A, 0x19DD79C7, 0x0C5A98E5, 0x657AA578,
        0x097777E8, 0x6BCC4651, 0xCC72F2F9, 0x74DC766E,
        0x07AEA3D0, 0xB557EF42, 0xFF57E6A5, 0x8E805358,
        0xCE925766, 0x9133B18F, 0x80FDBDFB, 0x38C5524C,
        0x7FB1DE07, 0x98424829, 0x90DF58F7, 0x2321D920,
        0x1F8979EA, 0xB159B267, 0x9C9E95AA, 0x6D53456C,
        0x0DF75C2B, 0x4316D1E2, 0x30921688, 0x2854253A,
        0x1FA60CA2, 0xC94ECE01, 0x3E2A8C94, 0x3341E7D9,
        0xE5A8464B, 0x3AD407E0, 0xAE465C3E, 0x3DD1BE60,
        0xA8C3D50F, 0x83153640, 0x1E776BE0, 0x2A6042FC,
        0x4A27AF65, 0x3F0CFC4D, 0x4D013F11, 0x5310788D,
        0x68CAEAD3, 0xECCCC533, 0x0587EB3C, 0x22A1459F,
        0xC8E6FCCE, 0x9CDE849A, 0x5205E70C, 0x6D66D125,
        0x814D698D, 0xD0EEBFEA, 0xE52CC65C, 0x5C84EEDF,
        0x20737900, 0x0E169D31, 0x8426516A, 0xC5D1C31F,
        0x2E18A65E, 0x07AE6E33, 0xFDD724B1, 0x3098B3A4,
        0x44688389, 0xEFBBB5EE, 0xAB588742, 0xBB083B67,
        0x9D42FB26, 0xFF77919E, 0xAB21DE03, 0x89D99974,
        0x98F967AE, 0x05AF0F4C, 0x7E177416, 0xE18C4D5E,
        0x6987ED35, 0x90690AD1, 0x27D872F1, 0x4A8F4903,
        0xA1232973, 0x2A9768F8, 0x2F295BEE, 0x39187929,
        0x3E3A97D5, 0x1435A7F0, 0x3ED7FBE2, 0x75F102A8,
        0x3202DC3D, 0xE94AF4C7, 0x12E9D006, 0xD182693E,
        0x9632933E, 0x6EB77388, 0x0CF147B9, 0x22E74539,
        0xE4582F79, 0xE39723B4, 0xC80E42ED, 0xCE4C08A8,
        0xD02221BA, 0xE6D17734, 0x817D5B53, 0x1C0D3C1A,
        0xE723911F, 0x3FFF6AAC, 0x02E97FEA, 0x69E376AF,
        0x4761E645, 0x1CA61FDB, 0x2F918764, 0x2EFCD63A,
        0x09AAB680, 0x770C1593, 0xEEDD4FF4, 0x293BFFD6,
        0xDD2C3367, 0xE85B14A6, 0x54C834B6, 0x699421A0};
        for(i = 0; i < 128; i ++){
            set_ram_word(E1B_prn[i], dfacq);
        }
        // for(i = 0; i < 32; i ++){
            // set_ram_word(GpsL1CA_prn[i], dfacq);
        // }
    }
*/    
    //настраиваем входы поиска
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[acq_ip_regs] + acq_ip_cfg, (RE_IN<<acq_ip_cfg_re_inp) | (IM_IN<<acq_ip_cfg_im_inp));
    
    // int i;
    TIMESTAMP printf("adresa:\n");fflush(stdout);usleep(1000);
    for(i = 0; i <= fsm_controller_regs; i++){
        TIMESTAMP printf("facq_module_offset[%d] = 0x%08X\n",i,BASE_ADDR + dfacq->facq_module_offset[i]*4);fflush(stdout);usleep(1000);
    }
    
    // TIMESTAMP printf("wr_depth = %f\n",dfacq->wr_depth);fflush(stdout);
    // TIMESTAMP printf("wr to ram %.2f ms\n",dfacq->wr_depth/dfacq->fprestore*1000.0);fflush(stdout);
    
    // TIMESTAMP printf("unceil %f ms\n",dfacq->kg*dfacq->nkg*dfacq->core_size/dfacq->fprestore*1000.0);fflush(stdout);
    
    // TIMESTAMP printf("wr to ram %.0f ms\n",dfacq->wr_length_ms);fflush(stdout);
    
    TIMESTAMP printf("Mode: continuous facq\n");fflush(stdout);
    
    TIMESTAMP printf("N_record = %d\n",N_record);
    start_record(pBASE, off_acq_tb_regs_base, 1);// запустили тестовую запись
    
    i = 0;
    while(1){
        if(need_ram_update){
            switch(facq_ram_update(dfacq)){
                case -2:
                    TIMESTAMP printf("ram update is not complete\n");fflush(stdout);
                    return -1;
                break;
                case -3:
                    TIMESTAMP printf("wr_depth == 0\n");fflush(stdout);
                    return -1;
                break;
                case -4:
                    TIMESTAMP printf("small memory\n");fflush(stdout);
                    return -1;
                break;
                case -5:
                    TIMESTAMP printf("non exist signal type\n");fflush(stdout);
                    return -1;
                break;
                case 0:
                    if(dfacq->disp){ TIMESTAMP printf("ram update successfully started\n");fflush(stdout);}
                break;
                default:
                    TIMESTAMP printf("Unknown error\n");fflush(stdout);
                    return -1;
                break;
            }
            dfacq->disp = 0;
            waitClks(200);
            while(facq_result(dfacq)){
                usleep(1e3);
                waitClks(200);
            }
            dfacq->disp = 1;
        }
        need_ram_update = 0;
        // dfacq->disp = 0;
        
        TIMESTAMP printf("ram update successfully complete\n");fflush(stdout);
        
        switch(facq_run(dfacq)){
            case -2:
                TIMESTAMP printf("ram update is not complete\n");fflush(stdout);
                return -1;
            break;
            case -3:
                TIMESTAMP printf("facq is not complete\n");fflush(stdout);
                return -1;
            break;
            case -4:
                TIMESTAMP printf("bram record is too short, need to update\n");fflush(stdout);
                return -1;
            break;
            case -5:
                TIMESTAMP printf("non valid signal type\n");fflush(stdout);
                return -1;
            break;
            case 0:
                TIMESTAMP printf("time to facq: %gms\n",dfacq->need_time*1000.0);fflush(stdout);
                if(dfacq->disp){ TIMESTAMP printf("successfully run\n");fflush(stdout);}
            break;
            default:
                TIMESTAMP printf("unknown error\n");fflush(stdout);
            break;
        }
        
        dfacq->disp = 0;
        waitClks(200);
        while(facq_result(dfacq)){
            usleep(1e3);
            waitClks(200);
        }
        dfacq->disp = 1;
        i++;
        
        TIMESTAMP printf("%4u | tau = %6.0f | freq = %4.0f | R = %.0f\n",i_facq,dfacq->res_tau,dfacq->res_freq,dfacq->res_R);fflush(stdout);
        TIMESTAMP printf("res_freq = %d\n",axi_read(dfacq->pBASE, dfacq->facq_module_offset[max_args_regs] + max_args_freq_off, 0));fflush(stdout);
        
        i_facq ++;
        start_record(pBASE, off_acq_tb_regs_base, 0);// остановили тестовую запись
        start_record(pBASE, off_acq_tb_regs_base, 1);// запустили тестовую запись
        
        // sleep_time = rand() % 1000;
        // usleep(sleep_time*1000);
        // TIMESTAMP printf("sleep on %u ms\n",sleep_time);
        
        // if(i == 2)
            // return 0;// debug
    }
    
    TIMESTAMP printf("EXIT good\n");fflush(stdout);
    return 0;
}


void start_record(volatile unsigned int * base, int off_acq_tb_regs_base, int start){
    axi_write(base, off_acq_tb_regs_base + acq_ip_tb_n_control, start<<acq_ip_tb_control_record_start); // record start
}
