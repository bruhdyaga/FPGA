`timescale 1ns/10ps

`include "global_param.v"
`include "channel_param.v"

/*!
\brief Обмен данными с CPU через регистры карты памяти канала коррелятора
*/
module channel_regfile (
    clk,                // [in]  
    reset_n,            // [in]  
    we_en,              // [in]  write enable 
    rd_en,              // [in]  read enable
    reg_addr,           // [in]  Шина адреса в `ADDR_WIDTH бит
    wdata,              // [in]  Данные на запись
    rdata,              // [out] Данные на чтение
    code_rate_int,      // [in]  Значение кода частоты CODE_RATE из генератора ПСП, защелкнутое в (или по смене эпохи, или последнее записанное значение???) \todo уточнить запись CODE_RATE    
    code_phase_int,     // [in]  Значение cчетчика CODE_PHASE фазы ПСП на чипе, защелкнутое по последнему сигналу снятия измерений
    chip_int,           // [in]  Значение счетчика чипов CHIP из СШВ, защелкнутое по последнему сигналу снятия измерений
    epoch_int,          // [in]  Значение счетчика эпох кода EPOCH из СШВ, защелкнутое по последнему сигналу снятия измерений
    epoch_int_intr,     // [in]  Значение счетчика эпох кода EPOCH из СШВ, защелкнутое по последнему прерыванию
    tow_int,            // [in]  Значение счетчика секунд TOW из СШВ, защелкнутое по последнему сигналу снятия измерений
    symb_int,           // [in]  Значение счетчика символов SYMB из СШВ, защелкнутое по последнему сигналу снятия измерений
    phase_rate_int,     // [in]  Значение управляющего кода частоты PHASE_RATE из генератора sin/cos, защелкнутое по \todo По какому событию?
    phase_int,          // [in]  Значение cчетчика фазы гармоники PHASE из генератора sin/cos, защелкнутое по последнему сигналу снятия измерений
    phase_cycles_int,   // [in]  Значение счетчика циклов опорного колебания PHASE_CYCLES из генератора sin/cos, защелкнутое по последнему сигналу снятия измерений
    dly_epoch_flag_intr,    // [in] Хитрый флаг, показывающий, что EPOCH уже инкрементировался, а до сохранения квадратур дело ещё не дошло (из-за линии задержки в 64 клока)
    
    promtq_int,         // [in]  Корр.суммы Qp для `NUM_ACCUM антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта)
    promti_int,         // [in]  Корр.суммы Ip для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта)
`ifdef EARLY_Q    
    earlyq_int,         // [in]  Корр.суммы Qe для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта) (если определен EARLY_Q)
`endif
`ifdef EARLY_I    
    earlyi_int,         // [in]  Корр.суммы Ie для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта) (если определен EARLY_I)
`endif
`ifdef EARLY_EARLY_Q    
    earlyearlyq_int,    // [in]  Корр.суммы Qee для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта) (если определен EARLY_EARLY_Q)
`endif
`ifdef EARLY_EARLY_I    
    earlyearlyi_int,    // [in]  Корр.суммы Iee для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта) (если определен EARLY_EARLY_I)
`endif
`ifdef LATE_Q           
    lateq_int,          // [in]  Корр.суммы Ql для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта) (если определен LATE_Q)
`endif   
`ifdef LATE_I 
    latei_int,          // [in]  Корр.суммы Il для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта) (если определен LATE_I)
`endif
`ifdef LATE_LATE_Q    
    latelateq_int,      // [in]  Корр.суммы Qll для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта) (если определен LATE_LATE_Q)
`endif
`ifdef LATE_LATE_I    
    latelatei_int,      // [in]  Корр.суммы Ill для `NUM_ACCUM  антенн, защелкнутые по реальной эпохе кода (смена EPOCH + 64 такта) (если определен LATE_LATE_I)
