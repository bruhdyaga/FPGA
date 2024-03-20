onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /axi_performance_tb/AXI_PERFORMANCE_BASE
add wave -noupdate -expand -group tb /axi_performance_tb/rdata
add wave -noupdate -expand -group tb /axi_performance_tb/aclk
add wave -noupdate -expand -group AXI_PERF /axi_performance_tb/AXI_PERFORMANCE/BASEADDR
add wave -noupdate -expand -group AXI_PERF /axi_performance_tb/AXI_PERFORMANCE/NPULSE
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/clk
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/resetn
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/addr
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/wdata
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/rdata
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/rvalid
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/wr
add wave -noupdate -expand -group AXI_PERF -expand -group bus /axi_performance_tb/bus/rd
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/BASEADDR
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/ID
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/DATA_WIDTH
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/OUTFF
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/NREGS
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/INIT
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/NPULSE
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/clk
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/resetn
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/in
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/out
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/pulse
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/wr
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/rd
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/reg_wdata
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/reg_rdata
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/reg_rdata_const
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/reg_rdata_int
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/reg_mem
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/reg_mem_const
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/reg_const_rd
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/sync_rd
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/pulse_reg
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/out_arr
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/in_arr
add wave -noupdate -expand -group AXI_PERF -expand -group RF /axi_performance_tb/AXI_PERFORMANCE/RF/init_arr
add wave -noupdate -expand -group AXI_PERF /axi_performance_tb/AXI_PERFORMANCE/PL
add wave -noupdate -expand -group AXI_PERF /axi_performance_tb/AXI_PERFORMANCE/PS
add wave -noupdate -expand -group AXI_PERF /axi_performance_tb/AXI_PERFORMANCE/tm_reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {206000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 406
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
