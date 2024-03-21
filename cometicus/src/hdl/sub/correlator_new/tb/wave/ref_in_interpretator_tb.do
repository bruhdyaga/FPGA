onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ref_in_interpretator_tb/clk
add wave -noupdate -group bus /ref_in_interpretator_tb/bus/clk
add wave -noupdate -group bus /ref_in_interpretator_tb/bus/resetn
add wave -noupdate -group bus /ref_in_interpretator_tb/bus/addr
add wave -noupdate -group bus /ref_in_interpretator_tb/bus/wdata
add wave -noupdate -group bus /ref_in_interpretator_tb/bus/rdata
add wave -noupdate -group bus /ref_in_interpretator_tb/bus/rvalid
add wave -noupdate -group bus /ref_in_interpretator_tb/bus/wr
add wave -noupdate -group bus /ref_in_interpretator_tb/bus/rd
add wave -noupdate /ref_in_interpretator_tb/READ_BUFF
add wave -noupdate -clampanalog 1 -format Analog-Interpolated -height 70 -max 2.0 -min -2.0 -radix decimal /ref_in_interpretator_tb/sinus
add wave -noupdate -clampanalog 1 -format Analog-Interpolated -height 70 -max 2.0 -min -2.0 -radix decimal -radixshowbase 1 /ref_in_interpretator_tb/REFINTER/in_cos
add wave -noupdate /ref_in_interpretator_tb/REFINTER/sec_pulse_ed
add wave -noupdate /ref_in_interpretator_tb/REFINTER/sec_hold_reg
add wave -noupdate /ref_in_interpretator_tb/REFINTER/sin_sign_ed
add wave -noupdate /ref_in_interpretator_tb/REFINTER/cos_sign_ed
add wave -noupdate /ref_in_interpretator_tb/REFINTER/sign_ed
add wave -noupdate /ref_in_interpretator_tb/REFINTER/sec_sync
add wave -noupdate -color {Slate Blue} /ref_in_interpretator_tb/REFINTER/out
add wave -noupdate /ref_in_interpretator_tb/REFINTER/enable
add wave -noupdate -radix unsigned -radixshowbase 0 /ref_in_interpretator_tb/REFINTER/GARM_COUNTER
add wave -noupdate -radix unsigned -radixshowbase 0 /ref_in_interpretator_tb/REFINTER/LAG
add wave -noupdate -radix unsigned -radixshowbase 0 /ref_in_interpretator_tb/REFINTER/MEAS_COUNTER
add wave -noupdate -radixshowbase 0 /ref_in_interpretator_tb/REFINTER/PL
add wave -noupdate -radixshowbase 0 /ref_in_interpretator_tb/REFINTER/PS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100037850 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 284
configure wave -valuecolwidth 216
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
WaveRestoreZoom {99892420 ps} {100247580 ps}
