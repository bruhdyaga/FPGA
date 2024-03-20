onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /sig_mag_v3_tb/WIDTH
add wave -noupdate -expand -group tb /sig_mag_v3_tb/N_CH
add wave -noupdate -expand -group tb /sig_mag_v3_tb/SIG_CNTR_SIZE
add wave -noupdate -expand -group tb -childformat {{{/sig_mag_v3_tb/data[1]} -radix decimal} {{/sig_mag_v3_tb/data[0]} -radix decimal}} -expand -subitemconfig {{/sig_mag_v3_tb/data[1]} {-height 15 -radix decimal} {/sig_mag_v3_tb/data[0]} {-height 15 -radix decimal}} /sig_mag_v3_tb/data
add wave -noupdate -expand -group tb /sig_mag_v3_tb/data_flat
add wave -noupdate -expand -group tb /sig_mag_v3_tb/k_scale
add wave -noupdate -expand -group tb /sig_mag_v3_tb/sigmag_cntr_period
add wave -noupdate -expand -group tb /sig_mag_v3_tb/sig_cntr
add wave -noupdate -expand -group tb /sig_mag_v3_tb/mag_cntr
add wave -noupdate -expand -group tb -childformat {{{/sig_mag_v3_tb/sig_res[1]} -radix unsigned} {{/sig_mag_v3_tb/sig_res[0]} -radix unsigned}} -expand -subitemconfig {{/sig_mag_v3_tb/sig_res[1]} {-radix unsigned} {/sig_mag_v3_tb/sig_res[0]} {-radix unsigned}} /sig_mag_v3_tb/sig_res
add wave -noupdate -expand -group tb -childformat {{{/sig_mag_v3_tb/mag_res[1]} -radix unsigned} {{/sig_mag_v3_tb/mag_res[0]} -radix unsigned}} -expand -subitemconfig {{/sig_mag_v3_tb/mag_res[1]} {-radix unsigned} {/sig_mag_v3_tb/mag_res[0]} {-radix unsigned}} /sig_mag_v3_tb/mag_res
add wave -noupdate -expand -group tb /sig_mag_v3_tb/clk
add wave -noupdate -expand -group tb /sig_mag_v3_tb/clr
add wave -noupdate -expand -group tb /sig_mag_v3_tb/we_cntr
add wave -noupdate -expand -group tb /sig_mag_v3_tb/we
add wave -noupdate -expand -group tb /sig_mag_v3_tb/sig
add wave -noupdate -expand -group tb /sig_mag_v3_tb/mag
add wave -noupdate -expand -group tb /sig_mag_v3_tb/sigmag_lch
add wave -noupdate -expand -group tb /sig_mag_v3_tb/out
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/WIDTH
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/N_CH
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/cntr_width
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/num_mag
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/clk
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/data_in
add wave -noupdate -expand -group sigmag -childformat {{{/sig_mag_v3_tb/sig_mag_v3_inst/data[1]} -radix decimal} {{/sig_mag_v3_tb/sig_mag_v3_inst/data[0]} -radix decimal}} -expand -subitemconfig {{/sig_mag_v3_tb/sig_mag_v3_inst/data[1]} {-height 15 -radix decimal} {/sig_mag_v3_tb/sig_mag_v3_inst/data[0]} {-height 15 -radix decimal}} /sig_mag_v3_tb/sig_mag_v3_inst/data
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/we
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/clr
add wave -noupdate -expand -group sigmag -expand /sig_mag_v3_tb/sig_mag_v3_inst/sig
add wave -noupdate -expand -group sigmag -expand /sig_mag_v3_tb/sig_mag_v3_inst/mag
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/valid
add wave -noupdate -expand -group sigmag -radix decimal /sig_mag_v3_tb/sig_mag_v3_inst/por_out
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/por_in
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/por_manual
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/mag_bisec
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/mag_cntr
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/cntr
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/cntr_iter
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/cntr_end
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/adpt_ready
add wave -noupdate -expand -group sigmag -childformat {{{/sig_mag_v3_tb/sig_mag_v3_inst/thr[1]} -radix decimal} {{/sig_mag_v3_tb/sig_mag_v3_inst/thr[0]} -radix decimal}} -expand -subitemconfig {{/sig_mag_v3_tb/sig_mag_v3_inst/thr[1]} {-radix decimal} {/sig_mag_v3_tb/sig_mag_v3_inst/thr[0]} {-radix decimal}} /sig_mag_v3_tb/sig_mag_v3_inst/thr
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/thr_a
add wave -noupdate -expand -group sigmag /sig_mag_v3_tb/sig_mag_v3_inst/thr_b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {333518 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 283
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
configure wave -timelineunits us
update
WaveRestoreZoom {330809 ns} {334911 ns}
