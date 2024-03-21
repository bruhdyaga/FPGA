onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /axi_hp_performance_tb/AXI_HP_PERFORMANCE_BASE
add wave -noupdate -expand -group tb /axi_hp_performance_tb/rdata
add wave -noupdate -expand -group tb /axi_hp_performance_tb/aclk
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/BASEADDR
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/NPULSE
add wave -noupdate -expand -group axi_hP_perf -expand /axi_hp_performance_tb/AXI_HP_PERFORMANCE/PL
add wave -noupdate -expand -group axi_hP_perf -expand /axi_hp_performance_tb/AXI_HP_PERFORMANCE/PS
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/reset
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/wr
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/awr
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/awaddr
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/wdata
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/new_wr
add wave -noupdate -expand -group axi_hP_perf /axi_hp_performance_tb/AXI_HP_PERFORMANCE/en_time
add wave -noupdate -expand -group axi_hP_perf -radix unsigned -radixshowbase 0 /axi_hp_performance_tb/AXI_HP_PERFORMANCE/burst_cntr
add wave -noupdate -expand -group axi_hP_perf -radix unsigned -radixshowbase 0 /axi_hp_performance_tb/AXI_HP_PERFORMANCE/cntr
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/FIFO_racount
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/FIFO_rcount
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/FIFO_rdissuecapen
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/FIFO_wacount
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/FIFO_wcount
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/FIFO_wrissuecapen
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/araddr
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arburst
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arcache
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arlen
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arlock
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arprot
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arqos
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arready
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arsize
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/arvalid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awaddr
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awburst
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awcache
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awlen
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awlock
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awprot
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awqos
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awready
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awsize
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/awvalid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/bid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/bready
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/bresp
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/bvalid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/rdata
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/rid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/rlast
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/rready
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/rresp
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/rvalid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/wdata
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/wid
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/wlast
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/wready
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/wstrb
add wave -noupdate -expand -group axi_hp /axi_hp_performance_tb/axi_hp_0/wvalid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {298250 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 374
configure wave -valuecolwidth 125
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
WaveRestoreZoom {0 ps} {2100 ns}
