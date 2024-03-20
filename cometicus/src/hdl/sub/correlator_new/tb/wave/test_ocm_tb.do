onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /test_ocm_tb/BASEADDR
add wave -noupdate -group tb /test_ocm_tb/N_TCOM
add wave -noupdate -group tb /test_ocm_tb/PCLK_PERIOD
add wave -noupdate -group tb /test_ocm_tb/pclk
add wave -noupdate -group tb /test_ocm_tb/aclk
add wave -noupdate -group tb /test_ocm_tb/core_clk
add wave -noupdate -group tb /test_ocm_tb/aresetn
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/D_WIDTH
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/ID_WIDTH
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/araddr
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/arburst
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/arcache
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/arid
add wave -noupdate -group tb -group axi_acp -color Magenta /test_ocm_tb/axi_acp/arlen
add wave -noupdate -group tb -group axi_acp -color {Slate Blue} /test_ocm_tb/axi_acp/arsize
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/arlock
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/arprot
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/arqos
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/arready
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/aruser
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/arvalid
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awaddr
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awburst
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awcache
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awid
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awlen
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awlock
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awprot
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awqos
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awready
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awsize
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awuser
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/awvalid
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/bid
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/bready
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/bresp
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/bvalid
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/rdata
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/rid
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/rlast
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/rready
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/rresp
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/rvalid
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/wdata
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/wid
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/wlast
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/wready
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/wstrb
add wave -noupdate -group tb -group axi_acp /test_ocm_tb/axi_acp/wvalid
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/ADDR_WIDTH
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/TIMEOUT
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/rdata_fifo
add wave -noupdate -group tb -group axi3_to_inter -radix unsigned -radixshowbase 0 /test_ocm_tb/axi3_to_inter_inst/rdata_fifo_addr_rd
add wave -noupdate -group tb -group axi3_to_inter -radix unsigned -radixshowbase 0 /test_ocm_tb/axi3_to_inter_inst/rdata_fifo_addr_wr
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/rresp_fifo
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/read_phase
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/write_phase
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/state_arbiter
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/cntr_timeout
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/timeout
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/araddr
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/awaddr
add wave -noupdate -group tb -group axi3_to_inter -radix unsigned -radixshowbase 0 /test_ocm_tb/axi3_to_inter_inst/addr_count
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/arlen
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/awlen
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/arid
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/awid
add wave -noupdate -group tb -group axi3_to_inter /test_ocm_tb/axi3_to_inter_inst/bvalid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/aclk
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/resetn
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/araddr
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arburst
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arcache
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arlen
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arlock
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arprot
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arqos
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arready
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arsize
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/arvalid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awaddr
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awburst
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awcache
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awlen
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awlock
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awprot
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awqos
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awready
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awsize
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/awvalid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/bid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/bready
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/bresp
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/bvalid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/rdata
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/rid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/rlast
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/rready
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/rresp
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/rvalid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/wdata
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/wid
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/wlast
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/wready
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/wstrb
add wave -noupdate -group tb -group axi3 /test_ocm_tb/axi3/wvalid
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/ADDR_WIDTH
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/DATA_WIDTH
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/clk
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/resetn
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/addr
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/wdata
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/rdata
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/rvalid
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/wr
add wave -noupdate -group tb -group bus /test_ocm_tb/bus/rd
add wave -noupdate -group tb /test_ocm_tb/presetn
add wave -noupdate -group tb /test_ocm_tb/test_data
add wave -noupdate -group tb -radix unsigned -radixshowbase 0 /test_ocm_tb/test_data_addr
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/D_WIDTH
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/ID_WIDTH
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/araddr
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arburst
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arcache
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arlen
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arlock
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arprot
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arqos
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arready
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arsize
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/arvalid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awaddr
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awburst
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awcache
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awlen
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awlock
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awprot
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awqos
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awready
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awsize
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/awvalid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/bid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/bready
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/bresp
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/bvalid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/rdata
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/rid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/rlast
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/rready
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/rresp
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/rvalid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/wdata
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/wid
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/wlast
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/wready
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/wstrb
add wave -noupdate -group AXI_HP /test_ocm_tb/axi_hp0/wvalid
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/BASEADDR
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/NBUSES
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/ACP_TEST_STRUCT_SIZE
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/ACP_TEST_STRUCT_FULL_SIZE
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/MAX_ARLEN
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/ACP_AXSIZE
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/AXI_GP_AXSIZE
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/PACK_SIZE
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/NPULSE
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/BASEREG
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/N_REGS
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/BASEREG2
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/PL
add wave -noupdate -group acp_test -childformat {{/test_ocm_tb/acp_test_inst/PS.AXLEN -radix unsigned} {/test_ocm_tb/acp_test_inst/PS.AXSIZE -radix unsigned} {/test_ocm_tb/acp_test_inst/PS.RD_SIZE -radix unsigned}} -subitemconfig {/test_ocm_tb/acp_test_inst/PS.AXLEN {-height 15 -radix unsigned} /test_ocm_tb/acp_test_inst/PS.AXSIZE {-height 15 -radix unsigned} /test_ocm_tb/acp_test_inst/PS.RD_SIZE {-height 15 -radix unsigned}} /test_ocm_tb/acp_test_inst/PS
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/PL2
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/PS2
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/start_pulse
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/axi_rlast
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/arvalid_reg
add wave -noupdate -group acp_test -radix unsigned -radixshowbase 0 /test_ocm_tb/acp_test_inst/addr_4B
add wave -noupdate -group acp_test -radix unsigned -radixshowbase 0 /test_ocm_tb/acp_test_inst/addr_4B_inc
add wave -noupdate -group acp_test -color Magenta /test_ocm_tb/acp_test_inst/last_trans
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/full_acp
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/axi_wlast
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/awbusy
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/wstrb
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/wstrb_cntr_wr
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/wstrb_cntr_rd
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/wstrb_cntr
add wave -noupdate -group acp_test -radix unsigned -radixshowbase 0 /test_ocm_tb/acp_test_inst/ARSIZE
add wave -noupdate -group acp_test -radix unsigned -radixshowbase 0 /test_ocm_tb/acp_test_inst/ARLEN
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/axi_ar
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/BURST_TYPE
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/AxCACHE
add wave -noupdate -group acp_test /test_ocm_tb/acp_test_inst/AxLOCK
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASEADDR
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/ADC_PORTS
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/NBUSES
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/NPULSE
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASEREGFILE
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASEIRQ
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASETIME
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASECORRCH
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASEFACQ
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BUS_FACQ
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BUS_REFINTER
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASEREFINT
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASECALIBR
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BUS_CALIB
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASEDATCOLL
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BUS_DATCOLL
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASEIMI
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BUS_IMI
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BASEVITDEC
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/BUS_VITDEC
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/core_clk
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/fix_pulse
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/irq
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/pps_in
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/pps_out
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/pps_pulse
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/irq_pulse
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/PL
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/PS
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/set_lock
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/TM
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/facq_time_pulse
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/pps_composite
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/epoch_pulse
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/sec_pulse
add wave -noupdate -expand -group trcv /test_ocm_tb/TRCV/core_resetn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {670021413 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 408
configure wave -valuecolwidth 156
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
WaveRestoreZoom {0 fs} {4200 ns}