`endif    

    input_reg_re,       // [out] Выбор действительной части входного сигнала, см. CHANNEL_CONFIG карты памяти
    input_reg_im,       // [out] Выбор мнимой части входного сигнала, см. CHANNEL_CONFIG карты памяти
    quadr,              // [out] Установка флага использования квадратурного входа, см. CHANNEL_CONFIG карты памяти

    code_state1,        // [out] Значение для записи в регистр CODE_STATE1 генератора ПСП
    code_bitmask1,      // [out] Значение для записи в регистр CODE_BITMASK1 генератора ПСП
    code_out_bitmask1,  // [out] Значение для записи в регистр CODE_OUT_BITMASK1 генератора ПСП
    code_state2,        // [out] Значение для записи в регистр CODE_STATE2 генератора ПСП
    code_bitmask2,      // [out] Значение для записи в регистр CODE_BITMASK2 генератора ПСП
    code_out_bitmask2,  // [out] Значение для записи в регистр CODE_OUT_BITMASK2 генератора ПСП  
    prn_length,         // [out] Значение для записи в регистр PRN_LENGTH генератора ПСП
    prn_init,           // [out] Значение для записи в регистр PRN_INIT генератора ПСП
    prn_length1,        // [out] Значение для записи в регистр PRN_LENGTH1 генератора ПСП
    prn_init1,          // [out] Значение для записи в регистр PRN_INIT1 генератора ПСП
    
    code_phase_init_wr, // [out] Разрешение на запись в регистр CODE_PHASE_INIT, используемого для инициализации CODE_PHASE по реальной эпохе (смена EPOCH+64 такта)
    chip_and_symb_init_wr,  // [out] Разрешение на запись в регистр CHIP_AND_SYMB_INIT, используемого для инициализации CHIP_AND_SYMB_PHASE по реальной эпохе
    epoch_and_tow_init_wr,  // [out] Разрешение на запись в регистр EPOCH_AND_TOW_INIT, используемого для инициализации EPOCH_AND_TOW по реальной эпохе      
    
    code_rate,          // [out] Значение для инициализации CODE_RATE, используется через промежуточный регистр, применяется по реальной эпохе
    code_phase_init,    // [out] Значение для инициализации CODE_PHASE, используется через промежуточный регистр, применяется по реальной эпохе
    
    chip_counter_init,  // [out] Значение для инициализации CHIP, используется через промежуточный регистр, применяется по реальной эпохе
    chip_max,           // [out] Значение для записи в регистр CHIPS_PER_EPOCH
    
    epoch_counter_init, // [out] Значение для инициализации EPOCH, используется через промежуточный регистр, применяется по реальной эпохе
    epoch_max,          // [out] Значение для записи в регистр EPOCH_PER_SEC, см. регистр EPOCH_PER_SEC_AND_SYMB карты памяти
    
    tow_counter_init,   // [out] Значение для инициализации TOW, используется через промежуточный регистр, применяется по реальной эпохе
    
    symb_counter_init,  // [out] Значение для инициализации SYMB, используется через промежуточный регистр, применяется по реальной эпохе
    symb_max,           // [out] Значение для записи в регистр SYMB_MAX, см. регистр EPOCH_PER_SEC_AND_SYMB карты памяти
    
`ifdef BOC_MOD    
    sub_cnt_init,       // [out] Значение для записи в промежуточный регистр, используемый для инициализации SUB_CNT по ??? (\todo уточнить событие), см. регистр BOC_CTRL карты памяти
    sub_code_init,      // [out] Начальное значение поднесущей (задает +1 или -1, записывается через временный регистр), см. регистр BOC_CTRL карты памяти
    sub_ratio,          // [out] Соотношение частоты поднесущей и скорости ПСП. 0 - отключить поднесущую, см. регистр BOC_CTRL карты памяти
    shift_ratio,        // [out] Соотношение темпа выдачи импульсов shift и половины периода поднесущей, см. регистр BOC_CTRL карты памяти
`endif    
    doinit,             // [out] Значение, записанное в CODE_DOINIT
    
    phase_rate,         // [out] Значение для записи в регистр PHASE_RATE (через временный регистр, будет применено при следующей реальной эпохе)
    
`ifdef EARLY_I
    delay1,             // [out] Задержка e, l компонент относительно p, см. регистр CHANNEL_CONFIG2
`elsif EARLY_Q
    delay1,
`elsif LATE_I
    delay1,
`elsfif LATE_Q
    delay1,		
`endif
`ifdef EARLY_EARLY_I
    delay2,             // [out] Задержка ee, ll компонент относительно p, см. регистр CHANNEL_CONFIG2			
`elsif EARLY_EARLY_Q
    delay2,
`elsif LATE_LATE_I
    delay2,
`elsif LATE_LATE_Q
    delay2,         
