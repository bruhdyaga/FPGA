onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /axi_hp_master_tb/AXI_HP_MASTER_BASE
add wave -noupdate -group tb /axi_hp_master_tb/HUB_BASE
add wave -noupdate -group tb /axi_hp_master_tb/CHANNELS
add wave -noupdate -group tb /axi_hp_master_tb/BASECORRCH
add wave -noupdate -group tb /axi_hp_master_tb/ENDCORRCH
add wave -noupdate -group tb /axi_hp_master_tb/rdata
add wave -noupdate -group tb /axi_hp_master_tb/aclk
add wave -noupdate -group tb /axi_hp_master_tb/pclk
add wave -noupdate -group bus /axi_hp_master_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /axi_hp_master_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /axi_hp_master_tb/bus/clk
add wave -noupdate -group bus /axi_hp_master_tb/bus/resetn
add wave -noupdate -group bus /axi_hp_master_tb/bus/addr
add wave -noupdate -group bus /axi_hp_master_tb/bus/wdata
add wave -noupdate -group bus /axi_hp_master_tb/bus/rdata
add wave -noupdate -group bus /axi_hp_master_tb/bus/rvalid
add wave -noupdate -group bus /axi_hp_master_tb/bus/wr
add wave -noupdate -group bus /axi_hp_master_tb/bus/rd
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/ADDR_WIDTH
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/DATA_WIDTH
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/clk
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/resetn
add wave -noupdate -expand -group bus_m -radix hexadecimal -radixshowbase 0 /axi_hp_master_tb/bus_m/addr
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/wdata
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/rdata
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/rvalid
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/wr
add wave -noupdate -expand -group bus_m /axi_hp_master_tb/bus_m/rd
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/D_WIDTH
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/ID_WIDTH
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/araddr
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arburst
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arcache
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arlen
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arlock
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arprot
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arqos
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arready
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arsize
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/arvalid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awaddr
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awburst
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awcache
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awlen
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awlock
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awprot
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awqos
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awready
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awsize
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/awvalid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/bid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/bready
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/bresp
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/bvalid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/rdata
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/rid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/rlast
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/rready
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/rresp
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/rvalid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/wdata
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/wid
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/wlast
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/wready
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/wstrb
add wave -noupdate -expand -group axi_hp /axi_hp_master_tb/axi_hp/wvalid
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/BASEADDR
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/NPULSE
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/PL
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/PS
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/start
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/wr
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/awr
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/new_wr
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/cntr
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/awaddr
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/wdata64
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/burst_cntr
add wave -noupdate -expand -group axi_hp_master /axi_hp_master_tb/AXI_HP_MASTER/int_addr
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/BASEADDR}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/BDSS_CH}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/BDSS_EN}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/IQ_DIGS}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/NBUSES}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/BASETIME}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/BASEPRN}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/BASEREGFILE}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/BASEENDREGFILE}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/fix_pulse}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/irq_pulse}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/chip_pulse}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/bdss_psp}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/PL}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/PS}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/epoch_pulse}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/do_rqst}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/eph_apply}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/time_out}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/phase_hi}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/PN}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/mask}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/PN_LINE}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/PN_dly}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/mask_LINE}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/mask_dly}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/PHASE_RATE}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/phase_next}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/PHASE}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/CAR_CYCLES}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/cos_prod}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/sin_prod}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/cos_prod32}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/sin_prod32}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/I}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/Q}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/INPUT_I}
add wave -noupdate -group ch_0 {/axi_hp_master_tb/CORR_GEN[0]/CORR_CH/INPUT_Q}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/BASEADDR}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/BDSS_CH}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/BDSS_EN}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/IQ_DIGS}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/NBUSES}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/BASETIME}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/BASEPRN}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/BASEREGFILE}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/BASEENDREGFILE}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/fix_pulse}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/irq_pulse}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/chip_pulse}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/bdss_psp}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/PL}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/PS}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/epoch_pulse}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/do_rqst}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/eph_apply}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/time_out}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/phase_hi}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/PN}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/mask}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/PN_LINE}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/PN_dly}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/mask_LINE}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/mask_dly}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/PHASE_RATE}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/phase_next}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/PHASE}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/CAR_CYCLES}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/cos_prod}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/sin_prod}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/cos_prod32}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/sin_prod32}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/I}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/Q}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/INPUT_I}
add wave -noupdate -group ch_9 {/axi_hp_master_tb/CORR_GEN[9]/CORR_CH/INPUT_Q}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/ADDR_WIDTH}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/DATA_WIDTH}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/clk}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/resetn}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/addr}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/wdata}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/rdata}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/rvalid}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/wr}
add wave -noupdate -group bus_sl_0 {/axi_hp_master_tb/bus_sl[0]/rd}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/ADDR_WIDTH}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/DATA_WIDTH}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/clk}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/resetn}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/addr}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/wdata}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/rdata}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/rvalid}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/wr}
add wave -noupdate -group bus_sl_9 {/axi_hp_master_tb/bus_sl[9]/rd}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {864930 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 399
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
WaveRestoreZoom {0 ps} {3150 ns}
