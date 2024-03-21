radix -unsigned
format -Logic
onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate                  /acq_api_tb/acq_IP_inst/adc/clk

# add wave -noupdate -label R_debug    -format Analog-Step -height 74 -max 154773.0                          -color white {/acq_api_tb/acq_IP_inst/core_inst/R_debug}
# add wave -noupdate -label I_kg_accum -format Analog-Step -height 74 -max 2000.0 -max -2000.0 -radix sfixed -color white {/acq_api_tb/acq_IP_inst/I_kg_accum}
# add wave -noupdate -label Q_kg_accum -format Analog-Step -height 74 -max 2000.0 -max -2000.0 -radix sfixed -color white {/acq_api_tb/acq_IP_inst/Q_kg_accum}
add wave -noupdate -label R_quad     -format Analog-Step -height 74 -max 2353172.0                         -color white {/acq_api_tb/acq_IP_inst/R_quad}
add wave -noupdate                                                                                                      {/acq_api_tb/acq_IP_inst/valid_quad}
add wave -noupdate                   -format Analog-Step -height 74 -max 1200000.0 -color white {/acq_api_tb/acq_IP_inst/R_quad_nkg}
add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/valid_nkg}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/sAmpMax}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/sTauMax}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/sTauEnd}


add wave -noupdate -divider _signal_read_
add wave -noupdate -radix unsigned                                        {/acq_api_tb/acq_IP_inst/bram_controller_inst/bram_controller_interface/rd_start_addr}
add wave -noupdate -label {rd_allow (from Start to Done)}                 {/acq_api_tb/acq_IP_inst/bram_controller_inst/rd_allow }
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/bram_controller_inst/I_mem_sig_n}

add wave -noupdate -divider _PRBS_
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/psp_gen_interface/prn_init}
add wave -noupdate -radix unsigned                         -color white   {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/psp_gen_interface/prn_counter}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/psp_out_shift_reg}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/core_inst/core_interface/we}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/core_inst/core_interface/wr_buf}
add wave -noupdate                                         -color white   {/acq_api_tb/acq_IP_inst/fsm_controller_inst/state}

add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/core_inst/code_buf}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/core_inst/core_interface/code_load}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/fsm_controller_inst/core_cntr}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/fsm_controller_inst/fsm_bram_kg_cntr}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/fsm_controller_inst/fsm_bram_nkg_cntr}

add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/core_inst/dat_I}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/core_inst/mul_I}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/core_inst/core_interface/data_latch}
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/core_inst/core_interface/we_adder}

add wave -noupdate -divider _FSM_
add wave -noupdate                                       {/acq_api_tb/acq_IP_inst/fsm_controller_inst/STATE_N_TAU_ZONE}
add wave -noupdate -label FSM_CORE_CNTR   -color yellow  {/acq_api_tb/acq_IP_inst/fsm_controller_inst/core_cntr}
add wave -noupdate -label FSM_CORES_CNTR  -color yellow  {/acq_api_tb/acq_IP_inst/fsm_controller_inst/cores_cntr}
add wave -noupdate -label FSM_KG_CNTR     -color yellow  {/acq_api_tb/acq_IP_inst/fsm_controller_inst/fsm_bram_kg_cntr}
add wave -noupdate -label FSM_NKG_CNTR    -color Magenta {/acq_api_tb/acq_IP_inst/fsm_controller_inst/fsm_bram_nkg_cntr}
add wave -noupdate -label R_debug    -format Analog-Step -height 74 -max 154773.0  -color white {/acq_api_tb/acq_IP_inst/core_inst/R_debug}
add wave -noupdate -label R_quad     -format Analog-Step -height 74 -max 2353172.0 -color white {/acq_api_tb/acq_IP_inst/R_quad}
add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/valid_quad}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/slowSigDly/oSig}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/slowSigDly/iSig}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/slowSigDly/sSigRE}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/slowSigDly/sSigFE}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/slowSigDly/sCtnREen}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/slowSigDly/sCtnFEen}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/slowSigDly/sCtnRE}
# add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/slowSigDly/sCtnFE}
add wave -noupdate                   -format Analog-Step -height 74 -max 2353172.0 -color white {/acq_api_tb/acq_IP_inst/R_quad_nkg}
add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/valid_nkg}
add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/arr_accum_I_kg_inst/zero_mem}
add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/fsm_wait}
add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/sAmpMax}
add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/sTauMax}
add wave -noupdate                                                                              {/acq_api_tb/acq_IP_inst/sTauEnd}



