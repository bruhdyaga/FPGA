onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /dma_dsp_tb/CPU_FREQ
add wave -noupdate -expand -group tb /dma_dsp_tb/AXI_HP_FREQ
add wave -noupdate -expand -group tb /dma_dsp_tb/ID_OFFS
add wave -noupdate -expand -group tb /dma_dsp_tb/R0_OFFS
add wave -noupdate -expand -group tb /dma_dsp_tb/R1_OFFS
add wave -noupdate -expand -group tb /dma_dsp_tb/R2_OFFS
add wave -noupdate -expand -group tb /dma_dsp_tb/R3_OFFS
add wave -noupdate -expand -group tb /dma_dsp_tb/N_REGS
add wave -noupdate -expand -group tb /dma_dsp_tb/aclk
add wave -noupdate -expand -group tb /dma_dsp_tb/a_hp_clk
add wave -noupdate -expand -group tb -expand /dma_dsp_tb/PL1
add wave -noupdate -expand -group tb /dma_dsp_tb/PS1
add wave -noupdate -expand -group tb /dma_dsp_tb/PL2
add wave -noupdate -expand -group tb -expand /dma_dsp_tb/PS2
add wave -noupdate -expand -group tb /dma_dsp_tb/tvalid_dly
add wave -noupdate -expand -group tb /dma_dsp_tb/tdata_dly
add wave -noupdate -expand -group tb /dma_dsp_tb/m_mux
add wave -noupdate -expand -group tb /dma_dsp_tb/s_mux
add wave -noupdate -expand -group tb -radix unsigned -radixshowbase 0 /dma_dsp_tb/s_axis_dma_wr_cnt
add wave -noupdate -expand -group tb /dma_dsp_tb/wr_fifo_cntr
add wave -noupdate -expand -group tb /dma_dsp_tb/rd_fifo_cntr
add wave -noupdate -expand -group tb /dma_dsp_tb/fifo
add wave -noupdate -expand -group tb /dma_dsp_tb/fifo_empty
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/BASEADDR
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/AXI_WIDTH
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/MAX_AXLEN
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/AXI_AXSIZE
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/BURST_ADDR_SIZE
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/ADDR_4B8B_AWIDTH
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/NPULSE
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/s_axi3_aclk
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/BURST_TYPE
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/AxCACHE
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/AxLOCK
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/addr_4B8B_wr
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/addr_4B8B_wr_inc
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/bresp_cntr
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/ARLEN
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/AWLEN
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/left_rd
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/left_wr
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/axi_ar
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/axi_aw
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/axi_r
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/axi_w
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/axi_wlast
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/axi_b
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/PL
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/PS
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/reset_pulse
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/start_pulse
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/start
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/addr_4B8B_rd
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/arvalid_reg
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/addr_4B8B_rd_inc
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/last_rd_trans
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/len_to_allign4k_rd
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/last_wr_trans
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/awvalid_reg
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/len_to_allign4k_wr
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/awlen_reg
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/wlast_cntr
add wave -noupdate -group dma_dsp /dma_dsp_tb/dma_dsp_inst/wr_trans
add wave -noupdate -group m_axis_data /dma_dsp_tb/m_axis_data/D_WIDTH
add wave -noupdate -group m_axis_data /dma_dsp_tb/m_axis_data/aclk
add wave -noupdate -group m_axis_data /dma_dsp_tb/m_axis_data/tdata
add wave -noupdate -group m_axis_data /dma_dsp_tb/m_axis_data/tvalid
add wave -noupdate -group m_axis_data /dma_dsp_tb/m_axis_data/tready
add wave -noupdate -expand -group s_axis_data /dma_dsp_tb/s_axis_data/D_WIDTH
add wave -noupdate -expand -group s_axis_data /dma_dsp_tb/s_axis_data/aclk
add wave -noupdate -expand -group s_axis_data /dma_dsp_tb/s_axis_data/tdata
add wave -noupdate -expand -group s_axis_data /dma_dsp_tb/s_axis_data/tvalid
add wave -noupdate -expand -group s_axis_data /dma_dsp_tb/s_axis_data/tready
add wave -noupdate -group m_axis_dma /dma_dsp_tb/m_axis_dma/D_WIDTH
add wave -noupdate -group m_axis_dma /dma_dsp_tb/m_axis_dma/aclk
add wave -noupdate -group m_axis_dma /dma_dsp_tb/m_axis_dma/tdata
add wave -noupdate -group m_axis_dma /dma_dsp_tb/m_axis_dma/tvalid
add wave -noupdate -group m_axis_dma /dma_dsp_tb/m_axis_dma/tready
add wave -noupdate -expand -group s_axis_dma /dma_dsp_tb/s_axis_dma/D_WIDTH
add wave -noupdate -expand -group s_axis_dma /dma_dsp_tb/s_axis_dma/aclk
add wave -noupdate -expand -group s_axis_dma /dma_dsp_tb/s_axis_dma/tdata
add wave -noupdate -expand -group s_axis_dma /dma_dsp_tb/s_axis_dma/tvalid
add wave -noupdate -expand -group s_axis_dma /dma_dsp_tb/s_axis_dma/tready
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/D_WIDTH
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/ID_WIDTH
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/WSTRB_W
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/aclk
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/araddr
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arburst
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arcache
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arlen
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arlock
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arprot
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arqos
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arready
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arsize
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/arvalid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awaddr
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awburst
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awcache
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awlen
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awlock
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awprot
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awqos
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awready
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awsize
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/awvalid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/bid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/bready
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/bresp
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/bvalid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/rdata
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/rid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/rlast
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/rready
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/rresp
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/rvalid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/wdata
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/wid
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/wlast
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/wready
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/wstrb
add wave -noupdate -expand -group axi_hp /dma_dsp_tb/axi_hp/wvalid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/D_WIDTH
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/ID_WIDTH
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/WSTRB_W
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/aclk
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/araddr
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arburst
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arcache
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arlen
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arlock
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arprot
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arqos
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arready
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arsize
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/arvalid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awaddr
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awburst
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awcache
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awlen
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awlock
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awprot
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awqos
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awready
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awsize
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/awvalid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/bid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/bready
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/bresp
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/bvalid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/rdata
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/rid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/rlast
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/rready
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/rresp
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/rvalid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/wdata
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/wid
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/wlast
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/wready
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/wstrb
add wave -noupdate -expand -group s_wr_axi3 /dma_dsp_tb/s_wr_axi3/wvalid
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/ADDR_WIDTH
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/DATA_WIDTH
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/clk
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/addr
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/wdata
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/rdata
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/rvalid
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/wr
add wave -noupdate -expand -group int_bus_s_wr /dma_dsp_tb/int_bus_s_wr/rd
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/ADDR_WIDTH
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/TIMEOUT
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/INT_BUS_BYTES
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/INT_BUS_BYTES_LOG2
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/rdata_fifo
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/rdata_fifo_addr_rd
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/rdata_fifo_addr_wr
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/rresp_fifo
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/read_phase
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/write_phase
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/state_arbiter
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/wready
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/cntr_timeout
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/timeout
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/araddr
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/awaddr
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst -radix unsigned -radixshowbase 0 /dma_dsp_tb/s_wr_axi3_to_inter_inst/addr_count
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/arlen
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/awlen
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/arid
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/awid
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/bvalid
add wave -noupdate -expand -group s_wr_axi3_to_inter_inst /dma_dsp_tb/s_wr_axi3_to_inter_inst/D_WIDTH
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2502740 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 377
configure wave -valuecolwidth 148
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
WaveRestoreZoom {7666870 ps} {8017540 ps}
