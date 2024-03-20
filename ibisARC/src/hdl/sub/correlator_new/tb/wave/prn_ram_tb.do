onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /prn_ram_tb/NBUSES
add wave -noupdate -group tb /prn_ram_tb/BASETIME
add wave -noupdate -group tb /prn_ram_tb/BASETIME_CH
add wave -noupdate -group tb /prn_ram_tb/BASEPRN
add wave -noupdate -group tb /prn_ram_tb/pclk
add wave -noupdate -group tb /prn_ram_tb/aclk
add wave -noupdate -group tb /prn_ram_tb/aresetn
add wave -noupdate -group tb /prn_ram_tb/fix_pulse
add wave -noupdate -group tb /prn_ram_tb/epoch_pulse
add wave -noupdate -group tb /prn_ram_tb/time_out
add wave -noupdate -group tb /prn_ram_tb/chip_pulse
add wave -noupdate -group tb /prn_ram_tb/do_rqst
add wave -noupdate -group tb /prn_ram_tb/eph_apply
add wave -noupdate -group tb /prn_ram_tb/phase_hi
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/BASEADDR
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/RAM_SIZE
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/ADDR_BITS
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/clk
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/phase_hi
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/code_out
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/mask
add wave -noupdate -expand -group PRN_RAM -radix unsigned -radixshowbase 0 /prn_ram_tb/PRN_RAM/chip
add wave -noupdate -expand -group PRN_RAM -childformat {{{/prn_ram_tb/PRN_RAM/LEN[0]} -radix unsigned} {{/prn_ram_tb/PRN_RAM/LEN[1]} -radix unsigned} {{/prn_ram_tb/PRN_RAM/LEN[2]} -radix unsigned} {{/prn_ram_tb/PRN_RAM/LEN[3]} -radix unsigned} {{/prn_ram_tb/PRN_RAM/LEN[4]} -radix unsigned} {{/prn_ram_tb/PRN_RAM/LEN[5]} -radix unsigned}} -expand -subitemconfig {{/prn_ram_tb/PRN_RAM/LEN[0]} {-radix unsigned} {/prn_ram_tb/PRN_RAM/LEN[1]} {-radix unsigned} {/prn_ram_tb/PRN_RAM/LEN[2]} {-radix unsigned} {/prn_ram_tb/PRN_RAM/LEN[3]} {-radix unsigned} {/prn_ram_tb/PRN_RAM/LEN[4]} {-radix unsigned} {/prn_ram_tb/PRN_RAM/LEN[5]} {-radix unsigned}} /prn_ram_tb/PRN_RAM/LEN
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/ram
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/ram_out
add wave -noupdate -expand -group PRN_RAM -radix unsigned -radixshowbase 0 /prn_ram_tb/PRN_RAM/hi_chip_cntr
add wave -noupdate -expand -group PRN_RAM -radix unsigned -radixshowbase 0 /prn_ram_tb/PRN_RAM/full_chip
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/PL
add wave -noupdate -expand -group PRN_RAM -expand -subitemconfig {/prn_ram_tb/PRN_RAM/PS.CFG -expand} /prn_ram_tb/PRN_RAM/PS
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/int_wr_arr
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/wr_ram
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/phase_hi_reg
add wave -noupdate -expand -group PRN_RAM /prn_ram_tb/PRN_RAM/boc_mod
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/BASEADDR
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/NPULSE
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/clk
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/chip_pulse
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/epoch_pulse
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/sec_pulse
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/fix_pulse
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/do_rqst
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/eph_apply
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/time_out
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/phase_hi
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/PL
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/PS
add wave -noupdate -expand -group TIME_CH -expand -subitemconfig {/prn_ram_tb/TIME_SCALE_CH/T.CHIP_EPOCH {-childformat {{CHIP -radix unsigned}} -expand} /prn_ram_tb/TIME_SCALE_CH/T.CHIP_EPOCH.CHIP {-radix unsigned} /prn_ram_tb/TIME_SCALE_CH/T.CHIP_EPOCH_MAX -expand} /prn_ram_tb/TIME_SCALE_CH/T
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/eph_rqst
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/eph_set
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/phase_next
add wave -noupdate -expand -group TIME_CH /prn_ram_tb/TIME_SCALE_CH/week_pulse
add wave -noupdate -group bus /prn_ram_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /prn_ram_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /prn_ram_tb/bus/clk
add wave -noupdate -group bus /prn_ram_tb/bus/addr
add wave -noupdate -group bus /prn_ram_tb/bus/wdata
add wave -noupdate -group bus /prn_ram_tb/bus/rdata
add wave -noupdate -group bus /prn_ram_tb/bus/rvalid
add wave -noupdate -group bus /prn_ram_tb/bus/wr
add wave -noupdate -group bus /prn_ram_tb/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {194024130 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 279
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
WaveRestoreZoom {193951050 ps} {194079230 ps}
