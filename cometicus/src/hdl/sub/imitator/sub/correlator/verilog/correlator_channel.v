`timescale 1ns/10ps

`include "global_param.v"
`include "channel_param.v"

module correlator_channel ( 
    clk,
    pclk,
    reset_n,    
    we_en,
    rd_en,
    reg_addr,
    wdata,
    imi_in,
    adc0_in_re,
	adc1_in_re,
	adc2_in_re,
	adc3_in_re,
	adc4_in_re,
	adc5_in_re,
	adc6_in_re,
	adc7_in_re,
	adc8_in_re,
	adc9_in_re,
	adc10_in_re,
	adc11_in_re,
	adc0_in_im,
	adc1_in_im,
	adc2_in_im,
	adc3_in_im,
	adc4_in_im,
	adc5_in_im,
	adc6_in_im,
	adc7_in_im,
	adc8_in_im,
	adc9_in_im,
	adc10_in_im,
	adc11_in_im,
    intr_pulse,
    fix_pulse,
    rdata    
    );
    
    parameter BASE_ADDR = `ADDR_WIDTH'h8000;
    
    input clk;
    input pclk;
    input reset_n;    
    input we_en;
    input rd_en;
    input [`ADDR_WIDTH - 1 : 0] reg_addr;
    input [31 : 0] wdata;
    input [1 : 0] imi_in;
    input [2 * `NUM_ACCUM - 1 : 0] adc0_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc1_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc2_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc3_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc4_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc5_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc6_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc7_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc8_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc9_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc10_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc11_in_re;
	input [2 * `NUM_ACCUM - 1 : 0] adc0_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc1_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc2_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc3_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc4_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc5_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc6_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc7_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc8_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc9_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc10_in_im;
	input [2 * `NUM_ACCUM - 1 : 0] adc11_in_im;
    input intr_pulse;
    input fix_pulse;
    output [31 : 0] rdata;    
    
    wire [31 : 0] code_state1;
    wire [31 : 0] code_bitmask1;
    wire [31 : 0] code_out_bitmask1;
    wire [31 : 0] code_state2;
    wire [31 : 0] code_bitmask2;
    wire [31 : 0] code_out_bitmask2;
    wire [31 : 0] code_phase_int;
    wire [23 : 0] chip_int;
    wire [9 : 0] epoch_int;
    wire [9 : 0] epoch_int_intr;
    wire [19 : 0] tow_int;
    wire [4 : 0] symb_int;
    wire [31 : 0] code_rate;
    wire [31 : 0] code_phase_init;
    wire [23 : 0] chip_counter_init;
    wire [23 : 0] chip_max;    
    wire [9 : 0] epoch_counter_init;
    wire [9 : 0] epoch_max;
    wire [19 : 0] tow_counter_init;
    wire [4 : 0] symb_counter_init;
    wire [4 : 0] symb_max;
    wire [31 : 0] code_rate_int;
    wire [31 : 0] prn_length;
    wire [31 : 0] prn_init;
    wire [31 : 0] prn_length1;
    wire [31 : 0] prn_init1;
    wire [31 : 0] phase_rate;
    wire [15 : 0] doinit_pulse; 

    wire [31 : 0] phase_rate_int;
    wire [31 :0] phase_int;
    wire [31 : 0] phase_cycles_int;  
    wire [4 : 0] cos_product [`NUM_ACCUM - 1 : 0];
    wire [4 : 0] sin_product [`NUM_ACCUM - 1 : 0];
    wire [4 : 0] cos_product_t [`NUM_ACCUM - 1 : 0];
    wire [4 : 0] sin_product_t [`NUM_ACCUM - 1 : 0];
    wire [4 : 0] cmplx_product_re [`NUM_ACCUM - 1 : 0];
    wire [4 : 0] cmplx_product_im [`NUM_ACCUM - 1 : 0];
    wire [4 : 0] phase_addr;
    wire [4 : 0] promt_cos_product [`NUM_ACCUM - 1 : 0];
    wire [4 : 0] promt_sin_product [`NUM_ACCUM - 1 : 0];
