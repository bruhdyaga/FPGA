onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /test_interf_tb/NBUSES
add wave -noupdate -group tb /test_interf_tb/clk
add wave -noupdate -group tb /test_interf_tb/PS1
add wave -noupdate -group tb /test_interf_tb/PS2
add wave -noupdate -group axi3 /test_interf_tb/axi3/D_WIDTH
add wave -noupdate -group axi3 /test_interf_tb/axi3/ID_WIDTH
add wave -noupdate -group axi3 /test_interf_tb/axi3/WSTRB_W
add wave -noupdate -group axi3 /test_interf_tb/axi3/aclk
add wave -noupdate -group axi3 /test_interf_tb/axi3/araddr
add wave -noupdate -group axi3 /test_interf_tb/axi3/arburst
add wave -noupdate -group axi3 /test_interf_tb/axi3/arcache
add wave -noupdate -group axi3 /test_interf_tb/axi3/arid
add wave -noupdate -group axi3 /test_interf_tb/axi3/arlen
add wave -noupdate -group axi3 /test_interf_tb/axi3/arlock
add wave -noupdate -group axi3 /test_interf_tb/axi3/arprot
add wave -noupdate -group axi3 /test_interf_tb/axi3/arqos
add wave -noupdate -group axi3 /test_interf_tb/axi3/arready
add wave -noupdate -group axi3 /test_interf_tb/axi3/arsize
add wave -noupdate -group axi3 /test_interf_tb/axi3/arvalid
add wave -noupdate -group axi3 /test_interf_tb/axi3/awaddr
add wave -noupdate -group axi3 /test_interf_tb/axi3/awburst
add wave -noupdate -group axi3 /test_interf_tb/axi3/awcache
add wave -noupdate -group axi3 /test_interf_tb/axi3/awid
add wave -noupdate -group axi3 /test_interf_tb/axi3/awlen
add wave -noupdate -group axi3 /test_interf_tb/axi3/awlock
add wave -noupdate -group axi3 /test_interf_tb/axi3/awprot
add wave -noupdate -group axi3 /test_interf_tb/axi3/awqos
add wave -noupdate -group axi3 /test_interf_tb/axi3/awready
add wave -noupdate -group axi3 /test_interf_tb/axi3/awsize
add wave -noupdate -group axi3 /test_interf_tb/axi3/awvalid
add wave -noupdate -group axi3 /test_interf_tb/axi3/bid
add wave -noupdate -group axi3 /test_interf_tb/axi3/bready
add wave -noupdate -group axi3 /test_interf_tb/axi3/bresp
add wave -noupdate -group axi3 /test_interf_tb/axi3/bvalid
add wave -noupdate -group axi3 /test_interf_tb/axi3/rdata
add wave -noupdate -group axi3 /test_interf_tb/axi3/rid
add wave -noupdate -group axi3 /test_interf_tb/axi3/rlast
add wave -noupdate -group axi3 /test_interf_tb/axi3/rready
add wave -noupdate -group axi3 /test_interf_tb/axi3/rresp
add wave -noupdate -group axi3 /test_interf_tb/axi3/rvalid
add wave -noupdate -group axi3 /test_interf_tb/axi3/wdata
add wave -noupdate -group axi3 /test_interf_tb/axi3/wid
add wave -noupdate -group axi3 /test_interf_tb/axi3/wlast
add wave -noupdate -group axi3 /test_interf_tb/axi3/wready
add wave -noupdate -group axi3 /test_interf_tb/axi3/wstrb
add wave -noupdate -group axi3 /test_interf_tb/axi3/wvalid
add wave -noupdate -group bus /test_interf_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /test_interf_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /test_interf_tb/bus/clk
add wave -noupdate -group bus /test_interf_tb/bus/addr
add wave -noupdate -group bus /test_interf_tb/bus/wdata
add wave -noupdate -group bus /test_interf_tb/bus/rdata
add wave -noupdate -group bus /test_interf_tb/bus/rvalid
add wave -noupdate -group bus /test_interf_tb/bus/wr
add wave -noupdate -group bus /test_interf_tb/bus/rd
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/ADDR_WIDTH}
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/DATA_WIDTH}
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/clk}
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/addr}
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/wdata}
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/rdata}
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/rvalid}
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/wr}
add wave -noupdate -expand -group bus_sl_0 {/test_interf_tb/bus_sl[0]/rd}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/ADDR_WIDTH}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/DATA_WIDTH}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/clk}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/addr}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/wdata}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/rdata}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/rvalid}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/wr}
add wave -noupdate -expand -group bus_sl_1 {/test_interf_tb/bus_sl[1]/rd}
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/BASEADDR
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/ID
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/DATA_WIDTH
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/OUTFF
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/NREGS
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/NPULSE
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/RVALID_FF
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/clk
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/in
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/out
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/pulse
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/wr
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/rd
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/reg_wdata
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/reg_rdata
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/reg_rdata_const
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/reg_rdata_int
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/reg_mem
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/reg_mem_const
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/reg_const_rd
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/sync_rd
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/rvalid_arr
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/pulse_reg
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/out_arr
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/in_arr
add wave -noupdate -group RF_1 /test_interf_tb/RF_1/init_arr
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/BASEADDR
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/ID
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/DATA_WIDTH
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/OUTFF
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/NREGS
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/NPULSE
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/RVALID_FF
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/clk
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/in
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/out
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/pulse
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/wr
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/rd
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/reg_wdata
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/reg_rdata
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/reg_rdata_const
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/reg_rdata_int
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/reg_mem
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/reg_mem_const
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/reg_const_rd
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/sync_rd
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/rvalid_arr
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/pulse_reg
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/out_arr
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/in_arr
add wave -noupdate -group RF_2 /test_interf_tb/RF_2/init_arr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {90940 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 373
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