add wave -noupdate -label FSM_F_CNTR      -color yellow  {/acq_api_tb/acq_IP_inst/fsm_controller_inst/fsm_bram_n_f_cntr}
add wave -noupdate                {/acq_api_tb/acq_IP_inst/fsm_controller_inst/sTimeSlotOver}
add wave -noupdate                {/acq_api_tb/acq_IP_inst/fsm_controller_inst/sPRBSpermutaionCnt}
add wave -noupdate                {/acq_api_tb/acq_IP_inst/fsm_controller_inst/sRdAddrStart}
add wave -noupdate -color white   {/acq_api_tb/acq_IP_inst/fsm_controller_inst/end_core}
add wave -noupdate -color white   {/acq_api_tb/acq_IP_inst/fsm_controller_inst/end_nkg}
add wave -noupdate                {/acq_api_tb/acq_IP_inst/fsm_controller_inst/state}

add wave -noupdate -divider _signal_write_
add wave -noupdate -radix unsigned                                        {/acq_api_tb/acq_IP_inst/bram_controller_inst/wr_addr     }
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/bram_controller_inst/we_ram      }
add wave -noupdate                                                        {/acq_api_tb/acq_IP_inst/bram_controller_inst/data_mux[0] }
add wave -noupdate -radix unsigned                                        {/acq_api_tb/indx }


# # # add wave -noupdate -radix unsigned  /acq_api_tb/record_cntr
# # # add wave -noupdate                  /acq_api_tb/PS.CONTROL.RECORD_START

# # # add wave -noupdate -expand -group PRESTORE
# # # add wave -noupdate -group PRESTORE /acq_api_tb/acq_IP_inst/prestore_inst/sig_I 
# # # add wave -noupdate -group PRESTORE /acq_api_tb/acq_IP_inst/prestore_inst/we 
# # # add wave -noupdate -group PRESTORE /acq_api_tb/acq_IP_inst/prestore_inst/I_sum_sig 
# # # add wave -noupdate -group PRESTORE /acq_api_tb/acq_IP_inst/prestore_inst/valid 

# # # add wave -noupdate -expand -group BRAM
# # # add wave -noupdate -group BRAM /acq_api_tb/acq_IP_inst/bram_controller_inst/wr_clr 
# # # add wave -noupdate -group BRAM /acq_api_tb/acq_IP_inst/bram_controller_inst/rd_clr 
# # # add wave -noupdate -group BRAM /acq_api_tb/acq_IP_inst/bram_controller_inst/I_sum_sig 
# # # add wave -noupdate -group BRAM /acq_api_tb/acq_IP_inst/bram_controller_inst/wr_addr 
# # # add wave -noupdate -group BRAM /acq_api_tb/acq_IP_inst/bram_controller_inst/we_ram 
# # # add wave -noupdate -group BRAM /acq_api_tb/acq_IP_inst/bram_controller_inst/wr_end_addr 
# # # add wave -noupdate -group BRAM /acq_api_tb/acq_IP_inst/bram_controller_inst/I_mem_sig 
# # # add wave -noupdate -group BRAM /acq_api_tb/acq_IP_inst/bram_controller_inst/rd_addr_mux 

# # # add wave -noupdate -expand -group FREQ_SHIFT
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/resetn 
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/I_sig 
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/I_mag 
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/Q_sig 
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/Q_mag 
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/we 
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/I_out 
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/Q_out 
# # # add wave -noupdate -group FREQ_SHIFT /acq_api_tb/acq_IP_inst/freq_shift_inst/freq_shift_interface/* 

