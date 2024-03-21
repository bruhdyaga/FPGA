#ifndef ID_DB
#define ID_DB

const unsigned int numOfModIDs = 65;

unsigned int IDs[] = {
    //ID list
    0x19BE,// 'acq_freq_shift'       | 
    0xAB2C,// 'acq_prestore'         | 
    0x1760,// 'max_args'             | 
    0x6237,// 'dds_sin_cos'          | 
    0x4E46,// 'dds_bin'              | 
    0x655C,// 'acq_bram_controller'  | 
    0xF646,// 'fsm_acq_controller'   | 
    0x18F8,// 'acq_ip'               | 
    0x46E4,// 'connectbus'           | 
    0x0074,// 'time_ch'              | 
    0xD090,// 'axi_trig'             | 
    0xE7E1,// 'z706_deser'           | 
    0x0037,// 'psp_gen'              | 
    0x0011,// 'irq_ctrl'             | 
    0xAB13,// 'corr_ch'              | 
    0xD8DC,// 'oryx'                 | 
    0xE004,// 'sigmag_test'          | 
    0x2082,// 'bdss'                 | 
    0xB0BA,// 'data_collector'       | 
    0xD627,// 'trcv'                 | 
    0xE9D2,// 'time_com'             | 
    0xA1E1,// 'ref_in_interpretator' | 
    0x474B,// 'calibration'          | 
    0x1FE9,// 'stuff'                | 
    0x1C40,// 'frequency_counter'    | 
    0x8BFF,// 'RGB'                  | 
    0xB1AA,// 'cmpo_deser'           | 
    0xF51E,// 'axi_performance'      | 
    0xF701,// 'axi_hp_performance'   | 
    0x2859,// 'axi_hp_master'        | 
    0xF877,// 'cov_matrix'           | 
    0xF507,// 'crpa_old'             | 
    0x7C41,// 'null_former'          | 
    0xCCDE,// 'crpa'                 | 
    0x2452,// 'XADC_7000'            | 
    0x6BF8,// 'imi_channel'          | 
    0xEA6C,// 'vitterby_dec'         | 
    0xCACD,// 'gps_ca_prn_gen'       | my_counter_test
    0xF5A0,// 'FIR'                  | fir
    0xA7DD,// 'HETERODYNE'           | heterodyne
    0x0924,// 'cvm_ram'              | 
    0xD95F,// 'imitator'             | imitator TOP
    0xEF19,// 'dma_intbus_axi_hp'    | dma на базе int_bus и OCM через axi_hp
    0x0000,// 'empty'                | заглушка для выравнивания адресного пространства
    0xADC0,// 'axi_uartlite_spi'     | axi UART lite c физическим уровнем SPI
    0xC1FA,// 'axi_uart'             | axi UART
    0xB0BE,// 'data_recorder'        | data_recorder TEMP
    0xBE3D,// 'adc_interconnect'     | мультиплексор шин adc M в N
    0x6468,// 'decimator'            | decimator
    0xA7CC,// 'samtec_ddr_decoder'   | приемный модуль в oryx от платы ацп
    0x2BD2,// 'cspp_adc_deser'       | управление десером CSPP
    0xB4BE,// 'cspp'                 | CSPP
    0x0826,// 'prn_ram'              | таблиный генератор ПСП
    0x0BD1,// 'dma'                  | контроллер DMA на базе шины ACP
    0x6756,// 'mem_controller'       | контроллер памяти для поицка
    0x18DD,// 'fir_syst'             | систолический FIR с симметричными коэффициентами
    0xD2CD,// 'prn_gen_facq'         | регистровый генератор ПСП идентичный корреляторному, но адаптированный под DMA
    0xCE4E,// 'facq_prn_ram'         | табличный генератор ПСП для блока поиска
    0xB1DF,// 'dsp_lut_iq'           | табличный LUT для преобразования сигнала
    0x512D,// 'normalizer'           | табличный normalizer
    0xF6EB,// 'acq_fft_IP'           | поиск на FFT
    0xAA8F,// 'prn_gen_facq_fft'     | prn_gen_facq_fft
    0xB9E4,// 'prestore_fft'         | prestore_fft
    0xF340,// 'lim_cntr'             | расчет превышений порога для лимитера
    0x08D1 // 'heterodyne_up'        | heterodyne_up
    //end of ID list
};

