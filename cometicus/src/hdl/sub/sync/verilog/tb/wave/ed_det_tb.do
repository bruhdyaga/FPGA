onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix ascii /ed_det_tb/ed_det_inst/TYPE
add wave -noupdate -radix ascii /ed_det_tb/ed_det_inst/RESET_TYPE
add wave -noupdate -radix ascii /ed_det_tb/ed_det_inst/RESET_POL
add wave -noupdate -radix decimal /ed_det_tb/ed_det_inst/IN_RESET_VALUE
add wave -noupdate -radix decimal /ed_det_tb/ed_det_inst/OUT_RESET_VALUE
add wave -noupdate -radix decimal /ed_det_tb/ed_det_inst/FLIP_EN
add wave -noupdate /ed_det_tb/ed_det_inst/clk
add wave -noupdate -color Red /ed_det_tb/ed_det_inst/reset
add wave -noupdate /ed_det_tb/ed_det_inst/in
add wave -noupdate -color {Violet Red} /ed_det_tb/ed_det_inst/out
add wave -noupdate /ed_det_tb/ed_det_inst/lat
add wave -noupdate /ed_det_tb/ed_det_inst/out_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30 ns} 0}
configure wave -namecolwidth 290
configure wave -valuecolwidth 90
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
WaveRestoreZoom {0 ns} {1050 ns}
