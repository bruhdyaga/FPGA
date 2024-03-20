onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /scaler_down_tb/IN_WIDTH
add wave -noupdate -group tb /scaler_down_tb/OUT_WIDTH
add wave -noupdate -group tb /scaler_down_tb/SCALE_WIDTH
add wave -noupdate -group tb /scaler_down_tb/clk
add wave -noupdate -group tb /scaler_down_tb/resetn
add wave -noupdate -group tb -format Analog-Step -height 74 -max 2046.9999999999995 -min -2048.0 -radix decimal /scaler_down_tb/cntr_in
add wave -noupdate -group tb /scaler_down_tb/out
add wave -noupdate -expand -group scaler /scaler_down_tb/scaler_down_inst/IN_WIDTH
add wave -noupdate -expand -group scaler /scaler_down_tb/scaler_down_inst/OUT_WIDTH
add wave -noupdate -expand -group scaler /scaler_down_tb/scaler_down_inst/SCALE_WIDTH
add wave -noupdate -expand -group scaler /scaler_down_tb/scaler_down_inst/clk
add wave -noupdate -expand -group scaler /scaler_down_tb/scaler_down_inst/resetn
add wave -noupdate -expand -group scaler /scaler_down_tb/scaler_down_inst/in
add wave -noupdate -expand -group scaler /scaler_down_tb/scaler_down_inst/out
add wave -noupdate -expand -group scaler /scaler_down_tb/scaler_down_inst/scale
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {97216 ns} 0}
configure wave -namecolwidth 311
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
WaveRestoreZoom {0 ns} {9932 ns}