# # # add wave -noupdate -expand -group PRN_GEN
# # # add wave -noupdate -group PRN_GEN               /acq_api_tb/acq_IP_inst/facq_prn_gen_inst/psp_out_shift_reg
# # # add wave -noupdate -group PRN_GEN -color yellow /acq_api_tb/acq_IP_inst/facq_prn_gen_inst/psp_gen_interface/prn_init

# # # add wave -noupdate -expand -group CORE
# # # add wave -noupdate -group CORE /acq_api_tb/acq_IP_inst/core_inst/I_in 
# # # add wave -noupdate -group CORE /acq_api_tb/acq_IP_inst/core_inst/Q_in 
# # # add wave -noupdate -group CORE /acq_api_tb/acq_IP_inst/core_inst/psp_in 
# # # add wave -noupdate -group CORE /acq_api_tb/acq_IP_inst/core_inst/I 
# # # add wave -noupdate -group CORE /acq_api_tb/acq_IP_inst/core_inst/Q 

# # # add wave -noupdate -expand -group ACC_I
# # # add wave -noupdate -group ACC_I /acq_api_tb/acq_IP_inst/arr_accum_I_kg_inst/clr 
# # # add wave -noupdate -group ACC_I /acq_api_tb/acq_IP_inst/arr_accum_I_kg_inst/R_in 
# # # add wave -noupdate -group ACC_I /acq_api_tb/acq_IP_inst/arr_accum_I_kg_inst/R_out 
# # # add wave -noupdate -group ACC_I /acq_api_tb/acq_IP_inst/arr_accum_I_kg_inst/we 
# # # add wave -noupdate -group ACC_I /acq_api_tb/acq_IP_inst/arr_accum_I_kg_inst/valid 
# # # add wave -noupdate -group ACC_I /acq_api_tb/acq_IP_inst/arr_accum_I_kg_inst/arr_accum_interface/*

# # # add wave -noupdate -expand -group QAUD
# # # add wave -noupdate -group QAUD /acq_api_tb/acq_IP_inst/quad_inst/resetn 
# # # add wave -noupdate -group QAUD /acq_api_tb/acq_IP_inst/quad_inst/I_in 
# # # add wave -noupdate -group QAUD /acq_api_tb/acq_IP_inst/quad_inst/Q_in 
# # # add wave -noupdate -group QAUD /acq_api_tb/acq_IP_inst/quad_inst/R 
# # # add wave -noupdate -group QAUD /acq_api_tb/acq_IP_inst/quad_inst/we 
# # # add wave -noupdate -group QAUD /acq_api_tb/acq_IP_inst/quad_inst/valid 

# # # add wave -noupdate -expand -group ACC_Q
# # # add wave -noupdate -group ACC_Q /acq_api_tb/acq_IP_inst/arr_accum_quad_nkg_inst/clr 
# # # add wave -noupdate -group ACC_Q /acq_api_tb/acq_IP_inst/arr_accum_quad_nkg_inst/R_in 
# # # add wave -noupdate -group ACC_Q /acq_api_tb/acq_IP_inst/arr_accum_quad_nkg_inst/R_out 
# # # add wave -noupdate -group ACC_Q /acq_api_tb/acq_IP_inst/arr_accum_quad_nkg_inst/we 
# # # add wave -noupdate -group ACC_Q /acq_api_tb/acq_IP_inst/arr_accum_quad_nkg_inst/valid 
# # # add wave -noupdate -group ACC_Q /acq_api_tb/acq_IP_inst/arr_accum_quad_nkg_inst/arr_accum_interface/* 

# # # # add wave -noupdate -expand -group MAX
# # # add wave -noupdate -group MAX /acq_api_tb/acq_IP_inst/max_args/R 
# # # add wave -noupdate -group MAX /acq_api_tb/acq_IP_inst/max_args/we 
# # # add wave -noupdate -group MAX /acq_api_tb/acq_IP_inst/max_args/max_args_interface/* 
# # # add wave -noupdate -group MAX /acq_api_tb/acq_IP_inst/max_args/bus/* 

