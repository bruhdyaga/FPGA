#include <stdint.h>

#include "libfacq/psp_init_functions.h"

void set_ram_cfg(bool en, bool reverse, unsigned int len, struct facq_data * dfacq) {
    unsigned int cfg = (en << 31) | (reverse << 30) | (len & 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[facq_prn_ram_regs] + facq_prn_ram_cfg, cfg);
}

void set_ram_word(uint32_t word, struct facq_data * dfacq) {
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[facq_prn_ram_regs] + facq_prn_ram_data, word);
}

int gal_E1B(struct facq_data * dfacq){
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}


//Nsat from "0"!
int gps_l1_ca(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("gps_l1_ca\n"); fflush(stdout); }
    unsigned long GPS_CA_G2_out_bitmasks[] = {
    0x022, 0x044, 0x088, 0x110, 0x101, 0x202, 0x081, 0x102,
    0x204, 0x006, 0x00C, 0x030, 0x060, 0x0C0, 0x180, 0x300,
    0x009, 0x012, 0x024, 0x048, 0x090, 0x120, 0x005, 0x028,
    0x050, 0x0A0, 0x140, 0x280, 0x021, 0x042, 0x084, 0x108,
    0x210, 0x208, 0x041, 0x082, 0x208};
    
    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;
    
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x3FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x3FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x204);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x200);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, 0x3FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, 0x3FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x3A6);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, GPS_CA_G2_out_bitmasks[dfacq->N_sat]);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  1022);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay
    
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL
    
    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);
    
    return 0;
}

// Вызывается при использовании табличного поиска
int gps_l1_ca_ram(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("gps_l1_ca_ram\n"); fflush(stdout); }

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}

int gln_of(struct facq_data * dfacq){
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x1FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x1FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x110);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x040);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, 0x0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, 0x0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x0);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off, 511-1);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay
    
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL
    
    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);
    
    return 0;
}

int gln_sf(struct facq_data * dfacq){
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x4);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x0000200);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x400);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x00000000);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  5110000-1);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay
    
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (1<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL
    
    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);
    
    return 0;
}

//Nsat from "0"!
int gps_l2_cm(struct facq_data * dfacq, unsigned int freq_div){
    unsigned long gps_cm_code_state[] =
    {0x015EF0F5, 0x050F811E, 0x010E553D, 0x016B0258, 0x0416F3BC, 0x065BC21E, 0x00F5BE58, 0x0496777F,
    0x04A5A8E2, 0x036E44D6, 0x05E84705, 0x0345EA19, 0x06965B5B, 0x0447FB02, 0x00043A6E, 0x035E5896,
    0x03059DDD, 0x05C16D2A, 0x010C80DB, 0x01C754B4, 0x0650324E, 0x07FB4E14, 0x074E048F, 0x00663507,
    0x01F887F9, 0x0487C247, 0x05FD6D8C, 0x020818D1, 0x01ECE400, 0x07AEB923, 0x0656B597, 0x0602E157,
    0x068B59F8, 0x039EED65, 0x04940672, 0x062B31F9, 0x02FCFB21, 0x0630E2F8, 0x04F9C540, 0x008DCF64,
    0x0105C42F, 0x01B7B53A, 0x0141E84D, 0x040E0E76, 0x052236F3, 0x0140FB3D, 0x03E97A28, 0x0514B56F,
    0x050C6A2B, 0x039BD2F4, 0x0404F0DE, 0x063A0950, 0x00D12663, 0x0747CFC6, 0x072A85AC, 0x0581FEAF,
    0x03B7C927, 0x07C39887, 0x079BE9A2, 0x01DF5F4C, 0x053724C5, 0x05B4F44F, 0x04A7F4A4};
    
    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, gps_cm_code_state[dfacq->N_sat] & 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, gps_cm_code_state[dfacq->N_sat] & 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x0494953C & 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x04000000 & 0x3FFF);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, (gps_cm_code_state[dfacq->N_sat]>>14) & 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, (gps_cm_code_state[dfacq->N_sat]>>14) & 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, (0x0494953C>>14) & 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, (0x04000000>>14) & 0x3FFF);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10229);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay
    
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (freq_div<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (1<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL
    
    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);
    
    return 0;
}

