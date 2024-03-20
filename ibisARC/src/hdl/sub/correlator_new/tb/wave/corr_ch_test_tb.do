onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group input
add wave -group input {/corr_ch_test_tb/genblk1[0]/CR_CH/INP[0]/CH_MUL/adc_re}
add wave -group input {/corr_ch_test_tb/genblk1[0]/CR_CH/INP[0]/CH_MUL/adc_im}
add wave -group input {/corr_ch_test_tb/genblk1[0]/CR_CH/INP[0]/CH_MUL/phase }
add wave -group input -noupdate -divider out
add wave -group input {/corr_ch_test_tb/genblk1[0]/CR_CH/INP[0]/CH_MUL/i_prod}
add wave -group input {/corr_ch_test_tb/genblk1[0]/CR_CH/INP[0]/CH_MUL/q_prod}


add wave -noupdate -group tb /corr_ch_test_tb/BASEADDR
add wave -noupdate -group tb /corr_ch_test_tb/PCLK_PERIOD
add wave -noupdate -group tb /corr_ch_test_tb/ADC_PORTS
add wave -noupdate -group tb /corr_ch_test_tb/pclk
add wave -noupdate -group tb /corr_ch_test_tb/aclk
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/BASEADDR
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/IQ_DIGS
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/NBUSES
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PRN_GEN
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PRN_RAM
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/BASETIME
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/BASEREGFILE
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/BASEADDR
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/NPULSE
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/clk
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/chip_pulse
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/epoch_pulse
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/sec_pulse
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/fix_pulse
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/do_rqst
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/eph_apply
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/time_out
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/phase_hi
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/PL
add wave -noupdate -group CH -group TIME -expand -subitemconfig {/corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/PS.CHIP_EPOCH -expand} /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/PS
add wave -noupdate -group CH -group TIME -expand -subitemconfig {/corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/T.CHIP_EPOCH -expand} /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/T
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/eph_rqst
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/eph_set
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/phase_next
add wave -noupdate -group CH -group TIME /corr_ch_test_tb/genblk1\[0\]/CR_CH/TIME_SCALE_CH/week_pulse
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/fix_pulse
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/irq_pulse
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PL
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PS
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/epoch_pulse
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/do_rqst
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/prn_gen_bus_num
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/BASE_PRN_GEN
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/prn_ram_bus_num
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/BASE_PRN_RAM
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/regs_file_bus_num
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/eph_apply
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/time_out
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/phase_hi
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/chip_pulse
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/pn_gen
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/pn_ram
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/mask_gen
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/mask_ram
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/MASK
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PN
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/int_wr_arr
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PN_LINE
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PN_dly
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/mask_LINE
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/mask_dly
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PHASE_RATE
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/phase_next
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/PHASE
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/CAR_CYCLES
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/cos_prod
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/sin_prod
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/cos_prod32
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/sin_prod32
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/ovfl
add wave -noupdate -group CH -expand -subitemconfig {{/corr_ch_test_tb/genblk1\[0\]/CR_CH/I[0]} {-height 15 -childformat {{{[2]} -radix decimal} {{[1]} -radix decimal} {{[0]} -radix decimal}} -expand} {/corr_ch_test_tb/genblk1\[0\]/CR_CH/I[0][2]} {-radix decimal} {/corr_ch_test_tb/genblk1\[0\]/CR_CH/I[0][1]} {-radix decimal} {/corr_ch_test_tb/genblk1\[0\]/CR_CH/I[0][0]} {-radix decimal}} /corr_ch_test_tb/genblk1\[0\]/CR_CH/I
add wave -noupdate -group CH -expand -subitemconfig {{/corr_ch_test_tb/genblk1\[0\]/CR_CH/Q[0]} -expand} /corr_ch_test_tb/genblk1\[0\]/CR_CH/Q
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/INPUT_I
add wave -noupdate -group CH /corr_ch_test_tb/genblk1\[0\]/CR_CH/INPUT_Q
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/D_WIDTH
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/ID_WIDTH
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/WSTRB_W
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/aclk
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/araddr
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arburst
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arcache
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arlen
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arlock
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arprot
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arqos
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arready
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arsize
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/arvalid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awaddr
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awburst
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awcache
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awlen
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awlock
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awprot
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awqos
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awready
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awsize
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/awvalid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/bid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/bready
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/bresp
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/bvalid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/rdata
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/rid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/rlast
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/rready
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/rresp
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/rvalid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/wdata
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/wid
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/wlast
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/wready
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/wstrb
add wave -noupdate -expand -group axi3 /corr_ch_test_tb/axi3/wvalid
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/clk
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/addr
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/wdata
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/rdata
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/rvalid
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/wr
add wave -noupdate -expand -group bus /corr_ch_test_tb/bus/rd
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/ADDR_WIDTH
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/TIMEOUT
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/rdata_fifo
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/rdata_fifo_addr_rd
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/rdata_fifo_addr_wr
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/rresp_fifo
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/read_phase
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/write_phase
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/state_arbiter
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/wready
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/cntr_timeout
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/timeout
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/araddr
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/awaddr
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/addr_count
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/arlen
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/awlen
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/arid
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/awid
add wave -noupdate -expand -group axi3_to_inter /corr_ch_test_tb/axi3_to_inter_inst/bvalid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3947468354 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 364
configure wave -valuecolwidth 121
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
WaveRestoreZoom {0 fs} {15750 ns}