`ifdef EARLY_I    
    wire [4 : 0] early_cos_product [`NUM_ACCUM - 1 : 0];
`endif
`ifdef EARLY_Q    
    wire [4 : 0] early_sin_product [`NUM_ACCUM - 1 : 0];
`endif    
`ifdef EARLY_EARLY_I
    wire [4 : 0] earlyearly_cos_product [`NUM_ACCUM - 1 : 0];
`endif
`ifdef EARLY_EARLY_Q    
    wire [4 : 0] earlyearly_sin_product [`NUM_ACCUM - 1 : 0];
`endif
`ifdef LATE_I    
    wire [4 : 0] late_cos_product [`NUM_ACCUM - 1 : 0];
`endif
`ifdef LATE_Q    
    wire [4 : 0] late_sin_product [`NUM_ACCUM - 1 : 0];
`endif
`ifdef LATE_LATE_I    
    wire [4 : 0] latelate_cos_product [`NUM_ACCUM - 1 : 0];
`endif
`ifdef LATE_LATE_Q    
    wire [4 : 0] latelate_sin_product [`NUM_ACCUM - 1 : 0];
`endif        
`ifdef EARLY_I
    wire [5 : 0] delay1;
`elsif EARLY_Q
    wire [5 : 0] delay1;
`elsif LATE_I
    wire [5 : 0] delay1;
`elsif LATE_Q
    wire [5 : 0] delay1;                  
//`ifdef ((EARLY_I | EARLY_Q) | (LATE_I | LATE_Q))    
//    wire [5 : 0] delay1;
`endif
`ifdef EARLY_EARLY_I
    wire [5 : 0] delay2;
`elsif EARLY_EARLY_Q
    wire [5 : 0] delay2;
`elsif LATE_LATE_I
    wire [5 : 0] delay2;
`elsif LATE_LATE_Q   
    wire [5 : 0] delay2;           
//`ifdef ((EARLY_EARLY_I | EARLY_EARLY_Q) | (LATE_LATE_I | LATE_LATE_Q))
//    wire [5 : 0] delay2;
`endif    
    wire [1 : 0] iq_shift;
    wire [4 : 0] input_reg_re;
    wire [4 : 0] input_reg_im;
    wire [2 * `NUM_ACCUM - 1 : 0] sample_int_re;
    wire [2 * `NUM_ACCUM - 1 : 0] sample_int_im;    
    wire [15 : 0] promtq_int [`NUM_ACCUM - 1 : 0];
    wire [15 : 0] promti_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] promtq_int_bus;
    wire [16 * `NUM_ACCUM - 1 : 0] promti_int_bus;
`ifdef EARLY_Q    
    wire [15 : 0] earlyq_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] earlyq_int_bus;
`endif
`ifdef EARLY_I    
    wire [15 : 0] earlyi_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] earlyi_int_bus;
`endif
`ifdef EARLY_EARLY_Q        
    wire [15 : 0] earlyearlyq_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] earlyearlyq_int_bus;
`endif
`ifdef EARLY_EARLY_I    
    wire [15 : 0] earlyearlyi_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] earlyearlyi_int_bus;
`endif
`ifdef LATE_Q    
    wire [15 : 0] lateq_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] lateq_int_bus;
`endif
`ifdef LATE_I    
    wire [15 : 0] latei_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] latei_int_bus;
`endif        
`ifdef LATE_LATE_Q
    wire [15 : 0] latelateq_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] latelateq_int_bus;
`endif
`ifdef LATE_LATE_I    
    wire [15 : 0] latelatei_int [`NUM_ACCUM - 1 : 0];
    wire [16 * `NUM_ACCUM - 1 : 0] latelatei_int_bus;
