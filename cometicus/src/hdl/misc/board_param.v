// Параметры, индивидуальные для платы

`define ADDR_WIDTH     16

`define IRQ_NUM    5

`define M_AXI_GP_NUM  1
`define AXI_HP_NUM    2
`define AXI_GP_WIDTH  32
`define AXI_HP_WIDTH  64



//MANUAL - конфиг Ивана, CI - облегченный,BUILD_MAX - самый жирный, заточен на ФИС, BUILD_MAX_RX - самый жирный на прием
`define MANUAL
// `define BUILD_MAX

`ifdef MANUAL
 
    // боевой режим на все деньги
    // `define CORR_CHANNELS  75
    // `define FACQ_FREQ_DIV  9 // делитель частоты с 1ГГц для ядра поиска
    // `define FACQ_SIZE      512 // размер ядра
    // `define FACQ_MEM_SIZE  (5*204600) // объем памяти в отсчетах

    // ничетак
    // `define CORR_CHANNELS 12
    // `define FACQ_FREQ_DIV 12
    // `define FACQ_SIZE     512
    // `define FACQ_MEM_SIZE (5*204600)
    
    // ЛАЙТ
    `define CORR_CHANNELS 1
    `define FACQ_FREQ_DIV 12
    `define FACQ_SIZE     256
    `define FACQ_MEM_SIZE (2**19) // 524288

    // бомбапоиск
    // `define CORR_CHANNELS  1
    // `define FACQ_FREQ_DIV  9 // делитель частоты с 1ГГц для ядра поиска
    // `define FACQ_SIZE      4096 // размер ядра
    // `define FACQ_MEM_SIZE  (15*204600) // объем памяти в отсчетах

    // режим напопробоватьсобрать
    // `define CORR_CHANNELS  2
    // `define FACQ_FREQ_DIV  50 // делитель частоты с 1ГГц для ядра поиска
    // `define FACQ_SIZE      10 // размер ядра
    // `define FACQ_MEM_SIZE  10 // объем памяти в отсчетах

    // Imitator config:
    // // // `define IMI_CHANNELS   6
    `define IMI_CHANNELS   1
    `define IMI_OUTWIDTH   12
    `define NORMALIZER_T_W 16
    `define IMI_NORM_DATCOLL

    `define FACQ
    // `define FACQ_DATCOLL
    // `define FACQ_DEBUG

    // `define CALIBRATION
    // `define DATCOLL
    `define IMITATOR
    `define VITDEC

`else
`endif

`ifdef CI

    `define CORR_CHANNELS 12
    `define FACQ_FREQ_DIV 12
    `define FACQ_SIZE     64
    `define FACQ_MEM_SIZE (2**19) // 524288
    
    `define IMI_CHANNELS 12
    `define IMI_OUTWIDTH 12
    `define NORMALIZER_T_W 16

    
    `define FACQ
    `define DATCOLL
    `define IMITATOR
    `define VITDEC
    
`else 
`endif

`ifdef BUILD_MAX

    `define CORR_CHANNELS 24
    `define FACQ_FREQ_DIV 8
    `define FACQ_SIZE 512
    `define FACQ_MEM_SIZE (2**19) // 524288
    
    `define IMI_CHANNELS   36
    `define IMI_OUTWIDTH   12
    `define NORMALIZER_T_W 16
    `define IMI_NORM_DATCOLL
    `define NORM_DATCOLL_SIZE 4096

    `define FACQ
    `define DATCOLL
    `define IMITATOR
    `define VITDEC
    
`else 



`endif

`ifdef BUILD_MAX_RX

    `define CORR_CHANNELS 56
    `define FACQ_FREQ_DIV 8
    `define FACQ_SIZE 512
    `define FACQ_MEM_SIZE (2**19) // 524288
    
    `define IMI_CHANNELS   4
    `define IMI_OUTWIDTH   12
    `define NORMALIZER_T_W 16
    `define IMI_NORM_DATCOLL

    
    `define FACQ
    `define DATCOLL
    `define IMITATOR
    `define VITDEC
    
`else 



`endif
