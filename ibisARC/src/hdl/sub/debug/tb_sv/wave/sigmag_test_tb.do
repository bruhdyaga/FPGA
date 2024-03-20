onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /sigmag_test_tb/BASE_ADDR
add wave -noupdate -expand -group tb /sigmag_test_tb/UNIQ_OFFS
add wave -noupdate -expand -group tb /sigmag_test_tb/pclk
add wave -noupdate -expand -group tb /sigmag_test_tb/aclk
add wave -noupdate -expand -group tb -group adc /sigmag_test_tb/adc/PORTS
add wave -noupdate -expand -group tb -group adc /sigmag_test_tb/adc/R
add wave -noupdate -expand -group tb -group adc /sigmag_test_tb/adc/data
add wave -noupdate -expand -group tb -group adc /sigmag_test_tb/adc/clk
add wave -noupdate -expand -group tb -group adc /sigmag_test_tb/adc/resetn
add wave -noupdate -expand -group tb /sigmag_test_tb/presetn
add wave -noupdate -expand -group tb /sigmag_test_tb/aresetn
add wave -noupdate -expand -group tb /sigmag_test_tb/done
add wave -noupdate -expand -group tb /sigmag_test_tb/rdata
add wave -noupdate -expand -group tb -radix unsigned -radixshowbase 0 /sigmag_test_tb/cntr
add wave -noupdate -expand -group sigmag_test /sigmag_test_tb/SIGMAG_TEST/BASEADDR
add wave -noupdate -expand -group sigmag_test /sigmag_test_tb/SIGMAG_TEST/BASENEXT
add wave -noupdate -expand -group sigmag_test /sigmag_test_tb/SIGMAG_TEST/INST
add wave -noupdate -expand -group sigmag_test /sigmag_test_tb/SIGMAG_TEST/NPULSE
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/BASEADDR
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/BASENEXT
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/ID
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/INST
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/DATA_WIDTH
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/OUTFF
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/NREGS
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/INIT
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/NPULSE
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/clk
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/resetn
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/in
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/out
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/pulse
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_wdata
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_rdata
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_rdata_const
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_rdata_int
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_mem
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_mem_const
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_wr
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_rd
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/reg_const_rd
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/sync_rd
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/pulse_reg
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/out_arr
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/in_arr
add wave -noupdate -expand -group sigmag_test -group RF /sigmag_test_tb/SIGMAG_TEST/RF/init_arr
add wave -noupdate -expand -group sigmag_test -subitemconfig {/sigmag_test_tb/SIGMAG_TEST/PL.CFG -expand} /sigmag_test_tb/SIGMAG_TEST/PL
add wave -noupdate -expand -group sigmag_test /sigmag_test_tb/SIGMAG_TEST/PS
add wave -noupdate -expand -group sigmag_test /sigmag_test_tb/SIGMAG_TEST/resetp
add wave -noupdate -expand -group sigmag_test -radix unsigned -radixshowbase 0 /sigmag_test_tb/SIGMAG_TEST/cntr
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/clk
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/resetn
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/addr
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/wdata
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/rdata
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/rvalid
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/wr
add wave -noupdate -expand -group bus /sigmag_test_tb/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {680000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 339
configure wave -valuecolwidth 84
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
WaveRestoreZoom {0 ps} {63 us}
