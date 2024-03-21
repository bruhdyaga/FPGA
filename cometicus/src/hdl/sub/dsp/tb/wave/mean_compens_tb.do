onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /mean_compens_tb/clk
add wave -noupdate -expand -group tb -color Red /mean_compens_tb/reset
add wave -noupdate -expand -group tb -format Analog-Step -height 74 -max 16383.0 -radix unsigned /mean_compens_tb/cntr
add wave -noupdate -expand -group mean_compens /mean_compens_tb/mean_compens_inst/tau_RC
add wave -noupdate -expand -group mean_compens /mean_compens_tb/mean_compens_inst/width
add wave -noupdate -expand -group mean_compens /mean_compens_tb/mean_compens_inst/clk
add wave -noupdate -expand -group mean_compens /mean_compens_tb/mean_compens_inst/reset
add wave -noupdate -expand -group mean_compens -format Analog-Step -height 74 -max 16383.0 -radix unsigned /mean_compens_tb/mean_compens_inst/DAT_in
add wave -noupdate -expand -group mean_compens -format Analog-Step -height 74 -max 8191.0 -min -8192.0 -radix decimal /mean_compens_tb/mean_compens_inst/DAT_out
add wave -noupdate -expand -group mean_compens -format Analog-Step -height 74 -max 8191.0 -min -8192.0 -radix decimal /mean_compens_tb/mean_compens_inst/DAT_in_sign
add wave -noupdate -expand -group mean_compens /mean_compens_tb/mean_compens_inst/y_k
add wave -noupdate -expand -group mean_compens /mean_compens_tb/mean_compens_inst/y_k_32
add wave -noupdate -expand -group mean_compens /mean_compens_tb/mean_compens_inst/x_k_32
add wave -noupdate -expand -group mean_compens /mean_compens_tb/mean_compens_inst/x_k_1_32
add wave -noupdate -expand -group mean_compens -format Analog-Step -height 74 -max 74.999999999999957 -min -474.0 /mean_compens_tb/mean_compens_inst/x_k
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {84630 ns} 0}
configure wave -namecolwidth 338
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
WaveRestoreZoom {0 ns} {210 us}
