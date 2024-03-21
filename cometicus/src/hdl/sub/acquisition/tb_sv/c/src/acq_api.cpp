#include <acq_api.h>

#define BASE_ADDR_COR_COM 0x40000000
#define BASE_ADDR 0x40120000

#define DAT_MUX_ADDR 0xC0//byte
#define RCV_DO_INIT_ADDR 0x40//byte
#define DAT_MUX 0xC0//byte




int main(int argc, char **argv) {
    unsigned int offset_cor_com;
    volatile unsigned int* pBASE_COR_COM;
    unsigned int *pPAGE_BASE_COR_COM = (unsigned int*)getBlockPtr(BASE_ADDR_COR_COM, 16384, &offset_cor_com);//64kB
    pBASE_COR_COM = (volatile unsigned int*)(pPAGE_BASE_COR_COM + offset_cor_com + 4);

    unsigned int offset;
    volatile unsigned int* pBASE;
    unsigned int *pPAGE_BASE = (unsigned int*)getBlockPtr(BASE_ADDR, 16384, &offset);//64kB
    pBASE = (volatile unsigned int*)(pPAGE_BASE + offset);

    unsigned int MUX_NUM = 8;//ORYX PORTABLE 8-GPS_L1; 9-GLN_L1; 10-GLN_L2; 11-GPS_L2
    printf("\n");
    printf("***************************************************************\n");
    printf("***************************************************************\n");
    printf("Hello from FACQ!\n");

    *(pBASE_COR_COM + DAT_MUX_ADDR/4) = 1;//NOMADA CLK
    unsigned int rc = *(pBASE_COR_COM + RCV_DO_INIT_ADDR/4);
    // printf("rc = %08X\n",rc);
    printf("MUX NUM: %i\n",MUX_NUM);
    rc = rc & ~(0b11111 << 3) & ~(0b11111 << 9);
    rc = rc | (MUX_NUM<<3) | (MUX_NUM<<9);
    // printf("rc = %08X\n",rc);
    *(pBASE_COR_COM + RCV_DO_INIT_ADDR/4) = rc ;//NOMADA DATA

    *(pBASE_COR_COM + DAT_MUX/4) = 1 ;//NOMADA CLK (*1)
    printf("CLK_MUX (0xC0): %i\n",*(pBASE_COR_COM + DAT_MUX/4));

//    //configure facq input
//    printf("base_corr_rc = %08X\n",*(pBASE_COR_COM));
//    int input_facq_re = 1;
//    int input_facq_im = 2;
//    *(pBASE_COR_COM + 16) = input_facq_re<<3 | input_facq_im<<9;//input ADC_0
//    printf("facq_MUX_re = %i\n",input_facq_re);
//    printf("facq_MUX_im = %i\n",input_facq_im);
//    printf("facq_MUX_rc = %08X\n",*(pBASE_COR_COM + 16));

    if(argc < 2){
        printf("give me MODE!\n");
        printf("./acq_api <MODE>\n");
        printf("0: ram update\n");fflush(stdout);
        printf("1: facq\n");fflush(stdout);
        printf("2: check\n");fflush(stdout);
        printf("3: check state\n");fflush(stdout);
        printf("4: reset\n");fflush(stdout);
        printf("5: continuous facq single Sat\n");fflush(stdout);
        printf("6: continuous facq full system\n");fflush(stdout);
        printf("7: por calibrate\n");fflush(stdout);
        printf("8: record and facq\n");fflush(stdout);
        printf("9: N starts Multi facq\n");fflush(stdout);
        return -1;
    }
    int mode = atoi(argv[1]);
    unsigned int i_facq = 0;
    int i_Nsat = 0;
    int facq_time;
    facq_data dfacq_malloc;
    facq_data * dfacq = &dfacq_malloc;

    dfacq->pBASE = pBASE;
    dfacq->fd            = 99.375e6; // !!!!!!!!!!!!!!
    dfacq->core_freq     = 111e6;
    dfacq->acq_IP_inst   = 0;
    dfacq->disp          = 1;
    dfacq->manual_por_en = 0;
    dfacq->reset_por_en  = 1;
    dfacq->manual_por    = 8192;

    unsigned int N_starts;
    FILE* fid; // результаты поиска в файл
    char cwd[1024];
    getcwd(cwd, sizeof(cwd));// путь к исполняемой программе

    int need_ram_update = 1;

    switch(mode){
        case 0:
            printf("Mode: ram update\n");fflush(stdout);
            if(argc != 7){
                printf("give me {SignType Nsat(code from \"1\" or Lit) fi(Hz) kg(ms) nkg}!\n");
                printf("SignType: 0-GPS_L1_CA; 1-GLN_L1_OF; 2-GLN_L2_OF; 3-GLN_L1_SF; 4-GLN_L2_SF; 5-GPS_L2C; 6-GPS_L2CL; 7-GPS_L2CM\n");
                return -1;
            }

            dfacq->SignType     = atoi(argv[2]);
            dfacq->N_sat        = atoi(argv[3]);
            dfacq->fi           = atof(argv[4]);
            dfacq->kg_ms        = atof(argv[5]);// когерентное время накопления в мс
            dfacq->nkg          = atof(argv[6]);

            if((dfacq->SignType == GPS_L1_CA) | (dfacq->SignType == GPS_L2C) | (dfacq->SignType == GPS_L2CL) | (dfacq->SignType == GPS_L2CM))
                dfacq->N_sat = dfacq->N_sat - 1;// code from "1"

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            switch(facq_ram_update(dfacq)){
                case -2:
                    printf("ram update is not complete\n");fflush(stdout);
                    return -1;
                break;
                case -4:
                    printf("small memory\n");fflush(stdout);
                    return -1;
                break;
                case 0:
                    printf("ram update successfully started\n");fflush(stdout);
                break;
                default:
                    printf("facq: Unknown error\n");fflush(stdout);
                    return -1;
                break;
            }
        break;
        case 1:
            printf("Mode: facq\n");fflush(stdout);
            if(argc != 8){
                printf("give me {SignType Nsat(code from \"1\" or Lit) kg(ms) nkg f_zone(Hz) tau_zone(ms)}!\n");
                printf("SignType: 0-GPS_L1_CA; 1-GLN_L1_OF; 2-GLN_L2_OF; 3-GLN_L1_SF; 4-GLN_L2_SF; 5-GPS_L2C; 6-GPS_L2CL; 7-GPS_L2CM\n");
                return -1;
            }

            dfacq->N_sat      = atoi(argv[3]);
            dfacq->kg_ms      = atof(argv[4]);// когерентное время накопления в мс
            dfacq->nkg        = atof(argv[5]);
            dfacq->freq_acq   = atof(argv[6]);// диапазон поиска по частоте в каждую сторону в Гц
            dfacq->tau_acq_ms = atof(argv[7]);// диапазон поиска по задержке в мс

            printf("N_sat = %d\n",dfacq->N_sat);fflush(stdout);

            if((dfacq->SignType == GPS_L1_CA) | (dfacq->SignType == GPS_L2C) | (dfacq->SignType == GPS_L2CL) | (dfacq->SignType == GPS_L2CM))
                dfacq->N_sat = dfacq->N_sat - 1;// code from "1"

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            facq_time = facq_run(dfacq);
            switch(facq_time){
                case -2:
                    printf("ram update is not complete\n");fflush(stdout);
                    return -1;
                break;
                case -3:
                    printf("facq is not complete\n");fflush(stdout);
                    return -1;
                break;
                case -4:
                    printf("bram record is too short, need to update\n");fflush(stdout);
                    return -1;
                break;
                case -5:
                    printf("non valid signal type\n");fflush(stdout);
                    return -1;
                break;
                default:
                    if(facq_time < 0){
                        printf("facq: Unknown error\n");fflush(stdout);
                        return -1;
                    }
                    else{
                        printf("successfully run\n");fflush(stdout);
                        printf("Need %i ms real time to facq\n",facq_time);fflush(stdout);
                    }
                break;
            }
        break;
        case 2:
            printf("Mode: check\n");fflush(stdout);

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            switch(facq_result(dfacq)){
                case -2:
                    dfacq->ram_wr_cntr = *axi_read(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_wr_cntr_off, 0);
                    dfacq->wr_depth    = *axi_read(dfacq->pBASE, dfacq->facq_module_offset[bram_controller_regs] + acq_bram_controller_wr_depth_off, 0);// вычитываем объем записи
                    printf("ram update is not complete\n");fflush(stdout);
                    printf("ram_wr_cntr %.0f\n",dfacq->ram_wr_cntr);fflush(stdout);
                    printf("wr_depth %.0f\n",dfacq->wr_depth);fflush(stdout);
                    printf("complete %.2f%%\n",dfacq->ram_wr_cntr/dfacq->wr_depth*100.0);fflush(stdout);
                    return -1;
                break;
                case -3:
                    printf("facq is not complete\n");fflush(stdout);
                    return -1;
                break;
                case 0:
                    printf("successfully check\n");fflush(stdout);
                break;
                default:
                    printf("facq: Unknown error\n");fflush(stdout);
                    return -1;
                break;
            }
            printf("\n-----\n");fflush(stdout);
            printf("%4u | tau = %6.0f | freq = %6.0f | R = %.0f\n",i_facq,dfacq->res_tau,dfacq->res_freq,dfacq->res_R);fflush(stdout);
        break;
        case 3:
            printf("Mode: check state\n");fflush(stdout);

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            check_state(dfacq);
            switch(dfacq->fsm_state){
                case 0:
                    printf("FSM_RESET\n");fflush(stdout);
                break;
                case 1:
                    printf("FSM_WAIT_START\n");fflush(stdout);
                break;
                case 2:
                    printf("FSM_INIT\n");fflush(stdout);
                break;
                case 3:
                    printf("FSM_N_TAU_ZONE\n");fflush(stdout);
                break;
                case 4:
                    printf("FSM_LAST_PSP\n");fflush(stdout);
                break;
                case 5:
                    printf("FSM_WAIT_MAX\n");fflush(stdout);
                break;
                default:
                    printf("UNDEF STATE\n");fflush(stdout);
                break;
            }
            printf("kg_cntr   = %.0f\n",dfacq->kg_cntr);fflush(stdout);
            printf("nkg_cntr  = %.0f\n",dfacq->nkg_cntr);fflush(stdout);
            printf("nf_cntr   = %.0f\n",dfacq->nf_cntr);fflush(stdout);
            printf("ntau_cntr = %.0f\n",dfacq->ntau_cntr);fflush(stdout);
        break;
        case 4:
            printf("Mode: reset\n");fflush(stdout);

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            facq_reset(dfacq);
            printf("reset done\n");fflush(stdout);
        break;
        case 5:
            if(argc != 9){
                printf("give me {SignType Nsat(code from \"1\" or Lit) fi(Hz) kg(ms) nkg f_zone(Hz) tau_zone(ms)}!\n");
                printf("SignType: 0-GPS_L1_CA; 1-GLN_L1_OF; 2-GLN_L2_OF; 3-GLN_L1_SF; 4-GLN_L2_SF; 5-GPS_L2C; 6-GPS_L2CL; 7-GPS_L2CM\n");
                return -1;
            }

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            dfacq->SignType     = atoi(argv[2]);
            dfacq->N_sat        = atoi(argv[3]);
            dfacq->fi           = atof(argv[4]);
            dfacq->kg_ms        = atof(argv[5]);// когерентное время накопления в мс
            dfacq->nkg          = atof(argv[6]);
            dfacq->freq_acq     = atof(argv[7]);// диапазон поиска по частоте в каждую сторону в Гц
            dfacq->tau_acq_ms   = atof(argv[8]);// диапазон поиска по задержке в мс

            if((dfacq->SignType == GPS_L1_CA) | (dfacq->SignType == GPS_L2C) | (dfacq->SignType == GPS_L2CL) | (dfacq->SignType == GPS_L2CM))
                dfacq->N_sat = dfacq->N_sat - 1;// code from "1"

            printf("Mode: continuous facq single Sat\n");fflush(stdout);

            // dfacq->disp = 0;

            get_por(dfacq);// откалибровали порог обнаружения
            printf("***************************************************************\n");

            while(1){
                if(need_ram_update){
                    switch(facq_ram_update(dfacq)){
                        case -2:
                            printf("ram update is not complete\n");fflush(stdout);
                            return -1;
                        break;
                        case -4:
                            printf("small memory\n");fflush(stdout);
                            return -1;
                        break;
                        case -5:
                            printf("non valid signal type\n");fflush(stdout);
                            return -1;
                        break;
                        case 0:
                            // printf("ram update successfully started\n");fflush(stdout);
                        break;
                        default:
                            printf("facq: Unknown error\n");fflush(stdout);
                            return -1;
                        break;
                    }
                    dfacq->disp = 0;
                    while(facq_result(dfacq)) usleep(1e3);
                }
                // need_ram_update = 0;
                dfacq->disp = 0;

                switch(facq_run(dfacq)){
                    case -2:
                        printf("ram update is not complete\n");fflush(stdout);
                        return -1;
                    break;
                    case -3:
                        printf("facq is not complete\n");fflush(stdout);
                        return -1;
                    break;
                    case -4:
                        printf("bram record is too short, need to update\n");fflush(stdout);
                        return -1;
                    break;
                    case -5:
                        printf("non valid signal type\n");fflush(stdout);
                        return -1;
                    break;
                    default:
                        // printf("facq: Unknown error\n");fflush(stdout);
                        // return -1;
                    break;
                }

                while(facq_result(dfacq)) usleep(1e3);

                if((dfacq->SignType == GLN_L1_OF)||(dfacq->SignType == GLN_L2_OF)||(dfacq->SignType == GLN_L1_SF)||(dfacq->SignType == GLN_L2_SF))
                    {printf("%4u | Lit = %3i | tau = %6.0f | freq = %6.0f | acq = %3s | por = %.0f | R = %.0f\n",
                    i_facq,dfacq->N_sat,dfacq->res_tau,dfacq->res_freq,(dfacq->res_R>dfacq->facq_por)?"yes":"",dfacq->facq_por,dfacq->res_R);fflush(stdout);}
                else
                    {printf("%4u | Sat = %3i | tau = %6.0f | freq = %6.0f | acq = %3s | por = %.0f | R = %.0f\n",
                    i_facq,dfacq->N_sat+1,dfacq->res_tau,dfacq->res_freq,(dfacq->res_R>dfacq->facq_por)?"yes":"",dfacq->facq_por,dfacq->res_R);fflush(stdout);}

                i_facq ++;
                dfacq->reset_por_en = 0; //после первого прохода более не сбрасываем квантователь
            }
        break;
        case 6:
            if(argc != 8){
                printf("give me {SignType fi(Hz) kg(ms) nkg f_zone(Hz) tau_zone(ms)}!\n");
                printf("SignType: 0-GPS_L1_CA; 1-GLN_L1_OF; 2-GLN_L2_OF; 3-GLN_L1_SF; 4-GLN_L2_SF; 5-GPS_L2C; 6-GPS_L2CL; 7-GPS_L2CM\n");
                return -1;
            }
            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            dfacq->SignType     = atoi(argv[2]);
            dfacq->fi           = atof(argv[3]);
            dfacq->kg_ms        = atof(argv[4]);// когерентное время накопления в мс
            dfacq->nkg          = atof(argv[5]);
            dfacq->freq_acq     = atof(argv[6]);// диапазон поиска по частоте в каждую сторону в Гц
            dfacq->tau_acq_ms   = atof(argv[7]);// диапазон поиска по задержке в мс

            dfacq->disp = 0;

            get_por(dfacq);// откалибровали порог обнаружения
            printf("***************************************************************\n");

            printf("Mode: continuous facq full system\n");fflush(stdout);



            while(1){

                if((dfacq->SignType == GLN_L1_OF) || (dfacq->SignType == GLN_L2_OF) || (dfacq->SignType == GLN_L1_SF) || (dfacq->SignType == GLN_L2_SF))
                    dfacq->N_sat = i_Nsat-7;
                else
                    dfacq->N_sat = i_Nsat;

                if((need_ram_update && (i_Nsat == 0)) || (dfacq->SignType == GLN_L1_OF)){
                    switch(facq_ram_update(dfacq)){
                        case -2:
                            printf("ram update is not complete\n");fflush(stdout);
                            return -1;
                        break;
                        case -4:
                            printf("small memory\n");fflush(stdout);
                            return -1;
                        break;
                        case -5:
                            printf("non valid signal type\n");fflush(stdout);
                            return -1;
                        break;
                        case 0:
                            // printf("ram update successfully started\n");fflush(stdout);
                        break;
                        default:
                            printf("facq: Unknown error\n");fflush(stdout);
                            return -1;
                        break;
                    }
                    while(facq_result(dfacq)) usleep(1e3);
                }
                // need_ram_update = 0;

                switch(facq_run(dfacq)){
                    case -2:
                        printf("ram update is not complete\n");fflush(stdout);
                        return -1;
                    break;
                    case -3:
                        printf("facq is not complete\n");fflush(stdout);
                        return -1;
                    break;
                    case -4:
                        printf("bram record is too short, need to update\n");fflush(stdout);
                        return -1;
                    break;
                    case -5:
                        printf("non valid signal type\n");fflush(stdout);
                        return -1;
                    break;
                    default:
                        // printf("facq: Unknown error\n");fflush(stdout);
                        // return -1;
                    break;
                }

                while(facq_result(dfacq)) usleep(1e3);


                if((dfacq->SignType == GLN_L1_OF)||(dfacq->SignType == GLN_L2_OF)||(dfacq->SignType == GLN_L1_SF)||(dfacq->SignType == GLN_L2_SF)){
                    printf("%4u | Lit = %3i | tau = %6.0f | freq = %6.0f | acq = %3s | por = %.0f | R = %.0f\n",
                    i_facq,dfacq->N_sat,dfacq->res_tau,dfacq->res_freq,(dfacq->res_R>dfacq->facq_por)?"yes":"",dfacq->facq_por,dfacq->res_R);fflush(stdout);
                    i_Nsat ++;
                    if(i_Nsat == 14){
                        i_Nsat = 0;
                        i_facq ++;
                    }
                }
                else{
                    printf("%4u | Sat = %3i | tau = %6.0f | freq = %6.0f | acq = %3s | por = %.0f | R = %.0f\n",
                    i_facq,dfacq->N_sat+1,dfacq->res_tau,dfacq->res_freq,(dfacq->res_R>dfacq->facq_por)?"yes":"",dfacq->facq_por,dfacq->res_R);fflush(stdout);
                    i_Nsat ++;
                    if(i_Nsat == 32){
                        i_Nsat = 0;
                        i_facq ++;
                    }
                }
                dfacq->reset_por_en = 0; //после первого прохода более не сбрасываем квантователь
            }
        break;
        case 7:
            if(argc != 6){
                printf("give me {SignType fi(Hz) kg(ms) nkg}!\n");
                printf("SignType: 0-GPS_L1_CA; 1-GLN_L1_OF; 2-GLN_L2_OF; 3-GLN_L1_SF; 4-GLN_L2_SF; 5-GPS_L2C; 6-GPS_L2CL; 7-GPS_L2CM\n");
                return -1;
            }

            dfacq->SignType     = atoi(argv[2]);
            dfacq->fi           = atof(argv[3]);
            dfacq->kg_ms        = atof(argv[4]);// когерентное время накопления в мс
            dfacq->nkg          = atof(argv[5]);

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }
            get_por(dfacq);

        break;
        case 8:
            if(argc != 9){
                printf("give me {SignType Nsat(code from \"1\" or Lit) fi(Hz) kg(ms) nkg f_zone(Hz) tau_zone(ms)}!\n");
                printf("SignType: 0-GPS_L1_CA; 1-GLN_L1_OF; 2-GLN_L2_OF; 3-GLN_L1_SF; 4-GLN_L2_SF; 5-GPS_L2C; 6-GPS_L2CL; 7-GPS_L2CM\n");
                return -1;
            }

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            dfacq->SignType     = atoi(argv[2]);
            dfacq->N_sat        = atoi(argv[3]);
            dfacq->fi           = atof(argv[4]);
            dfacq->kg_ms        = atof(argv[5]);// когерентное время накопления в мс
            dfacq->nkg          = atof(argv[6]);
            dfacq->freq_acq     = atof(argv[7]);// диапазон поиска по частоте в каждую сторону в Гц
            dfacq->tau_acq_ms   = atof(argv[8]);// диапазон поиска по задержке в мс

            printf("Mode: record and facq\n");fflush(stdout);

            if((dfacq->SignType == GPS_L1_CA) | (dfacq->SignType == GPS_L2C) | (dfacq->SignType == GPS_L2CL) | (dfacq->SignType == GPS_L2CM))
                dfacq->N_sat = dfacq->N_sat - 1;// code from "1"
            // dfacq->disp = 0;

                if(need_ram_update){
                    switch(facq_ram_update(dfacq)){
                        case -2:
                            printf("ram update is not complete\n");fflush(stdout);
                            return -1;
                        break;
                        case -4:
                            printf("small memory\n");fflush(stdout);
                            return -1;
                        break;
                        case -5:
                            printf("non valid signal type\n");fflush(stdout);
                            return -1;
                        break;
                        case 0:
                            // printf("ram update successfully started\n");fflush(stdout);
                        break;
                        default:
                            printf("facq: Unknown error\n");fflush(stdout);
                            return -1;
                        break;
                    }
                    while(facq_result(dfacq)) usleep(1e3);
                }

                switch(facq_run(dfacq)){
                    case -2:
                        printf("ram update is not complete\n");fflush(stdout);
                        return -1;
                    break;
                    case -3:
                        printf("facq is not complete\n");fflush(stdout);
                        return -1;
                    break;
                    case -4:
                        printf("bram record is too short, need to update\n");fflush(stdout);
                        return -1;
                    break;
                    case -5:
                        printf("non valid signal type\n");fflush(stdout);
                        return -1;
                    break;
                    default:
                        // printf("facq: Unknown error\n");fflush(stdout);
                        // return -1;
                    break;
                }

                while(facq_result(dfacq)) usleep(1e3);

                if((dfacq->SignType == GLN_L1_OF)||(dfacq->SignType == GLN_L2_OF)||(dfacq->SignType == GLN_L1_SF)||(dfacq->SignType == GLN_L2_SF))
                    {printf("Lit = %3i | tau = %6.0f | freq = %6.0f | acq = %3s | por = %.0f | R = %.0f\n",
                    dfacq->N_sat,dfacq->res_tau,dfacq->res_freq,(dfacq->res_R>dfacq->facq_por)?"yes":"",dfacq->facq_por,dfacq->res_R);fflush(stdout);}
                else
                    {printf("Sat = %3i | tau = %6.0f | freq = %6.0f | acq = %3s | por = %.0f | R = %.0f\n",
                    dfacq->N_sat+1,dfacq->res_tau,dfacq->res_freq,(dfacq->res_R>dfacq->facq_por)?"yes":"",dfacq->facq_por,dfacq->res_R);fflush(stdout);}
        break;
        case 9:
            if(argc != 12){
                printf("give me {SignType Nsat(code from \"1\" or Lit) fi(Hz) kg(ms) nkg f_zone(Hz) tau_zone(ms) N_starts MUX_NUM Fd[Hz]}!\n");
                printf("SignType: 0-GPS_L1_CA; 1-GLN_L1_OF; 2-GLN_L2_OF; 3-GLN_L1_SF; 4-GLN_L2_SF; 5-GPS_L2C; 6-GPS_L2CL; 7-GPS_L2CM\n");
                return -1;
            }

            if(facq_init(dfacq)){
                printf("Init problem\n");fflush(stdout);
                return -1;
            }

            dfacq->SignType     = atoi(argv[2]);
            dfacq->N_sat        = atoi(argv[3]);
            dfacq->fi           = atof(argv[4]);
            dfacq->kg_ms        = atof(argv[5]);// когерентное время накопления в мс
            dfacq->nkg          = atof(argv[6]);
            dfacq->freq_acq     = atof(argv[7]);// диапазон поиска по частоте в каждую сторону в Гц
            dfacq->tau_acq_ms   = atof(argv[8]);// диапазон поиска по задержке в мс
            N_starts            = atoi(argv[9]);// количество запусков поиска
            MUX_NUM             = atoi(argv[10]);// номер мультиплексора
            dfacq->fd           = atof(argv[11]);
            
            printf("MUX NUM: %i\n",MUX_NUM);
            rc = *(pBASE_COR_COM + RCV_DO_INIT_ADDR/4);
            // printf("rc = %08X\n",rc);
            printf("MUX NUM: %i\n",MUX_NUM);
            rc = rc & ~(0b11111 << 3) & ~(0b11111 << 9);
            rc = rc | (MUX_NUM<<3) | (MUX_NUM<<9);
            // printf("rc = %08X\n",rc);
            *(pBASE_COR_COM + RCV_DO_INIT_ADDR/4) = rc ;//NOMADA DATA
            
            printf("Mode: N starts Multi facq\n");fflush(stdout);
            fid = fopen("log.txt", "w+");
            if(fid){
                fprintf(fid,"SignType;Nsat;fi;kg;nkg;f_zone;tau_zone;N_starts\n");
                fprintf(fid,"%i;%i;%f;%f;%f;%f;%f;%i\n",
                dfacq->SignType,dfacq->N_sat,dfacq->fi,dfacq->kg_ms,dfacq->nkg,dfacq->freq_acq,dfacq->tau_acq_ms,N_starts);
                fprintf(fid,"R;freq;tau");
            }
            // printf("Current working dir: %s\n", cwd);
            // printf("Current working dir: %s\n", argv[0]);

            if((dfacq->SignType == GPS_L1_CA) | (dfacq->SignType == GPS_L2C) | (dfacq->SignType == GPS_L2CL) | (dfacq->SignType == GPS_L2CM))
                dfacq->N_sat = dfacq->N_sat - 1;// code from "1"
            // dfacq->disp = 0;
            for(i_facq=0;i_facq<N_starts;i_facq++){
                    switch(facq_ram_update(dfacq)){
                        case -2:
                            printf("ram update is not complete\n");fflush(stdout);
                            return -1;
                        break;
                        case -4:
                            printf("small memory\n");fflush(stdout);
                            return -1;
                        break;
                        case -5:
                            printf("non valid signal type\n");fflush(stdout);
                            return -1;
                        break;
                        case 0:
                            // printf("ram update successfully started\n");fflush(stdout);
                        break;
                        default:
                            printf("facq: Unknown error\n");fflush(stdout);
                            return -1;
                        break;
                    }
                    while(facq_result(dfacq)) usleep(1e3);
                    dfacq->reset_por_en = 0; //после первого прохода более не сбрасываем квантователь
                    
                    switch(facq_run(dfacq)){
                        case -2:
                            printf("ram update is not complete\n");fflush(stdout);
                            return -1;
                        break;
                        case -3:
                            printf("facq is not complete\n");fflush(stdout);
                            return -1;
                        break;
                        case -4:
                            printf("bram record is too short, need to update\n");fflush(stdout);
                            return -1;
                        break;
                        case -5:
                            printf("non valid signal type\n");fflush(stdout);
                            return -1;
                        break;
                        default:
                            // printf("facq: Unknown error\n");fflush(stdout);
                            // return -1;
                        break;
                    }
                    while(facq_result(dfacq)) usleep(1e3);
                    
                    if((dfacq->SignType == GLN_L1_OF)||(dfacq->SignType == GLN_L2_OF)||(dfacq->SignType == GLN_L1_SF)||(dfacq->SignType == GLN_L2_SF))
                        {printf("%3i | Lit = %3i | tau = %6.0f | freq = %6.0f | acq = %3s | por = %.0f | R = %.0f\n",
                        i_facq,dfacq->N_sat,dfacq->res_tau,dfacq->res_freq,(dfacq->res_R>dfacq->facq_por)?"yes":"",dfacq->facq_por,dfacq->res_R);fflush(stdout);}
                    else
                        {printf("%3i | Sat = %3i | tau = %6.0f | freq = %6.0f | acq = %3s | por = %.0f | R = %.0f\n",
                        i_facq,dfacq->N_sat+1,dfacq->res_tau,dfacq->res_freq,(dfacq->res_R>dfacq->facq_por)?"yes":"",dfacq->facq_por,dfacq->res_R);fflush(stdout);}
                    
                    if(fid)
                        fprintf(fid,"\n%.0f;%.0f;%.0f",dfacq->res_R,dfacq->res_freq,dfacq->res_tau);
            }
            fclose(fid);
        break;
        default:
            printf("Mode: INVALID\n");fflush(stdout);
            printf("0: ram update\n");fflush(stdout);
            printf("1: facq\n");fflush(stdout);
            printf("2: check\n");fflush(stdout);
            printf("3: check state\n");fflush(stdout);
            printf("4: reset\n");fflush(stdout);
            printf("5: continuous facq single Sat\n");fflush(stdout);
            printf("6: continuous facq full system\n");fflush(stdout);
            printf("7: por calibrate\n");fflush(stdout);
            printf("8: record and facq\n");fflush(stdout);
            printf("9: N starts Multi facq\n");fflush(stdout);
            return -1;
        break;
    }

    // printf("adresa:\n");fflush(stdout);usleep(1000);
    // for(int i = 0; i <= fsm_controller_regs; i++){
        // printf("facq_module_offset[%d] = 0x%08X\n",i,BASE_ADDR + dfacq->facq_module_offset[i]*4);fflush(stdout);usleep(1000);
    // }

    return 0;

}

int get_por(struct facq_data * dfacq){
    if(dfacq->facq_por_busy == 0){// start por calibration
        printf("start por calibrate\n");fflush(stdout);
        if(por_calibrate(dfacq) == -2){
            printf("por calibrate ERROR\n");fflush(stdout);
            return -1;
        }
    }

    while(dfacq->facq_por_busy){
        if(por_calibrate(dfacq) == -2){
            printf("por calibrate ERROR\n");fflush(stdout);
            return -1;
        }
        usleep(1e3);
    }
    printf("por = %.0f\n",dfacq->facq_por);fflush(stdout);
    return 0;
}
