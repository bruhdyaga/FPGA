onerror {resume}
quietly virtual function -install /prn_gen_tb/prn_gen_inst -env /prn_gen_tb { &{/prn_gen_tb/prn_gen_inst/sr1[12], /prn_gen_tb/prn_gen_inst/sr1[11], /prn_gen_tb/prn_gen_inst/sr1[10], /prn_gen_tb/prn_gen_inst/sr1[9], /prn_gen_tb/prn_gen_inst/sr1[8], /prn_gen_tb/prn_gen_inst/sr1[7], /prn_gen_tb/prn_gen_inst/sr1[6], /prn_gen_tb/prn_gen_inst/sr1[5], /prn_gen_tb/prn_gen_inst/sr1[4], /prn_gen_tb/prn_gen_inst/sr1[3], /prn_gen_tb/prn_gen_inst/sr1[2], /prn_gen_tb/prn_gen_inst/sr1[1], /prn_gen_tb/prn_gen_inst/sr1[0] }} XA
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /prn_gen_tb/BASEADDR
add wave -noupdate -expand -group tb /prn_gen_tb/prn_clk
add wave -noupdate -expand -group tb /prn_gen_tb/aclk
add wave -noupdate -expand -group tb /prn_gen_tb/prn_rd
add wave -noupdate -expand -group tb /prn_gen_tb/PN
add wave -noupdate -expand -group tb -radix unsigned -radixshowbase 0 /prn_gen_tb/prn_cntr
add wave -noupdate -expand -group tb /prn_gen_tb/update
add wave -noupdate -expand -group tb /prn_gen_tb/data
add wave -noupdate -expand -group tb /prn_gen_tb/prn
add wave -noupdate -expand -group tb /prn_gen_tb/valid
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/BASEADDR
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/clk
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/sr_shift
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/phase_hi
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/update
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/code_out
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/mask
add wave -noupdate -expand -group PRN -expand /prn_gen_tb/prn_gen_inst/XA
add wave -noupdate -expand -group PRN -expand /prn_gen_tb/prn_gen_inst/sr1
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/sr2
add wave -noupdate -expand -group PRN -radix unsigned -radixshowbase 0 /prn_gen_tb/prn_gen_inst/prn_counter
add wave -noupdate -expand -group PRN -color {Orange Red} /prn_gen_tb/prn_gen_inst/prn_reset
add wave -noupdate -expand -group PRN -color {Orange Red} /prn_gen_tb/prn_gen_inst/gps_l5_reset
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/sr1_xor
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/sr2_xor
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/sr1_out
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/sr2_out
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/PS
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/sr2_fb
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/sr2_xor_fb
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/phase_hi_reg
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/boc_mod
add wave -noupdate -expand -group PRN /prn_gen_tb/prn_gen_inst/code
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49394230 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 303
configure wave -valuecolwidth 115
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
WaveRestoreZoom {49321040 ps} {49486150 ps}