char *IDnamelist[] = {
    (char *)"acq_freq_shift",
    (char *)"acq_prestore",
    (char *)"max_args",
    (char *)"dds_sin_cos",
    (char *)"dds_bin",
    (char *)"acq_bram_controller",
    (char *)"fsm_acq_controller",
    (char *)"acq_ip",
    (char *)"connectbus",
    (char *)"time_ch",
    (char *)"axi_trig",
    (char *)"z706_deser",
    (char *)"psp_gen",
    (char *)"irq_ctrl",
    (char *)"corr_ch",
    (char *)"oryx",
    (char *)"sigmag_test",
    (char *)"bdss",
    (char *)"data_collector",
    (char *)"trcv",
    (char *)"time_com",
    (char *)"ref_in_interpretator",
    (char *)"calibration",
    (char *)"stuff",
    (char *)"frequency_counter",
    (char *)"RGB",
    (char *)"cmpo_deser",
    (char *)"axi_performance",
    (char *)"axi_hp_performance",
    (char *)"axi_hp_master",
    (char *)"cov_matrix",
    (char *)"crpa_old",
    (char *)"null_former",
    (char *)"crpa",
    (char *)"XADC_7000",
    (char *)"imi_channel",
    (char *)"vitterby_dec",
    (char *)"gps_ca_prn_gen",
    (char *)"FIR",
    (char *)"HETERODYNE",
    (char *)"cvm_ram",
    (char *)"imitator",
    (char *)"dma_intbus_axi_hp",
    (char *)"empty",
    (char *)"axi_uartlite_spi",
    (char *)"axi_uart",
    (char *)"data_recorder",
    (char *)"adc_interconnect",
    (char *)"decimator",
    (char *)"samtec_ddr_decoder",
    (char *)"cspp_adc_deser",
    (char *)"cspp",
    (char *)"prn_ram",
    (char *)"dma",
    (char *)"mem_controller",
    (char *)"fir_syst",
    (char *)"prn_gen_facq",
    (char *)"facq_prn_ram",
    (char *)"dsp_lut_iq",
    (char *)"normalizer",
    (char *)"acq_fft_IP",
    (char *)"prn_gen_facq_fft",
    (char *)"prestore_fft",
    (char *)"lim_cntr",
    (char *)"heterodyne_up"
};

typedef enum
{
    acq_freq_shift,
    acq_prestore,
    max_args,
    dds_sin_cos,
    dds_bin,
    acq_bram_controller,
    fsm_acq_controller,
    acq_ip,
    connectbus,
    time_ch,
    axi_trig,
    z706_deser,
    psp_gen,
    irq_ctrl,
    corr_ch,
    oryx,
    sigmag_test,
    bdss,
    data_collector,
    trcv,
    time_com,
    ref_in_interpretator,
    calibration,
    stuff,
    frequency_counter,
    RGB,
    cmpo_deser,
    axi_performance,
    axi_hp_performance,
    axi_hp_master,
    cov_matrix,
    crpa_old,
    null_former,
    crpa,
    XADC_7000,
    imi_channel,
    vitterby_dec,
    gps_ca_prn_gen,
    FIR,
    HETERODYNE,
    cvm_ram,
    imitator,
    dma_intbus_axi_hp,
    empty,
    axi_uartlite_spi,
    axi_uart,
    data_recorder,
    adc_interconnect,
    decimator,
    samtec_ddr_decoder,
    cspp_adc_deser,
    cspp,
    prn_ram,
    dma,
    mem_controller,
    fir_syst,
    prn_gen_facq,
    facq_prn_ram,
    dsp_lut_iq,
    normalizer,
    acq_fft_IP,
    prn_gen_facq_fft,
    prestore_fft,
    lim_cntr,
    heterodyne_up
}
module_name_list;

#endif
