onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /antiglitch_tb/clk
add wave -noupdate -expand -group tb /antiglitch_tb/resetn
add wave -noupdate -expand -group tb /antiglitch_tb/glitch_asy
add wave -noupdate -expand -group tb -color Yellow /antiglitch_tb/glitch
add wave -noupdate -expand -group tb -color Orange /antiglitch_tb/clean
add wave -noupdate -group glitch -radix unsigned -radixshowbase 0 /antiglitch_tb/antiglitch_inst/N
add wave -noupdate -group glitch -radix unsigned -radixshowbase 0 /antiglitch_tb/antiglitch_inst/M
add wave -noupdate -group glitch /antiglitch_tb/antiglitch_inst/clk
add wave -noupdate -group glitch /antiglitch_tb/antiglitch_inst/resetn
add wave -noupdate -group glitch /antiglitch_tb/antiglitch_inst/glitch
add wave -noupdate -group glitch /antiglitch_tb/antiglitch_inst/clean
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {380000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 290
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
WaveRestoreZoom {0 ps} {1050 ns}
