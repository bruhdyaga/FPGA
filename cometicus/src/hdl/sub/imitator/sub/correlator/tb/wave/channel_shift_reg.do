onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /channel_shift_reg_tb/clk
add wave -noupdate -group tb /channel_shift_reg_tb/reset
add wave -noupdate -group tb /channel_shift_reg_tb/doinit
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/clk
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/reset_n
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_state1
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_reset_state1
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_bitmask1
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_out_bitmask1
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_state2
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_reset_state2
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_bitmask2
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_out_bitmask2
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/prn_length
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/prn_init
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/prn_length1
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/prn_init1
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sr1
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sr2
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sub_cnt_init
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sub_code_init
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sub_ratio
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/shift_ratio
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/doinit
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/intr_pulse
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/shift
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/code_out
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/prn_reset
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/prn_counter
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/prn_counter1
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sub_cnt
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sub_code
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sub_shift
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sub_cnt_sum
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/shift_cnt
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/shift_cnt_sum
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/shift_shift
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sr1_xor
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sr2_xor
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sr1_out
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sr2_out
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/sr_shift
add wave -noupdate -expand -group shift_reg /channel_shift_reg_tb/channel_shift_reg_inst/prn_reset1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 366
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {920 ps}
