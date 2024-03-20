onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /mean_compens_v3_tb/in_adr
add wave -noupdate -group tb /mean_compens_v3_tb/in_dat_add_full
add wave -noupdate -group tb /mean_compens_v3_tb/in_dat_add
add wave -noupdate -group tb /mean_compens_v3_tb/out_dat
add wave -noupdate -group tb /mean_compens_v3_tb/valid
add wave -noupdate -group tb /mean_compens_v3_tb/err_mean
add wave -noupdate -group tb /mean_compens_v3_tb/clk
add wave -noupdate -group tb /mean_compens_v3_tb/resetn
add wave -noupdate -expand -group mean /mean_compens_v3_tb/mean_compens_v2_inst/WIDTH
add wave -noupdate -expand -group mean /mean_compens_v3_tb/mean_compens_v2_inst/PERIODN
add wave -noupdate -expand -group mean /mean_compens_v3_tb/mean_compens_v2_inst/clk
add wave -noupdate -expand -group mean /mean_compens_v3_tb/mean_compens_v2_inst/resetn
add wave -noupdate -expand -group mean -format Analog-Step -height 74 -max 8191.0 -min -8192.0 -radix decimal /mean_compens_v3_tb/mean_compens_v2_inst/data_in
add wave -noupdate -expand -group mean -format Analog-Step -height 74 -max 8191.0 -min -8192.0 -radix decimal /mean_compens_v3_tb/mean_compens_v2_inst/data_out
add wave -noupdate -expand -group mean /mean_compens_v3_tb/mean_compens_v2_inst/valid
add wave -noupdate -expand -group mean -radix unsigned -radixshowbase 0 /mean_compens_v3_tb/mean_compens_v2_inst/mean_cntr
add wave -noupdate -expand -group mean -format Analog-Step -height 74 -max 14878800.0 -min -5916.0 -radix decimal /mean_compens_v3_tb/mean_compens_v2_inst/mean
add wave -noupdate -expand -group mean -radix unsigned /mean_compens_v3_tb/mean_compens_v2_inst/mean_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {146820 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 359
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
configure wave -timelineunits ns
update
WaveRestoreZoom {100228 ns} {205252 ns}
