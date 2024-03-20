onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /ch_mul_tb/FREQ_CNTR_BASE_ADDR
add wave -noupdate -expand -group tb /ch_mul_tb/pclk
add wave -noupdate -expand -group tb /ch_mul_tb/PHASE
add wave -noupdate -expand -group table /ch_mul_tb/CH_MUL/adc_re
add wave -noupdate -expand -group table /ch_mul_tb/CH_MUL/adc_im
add wave -noupdate -expand -group table /ch_mul_tb/CH_MUL/phase
add wave -noupdate -expand -group table /ch_mul_tb/CH_MUL/i_prod
add wave -noupdate -expand -group table /ch_mul_tb/CH_MUL/q_prod
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {222690 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