`endif
`ifdef BOC_MOD
    wire [`BOC_REG_WIDTH - 1 : 0] sub_cnt_init;
    wire sub_code_init;    
    wire [`BOC_REG_WIDTH - 1 : 0] sub_ratio;    
    wire [`BOC_REG_WIDTH - 1 : 0] shift_ratio;    
`endif

   wire 			  prn_reset;
  
   
    channel_regfile 
    #(BASE_ADDR) CR (
        .clk                   (clk),
        .reset_n               (reset_n),    
        .we_en                 (we_en),
        .rd_en                 (rd_en),
        .reg_addr              (reg_addr),
        .wdata                 (wdata),
        .rdata                 (rdata),
        .code_rate_int         (code_rate_int),
        .code_phase_int        (code_phase_int),
        .chip_int              (chip_int),
        .epoch_int             (epoch_int),
        .epoch_int_intr        (epoch_int_intr),
        .tow_int               (tow_int),
        .symb_int              (symb_int),
        .phase_rate_int        (phase_rate_int),
        .phase_int             (phase_int),
        .phase_cycles_int      (phase_cycles_int),
        .dly_epoch_flag_intr   (dly_epoch_flag_intr),
		.promtq_int            (promtq_int_bus),
		.promti_int            (promti_int_bus),
`ifdef EARLY_Q		
        .earlyq_int            (earlyq_int_bus),
`endif
`ifdef EARLY_I        
        .earlyi_int            (earlyi_int_bus),
`endif
`ifdef EARLY_EARLY_Q       
        .earlyearlyq_int       (earlyearlyq_int_bus),
`endif
`ifdef EARLY_EARLY_I        
        .earlyearlyi_int       (earlyearlyi_int_bus),
`endif
`ifdef LATE_Q        
        .lateq_int             (lateq_int_bus),
`endif
`ifdef LATE_I        
        .latei_int             (latei_int_bus),
`endif        
`ifdef LATE_LATE_Q
        .latelateq_int         (latelateq_int_bus),
`endif        
`ifdef LATE_LATE_I        
        .latelatei_int         (latelatei_int_bus),
`endif        
        .input_reg_re          (input_reg_re),
        .input_reg_im          (input_reg_im),
        .quadr                 (quadr),
        .code_state1           (code_state1),
        .code_bitmask1         (code_bitmask1),
        .code_out_bitmask1     (code_out_bitmask1),
        .code_state2           (code_state2),
        .code_bitmask2         (code_bitmask2),
        .code_out_bitmask2     (code_out_bitmask2),
        .prn_length            (prn_length),
        .prn_init              (prn_init),
        .prn_length1           (prn_length1),
        .prn_init1             (prn_init1),
        .code_phase_init_wr    (code_phase_init_wr),
        .chip_and_symb_init_wr (chip_and_symb_init_wr),
        .epoch_and_tow_init_wr (epoch_and_tow_init_wr),        
        .code_rate             (code_rate),
        .code_phase_init       (code_phase_init),
        .chip_counter_init     (chip_counter_init),
        .chip_max              (chip_max),
        .epoch_counter_init    (epoch_counter_init),
        .epoch_max             (epoch_max),
        .tow_counter_init      (tow_counter_init),
        .symb_counter_init     (symb_counter_init),
        .symb_max              (symb_max),
`ifdef BOC_MOD    
        .sub_cnt_init          (sub_cnt_init),
        .sub_code_init         (sub_code_init),
        .sub_ratio             (sub_ratio), 
        .shift_ratio           (shift_ratio), 
`endif        
        .doinit                (doinit_pulse),
        .phase_rate            (phase_rate),
`ifdef EARLY_I
        .delay1                (delay1),
`elsif EARLY_Q
        .delay1                (delay1),
`elsif LATE_I        
        .delay1                (delay1),
`elsif LATE_Q         
        .delay1                (delay1),
`endif
`ifdef EARLY_EARLY_I        
        .delay2                (delay2),
`elsif EARLY_EARLY_Q         
        .delay2                (delay2),
`elsif LATE_LATE_I
        .delay2                (delay2),
`elsif LATE_LATE_Q
        .delay2                (delay2),
`endif        
        .iq_shift              (iq_shift)
    );
    
    signal_mux_adc CRMUXADC (
		.pclk            (pclk),
		.reset_n         (reset_n),
		.input_reg_re    (input_reg_re),
		.input_reg_im    (input_reg_im),
		.imi_in          (imi_in),
		.adc0_in_re      (adc0_in_re),
		.adc1_in_re      (adc1_in_re),
		.adc2_in_re      (adc2_in_re),
		.adc3_in_re      (adc3_in_re),
		.adc4_in_re      (adc4_in_re),
		.adc5_in_re      (adc5_in_re),
		.adc6_in_re      (adc6_in_re),
		.adc7_in_re      (adc7_in_re),
		.adc8_in_re      (adc8_in_re),
		.adc9_in_re      (adc9_in_re),
		.adc10_in_re     (adc10_in_re),
		.adc11_in_re     (adc11_in_re),
		.adc0_in_im      (adc0_in_im),
		.adc1_in_im      (adc1_in_im),
		.adc2_in_im      (adc2_in_im),
		.adc3_in_im      (adc3_in_im),
		.adc4_in_im      (adc4_in_im),
		.adc5_in_im      (adc5_in_im),
		.adc6_in_im      (adc6_in_im),
		.adc7_in_im      (adc7_in_im),
		.adc8_in_im      (adc8_in_im),
		.adc9_in_im      (adc9_in_im),
		.adc10_in_im     (adc10_in_im),
		.adc11_in_im     (adc11_in_im),
		.signal_out_re   (sample_int_re),
		.signal_out_im   (sample_int_im)
		);    

   flag_sync_n DO_INIT (
   		.sclk          (clk),
		.dclk          (pclk),
		.reset_n       (reset_n),
		.set_pulse     (doinit_pulse),
		.rst_pulse     (fix_pulse),
		.flag          (doinit)
	); 
   
    flag_sync CODE_PHASE_INIT (
        .sclk          (clk),
        .dclk          (pclk),
        .reset_n       (reset_n),
        .set_pulse     (code_phase_init_wr),
        .rst_pulse     (epoch_pulse),
        .flag          (code_phase_init_wr_sync)
    );
    
    flag_sync EPOCH_AND_TOW_INIT (
        .sclk          (clk),
        .dclk          (pclk),
        .reset_n       (reset_n),
        .set_pulse     (epoch_and_tow_init_wr),
        .rst_pulse     (epoch_pulse),
        .flag          (epoch_and_tow_init_wr_sync)
    );    
    
    flag_sync CHIP_AND_SYMB_INIT (
        .sclk          (clk),
        .dclk          (pclk),
        .reset_n       (reset_n),
        .set_pulse     (chip_and_symb_init_wr),
        .rst_pulse     (epoch_pulse),
        .flag          (chip_and_symb_init_wr_sync)
    );
    
    time_generator 
      #(.SCALE_TYPE            (1'b0))       // 0 - шкала времени сигнала
      CHTG(
        .clk                   (pclk),
        .reset_n               (reset_n),
        .doinit                (doinit),
        .fix_pulse             (fix_pulse),
        .intr_pulse            (fix_pulse),
        .intr_fix_pulse        (intr_pulse),
        .dly_epoch             (dly_epoch),
        .sec_in                (1'b0),
        .cur_time              (1'b0),
        .code_phase_init_wr    (code_phase_init_wr_sync),
        .chip_and_symb_init_wr (chip_and_symb_init_wr_sync),
        .epoch_and_tow_init_wr (epoch_and_tow_init_wr_sync),
        .code_rate             (code_rate),
        .code_phase_init       (code_phase_init),
        .chip_counter_init     (chip_counter_init),
        .chip_max              (chip_max),
        .epoch_counter_init    (epoch_counter_init),
        .epoch_max             (epoch_max),
        .tow_counter_init      (tow_counter_init),
        .symb_counter_init     (symb_counter_init),
        .symb_max              (symb_max),
        .code_rate_int         (code_rate_int),
        .code_phase_int        (code_phase_int),
        .code_phase_sec        (),
        .code_phase_time       (),
        .chip_int              (chip_int),
        .chip_sec              (),
        .chip_time             (),
        .epoch_int             (epoch_int),
        .epoch_sec             (),
        .epoch_time            (),
        .epoch_int_intr        (epoch_int_intr),
        .tow_int               (tow_int),
        .tow_sec               (),
        .tow_time              (),
        .symb_int              (symb_int),
        .symb_sec              (),
        .symb_time             (),
        .shift                 (shift),
        .epoch_pulse           (epoch_pulse),
        .sec_pulse             (),
        .pps_pulse             (),
		.prn_reset             (prn_reset),
		.code_phase_ext        (),
		.chip_and_symb_ext     (),
		.epoch_and_tow_ext     (),
		.dly_epoch_flag_intr   (dly_epoch_flag_intr),
		.pps_max               (10'b0)
    );
    
    channel_shift_reg SR(
        .clk                  (pclk),
        .reset_n              (reset_n),
        .code_state1          (code_state1),
        .code_reset_state1    (code_state1),
        .code_bitmask1        (code_bitmask1),
        .code_out_bitmask1    (code_out_bitmask1),
        .code_state2          (code_state2),
        .code_reset_state2    (code_state2),
        .code_bitmask2        (code_bitmask2),
        .code_out_bitmask2    (code_out_bitmask2),    
        .prn_length           (prn_length),
        .prn_init             (prn_init),
        .prn_length1          (prn_length1),
        .prn_init1            (prn_init1),
        .sr1                  (),
        .sr2                  (),
`ifdef BOC_MOD    
        .sub_cnt_init         (sub_cnt_init),
        .sub_code_init        (sub_code_init),
        .sub_ratio            (sub_ratio),
        .shift_ratio          (shift_ratio),
`endif        
        .doinit               (doinit),    
        .intr_pulse           (fix_pulse),
        .shift                (shift),
        .code_out             (code_out),
		.prn_reset            (prn_reset)
    );
    
    channel_synthesizer CHSYN (
        .clk                  (pclk),
        .reset_n              (reset_n),
        .phase_rate           (phase_rate),
        .doinit               (doinit),
        .intr_pulse           (fix_pulse),
        .epoch_pulse          (dly_epoch),
        .phase_rate_int       (phase_rate_int),
        .phase_int            (phase_int),
        .phase_cycles_int     (phase_cycles_int),
        .phase_addr           (phase_addr)
    );  
    
    genvar iAcc;
    
    generate
        for (iAcc = 0; iAcc < `NUM_ACCUM; iAcc = iAcc + 1) begin:PRODUCT
    
            channel_cos_table CHCT (
                .adc           (sample_int_re[iAcc * 2 + 2 - 1 : iAcc * 2]),
                .phase_addr    (phase_addr),
                .cos_product   (cos_product_t[iAcc])
            );
            
            channel_sin_table CHST (
                .adc           ( (quadr) ? (sample_int_im[iAcc * 2 + 2 - 1 : iAcc * 2]) : (sample_int_re[iAcc * 2 + 2 - 1 : iAcc * 2]) ),
                .phase_addr    (phase_addr),
                .sin_product   (sin_product_t[iAcc])
            );
            
            channel_cmplx_table CHCMPLT (
            	.clk               (pclk),
				.reset_n           (reset_n),
				.adc_re            (sample_int_re[iAcc * 2 + 2 - 1 : iAcc * 2]),
				.adc_im            (sample_int_im[iAcc * 2 + 2 - 1 : iAcc * 2]),
				.cos_product       (cos_product_t[iAcc]),
				.sin_product       (sin_product_t[iAcc]),		
				.phase_addr        (phase_addr),
				.cmplx_product_re  (cmplx_product_re[iAcc]),  
				.cmplx_product_im  (cmplx_product_im[iAcc])
            );
            
            assign cos_product[iAcc] = (quadr) ? cmplx_product_re[iAcc] : cos_product_t[iAcc];
            assign sin_product[iAcc] = (quadr) ? cmplx_product_im[iAcc] : sin_product_t[iAcc];
            
        end
    endgenerate            
    
    channel_delay_reg CHDR (
        .clk               (pclk),
        .reset_n           (reset_n),
        .code              (code_out),
        .epoch_pulse       (epoch_pulse),
`ifdef EARLY_I
        .delay1            (delay1),
`elsif EARLY_Q
        .delay1            (delay1),
`elsif LATE_I
        .delay1            (delay1),
`elsif LATE_Q
        .delay1            (delay1),                           
//`ifdef ((EARLY_I | EARLY_Q) | (LATE_I | LATE_Q))        
//        .delay1            (delay1),
`endif
`ifdef EARLY_EARLY_I
        .delay2            (delay2),
`elsif EARLY_EARLY_Q
        .delay2            (delay2),
`elsif LATE_LATE_I
        .delay2            (delay2),
`elsif LATE_LATE_Q
        .delay2            (delay2),
//`ifdef ((EARLY_EARLY_I | EARLY_EARLY_Q) | (LATE_LATE_I | LATE_LATE_Q))        
//        .delay2            (delay2),
`endif        
        .promt_code        (promt_code),
`ifdef EARLY_I
        .early_code        (early_code),
`elsif EARLY_Q
        .early_code        (early_code),                   
//`ifdef (EARLY_I | EARLY_Q)           
//        .early_code        (early_code),
`endif
`ifdef EARLY_EARLY_I
        .earlyearly_code   (earlyearly_code),
`elsif EARLY_EARLY_Q         
        .earlyearly_code   (earlyearly_code),
//`ifdef (EARLY_EARLY_I | EARLY_EARLY_Q)        
//        .earlyearly_code   (earlyearly_code),
`endif
`ifdef LATE_I
        .late_code         (late_code),
`elsif LATE_Q         
        .late_code         (late_code),
//`ifdef (LATE_I | LATE_Q)        
//        .late_code         (late_code),
`endif
`ifdef LATE_LATE_I
        .latelate_code     (latelate_code),
`elsif LATE_LATE_Q
        .latelate_code     (latelate_code),
//`ifdef (LATE_LATE_I | LATE_LATE_Q)        
//        .latelate_code     (latelate_code),
`endif        
        .dly_epoch         (dly_epoch)
    );    
    
    generate
        for (iAcc = 0; iAcc < `NUM_ACCUM; iAcc = iAcc + 1) begin:ACCUM     
    
            assign promt_cos_product[iAcc] = promt_code ? cos_product[iAcc] : (~cos_product[iAcc] + 1'b1);
            assign promt_sin_product[iAcc] = promt_code ? sin_product[iAcc] : (~sin_product[iAcc] + 1'b1);
    
`ifdef EARLY_I
            assign early_cos_product[iAcc] = early_code ? cos_product[iAcc] : (~cos_product[iAcc] + 1'b1);
`endif
`ifdef EARLY_Q            
            assign early_sin_product[iAcc] = early_code ? sin_product[iAcc] : (~sin_product[iAcc] + 1'b1);
`endif            
`ifdef EARLY_EARLY_I            
            assign earlyearly_cos_product[iAcc] = earlyearly_code ? cos_product[iAcc] : (~cos_product[iAcc] + 1'b1);
`endif            
`ifdef EARLY_EARLY_Q
            assign earlyearly_sin_product[iAcc] = earlyearly_code ? sin_product[iAcc] : (~sin_product[iAcc] + 1'b1);
`endif            
`ifdef LATE_I            
            assign late_cos_product[iAcc] = late_code ? cos_product[iAcc] : (~cos_product[iAcc] + 1'b1);
`endif            
`ifdef LATE_Q            
            assign late_sin_product[iAcc] = late_code ? sin_product[iAcc] : (~sin_product[iAcc] + 1'b1);
`endif            
`ifdef LATE_LATE_I            
            assign latelate_cos_product[iAcc] = latelate_code ? cos_product[iAcc] : (~cos_product[iAcc] + 1'b1);
`endif
`ifdef LATE_LATE_Q            
            assign latelate_sin_product[iAcc] = latelate_code ? sin_product[iAcc] : (~sin_product[iAcc] + 1'b1);
`endif            
            
            
            channel_adder CHAD (
                .clk                       (pclk),
                .reset_n                   (reset_n),
                .doinit                    (doinit),
                .intr_pulse                (fix_pulse),
                .epoch                     (dly_epoch),
                .promt_cos_product         (promt_cos_product[iAcc]),
                .promt_sin_product         (promt_sin_product[iAcc]),
`ifdef EARLY_I                
                .early_cos_product         (early_cos_product[iAcc]),
`endif
`ifdef EARLY_Q
                .early_sin_product         (early_sin_product[iAcc]),
`endif
`ifdef EARLY_EARLY_I                
                .earlyearly_cos_product    (earlyearly_cos_product[iAcc]),
`endif
`ifdef EARLY_EARLY_Q                
                .earlyearly_sin_product    (earlyearly_sin_product[iAcc]),
`endif
`ifdef LATE_I          
                .late_cos_product          (late_cos_product[iAcc]),
`endif
`ifdef LATE_Q                
                .late_sin_product          (late_sin_product[iAcc]),
`endif    
`ifdef LATE_LATE_I            
                .latelate_cos_product      (latelate_cos_product[iAcc]),
`endif
`ifdef LATE_LATE_Q                
                .latelate_sin_product      (latelate_sin_product[iAcc]),
`endif                                
                .iq_shift                  (iq_shift),   
`ifdef EARLY_Q                             
                .earlyq_int                (earlyq_int[iAcc]),
`endif
`ifdef EARLY_I                
                .earlyi_int                (earlyi_int[iAcc]),
`endif
`ifdef EARLY_EARLY_Q                
                .earlyearlyq_int           (earlyearlyq_int[iAcc]),
`endif
`ifdef EARLY_EARLY_I                
                .earlyearlyi_int           (earlyearlyi_int[iAcc]),
`endif
`ifdef LATE_Q                
                .lateq_int                 (lateq_int[iAcc]),
`endif
`ifdef LATE_I                
                .latei_int                 (latei_int[iAcc]),
`endif
`ifdef LATE_LATE_Q                
                .latelateq_int             (latelateq_int[iAcc]),
`endif
`ifdef LATE_LATE_I                
                .latelatei_int             (latelatei_int[iAcc]),
`endif                
                .promtq_int                (promtq_int[iAcc]),
                .promti_int                (promti_int[iAcc])
            );
            
            assign promtq_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = promtq_int[iAcc];
            assign promti_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = promti_int[iAcc];
`ifdef EARLY_Q                          
            assign earlyq_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = earlyq_int[iAcc];
`endif
`ifdef EARLY_I            
            assign earlyi_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = earlyi_int[iAcc];
`endif
`ifdef EARLY_EARLY_Q            
            assign earlyearlyq_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = earlyearlyq_int[iAcc];
`endif
`ifdef EARLY_EARLY_I            
            assign earlyearlyi_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = earlyearlyi_int[iAcc];
`endif
`ifdef LATE_Q            
            assign lateq_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = lateq_int[iAcc];
`endif            
`ifdef LATE_I            
            assign latei_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = latei_int[iAcc];
`endif
`ifdef LATE_LATE_Q            
            assign latelateq_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = latelateq_int[iAcc];
`endif
`ifdef LATE_LATE_I            
            assign latelatei_int_bus[iAcc * 16 + 16  - 1 : iAcc * 16] = latelatei_int[iAcc];
`endif            
        end
    endgenerate              

endmodule