# # # add wave -noupdate -expand -group FSM
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/rf_clk 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/core_clk 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/fsm_wait 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/fsm_reset 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/acq_global_resetn_core 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/bram_controller_interface/* 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/freq_shift_interface/* 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/psp_gen_interface/* 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/core_interface/* 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/arr_accum_interface/* 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/max_args_interface/* 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/bus/* 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/rd_cntr 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/rd_cntr_init 
# # # add wave -noupdate -group FSM /acq_api_tb/acq_IP_inst/fsm_controller_inst/state

# # # add wave -noupdate -group FSM -divider {CORR_OUTPUT}
# # # add wave -noupdate -group FSM -label PRBSin        -color gold {/acq_api_tb/acq_IP_inst/core_inst/psp_in}
# # # add wave -noupdate -group FSM -label PRBScode      -color gold {/acq_api_tb/acq_IP_inst/core_inst/code}
# # # add wave -noupdate -group FSM -label PRBScodeBuf   -color gold {/acq_api_tb/acq_IP_inst/core_inst/code_buf}
# # # add wave -noupdate -group FSM -label PRBScodeReg   -color gold {/acq_api_tb/acq_IP_inst/core_inst/code_reg}
# # # add wave -noupdate -group FSM -label CodeWe        -color gold {/acq_api_tb/acq_IP_inst/core_inst/core_interface/we}
# # # add wave -noupdate -group FSM -label CodeLoad      -color gold {/acq_api_tb/acq_IP_inst/core_inst/core_interface/code_load}
# # # add wave -noupdate -group FSM -label CodeWr_buf    -color gold {/acq_api_tb/acq_IP_inst/core_inst/core_interface/wr_buf}
# # # add wave -noupdate -group FSM -label DataI         -color gold {/acq_api_tb/acq_IP_inst/core_inst/dat_I}
# # # add wave -noupdate -group FSM -label DataIlatch    -color gold {/acq_api_tb/acq_IP_inst/core_inst/core_interface/data_latch}
# # # add wave -noupdate -group FSM -label AdderWe_adder -color gold {/acq_api_tb/acq_IP_inst/core_inst/core_interface/we_adder}
# # # add wave -noupdate -group FSM -label AdderValid    -color gold {/acq_api_tb/acq_IP_inst/core_inst/core_interface/valid}

# # # # add wave -noupdate -expand -group ACQ
# # # add wave -noupdate -group ACQ -label sumCode             -radix unsigned -color white -format Analog-Step -height 74 -max 131072.0 /acq_api_tb/acq_IP_inst/core_inst/sumCode

add wave -noupdate -expand -group FSM
### add wave -noupdate -group FSM -label IQabs -format Analog-Step -height 74 -max 300000.0 -color white {/acq_api_tb/acq_IP_inst/core_inst/R_debug}
add wave -noupdate -group FSM -label rd_addr {/acq_api_tb/acq_IP_inst/bram_controller_inst/rd_addr_mux}
add wave -noupdate -group FSM -label IQabs      -format Analog-Step -height 74 -max 154773.0 -color white {/acq_api_tb/acq_IP_inst/core_inst/R_debug}

# # # add wave -noupdate -group FSM                {/acq_api_tb/acq_IP_inst/bram_controller_inst/bram_controller_interface/valid}
# # # add wave -noupdate -group FSM -color white   {/acq_api_tb/acq_IP_inst/psp_gen_interface/prn_counter[8:7]}
# # # add wave -noupdate -group FSM -color white   {/acq_api_tb/acq_IP_inst/psp_gen_interface/prn_counter}
# # # add wave -noupdate -group FSM -color white   {/acq_api_tb/acq_IP_inst/psp_gen_interface/prn_init}
# # # add wave -noupdate -group FSM -color white   {/acq_api_tb/acq_IP_inst/fsm_controller_inst/state}
# # # add wave -noupdate -group FSM -color white   {/acq_api_tb/acq_IP_inst/fsm_controller_inst/prn_counter_reg}
# # # add wave -noupdate -group FSM -color yellow  {/acq_api_tb/acq_IP_inst/core_inst/core_interface/wr_buf}
# # # add wave -noupdate -group FSM -color Magenta {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/psp_gen_interface/do_init}

# # # add wave -noupdate -group FSM -color yellow  {/acq_api_tb/acq_IP_inst/core_inst/core_interface/code_load}
# # # add wave -noupdate -group FSM -color yellow  {/acq_api_tb/acq_IP_inst/fsm_controller_inst/fsm_bram_n_tau_zone_cntr}


# # # add wave -noupdate -group FSM -divider check02
# # # add wave -noupdate -group FSM -label code_cnt_buf               -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/code_cnt_buf}
# # # add wave -noupdate -group FSM -label code_cnt                   -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/code_cnt}
# # # add wave -noupdate -group FSM -label prn_reset                  -radix unsigned               {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/prn_reset}
# # # add wave -noupdate -group FSM -label code                       -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/code}
# # # add wave -noupdate -group FSM -label code_buf                   -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/code_buf}

# # # add wave -noupdate -group FSM -label we                         -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/core_interface/we}
# # # add wave -noupdate -group FSM -label we_adder                   -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/core_interface/we_adder}

# # # add wave -noupdate -group FSM -label core_interface.valid       -radix unsigned               {/acq_api_tb/acq_IP_inst/core_interface/valid}
# # # add wave -noupdate -group FSM -label core_interface.wr_buf      -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/core_interface/wr_buf}
# # # add wave -noupdate -group FSM -label core_interface.code_load   -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/core_interface/code_load}

# # # add wave -noupdate -group FSM -label freqVld      -color white -radix unsigned {/acq_api_tb/acq_IP_inst/freq_shift_interface/valid}
# # # add wave -noupdate -group FSM -label pspVld       -color white -radix unsigned {/acq_api_tb/acq_IP_inst/psp_gen_interface/psp_back_valid}
# # # add wave -noupdate -group FSM -label fsm_wait     -color white -radix unsigned {/acq_api_tb/acq_IP_inst/fsm_wait}
# # # add wave -noupdate -group FSM -label wr_buf       -color white -radix unsigned {/acq_api_tb/acq_IP_inst/core_interface/wr_buf}
# # # add wave -noupdate -group FSM -label prn_reset    -color white -radix unsigned {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/prn_reset}
# # # add wave -noupdate -group FSM -label shift_en     -color white -radix unsigned {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/shift_en}
# # # add wave -noupdate -group FSM -label prn_length     -color white -radix unsigned {/acq_api_tb/acq_IP_inst/psp_gen_interface/prn_length}

# # # add wave -noupdate -group FSM -label end_kg       -radix unsigned {/acq_api_tb/acq_IP_inst/fsm_controller_inst/end_kg}
# # # add wave -noupdate -group FSM -label end_nkg      -radix unsigned {/acq_api_tb/acq_IP_inst/fsm_controller_inst/end_nkg}
# # # add wave -noupdate -group FSM -label end_n_tau    -radix unsigned {/acq_api_tb/acq_IP_inst/fsm_controller_inst/end_n_tau}
# # # add wave -noupdate -group FSM -label valid_kg     -radix unsigned {/acq_api_tb/acq_IP_inst/valid_kg}

# # # add wave -noupdate -group FSM -label prbs_seq_cnt               -radix unsigned               {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/prbs_seq_cnt}
# # # add wave -noupdate -group FSM -label psp_back_valid             -radix unsigned               {/acq_api_tb/acq_IP_inst/psp_gen_interface/psp_back_valid}
# # # add wave -noupdate -group FSM -label psp_out_shift_reg          -radix unsigned               {/acq_api_tb/acq_IP_inst/psp_out_shift_reg}
# # # add wave -noupdate -group FSM -label freq_shift_interface.valid -radix unsigned               {/acq_api_tb/acq_IP_inst/freq_shift_interface/valid}
# # # add wave -noupdate -group FSM -label valid_quad                 -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/valid_quad}
# # # add wave -noupdate -group FSM -label valid_kg                   -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/valid_kg}
# # # add wave -noupdate -group FSM -label R_quad_nkg -format Analog-Step -height 74 -max 2353268.0 -color white {/acq_api_tb/acq_IP_inst/R_quad_nkg}
# # # add wave -noupdate -group FSM -label valid_nkg                  -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/valid_nkg}
# # # add wave -noupdate -group FSM -label tau                        -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/max_args/tau}
# # # add wave -noupdate -group FSM -label tau_lat_max                -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/max_args/tau_lat_max}
# # # add wave -noupdate -group FSM -label tau_max                    -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/max_args/tau_max}


# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/sig_I}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/mag_I}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/cos}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/sin}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/I}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/Q}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/sum_mux}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/valid_IQ}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/I_sum}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/Q_sum}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/valid_ed}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/sig_mag_v3_I/clr}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/sig_mag_v3_I/adpt_ready}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/sig_mag_v3_I/cntr}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/sig_mag_v3_I/cntr_end}
# # # # add wave -noupdate -group FSM -color salmon           -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/bypass}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/I_sum_sig}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/I_sum_mag}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/Q_sum_sig}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/prestore_inst/Q_sum_mag}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/I_mem_sig}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/I_mem_mag}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/Q_mem_sig}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/Q_mem_mag}
# # # # add wave -noupdate -group FSM            -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_interface/valid}
# # # add wave -noupdate -group FSM -label I_in              -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/I_in}
# # # add wave -noupdate -group FSM -label Q_in              -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/Q_in}
# # # add wave -noupdate -group FSM -label I_sh              -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/freq_shift_inst/inp_I}
# # # add wave -noupdate -group FSM -label Q_sh              -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/freq_shift_inst/inp_Q}
# # # add wave -noupdate -group FSM -label psp_in            -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/psp_in}
# # # # add wave -noupdate -group FSM -label we                -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/core_inst/core_interface/we}
# # # add wave -noupdate -group FSM -divider {CORR_OUTPUT}
# # # ### add wave -noupdate -group FSM -label R_quad_nkg -format Analog-Step -height 74 -max 471000000.0 -color white {/acq_api_tb/acq_IP_inst/R_quad_nkg}

# # # add wave -noupdate -group FSM -divider {MAX}
# # # add wave -noupdate -group FSM -label reset_max         -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/max_args/max_args_interface/reset_max}
# # # add wave -noupdate -group FSM -label we                -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/max_args/we}
# # # add wave -noupdate -group FSM -label end_tau_zone      -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/max_args/end_tau_zone}
# # # add wave -noupdate -group FSM -label end_max           -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/max_args/end_max}
# # # add wave -noupdate -group FSM -label FSMstate          /acq_api_tb/acq_IP_inst/fsm_controller_inst/state
# # # add wave -noupdate -label wr_clr             -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_inst/wr_clr}
# # # add wave -noupdate -label wr_start           -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_inst/wr_start}
# # # add wave -noupdate -label wr_done            -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_inst/wr_done}
# # # add wave -noupdate -label wr_end_addr        -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_inst/wr_end_addr}
# # # add wave -noupdate -label PS.WR_DEPTH        -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_inst/PS.WR_DEPTH}
# # # add wave -noupdate -label wr_addr            -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_inst/wr_addr}
# # # add wave -noupdate -label wr_allow           -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_inst/wr_allow}
# # # add wave -noupdate -label acq_sync           -radix unsigned {/acq_api_tb/acq_IP_inst/bram_controller_inst/acq_sync}
# # # add wave -noupdate -label FSM_PS -expand                     {/acq_api_tb/acq_IP_inst/fsm_controller_inst/PS}

# # # # add wave -noupdate -expand -group PRBS
# # # # add wave -noupdate -group PRBS -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/psp_gen_interface/*}
# # # # add wave -noupdate -group PRBS -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/facq_prn_gen_inst/shift_en}
# # # # add wave -noupdate -group PRBS -radix unsigned -color yellow {/acq_api_tb/acq_IP_inst/fsm_controller_inst/reset_fsm}

# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/I_sum_1
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/I_sum_2
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/sum_mux
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/I_sum
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/valid_ed
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/sig_I
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/I_sum_sig
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/valid
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/DDS_bin_inst/out
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/DDS_bin_inst/PS.CODE_FREQ
# # # # add wave -noupdate /acq_api_tb/acq_IP_inst/prestore_inst/DDS_bin_inst/adr


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {42000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 220
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us