`endif    
    iq_shift            // [out] Делитель I,Q, см. регистр CHANNEL_CONFIG2        
    );
    
    parameter BASE_ADDR=`ADDR_WIDTH'h8000;
    
    input clk;
    input reset_n;
    input we_en;
    input rd_en;  
    input [`ADDR_WIDTH - 1 : 0] reg_addr;
    input [31 : 0] wdata;
    output [31 : 0] rdata;
    input [31 : 0] code_rate_int;
    input [31 : 0] code_phase_int;
    input [23 : 0] chip_int;
    input [9 : 0] epoch_int;
    input [9 : 0] epoch_int_intr;
    input [19 : 0] tow_int;
    input [4 : 0] symb_int;        
    input [31 : 0] phase_rate_int;
    input [31 : 0] phase_int;
    input [31 : 0] phase_cycles_int;
    input dly_epoch_flag_intr;
    input [16 * `NUM_ACCUM - 1 : 0] promtq_int;
    input [16 * `NUM_ACCUM - 1 : 0] promti_int;
`ifdef EARLY_Q    
    input [16 * `NUM_ACCUM - 1 : 0] earlyq_int;
`endif
`ifdef EARLY_I    
    input [16 * `NUM_ACCUM - 1 : 0] earlyi_int;
`endif    
`ifdef EARLY_EARLY_Q
    input [16 * `NUM_ACCUM - 1 : 0] earlyearlyq_int;
`endif
`ifdef EARLY_EARLY_I    
    input [16 * `NUM_ACCUM - 1 : 0] earlyearlyi_int;
`endif
`ifdef LATE_Q    
    input [16 * `NUM_ACCUM - 1 : 0] lateq_int;
`endif
`ifdef LATE_I    
    input [16 * `NUM_ACCUM - 1 : 0] latei_int;
`endif    
`ifdef LATE_LATE_Q
    input [16 * `NUM_ACCUM - 1 : 0] latelateq_int;
`endif
`ifdef LATE_LATE_I    
    input [16 * `NUM_ACCUM - 1 : 0] latelatei_int;
`endif    
    output [4 : 0] input_reg_re;
    output [4 : 0] input_reg_im;
    output quadr;
    output [31 : 0] code_state1;
    output [31 : 0] code_bitmask1;
    output [31 : 0] code_out_bitmask1;
    output [31 : 0] code_state2;
    output [31 : 0] code_bitmask2;
    output [31 : 0] code_out_bitmask2;    
    output [31 : 0] prn_length;  
    output [31 : 0] prn_init;
    output [31 : 0] prn_length1;
    output [31 : 0] prn_init1;
    output code_phase_init_wr;
    output chip_and_symb_init_wr;
    output epoch_and_tow_init_wr;
    output [31 : 0] code_rate;    
    output [31 : 0] code_phase_init;    
    output [23 : 0] chip_counter_init;
    output [23 : 0] chip_max;    
    output [9 : 0] epoch_counter_init;
    output [9 : 0] epoch_max;
    output [19 : 0] tow_counter_init;
    output [4 : 0] symb_counter_init;
    output [4 : 0] symb_max; 
`ifdef BOC_MOD
    output [`BOC_REG_WIDTH - 1 : 0] sub_cnt_init;
    output sub_code_init;
    output [`BOC_REG_WIDTH - 1 : 0] sub_ratio;
    output [`BOC_REG_WIDTH - 1 : 0] shift_ratio;
`endif    
    output [15 : 0] doinit;
    output [31 : 0] phase_rate;
`ifdef EARLY_I
    output [5 : 0] delay1;
`elsif EARLY_Q
    output [5 : 0] delay1;
`elsif LATE_I
    output [5 : 0] delay1;
`elsif LATE_Q
    output [5 : 0] delay1;
`endif
`ifdef EARLY_EARLY_I
    output [5 : 0] delay2;
`elsif EARLY_EARLY_Q
    output [5 : 0] delay2;
`elsif LATE_LATE_I
    output [5 : 0] delay2;
`elsif LATE_LATE_Q
    output [5 : 0] delay2;
`endif    
    output [1 : 0] iq_shift;
  
    reg [31 : 0] code_state1;
    reg [31 : 0] code_bitmask1;
    reg [31 : 0] code_out_bitmask1;
    reg [31 : 0] code_state2;
    reg [31 : 0] code_bitmask2;
    reg [31 : 0] code_out_bitmask2;
    reg [31 : 0] prn_length;
    reg [31 : 0] prn_init;
    reg [31 : 0] prn_length1;
    reg [31 : 0] prn_init1;
    reg [31 : 0] code_rate;  
    reg [31 : 0] code_phase_init;
    reg [23 : 0] chip_counter_init;
    reg [23 : 0] chip_max;  
    reg [9 : 0] epoch_counter_init;
    reg [9 : 0] epoch_max;   
    reg [19 : 0] tow_counter_init;    
    reg [4 : 0] symb_counter_init;
    reg [4 : 0] symb_max; 
`ifdef BOC_MOD
    reg [`BOC_REG_WIDTH - 1 : 0] sub_cnt_init;
    reg sub_code_init;    
    reg [`BOC_REG_WIDTH - 1 : 0] sub_ratio;    
    reg [`BOC_REG_WIDTH - 1 : 0] shift_ratio;    
`endif    
    reg [15 : 0 ] doinit;
    reg [31 : 0] phase_rate;
`ifdef EARLY_I
    reg [5 : 0] delay1;
`elsif EARLY_Q
    reg [5 : 0] delay1;
`elsif LATE_I
    reg [5 : 0] delay1;
`elsif LATE_Q  
    reg [5 : 0] delay1;
`endif  
`ifdef EARLY_EARLY_I
    reg [5 : 0] delay2;
`elsif EARLY_EARLY_Q
    reg [5 : 0] delay2;
`elsif LATE_LATE_I
    reg [5 : 0] delay2;
`elsif LATE_LATE_Q  
    reg [5 : 0] delay2;
`endif  
    reg [1 : 0] iq_shift;
    reg [4 : 0] input_reg_re;  
    reg [4 : 0] input_reg_im;
    reg quadr;
    reg [31 : 0] rdata1;
    reg [31 : 0] rdata2 [`NUM_ACCUM - 1 : 0];    
    
