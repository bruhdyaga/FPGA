onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /axi3_to_inter_tb/BASEADDR_BYTE
add wave -noupdate -group tb /axi3_to_inter_tb/CLK_FREQ
add wave -noupdate -group tb /axi3_to_inter_tb/CPU_FREQ
add wave -noupdate -group tb /axi3_to_inter_tb/INST
add wave -noupdate -group tb /axi3_to_inter_tb/ID_OFFS
add wave -noupdate -group tb /axi3_to_inter_tb/R0_OFFS
add wave -noupdate -group tb /axi3_to_inter_tb/R1_OFFS
add wave -noupdate -group tb /axi3_to_inter_tb/R2_OFFS
add wave -noupdate -group tb /axi3_to_inter_tb/R3_OFFS
add wave -noupdate -group tb /axi3_to_inter_tb/N_BUSES
add wave -noupdate -group tb /axi3_to_inter_tb/INIT_0
add wave -noupdate -group tb /axi3_to_inter_tb/INIT_1
add wave -noupdate -group tb /axi3_to_inter_tb/clk
add wave -noupdate -group tb /axi3_to_inter_tb/aclk
add wave -noupdate -group tb /axi3_to_inter_tb/resetn
add wave -noupdate -group tb /axi3_to_inter_tb/val
add wave -noupdate -group tb /axi3_to_inter_tb/BASE_0_BYTE
add wave -noupdate -group tb /axi3_to_inter_tb/BASE_1_BYTE
add wave -noupdate -group tb /axi3_to_inter_tb/REG_0_in
add wave -noupdate -group tb /axi3_to_inter_tb/REG_0_out
add wave -noupdate -group tb /axi3_to_inter_tb/REG_1_in
add wave -noupdate -group tb /axi3_to_inter_tb/REG_1_out
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/aclk
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/resetn
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/araddr
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arburst
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arcache
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arlen
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arlock
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arprot
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arqos
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arready
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arsize
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awaddr
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awburst
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awcache
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awlen
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awlock
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awprot
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awqos
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awready
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awsize
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/awvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/bid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/bready
add wave -noupdate -expand -group axi3 -color Coral /axi3_to_inter_tb/axi3/bresp
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/bvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rdata
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rlast
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rready
add wave -noupdate -expand -group axi3 -color Coral -radix binary -radixshowbase 1 /axi3_to_inter_tb/axi3/rresp
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wdata
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wlast
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wready
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wstrb
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/readReg/base
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/readReg/offset
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/readReg/burst_len
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/readReg/disp_addr
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/ADDR_WIDTH
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/DATA_WIDTH
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/clk
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/resetn
add wave -noupdate -group intbus -radix hexadecimal -radixshowbase 0 /axi3_to_inter_tb/int_bus/addr
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/wdata
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/rdata
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/rvalid
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/wr
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/rd
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/baseaddr
add wave -noupdate -group intbus /axi3_to_inter_tb/int_bus/asize
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/ADDR_WIDTH}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/DATA_WIDTH}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/clk}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/resetn}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/addr}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/wdata}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/rdata}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/rvalid}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/wr}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/rd}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/baseaddr}
add wave -noupdate -group hub_bus_0 {/axi3_to_inter_tb/hub_bus[0]/asize}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/ADDR_WIDTH}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/DATA_WIDTH}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/clk}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/resetn}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/addr}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/wdata}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/rdata}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/rvalid}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/wr}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/rd}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/baseaddr}
add wave -noupdate -group hub_bus_1 {/axi3_to_inter_tb/hub_bus[1]/asize}
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/ADDR_WIDTH
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/BASEADDR
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/TIMEOUT
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/rdata_fifo
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/rdata_fifo_addr_rd
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/rdata_fifo_addr_wr
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/rresp_fifo
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/state_arbiter
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/read_phase
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/write_phase
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/cntr_timeout
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/timeout
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/araddr
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/awaddr
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/addr_count
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/arlen
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/awlen
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/arid
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/awid
add wave -noupdate -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/bvalid
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/clk
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/resetn
add wave -noupdate -group regfile_0 -expand /axi3_to_inter_tb/regs_file_0_inst/in
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/out
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/pulse
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/reg_rdata
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/reg_rdata_int
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/reg_mem
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/reg_wr
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/reg_rd
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/sync_rd
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/pulse_reg
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/base_addr
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/out_arr
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/in_arr
add wave -noupdate -group regfile_0 /axi3_to_inter_tb/regs_file_0_inst/init_arr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4554390 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 341
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
WaveRestoreZoom {4426670 ps} {4754810 ps}