//Nsat from "0"!
int gps_l2_cl(struct facq_data * dfacq){
    unsigned long gps_cl_code_state[] =
    {0x0447D940,0xEB748040,0xD26BEBC0,0x5238D480,0x10C5C7A0,0x98E038C0,0xF9E8ADC0,
    0x659422E0,0xDC3FAB80,0x5C29FDC0,0x2463E1A0,0x73217D00,0xE8E1BEA0,0xF6EC1560,
    0xBAFC85A0,0xFBAFA520,0xD49D6200,0x7543E5E0,0x65611A20,0xC26595A0,0x4F4E1160,
    0x6F9AE7C0,0xBDBF6D60,0xDE8ED8C0,0x0D3F1200,0xC793D380,0xDAB1CD60,0x5F1DAF60,
    0x76E58480,0xAC3C4FA0,0x84BF64C0,0x3C72D3C0,0x105A1F20,0x8033D640,0x304365E0,
    0xD7076DE0,0xC4E00660,0x25657B00,0x393298C0,0x2EA0BBE0,0x9EAAADA0,0x32E88E00,
    0xE2A33860,0xCAD98D20,0x5CF234E0,0x17B222A0,0xEF39B240,0xEBDDF1C0,0x4206DF80,
    0x90839A40,0x68412C40,0xDC893B20,0xD89EFF80,0x1E515D40,0x4B4E60A0,0xC91D5940,
    0x37DB7500,0x9677EFC0,0xEDA93760,0xAF35FBA0,0xF9D58E60,0x5AE21FA0,0xA4C208E0};
    
    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, gps_cl_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, gps_cl_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x3CA92920);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x20);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, 0x0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, 0x0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x0);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  767249);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay
    
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (1<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL
    
    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);
    
    return 0;
}

//Nsat from "0"!
int gln_l1oc_d(struct facq_data * dfacq, unsigned int freq_div){
    unsigned long gln_l1oc_d_code_state[] = {
    0x000, 0x200, 0x100, 0x300, 0x80, 0x280, 0x180, 0x380,
    0x40 , 0x240, 0x140, 0x340, 0xC0, 0x2C0, 0x1C0, 0x3C0,
    0x20 , 0x220, 0x120, 0x320, 0xA0, 0x2A0, 0x1A0, 0x3A0,
    0x60 , 0x260, 0x160, 0x360, 0xE0, 0x2E0, 0x1E0, 0x3E0,
    0x10 , 0x210, 0x110, 0x310, 0x90, 0x290, 0x190, 0x390,
    0x50 , 0x250, 0x150, 0x350, 0xD0, 0x2D0, 0x1D0, 0x3D0,
    0x30 , 0x230, 0x130, 0x330, 0xB0, 0x2B0, 0x1B0, 0x3B0,
    0x70 , 0x270, 0x170, 0x370, 0xF0, 0x2F0, 0x1F0, 0x3F0
};
    
    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x4C);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x4C);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x240);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x200);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, gln_l1oc_d_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, gln_l1oc_d_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x344);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x200);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  1022);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay
    
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (freq_div<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL
    
    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);
    
    return 0;
}

//Nsat from "0"!
int gln_l2oc_p(struct facq_data * dfacq, unsigned int freq_div){
    unsigned long gln_l2oc_p_code_state[] =
    {0x80000000,0x82000000,0x84000000,0x86000000,0x88000000,0x8A000000,0x8C000000,
    0x8E000000,0x90000000,0x92000000,0x94000000,0x96000000,0x98000000,0x9A000000,
    0x9C000000,0x9E000000,0xA0000000,0xA2000000,0xA4000000,0xA6000000,0xA8000000,
    0xAA000000,0xAC000000,0xAE000000,0xB0000000,0xB2000000,0xB4000000,0xB6000000,
    0xB8000000,0xBA000000,0xBC000000,0xBE000000,0xC0000000,0xC2000000,0xC4000000,
    0xC6000000,0xC8000000,0xCA000000,0xCC000000,0xCE000000,0xD0000000,0xD2000000,
    0xD4000000,0xD6000000,0xD8000000,0xDA000000,0xDC000000,0xDE000000,0xE0000000,
    0xE2000000,0xE4000000,0xE6000000,0xE8000000,0xEA000000,0xEC000000,0xEE000000,
    0xF0000000,0xF2000000,0xF4000000,0xF6000000,0xF8000000,0xFA000000,0xFC000000,
    0xFE000000};
    
    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x34E00000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x34E00000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x110C0000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x40000);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, gln_l2oc_p_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, gln_l2oc_p_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x6000000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x2000000);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10229);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay
    
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (freq_div<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL
    
    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);
    
    return 0;
}