`ifdef EARLY_Q
`ifdef EARLY_I
`else
    wire [16 * `NUM_ACCUM - 1 : 0] earlyi_int;
    assign earlyq_int = 16 * `NUM_ACCUM{1'b0};
`endif    
`endif
`ifdef EARLY_I
`ifdef EARLY_Q
`else
    wire [16 * `NUM_ACCUM - 1 : 0] earlyq_int;
    assign earlyq_int = 16 * `NUM_ACCUM{1'b0};
`endif    
`endif    
    
    wire [31 : 0] rdata_int[`NUM_ACCUM - 1 : 0];
    wire [31 : 0] rdata;
  
    wire channel_config_wr;
    wire code_state1_wr;
    wire code_bitmask1_wr;
    wire code_out_bitmask1_wr;
    wire code_state2_wr;
    wire code_bitmask2_wr;
    wire code_out_bitmask2_wr;
    wire code_rate_wr;
    wire code_phase_init_wr;
    wire prn_length_wr;
    wire prn_init_wr;
    wire prn_length1_wr;
    wire prn_init1_wr;
    wire chips_per_epoch_wr;
    wire chips_per_epoch_init_wr;
    wire doinit_wr;
    wire phase_rate_wr;
    wire channel_config2_wr;
`ifdef BOC_MOD
    wire boc_regs_wr;
`endif        
  
    wire channel_config_rd;
    wire code_state1_rd;
    wire code_bitmask1_rd;
    wire code_out_bitmask1_rd;
    wire code_state2_rd;
    wire code_bitmask2_rd;
    wire code_out_bitmask2_rd;
    wire prn_length_rd;
    wire prn_init_rd;
    wire prn_length1_rd;
    wire prn_init1_rd;
    wire phase_rate_int_rd;
    wire phase_int_rd;
    wire phase_cycles_int_rd;
    wire [`NUM_ACCUM - 1 : 0] ipqp_int_rd;
`ifdef EARLY_I
    wire [`NUM_ACCUM - 1 : 0]  ie1qe1_int_rd;
`elsif EARLY_Q
    wire [`NUM_ACCUM - 1 : 0] ie1qe1_int_rd;
`endif
`ifdef LATE_I
    wire [`NUM_ACCUM - 1 : 0] il1ql1_int_rd;
`elsif LATE_Q)    
    wire [`NUM_ACCUM - 1 : 0] il1ql1_int_rd;
`endif
`ifdef EARLY_EARLY_I
    wire [`NUM_ACCUM - 1 : 0] ie2qe2_int_rd;
`elsif EARLY_EARLY_Q
    wire [`NUM_ACCUM - 1 : 0] ie2qe2_int_rd;
