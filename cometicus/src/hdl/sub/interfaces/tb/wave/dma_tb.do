onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group M_GP /dma_tb/axi3/D_WIDTH
add wave -noupdate -group M_GP /dma_tb/axi3/ID_WIDTH
add wave -noupdate -group M_GP /dma_tb/axi3/WSTRB_W
add wave -noupdate -group M_GP /dma_tb/axi3/aclk
add wave -noupdate -group M_GP /dma_tb/axi3/araddr
add wave -noupdate -group M_GP /dma_tb/axi3/arburst
add wave -noupdate -group M_GP /dma_tb/axi3/arcache
add wave -noupdate -group M_GP /dma_tb/axi3/arid
add wave -noupdate -group M_GP /dma_tb/axi3/arlen
add wave -noupdate -group M_GP /dma_tb/axi3/arlock
add wave -noupdate -group M_GP /dma_tb/axi3/arprot
add wave -noupdate -group M_GP /dma_tb/axi3/arqos
add wave -noupdate -group M_GP /dma_tb/axi3/arready
add wave -noupdate -group M_GP /dma_tb/axi3/arsize
add wave -noupdate -group M_GP /dma_tb/axi3/arvalid
add wave -noupdate -group M_GP /dma_tb/axi3/awaddr
add wave -noupdate -group M_GP /dma_tb/axi3/awburst
add wave -noupdate -group M_GP /dma_tb/axi3/awcache
add wave -noupdate -group M_GP /dma_tb/axi3/awid
add wave -noupdate -group M_GP /dma_tb/axi3/awlen
add wave -noupdate -group M_GP /dma_tb/axi3/awlock
add wave -noupdate -group M_GP /dma_tb/axi3/awprot
add wave -noupdate -group M_GP /dma_tb/axi3/awqos
add wave -noupdate -group M_GP /dma_tb/axi3/awready
add wave -noupdate -group M_GP /dma_tb/axi3/awsize
add wave -noupdate -group M_GP /dma_tb/axi3/awvalid
add wave -noupdate -group M_GP /dma_tb/axi3/bid
add wave -noupdate -group M_GP /dma_tb/axi3/bready
add wave -noupdate -group M_GP /dma_tb/axi3/bresp
add wave -noupdate -group M_GP /dma_tb/axi3/bvalid
add wave -noupdate -group M_GP /dma_tb/axi3/rdata
add wave -noupdate -group M_GP /dma_tb/axi3/rid
add wave -noupdate -group M_GP /dma_tb/axi3/rlast
add wave -noupdate -group M_GP /dma_tb/axi3/rready
add wave -noupdate -group M_GP /dma_tb/axi3/rresp
add wave -noupdate -group M_GP /dma_tb/axi3/rvalid
add wave -noupdate -group M_GP /dma_tb/axi3/wdata
add wave -noupdate -group M_GP /dma_tb/axi3/wid
add wave -noupdate -group M_GP /dma_tb/axi3/wlast
add wave -noupdate -group M_GP /dma_tb/axi3/wready
add wave -noupdate -group M_GP /dma_tb/axi3/wstrb
add wave -noupdate -group M_GP /dma_tb/axi3/wvalid
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/ADDR_WIDTH
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/TIMEOUT
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/rdata_fifo
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/rdata_fifo_addr_rd
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/rdata_fifo_addr_wr
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/rresp_fifo
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/read_phase
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/write_phase
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/state_arbiter
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/wready
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/cntr_timeout
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/timeout
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/araddr
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/awaddr
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/addr_count
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/arlen
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/awlen
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/arid
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/awid
add wave -noupdate -group axi3_to_inter /dma_tb/axi3_to_inter_inst/bvalid
add wave -noupdate -group int_bus /dma_tb/int_bus/ADDR_WIDTH
add wave -noupdate -group int_bus /dma_tb/int_bus/DATA_WIDTH
add wave -noupdate -group int_bus /dma_tb/int_bus/clk
add wave -noupdate -group int_bus /dma_tb/int_bus/addr
add wave -noupdate -group int_bus /dma_tb/int_bus/wdata
add wave -noupdate -group int_bus /dma_tb/int_bus/rdata
add wave -noupdate -group int_bus /dma_tb/int_bus/rvalid
add wave -noupdate -group int_bus /dma_tb/int_bus/wr
add wave -noupdate -group int_bus /dma_tb/int_bus/rd
add wave -noupdate -group S_GP /dma_tb/s_axi3/D_WIDTH
add wave -noupdate -group S_GP /dma_tb/s_axi3/ID_WIDTH
add wave -noupdate -group S_GP /dma_tb/s_axi3/WSTRB_W
add wave -noupdate -group S_GP /dma_tb/s_axi3/aclk
add wave -noupdate -group S_GP /dma_tb/s_axi3/araddr
add wave -noupdate -group S_GP /dma_tb/s_axi3/arburst
add wave -noupdate -group S_GP /dma_tb/s_axi3/arcache
add wave -noupdate -group S_GP /dma_tb/s_axi3/arid
add wave -noupdate -group S_GP /dma_tb/s_axi3/arlen
add wave -noupdate -group S_GP /dma_tb/s_axi3/arlock
add wave -noupdate -group S_GP /dma_tb/s_axi3/arprot
add wave -noupdate -group S_GP /dma_tb/s_axi3/arqos
add wave -noupdate -group S_GP /dma_tb/s_axi3/arready
add wave -noupdate -group S_GP /dma_tb/s_axi3/arsize
add wave -noupdate -group S_GP /dma_tb/s_axi3/arvalid
add wave -noupdate -group S_GP /dma_tb/s_axi3/awaddr
add wave -noupdate -group S_GP /dma_tb/s_axi3/awburst
add wave -noupdate -group S_GP /dma_tb/s_axi3/awcache
add wave -noupdate -group S_GP /dma_tb/s_axi3/awid
add wave -noupdate -group S_GP /dma_tb/s_axi3/awlen
add wave -noupdate -group S_GP /dma_tb/s_axi3/awlock
add wave -noupdate -group S_GP /dma_tb/s_axi3/awprot
add wave -noupdate -group S_GP /dma_tb/s_axi3/awqos
add wave -noupdate -group S_GP /dma_tb/s_axi3/awsize
add wave -noupdate -group S_GP /dma_tb/s_axi3/awready
add wave -noupdate -group S_GP /dma_tb/s_axi3/awvalid
add wave -noupdate -group S_GP /dma_tb/s_axi3/bid
add wave -noupdate -group S_GP /dma_tb/s_axi3/bready
add wave -noupdate -group S_GP /dma_tb/s_axi3/bresp
add wave -noupdate -group S_GP /dma_tb/s_axi3/bvalid
add wave -noupdate -group S_GP /dma_tb/s_axi3/rdata
add wave -noupdate -group S_GP /dma_tb/s_axi3/rid
add wave -noupdate -group S_GP /dma_tb/s_axi3/rlast
add wave -noupdate -group S_GP /dma_tb/s_axi3/rready
add wave -noupdate -group S_GP /dma_tb/s_axi3/rresp
add wave -noupdate -group S_GP /dma_tb/s_axi3/rvalid
add wave -noupdate -group S_GP /dma_tb/s_axi3/wdata
add wave -noupdate -group S_GP /dma_tb/s_axi3/wid
add wave -noupdate -group S_GP -color Magenta /dma_tb/s_axi3/wlast
add wave -noupdate -group S_GP /dma_tb/s_axi3/wready
add wave -noupdate -group S_GP /dma_tb/s_axi3/wstrb
add wave -noupdate -group S_GP -color Gold /dma_tb/s_axi3/wvalid
add wave -noupdate -expand -group dma /dma_tb/dma_inst/s_axi3/aclk
add wave -noupdate -expand -group dma /dma_tb/dma_inst/BASEADDR
add wave -noupdate -expand -group dma /dma_tb/dma_inst/AXI_WIDTH
add wave -noupdate -expand -group dma /dma_tb/dma_inst/AXI_AXSIZE
add wave -noupdate -expand -group dma /dma_tb/dma_inst/MAX_AXLEN
add wave -noupdate -expand -group dma /dma_tb/dma_inst/FIFO_DWIDTH
add wave -noupdate -expand -group dma /dma_tb/dma_inst/BURST_ADDR_SIZE
add wave -noupdate -expand -group dma /dma_tb/dma_inst/ADDR_4B8B_AWIDTH
add wave -noupdate -expand -group dma /dma_tb/dma_inst/irq
add wave -noupdate -expand -group dma /dma_tb/dma_inst/NPULSE
add wave -noupdate -expand -group dma /dma_tb/dma_inst/BURST_TYPE
add wave -noupdate -expand -group dma /dma_tb/dma_inst/AxCACHE
add wave -noupdate -expand -group dma /dma_tb/dma_inst/AxLOCK
add wave -noupdate -expand -group dma /dma_tb/dma_inst/ARLEN
add wave -noupdate -expand -group dma /dma_tb/dma_inst/AWLEN
add wave -noupdate -expand -group dma /dma_tb/dma_inst/addr_4B8B_rd
add wave -noupdate -expand -group dma /dma_tb/dma_inst/addr_4B8B_rd_inc
add wave -noupdate -expand -group dma /dma_tb/dma_inst/addr_4B8B_wr
add wave -noupdate -expand -group dma /dma_tb/dma_inst/addr_4B8B_wr_inc
add wave -noupdate -expand -group dma -radix unsigned -radixshowbase 0 /dma_tb/dma_inst/left_wr
add wave -noupdate -expand -group dma -radix unsigned -radixshowbase 0 /dma_tb/dma_inst/left_rd
add wave -noupdate -expand -group dma /dma_tb/dma_inst/axi_ar
add wave -noupdate -expand -group dma /dma_tb/dma_inst/axi_aw
add wave -noupdate -expand -group dma /dma_tb/dma_inst/axi_r
add wave -noupdate -expand -group dma /dma_tb/dma_inst/axi_w
add wave -noupdate -expand -group dma /dma_tb/dma_inst/axi_wlast
add wave -noupdate -expand -group dma /dma_tb/dma_inst/axi_b
add wave -noupdate -expand -group dma /dma_tb/dma_inst/fifo_wr
add wave -noupdate -expand -group dma /dma_tb/dma_inst/fifo_rd
add wave -noupdate -expand -group dma /dma_tb/dma_inst/fifo_full
add wave -noupdate -expand -group dma /dma_tb/dma_inst/fifo_wr_cntr
add wave -noupdate -expand -group dma /dma_tb/dma_inst/fifo_wr_next1_cntr
add wave -noupdate -expand -group dma /dma_tb/dma_inst/fifo_wr_next2_cntr
add wave -noupdate -expand -group dma /dma_tb/dma_inst/fifo_rd_cntr
add wave -noupdate -expand -group dma /dma_tb/dma_inst/fifo_empty
add wave -noupdate -expand -group dma -radix unsigned -radixshowbase 0 /dma_tb/dma_inst/bresp_cntr
add wave -noupdate -expand -group dma -expand -subitemconfig {/dma_tb/dma_inst/PL.CFG {-height 15 -childformat {{RD_SIZE -radix unsigned}} -expand} /dma_tb/dma_inst/PL.CFG.RD_SIZE {-radix unsigned}} /dma_tb/dma_inst/PL
add wave -noupdate -expand -group dma /dma_tb/dma_inst/PS
add wave -noupdate -expand -group dma /dma_tb/dma_inst/irq_syn
add wave -noupdate -expand -group dma /dma_tb/dma_inst/irq_pulse
add wave -noupdate -expand -group dma /dma_tb/dma_inst/start
add wave -noupdate -expand -group dma /dma_tb/dma_inst/reset_pulse
add wave -noupdate -expand -group dma /dma_tb/dma_inst/start_pulse
add wave -noupdate -expand -group dma /dma_tb/dma_inst/last_rd_trans
add wave -noupdate -expand -group dma /dma_tb/dma_inst/last_wr_trans
add wave -noupdate -expand -group dma /dma_tb/dma_inst/len_to_allign4k_rd
add wave -noupdate -expand -group dma /dma_tb/dma_inst/len_to_allign4k_wr
add wave -noupdate -expand -group dma /dma_tb/dma_inst/awlen_reg
add wave -noupdate -expand -group dma -radix unsigned -radixshowbase 0 /dma_tb/dma_inst/wlast_cntr
add wave -noupdate -expand -group dma /dma_tb/dma_inst/wr_trans
add wave -noupdate -expand -group dma /dma_tb/dma_inst/arvalid_reg
add wave -noupdate -expand -group dma /dma_tb/dma_inst/awvalid_reg
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/ADDR_WIDTH
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/DATA_WIDTH
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/clk
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/addr
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/wdata
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/rdata
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/rvalid
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/wr
add wave -noupdate -group int_bus_rd /dma_tb/int_bus_s_rd/rd
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/ADDR_WIDTH
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/DATA_WIDTH
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/clk
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/addr
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/wdata
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/rdata
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/rvalid
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/wr
add wave -noupdate -group int_bus_wr /dma_tb/int_bus_s_wr/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2614420 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 291
configure wave -valuecolwidth 138
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
WaveRestoreZoom {0 ps} {15750 ns}
