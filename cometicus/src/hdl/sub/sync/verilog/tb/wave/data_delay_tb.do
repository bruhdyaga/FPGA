onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /data_delay_tb/WIDTH
add wave -noupdate -expand -group tb /data_delay_tb/MAX_DELAY
add wave -noupdate -expand -group tb /data_delay_tb/clk
add wave -noupdate -expand -group tb /data_delay_tb/resetn
add wave -noupdate -expand -group tb /data_delay_tb/cntr
add wave -noupdate -expand -group tb /data_delay_tb/out
add wave -noupdate -expand -group data_delay /data_delay_tb/DATA_DELAY/WIDTH
add wave -noupdate -expand -group data_delay /data_delay_tb/DATA_DELAY/MAX_DELAY
add wave -noupdate -expand -group data_delay /data_delay_tb/DATA_DELAY/DELAY_WIDTH
add wave -noupdate -expand -group data_delay /data_delay_tb/DATA_DELAY/resetn
add wave -noupdate -expand -group data_delay /data_delay_tb/DATA_DELAY/clk
add wave -noupdate -expand -group data_delay /data_delay_tb/DATA_DELAY/delay
add wave -noupdate -expand -group data_delay /data_delay_tb/DATA_DELAY/in
add wave -noupdate -expand -group data_delay /data_delay_tb/DATA_DELAY/out
add wave -noupdate -expand -group data_delay -expand /data_delay_tb/DATA_DELAY/data_dly_reg
add wave -noupdate -expand -group data_delay -expand /data_delay_tb/DATA_DELAY/data_dly
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {435000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 309
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
WaveRestoreZoom {0 ps} {1050 ns}