//Nsat from "0"!
int gln_l3oc_p(struct facq_data * dfacq){
    unsigned long gln_l3oc_p_code_state[] =
    {0x80000000,0x82000000,0x84000000,0x86000000,0x88000000,0x8A000000,0x8C000000,
    0x8E000000,0x90000000,0x92000000,0x94000000,0x96000000,0x98000000,0x9A000000,
    0x9C000000,0x9E000000,0xA0000000,0xA2000000,0xA4000000,0xA6000000,0xA8000000,
    0xAA000000,0xAC000000,0xAE000000,0xB0000000,0xB2000000,0xB4000000,0xB6000000,
    0xB8000000,0xBA000000,0xBC000000,0xBE000000,0xC0000000,0xC2000000,0xC4000000,
    0xC6000000,0xC8000000,0xCA000000,0xCC000000,0xCE000000,0xD0000000,0xD2000000,
    0xD4000000,0xD6000000,0xD8000000,0xDA000000,0xDC000000,0xDE000000,0xE0000000,
    0xE2000000,0xE4000000,0xE6000000,0xE8000000,0xEA000000,0xEC000000,0xEE000000,
    0xF0000000,0xF2000000,0xF4000000,0xF6000000,0xF8000000,0xFA000000,0xFC000000,
    0xFE000000};
    
    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x34E00000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x34E00000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x110C0000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x40000);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, gln_l3oc_p_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, gln_l3oc_p_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x6000000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x2000000);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10229);
    
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay
    
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL
    
    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);
    
    return 0;
}

//Nsat from "0"!
int gln_l3oc_d(struct facq_data * dfacq, unsigned int freq_div){
    unsigned long gln_l3oc_d_code_state[] =
    { 0x00, 0x40, 0x20, 0x60, 0x10, 0x50, 0x30, 0x70,
      0x08, 0x48, 0x28, 0x68, 0x18, 0x58, 0x38, 0x78,
      0x04, 0x44, 0x24, 0x64, 0x14, 0x54, 0x34, 0x74,
      0x0C, 0x4C, 0x2C, 0x6C, 0x1C, 0x5C, 0x3C, 0x7C,
      0x02, 0x42, 0x22, 0x62, 0x12, 0x52, 0x32, 0x72,
      0x0A, 0x4A, 0x2A, 0x6A, 0x1A, 0x5A, 0x3A, 0x7A,
      0x06, 0x46, 0x26, 0x66, 0x16, 0x56, 0x36, 0x76,
      0x0E, 0x4E, 0x2E, 0x6E, 0x1E, 0x5E, 0x3E, 0x7E};

    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x072C);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x072C);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x3088);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x2000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, gln_l3oc_d_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, gln_l3oc_d_code_state[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x060);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x040);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10229);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (freq_div<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}

//Nsat from "0"!
int sbs_sdcm(struct facq_data * dfacq){
    unsigned long SBS_SDCM_state_G2[] = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x246,
        0x2A1, 0xB7, 0x9A, 0x38F, 0x23E, 0x3F4, 0x1CF, 0x35A, 0x2A8, 0xE1, 0x169, 0x150, 0x3D9, 0x1C6, 0x28E, 0x1E0, 0x207, 0x128, 0xC5, 0x3AB,
        0x309, 0x3A4, 0x2CA, 0x230, 0x370, 0x1D, 0xED, 0xDD, 0x2AC, 0x221, 0x62, 0x3A1, 0x344, 0x1E9, 0x47, 0x26B, 0x362, 0, 0, 0
    };

//    unsigned long SBS_SDCM_state_G2[] =
//    {0x23E, 0x3AB, 0x309}; // initial state G2 for prn 125, 140, 141
//    {0x62400000, 0xF1C00000, 0x2FC00000}; // initial state G2 for prn 120, 124, 126

    if((dfacq->N_sat > 160) || (dfacq->N_sat < 119))
        return -1;


    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x3FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x3FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x204);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x200);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, SBS_SDCM_state_G2[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, SBS_SDCM_state_G2[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x3A6);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x200);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  1022);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}