`endif    
`ifdef LATE_LATE_I
    wire [`NUM_ACCUM - 1 : 0] il2ql2_int_rd;
`elsif LATE_LATE_Q
    wire [`NUM_ACCUM - 1 : 0] il2ql2_int_rd;
`endif
`ifdef BOC_MOD
    wire boc_regs_rd;
`endif     
    
  
    assign channel_config_wr = (reg_addr == `CHANNEL_CONFIG_OFFSET) & we_en;
    assign code_state1_wr = (reg_addr == `CODE_STATE1_OFFSET) & we_en;
    assign code_bitmask1_wr = (reg_addr == `CODE_BITMASK1_OFFSET) & we_en;
    assign code_out_bitmask1_wr = (reg_addr == `CODE_OUT_BITMASK1_OFFSET) & we_en;
    assign code_state2_wr = (reg_addr == `CODE_STATE2_OFFSET) & we_en;
    assign code_bitmask2_wr = (reg_addr == `CODE_BITMASK2_OFFSET) & we_en;
    assign code_out_bitmask2_wr = (reg_addr == `CODE_OUT_BITMASK2_OFFSET) & we_en;
    assign prn_length_wr = (reg_addr == `PRN_LENGTH_OFFSET) & we_en;
    assign prn_init_wr = (reg_addr == `PRN_INIT_OFFSET) & we_en;
    assign prn_length1_wr = (reg_addr == `PRN_LENGTH1_OFFSET) & we_en;
    assign prn_init1_wr = (reg_addr == `PRN_INIT1_OFFSET) & we_en;
    assign code_rate_wr = (reg_addr == `CODE_RATE_OFFSET) & we_en;
    assign doinit_wr = (reg_addr == `CODE_DOINIT_OFFSET) & we_en;
    assign chip_max_wr = (reg_addr == `CHIP_MAX_OFFSET) & we_en;
    assign chip_and_symb_init_wr = (reg_addr == `CHIP_AND_SYMB_INIT_OFFSET) & we_en;
    assign epoch_and_symb_max_wr = (reg_addr == `EPOCH_AND_SYMB_MAX_OFFSET) & we_en;
    assign epoch_and_tow_init_wr = (reg_addr == `EPOCH_AND_TOW_INIT_OFFSET) & we_en;
    assign code_phase_init_wr = (reg_addr == `CODE_PHASE_INIT_OFFSET) & we_en;    
    assign phase_rate_wr = (reg_addr == `PHASE_RATE_OFFSET) & we_en;
    assign channel_config2_wr = (reg_addr == `CHANNEL_CONFIG2_OFFSET) & we_en;
`ifdef BOC_MOD
    assign boc_regs_wr = (reg_addr == `BOC_REGS_OFFSET) & we_en;
`endif    
  
    assign channel_config_rd = (reg_addr == `CHANNEL_CONFIG_OFFSET) & rd_en;
    assign code_state1_rd = (reg_addr == `CODE_STATE1_OFFSET) & rd_en;
    assign code_bitmask1_rd = (reg_addr == `CODE_BITMASK1_OFFSET) & rd_en;
    assign code_out_bitmask1_rd = (reg_addr == `CODE_OUT_BITMASK1_OFFSET) & rd_en;
    assign code_state2_rd = (reg_addr == `CODE_STATE2_OFFSET) & rd_en;
    assign code_bitmask2_rd = (reg_addr == `CODE_BITMASK2_OFFSET) & rd_en;
    assign code_out_bitmask2_rd = (reg_addr == `CODE_OUT_BITMASK2_OFFSET) & rd_en;  
    assign prn_length_rd = (reg_addr == `PRN_LENGTH_OFFSET) & rd_en;
    assign prn_init_rd = (reg_addr == `PRN_INIT_OFFSET) & rd_en;
    assign prn_length1_rd = (reg_addr == `PRN_LENGTH1_OFFSET) & rd_en;
    assign prn_init1_rd = (reg_addr == `PRN_INIT1_OFFSET) & rd_en;
    assign code_rate_rd = (reg_addr == `CODE_RATE_OFFSET) & rd_en;
    assign code_phase_rd = (reg_addr == `CODE_PHASE_OFFSET) & rd_en;
    assign chip_max_rd = (reg_addr == `CHIP_MAX_OFFSET) & rd_en;
    assign chip_and_symb_rd = (reg_addr == `CHIP_AND_SYMB_OFFSET) & rd_en;
    assign epoch_and_symb_max_rd = (reg_addr == `EPOCH_AND_SYMB_MAX_OFFSET) & rd_en;
    assign epoch_and_tow_rd = (reg_addr == `EPOCH_AND_TOW_OFFSET) & rd_en;
    assign epoch_intr_rd = (reg_addr == `EPOCH_INTR_OFFSET) & rd_en;
    assign phase_rate_int_rd = (reg_addr == `PHASE_RATE_OFFSET) & rd_en;
    assign phase_int_rd = (reg_addr == `PHASE_OFFSET) & rd_en;
    assign phase_cycles_int_rd = (reg_addr == `PHASE_CYCLES_OFFSET) & rd_en;
