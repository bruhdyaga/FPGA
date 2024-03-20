onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /mean_compens_v2_tb/N_dig_in
add wave -noupdate -expand -group tb -radix unsigned /mean_compens_v2_tb/SIG_CNTR_SIZE
add wave -noupdate -expand -group tb /mean_compens_v2_tb/sigmag_lch
add wave -noupdate -expand -group tb /mean_compens_v2_tb/LENGTH_N
add wave -noupdate -expand -group tb /mean_compens_v2_tb/LENGTH
add wave -noupdate -expand -group tb -radix unsigned /mean_compens_v2_tb/sigmag_cntr_period
add wave -noupdate -expand -group tb -radix unsigned /mean_compens_v2_tb/sig_cntr
add wave -noupdate -expand -group tb -radix unsigned /mean_compens_v2_tb/mag_cntr
add wave -noupdate -expand -group tb -radix unsigned /mean_compens_v2_tb/sig_res
add wave -noupdate -expand -group tb -radix unsigned /mean_compens_v2_tb/mag_res
add wave -noupdate -expand -group tb /mean_compens_v2_tb/in_adr
add wave -noupdate -expand -group tb /mean_compens_v2_tb/in_dat
add wave -noupdate -expand -group tb -radix decimal /mean_compens_v2_tb/in_dat_add
add wave -noupdate -expand -group tb -radix decimal /mean_compens_v2_tb/out_dat
add wave -noupdate -expand -group tb /mean_compens_v2_tb/valid
add wave -noupdate -expand -group tb -radix unsigned /mean_compens_v2_tb/err_mean
add wave -noupdate -expand -group tb /mean_compens_v2_tb/clk
add wave -noupdate -expand -group tb /mean_compens_v2_tb/sig
add wave -noupdate -expand -group tb /mean_compens_v2_tb/mag
add wave -noupdate -expand -group tb /mean_compens_v2_tb/valid_sigmag
add wave -noupdate -expand -group tb /mean_compens_v2_tb/resetn
add wave -noupdate -expand -group tb /mean_compens_v2_tb/Res_file
add wave -noupdate -expand -group tb /mean_compens_v2_tb/nclk
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/tau_RC
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/width
add wave -noupdate -group mean_comp -radix unsigned /mean_compens_v2_tb/mean_compens_v2_inst/TAU_RC_ADPT_W
add wave -noupdate -group mean_comp -radix unsigned -childformat {{{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[14]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[13]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[12]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[11]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[10]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[9]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[8]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[7]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[6]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[5]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[4]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[3]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[2]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[1]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[0]} -radix unsigned}} -subitemconfig {{/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[14]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[13]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[12]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[11]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[10]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[9]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[8]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[7]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[6]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[5]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[4]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[3]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[2]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[1]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt[0]} {-height 15 -radix unsigned}} /mean_compens_v2_tb/mean_compens_v2_inst/tau_RC_adpt
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/clk
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/resetn
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/data_in
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/data_out
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/valid
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/y_k
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/y_k_32
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/x_k_32
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/x_k_1_32
add wave -noupdate -group mean_comp /mean_compens_v2_tb/mean_compens_v2_inst/up_RC_adpt
add wave -noupdate -group mean_comp -format Analog-Step -height 74 -max 981.0 -radix decimal /mean_compens_v2_tb/mean_compens_v2_inst/x_k
add wave -noupdate -group mean_comp -radix unsigned -childformat {{{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[17]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[16]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[15]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[14]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[13]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[12]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[11]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[10]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[9]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[8]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[7]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[6]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[5]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[4]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[3]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[2]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[1]} -radix unsigned} {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[0]} -radix unsigned}} -expand -subitemconfig {{/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[17]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[16]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[15]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[14]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[13]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[12]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[11]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[10]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[9]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[8]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[7]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[6]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[5]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[4]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[3]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[2]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[1]} {-height 15 -radix unsigned} {/mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr[0]} {-height 15 -radix unsigned}} /mean_compens_v2_tb/mean_compens_v2_inst/mean_cntr
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/width
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/clk
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/resetn
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/data_in
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/sig
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/mag
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/valid
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/por_reg
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/por_reg_a
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/por_reg_b
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/mag_cntr
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/cntr
add wave -noupdate -expand -group sigmag /mean_compens_v2_tb/sig_mag_v2_inst/cntr_iter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4424299065 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 383
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {12600 us}