//Nsat from "0"!
int gps_l5_d(struct facq_data * dfacq, unsigned int freq_div){
    unsigned long gps_l5_d_state_G2[] =
    {0x04EA, 0x1583, 0x0202, 0x0C8D, 0x1D77, 0x0BE6, 0x1F25, 0x04BD, 0x1A9F, 0x0F7E,
     0x0B90, 0x13E7, 0x0738, 0x1C82, 0x0B56, 0x1278, 0x1E32, 0x0F0F, 0x1F13, 0x16D6,
     0x0204, 0x1EF7, 0x0FE1, 0x05A3, 0x16CB, 0x0D35, 0x0F6A, 0x0D5E, 0x10FA, 0x1DA1,
     0x0F28, 0x13A0, 0x102B, 0x13FB, 0x076F, 0x0269, 0x012C, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0x8CB,
    0x663,  0x1461, 0x1B6F, 0x4C0,  0x143B, 0x843,  0x1658, 0x1A95, 0x5EF,  0x6FF,
    0x1C20, 0x83F,  0x1B9C, 0x151B, 0x1BEA, 0x1B18, 0x1DD8, 0x1E7,  0x1F1E, 0x1DC,
    0x24F,  0x9D8,  0x79A,  0x17A4, 0x19BB, 0x1F3C, 0x1EA9, 0x1EFE, 0x1090, 0x1AC7,
    0x112F, 0x17AD, 0x1D8,  0x7A0,  0x7D2,  0xBB7,  0x1ABB, 0x118B, 0, 0, //prn 120-158 reserved for SBAS
};

    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x1FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x1FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x1B00);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x1000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, gps_l5_d_state_G2[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, gps_l5_d_state_G2[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x18ED);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x1000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10229);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, (0b1010110000) | (9 << 20));

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (freq_div<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (1<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - ON
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}

//Nsat from "0"!
int gps_l5_p(struct facq_data * dfacq){
    unsigned long gps_l5_p_state_G2[] =
    {0x96600000, 0x47B00000, 0xF1180000, 0x3B500000, 0x3D900000, 0x55480000, 0xFC080000,
    0x6B400000, 0xBA180000, 0x24300000, 0x10280000, 0x56280000, 0x4D280000, 0xA1F80000,
    0xBC780000, 0xD2F80000, 0xE6400000, 0xB7200000, 0x32D80000, 0xC3880000, 0x6C800000,
    0x2C700000, 0x8BE80000, 0x6F980000, 0x44D80000, 0x55E00000, 0x87D00000, 0xFA100000,
    0x51200000, 0x83C80000, 0x5F280000, 0x91500000, 0xB2200000, 0xF2200000, 0x65980000,
    0x3D780000, 0x26880000};

    if((dfacq->N_sat > 31) || (dfacq->N_sat < 0))
        return -1;

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0xFFFFFFFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0xFFFFFFFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x00D80000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x00080000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, gps_l5_p_state_G2[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, gps_l5_p_state_G2[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0xB7180000);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x00080000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10229);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (1<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - ON
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}


//Nsat from "0"!
int bds_BxI(struct facq_data * dfacq){
    unsigned long BeiDou_rep2_OUT_BITMASK_2_BxI[] = {
        0x005, 0x009, 0x011, 0x021, 0x081,
        0x101, 0x201, 0x401, 0x042, 0x00C,
        0x014, 0x024, 0x084, 0x104, 0x204,
        0x404, 0x018, 0x028, 0x088, 0x108,
        0x208, 0x408, 0x030, 0x090, 0x110,
        0x210, 0x410, 0x0A0, 0x120, 0x220,
        0x420, 0x180, 0x280, 0x480, 0x300,
        0x500, 0x600,
    };

    if((dfacq->N_sat > 36) || (dfacq->N_sat < 0)) {
        return -1;
    }

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x2AA);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x2AA);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x7C1);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x400);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, 0x2AA);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, 0x2AA);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x59F);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, BeiDou_rep2_OUT_BITMASK_2_BxI[dfacq->N_sat]);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  2045);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}

int gal_E5a(struct facq_data * dfacq){
    unsigned long Galileo_rep2_CODESTATE2_E5aI[] = {
        0x30C5, 0x189C, 0x2E8B, 0x217F, 0x26CA,
        0x3733, 0x1B8C, 0x155F, 0x0357, 0x309E,
        0x2EE4, 0x0EBA, 0x3CFF, 0x1E26, 0x0D1C,
        0x1B05, 0x28AA, 0x1399, 0x29FE, 0x0198,
        0x1370, 0x1EBA, 0x2F25, 0x33C2, 0x160A,
        0x1901, 0x39D7, 0x2597, 0x3193, 0x2EAE,
        0x0350, 0x1889, 0x3335, 0x2474, 0x374E,
        0x05DF, 0x22CE, 0x3B15, 0x3B9B, 0x29AD,
        0x182C, 0x2E17, 0x0D84, 0x332D, 0x3935,
        0x2ABB, 0x21F3, 0x33D1, 0x1ECA, 0x16BF,
    };

    if((dfacq->N_sat >= 49) || (dfacq->N_sat < 0))
        return -1;

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x20A1);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x2000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, Galileo_rep2_CODESTATE2_E5aI[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, Galileo_rep2_CODESTATE2_E5aI[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x28D8);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x2000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10229);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, (0b10010111010000100001) | (19 << 20));
    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}

