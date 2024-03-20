onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regsfile_tb/aclk
add wave -noupdate /regsfile_tb/pclk
add wave -noupdate /regsfile_tb/presetn
add wave -noupdate /regsfile_tb/PL
add wave -noupdate /regsfile_tb/PS
add wave -noupdate /regsfile_tb/bus_rd
add wave -noupdate /regsfile_tb/bus_wr
add wave -noupdate /regsfile_tb/bus_wr_pl
add wave -noupdate /regsfile_tb/pulse_0
add wave -noupdate /regsfile_tb/pulse_1
add wave -noupdate -group axi3 /regsfile_tb/axi3/aclk
add wave -noupdate -group axi3 /regsfile_tb/axi3/araddr
add wave -noupdate -group axi3 /regsfile_tb/axi3/arburst
add wave -noupdate -group axi3 /regsfile_tb/axi3/arcache
add wave -noupdate -group axi3 /regsfile_tb/axi3/arid
add wave -noupdate -group axi3 /regsfile_tb/axi3/arlen
add wave -noupdate -group axi3 /regsfile_tb/axi3/arlock
add wave -noupdate -group axi3 /regsfile_tb/axi3/arprot
add wave -noupdate -group axi3 /regsfile_tb/axi3/arqos
add wave -noupdate -group axi3 /regsfile_tb/axi3/arready
add wave -noupdate -group axi3 /regsfile_tb/axi3/arsize
add wave -noupdate -group axi3 /regsfile_tb/axi3/arvalid
add wave -noupdate -group axi3 /regsfile_tb/axi3/awaddr
add wave -noupdate -group axi3 /regsfile_tb/axi3/awburst
add wave -noupdate -group axi3 /regsfile_tb/axi3/awcache
add wave -noupdate -group axi3 /regsfile_tb/axi3/awid
add wave -noupdate -group axi3 /regsfile_tb/axi3/awlen
add wave -noupdate -group axi3 /regsfile_tb/axi3/awlock
add wave -noupdate -group axi3 /regsfile_tb/axi3/awprot
add wave -noupdate -group axi3 /regsfile_tb/axi3/awqos
add wave -noupdate -group axi3 /regsfile_tb/axi3/awready
add wave -noupdate -group axi3 /regsfile_tb/axi3/awsize
add wave -noupdate -group axi3 /regsfile_tb/axi3/awvalid
add wave -noupdate -group axi3 /regsfile_tb/axi3/bid
add wave -noupdate -group axi3 /regsfile_tb/axi3/bready
add wave -noupdate -group axi3 /regsfile_tb/axi3/bresp
add wave -noupdate -group axi3 /regsfile_tb/axi3/bvalid
add wave -noupdate -group axi3 /regsfile_tb/axi3/rdata
add wave -noupdate -group axi3 /regsfile_tb/axi3/rid
add wave -noupdate -group axi3 /regsfile_tb/axi3/rlast
add wave -noupdate -group axi3 /regsfile_tb/axi3/rready
add wave -noupdate -group axi3 /regsfile_tb/axi3/rresp
add wave -noupdate -group axi3 /regsfile_tb/axi3/rvalid
add wave -noupdate -group axi3 /regsfile_tb/axi3/wdata
add wave -noupdate -group axi3 /regsfile_tb/axi3/wid
add wave -noupdate -group axi3 /regsfile_tb/axi3/wlast
add wave -noupdate -group axi3 /regsfile_tb/axi3/wready
add wave -noupdate -group axi3 /regsfile_tb/axi3/wstrb
add wave -noupdate -group axi3 /regsfile_tb/axi3/wvalid
add wave -noupdate -group axi3 /regsfile_tb/axi3/waitClks/numclks
add wave -noupdate -group axi3 /regsfile_tb/axi3/readwriteReg/r_base
add wave -noupdate -group axi3 /regsfile_tb/axi3/readwriteReg/r_offset
add wave -noupdate -group axi3 /regsfile_tb/axi3/readwriteReg/r_burst_len
add wave -noupdate -group axi3 /regsfile_tb/axi3/readwriteReg/w_base
add wave -noupdate -group axi3 /regsfile_tb/axi3/readwriteReg/w_offset
add wave -noupdate -group axi3 /regsfile_tb/axi3/readwriteReg/w_burst_len
add wave -noupdate -group axi3 /regsfile_tb/axi3/readwriteReg/disp_r_addr
add wave -noupdate -group axi3 /regsfile_tb/axi3/readwriteReg/disp_w_addr
add wave -noupdate -group axi3 /regsfile_tb/axi3/readReg/base
add wave -noupdate -group axi3 /regsfile_tb/axi3/readReg/offset
add wave -noupdate -group axi3 /regsfile_tb/axi3/readReg/burst_len
add wave -noupdate -group axi3 /regsfile_tb/axi3/readReg/disp_addr
add wave -noupdate -group axi3 /regsfile_tb/axi3/writeReg/base
add wave -noupdate -group axi3 /regsfile_tb/axi3/writeReg/offset
add wave -noupdate -group axi3 /regsfile_tb/axi3/writeReg/burst_len
add wave -noupdate -group axi3 /regsfile_tb/axi3/readReg_2/base
add wave -noupdate -group axi3 /regsfile_tb/axi3/readReg_2/offset
add wave -noupdate -group axi3 /regsfile_tb/axi3/write_addr_2data_addr/base
add wave -noupdate -group axi3 /regsfile_tb/axi3/write_addr_2data_addr/offset
add wave -noupdate -group bus /regsfile_tb/bus/clk
add wave -noupdate -group bus /regsfile_tb/bus/addr
add wave -noupdate -group bus /regsfile_tb/bus/wdata
add wave -noupdate -group bus /regsfile_tb/bus/rdata
add wave -noupdate -group bus /regsfile_tb/bus/rvalid
add wave -noupdate -group bus /regsfile_tb/bus/wr
add wave -noupdate -group bus /regsfile_tb/bus/rd
add wave -noupdate -group RF /regsfile_tb/RF/clk
add wave -noupdate -group RF /regsfile_tb/RF/in
add wave -noupdate -group RF /regsfile_tb/RF/out
add wave -noupdate -group RF /regsfile_tb/RF/pulse
add wave -noupdate -group RF /regsfile_tb/RF/wr
add wave -noupdate -group RF /regsfile_tb/RF/rd
add wave -noupdate -group RF /regsfile_tb/RF/reg_rdata
add wave -noupdate -group RF /regsfile_tb/RF/reg_rdata_const
add wave -noupdate -group RF /regsfile_tb/RF/reg_rdata_int
add wave -noupdate -group RF /regsfile_tb/RF/reg_mem
add wave -noupdate -group RF /regsfile_tb/RF/reg_mem_const
add wave -noupdate -group RF /regsfile_tb/RF/reg_const_rd
add wave -noupdate -group RF /regsfile_tb/RF/sync_rd
add wave -noupdate -group RF /regsfile_tb/RF/rvalid_arr
add wave -noupdate -group RF /regsfile_tb/RF/pulse_reg
add wave -noupdate -group RF /regsfile_tb/RF/out_arr
add wave -noupdate -group RF /regsfile_tb/RF/in_arr
add wave -noupdate -group RF /regsfile_tb/RF/init_arr
add wave -noupdate -group RF /regsfile_tb/RF/bus/clk
add wave -noupdate -group RF /regsfile_tb/RF/bus/addr
add wave -noupdate -group RF /regsfile_tb/RF/bus/wdata
add wave -noupdate -group RF /regsfile_tb/RF/bus/rdata
add wave -noupdate -group RF /regsfile_tb/RF/bus/rvalid
add wave -noupdate -group RF /regsfile_tb/RF/bus/wr
add wave -noupdate -group RF /regsfile_tb/RF/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {675400 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 941
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
WaveRestoreZoom {0 ps} {786 ns}
