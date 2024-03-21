onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /log2_tb/clk
add wave -noupdate /log2_tb/x
add wave -noupdate /log2_tb/log_x
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20434 ns} 0}
configure wave -namecolwidth 199
configure wave -valuecolwidth 74
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
WaveRestoreZoom {20351 ns} {20609 ns}