int gal_E5b(struct facq_data * dfacq){
    if(dfacq->disp){ TIMESTAMP printf("gal_E5b, N_sat=%d\n", dfacq->N_sat); fflush(stdout); }
    unsigned long Galileo_rep2_CODESTATE2_E5bI[] = {
        0x0E90, 0x2C27, 0x00AA, 0x1E76, 0x1871,
        0x0560, 0x035F, 0x2C13, 0x03D5, 0x219F,
        0x04F4, 0x2FD9, 0x31A0, 0x387C, 0x0D34,
        0x0FBE, 0x3499, 0x10EB, 0x01ED, 0x2C3F,
        0x13A4, 0x135F, 0x3A4D, 0x212A, 0x39A5,
        0x2BB4, 0x2303, 0x34AB, 0x04DF, 0x31FF,
        0x2E52, 0x24FF, 0x3C7D, 0x363D, 0x3669,
        0x165C, 0x0F1B, 0x108E, 0x3B36, 0x055B,
        0x0AE9, 0x3051, 0x1808, 0x357E, 0x30D6,
        0x3F1B, 0x2C12, 0x3BF8, 0x0DB8, 0x140F,
    };

    if((dfacq->N_sat >= 49) || (dfacq->N_sat < 0))
        return -1;

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x3FFF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x3408);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x2000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, Galileo_rep2_CODESTATE2_E5bI[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, Galileo_rep2_CODESTATE2_E5bI[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x2992);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x2000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10229);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, (0b0111) | (3 << 20));

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}

int lct_ism(struct facq_data * dfacq){

    unsigned long LCT_ISM_CODESTATE[] = {
        01550, 00337, 00016, 00310, 00543, 00157, 00003, 00013, 00001, 00065
    };

    if((dfacq->N_sat > 10) || (dfacq->N_sat < 0))
        return -1;

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, 0x3FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, 0x3FF);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x204);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x200);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, LCT_ISM_CODESTATE[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, LCT_ISM_CODESTATE[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x3A6);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x200);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  1023-1);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (0<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}

int loc_l2o(struct facq_data * dfacq){

    unsigned long LOC_L2O_CODESTATE[] = { // Initial 25 chips
                                          0b1111111111111111111111111,
                                          0b1011000100000100101110010,
                                          0b1010001010101111011101101,
                                          0b0010111101110111111000000,
                                          0b0000110110111101011110100,
                                          0b1101101000001110000101110,
                                          0b1011110011111000001111110,
                                          0b1110100001001101101100100,
                                          0b0001101001000011101001001,
                                          0b0100011101010100000100000
                                        };

    if((dfacq->N_sat > 10) || (dfacq->N_sat < 0))
        return -1;

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state1_off, LOC_L2O_CODESTATE[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state1_off, LOC_L2O_CODESTATE[dfacq->N_sat]);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask1_off, 0x4);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask1_off, 0x0000200);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_state2_off, LOC_L2O_CODESTATE[dfacq->N_sat]>>14);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_reset_state2_off, LOC_L2O_CODESTATE[dfacq->N_sat]>>14);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_bitmask2_off, 0x400);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_code_out_bitmask2_off, 0x00000000);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_length_off,  10230-1);

    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_init_off, 0);
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_ovl_off, 0); // no overlay

    // extend psp for prestore
    unsigned int freq_div_reg;
    freq_div_reg = (2<<0) & ((1<<FREQ_DIV_SIZE)-1);
    freq_div_reg = freq_div_reg | (0<<GPS_L5_RESET_EN_OFF) | (1<<SINGLE_SR_OFF); // GPS_L5_RESET_EN - OFF
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_psp_freq_div_off, freq_div_reg);//freq divider value and GPS_L5_CONTROL

    // do init
    axi_write(dfacq->pBASE, dfacq->facq_module_offset[fsm_controller_regs] + fsm_acq_controller_control_off, 1<<fsm_acq_controller_conf_do_init);

    return 0;
}