`ifdef BOC_MOD
    assign boc_regs_rd = (reg_addr == `BOC_REGS_OFFSET) & rd_en;
`endif    
  
  
    genvar iAcc;
    generate
        for (iAcc = 0; iAcc < `NUM_ACCUM; iAcc = iAcc + 1) begin:READ_PULSE
            assign ipqp_int_rd[iAcc] = (reg_addr == (`IPQP_OFFSET + iAcc * 5)) & rd_en;
`ifdef EARLY_I 
            assign ie1qe1_int_rd[iAcc] = (reg_addr == (`IE1QE1_OFFSET + iAcc * 5)) & rd_en;
`elsif EARLY_Q             
            assign ie1qe1_int_rd[iAcc] = (reg_addr == (`IE1QE1_OFFSET + iAcc * 5)) & rd_en;
`endif
`ifdef LATE_I
            assign il1ql1_int_rd[iAcc] = (reg_addr == (`IL1QL1_OFFSET + iAcc * 5)) & rd_en;
`elsif LATE_Q              
            assign il1ql1_int_rd[iAcc] = (reg_addr == (`IL1QL1_OFFSET + iAcc * 5)) & rd_en;
`endif
`ifdef EARLY_EARLY_I
            assign ie2qe2_int_rd[iAcc] = (reg_addr == (`IE2QE2_OFFSET + iAcc * 5)) & rd_en;
`elsif EARLY_EARLY_Q            
            assign ie2qe2_int_rd[iAcc] = (reg_addr == (`IE2QE2_OFFSET + iAcc * 5)) & rd_en;
`endif
`ifdef LATE_LATE_I
            assign il2ql2_int_rd[iAcc] = (reg_addr == (`IL2QL2_OFFSET + iAcc * 5)) & rd_en;
`elsif LATE_LATE_Q            
            assign il2ql2_int_rd[iAcc] = (reg_addr == (`IL2QL2_OFFSET + iAcc * 5)) & rd_en;
`endif                    
        end
    endgenerate  
  
    //Process registers
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_state1 <= 32'b0;
        end
        else begin
            if (code_state1_wr) begin
                code_state1 <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            input_reg_re <= 5'b0;
            input_reg_im <= 5'b0;
            quadr <= 1'b0;
        end
        else begin
            if (channel_config_wr) begin
            	quadr <= wdata[1];
                input_reg_re <= wdata[6 : 2];
                input_reg_im <= wdata[11 : 7];
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_bitmask1 <= 32'b0;
        end
        else begin
            if (code_bitmask1_wr) begin
                code_bitmask1 <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_out_bitmask1 <= 32'b0;
        end
        else begin
            if (code_out_bitmask1_wr) begin
                code_out_bitmask1 <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_state2 <= 32'b0;
        end
        else begin
            if (code_state2_wr) begin
                code_state2 <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_bitmask2 <= 32'b0;
        end
        else begin
            if (code_bitmask2_wr) begin
                code_bitmask2 <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_out_bitmask2 <= 32'b0;
        end
        else begin
            if (code_out_bitmask2_wr) begin
                code_out_bitmask2 <= wdata;
            end      
        end
    end    
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            prn_length <= 32'b0;
        end
        else begin
            if (prn_length_wr) begin
                prn_length <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            prn_init <= 32'b0;
        end
        else begin
            if (prn_init_wr) begin
                prn_init <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            prn_length1 <= 32'b0;
        end
        else begin
            if (prn_length1_wr) begin
                prn_length1 <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
              prn_init1 <= 32'b0;
        end
        else begin
            if (prn_init1_wr) begin
                prn_init1 <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_rate <= 32'b0;
        end
        else begin
            if (code_rate_wr) begin
                code_rate <= wdata;
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_phase_init <= 32'b0;
        end
        else begin
            if (code_phase_init_wr) begin
                code_phase_init <= wdata;
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            chip_max <= 24'b0;            
        end
        else begin
            if (chip_max_wr) begin
                chip_max <= wdata[23 : 0];                
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            chip_counter_init <= 24'b0;
            symb_counter_init <= 5'b0;
        end
        else begin
            if (chip_and_symb_init_wr) begin
                chip_counter_init <= wdata[23 : 0];
                symb_counter_init <= wdata[28 : 24];
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_counter_init <= 10'b0;
            tow_counter_init <= 20'b0;
        end
        else begin
            if (epoch_and_tow_init_wr) begin
                epoch_counter_init <= wdata[9 : 0];
                tow_counter_init <= wdata[29 : 10];
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_max <= 10'b0;  
            symb_max <= 5'b0;          
        end
        else begin
            if (epoch_and_symb_max_wr) begin
                epoch_max <= wdata[9 : 0];
                symb_max <= wdata[14 : 10];                
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            doinit <= 16'b0;
        end
        else begin
            if (doinit_wr) begin
                doinit <= wdata[31 : 16];
            end      
            else begin
                doinit <= 16'b0;
            end
        end
    end   
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            phase_rate <= 32'b0;
        end
        else begin
            if (phase_rate_wr) begin
                phase_rate <= wdata;
            end      
        end
    end 
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
`ifdef EARLY_I
            delay1 <= 6'b0;
`elsif EARLY_Q
            delay1 <= 6'b0;
`elsif LATE_I
            delay1 <= 6'b0;
`elsif LATE_Q        
            delay1 <= 6'b0;
`endif      
`ifdef EARLY_EARLY_I
            delay2 <= 6'b0;
`elsif EARLY_EARLY_Q
            delay2 <= 6'b0;
`elsif LATE_LATE_I
            delay2 <= 6'b0;
`elsif LATE_LATE_Q
            delay2 <= 6'b0;
`endif      
            iq_shift <= 2'b0;
        end
        else begin
            if (channel_config2_wr) begin
`ifdef EARLY_I
                delay1 <= wdata[5 : 0];
`elsif EARLY_Q
                delay1 <= wdata[5 : 0];
`elsif LATE_I
                delay1 <= wdata[5 : 0];
`elsif LATE_Q      
                delay1 <= wdata[5 : 0];
`endif        
`ifdef EARLY_EARLY_I
                delay2 <= wdata[13 : 8];
`elsif EARLY_EARLY_Q
                delay2 <= wdata[13 : 8];
`elsif LATE_LATE_I
                delay2 <= wdata[13 : 8];
`elsif LATE_LATE_Q
                delay2 <= wdata[13 : 8];
`endif        
                iq_shift <= wdata[25 : 24];
            end      
        end
    end 

`ifdef BOC_MOD    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            shift_ratio <= {`BOC_REG_WIDTH{1'b0}};
            sub_ratio <= {`BOC_REG_WIDTH{1'b0}};
            sub_cnt_init <= {`BOC_REG_WIDTH{1'b0}};
            sub_code_init <= 1'b0;
        end
        else begin
            if (boc_regs_wr) begin
                sub_ratio <= wdata[`BOC_REG_WIDTH - 1 : 0];
                shift_ratio <= wdata[`BOC_REG_WIDTH + 8 - 1 : 8 ];
                sub_cnt_init <= wdata[`BOC_REG_WIDTH + 16 - 1 : 16];
                sub_code_init <= wdata[31];
            end
        end
    end            
`endif        
  
    always @ (*) begin
        rdata1 = {32{1'b0}};
        case (1'b1)
            channel_config_rd       : rdata1 = {8'hcc, 8'b0, 4'b0, input_reg_im, input_reg_re, quadr, 1'b0};
            code_state1_rd          : rdata1 = code_state1;
            code_bitmask1_rd        : rdata1 = code_bitmask1;
            code_out_bitmask1_rd    : rdata1 = code_out_bitmask1;
            code_state2_rd          : rdata1 = code_state2;
            code_bitmask2_rd        : rdata1 = code_bitmask2;
            code_out_bitmask2_rd    : rdata1 = code_out_bitmask2;    
            prn_length_rd           : rdata1 = prn_length;    
            prn_init_rd             : rdata1 = prn_init;    
            prn_length1_rd          : rdata1 = prn_length1;    
            prn_init1_rd            : rdata1 = prn_init1; 
            code_phase_rd           : rdata1 = code_phase_int;
            chip_max_rd             : rdata1 = chip_max;
            epoch_and_symb_max_rd   : rdata1 = {epoch_max, epoch_max};
            chip_and_symb_rd        : rdata1 = {symb_int, chip_int};
            epoch_and_tow_rd        : rdata1 = {tow_int, epoch_int};
            epoch_intr_rd           : rdata1 = {dly_epoch_flag_intr, 21'b0, epoch_int_intr};
            code_rate_rd            : rdata1 = code_rate_int;
            phase_rate_int_rd       : rdata1 = phase_rate_int;  
            phase_int_rd            : rdata1 = phase_int;  
            phase_cycles_int_rd     : rdata1 = phase_cycles_int;
`ifdef BOC_MOD            
            boc_regs_rd             : rdata1 = {sub_code_init, {{15 - `BOC_REG_WIDTH}{1'b0}}, sub_cnt_init, {{8 - `BOC_REG_WIDTH}{1'b0}}, shift_ratio, {{8 - `BOC_REG_WIDTH}{1'b0}}, sub_ratio};
`endif            
        endcase
    end
  
    generate
        for (iAcc = 0; iAcc < `NUM_ACCUM; iAcc = iAcc + 1) begin:READ
            always @ (*) begin
                rdata2[iAcc] = {32{1'b0}};
                case (1'b1)
                    ipqp_int_rd[iAcc]             : rdata2[iAcc] = {promtq_int[16 * iAcc + 16 - 1: 16 * iAcc], promti_int[16 * iAcc + 16 - 1: 16 * iAcc]};
`ifdef EARLY_I 
  `ifdef EARLY_Q
                    ie1qe1_int_rd[iAcc]           : rdata2[iAcc] = {earlyq_int[16 * iAcc + 16 - 1: 16 * iAcc], earlyi_int[16 * iAcc + 16 - 1: 16 * iAcc]};
  `else
                    ie1qe1_int_rd[iAcc]           : rdata2[iAcc] = {16'b0, earlyi_int[16 * iAcc + 16 - 1: 16 * iAcc]};
  `endif
`elsif EARLY_Q		  
                    ie1qe1_int_rd[iAcc]           : rdata2[iAcc] = {earlyq_int[16 * iAcc + 16 - 1: 16 * iAcc], 16'b0};
`endif                    

`ifdef LATE_I
  `ifdef LATE_Q
                    il1ql1_int_rd[iAcc]           : rdata2[iAcc] = {lateq_int[16 * iAcc + 16 - 1: 16 * iAcc], latei_int[16 * iAcc + 16 - 1: 16 * iAcc]};
  `else
                    il1ql1_int_rd[iAcc]           : rdata2[iAcc] = {16'b0, latei_int[16 * iAcc + 16 - 1: 16 * iAcc]};
  `endif
`elsif LATE_Q	  
                    il1ql1_int_rd[iAcc]           : rdata2[iAcc] = {lateq_int[16 * iAcc + 16 - 1: 16 * iAcc], 16'b0};
`endif
		  
`ifdef EARLY_EARLY_I
  `ifdef EARLY_EARLY_Q
                    ie2qe2_int_rd[iAcc]           : rdata2[iAcc] = {earlyearlyq_int[16 * iAcc + 16 - 1: 16 * iAcc], earlyearlyi_int[16 * iAcc + 16 - 1: 16 * iAcc]};
  `else
                    ie2qe2_int_rd[iAcc]           : rdata2[iAcc] = {16'b0, earlyearlyi_int[16 * iAcc + 16 - 1: 16 * iAcc]};
  `endif
`elsif EARLY_EARLY_Q
                    ie2qe2_int_rd[iAcc]           : rdata2[iAcc] = {earlyearlyq_int[16 * iAcc + 16 - 1: 16 * iAcc], 16'b0};
`endif
		  
`ifdef LATE_LATE_I
  `ifdef LATE_LATE_Q
                    il2ql2_int_rd[iAcc]           : rdata2[iAcc] = {latelateq_int[16 * iAcc + 16 - 1: 16 * iAcc], latelatei_int[16 * iAcc + 16 - 1: 16 * iAcc]};
  `else
                    il2ql2_int_rd[iAcc]           : rdata2[iAcc] = {16'b0, latelatei_int[16 * iAcc + 16 - 1: 16 * iAcc]};
  `endif
`elsif LATE_LATE_Q
                    il2ql2_int_rd[iAcc]           : rdata2[iAcc] = {latelateq_int[16 * iAcc + 16 - 1: 16 * iAcc], 16'b0};
`endif                    
                endcase
            end
            if (iAcc!= 0) begin
                assign rdata_int[iAcc] = rdata_int[iAcc - 1] | rdata2[iAcc];
            end
            else begin
                assign rdata_int[iAcc] = rdata2[iAcc];
            end 
        end
    endgenerate
  
    assign rdata = rdata1 | rdata_int[`NUM_ACCUM - 1];

endmodule
