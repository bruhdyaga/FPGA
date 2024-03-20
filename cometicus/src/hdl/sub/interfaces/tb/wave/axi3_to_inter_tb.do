onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /axi3_to_inter_tb/CLK_FREQ
add wave -noupdate -expand -group tb /axi3_to_inter_tb/CPU_FREQ
add wave -noupdate -expand -group tb /axi3_to_inter_tb/INST
add wave -noupdate -expand -group tb /axi3_to_inter_tb/ID_OFFS
add wave -noupdate -expand -group tb /axi3_to_inter_tb/R0_OFFS
add wave -noupdate -expand -group tb /axi3_to_inter_tb/R1_OFFS
add wave -noupdate -expand -group tb /axi3_to_inter_tb/R2_OFFS
add wave -noupdate -expand -group tb /axi3_to_inter_tb/R3_OFFS
add wave -noupdate -expand -group tb /axi3_to_inter_tb/N_BUSES
add wave -noupdate -expand -group tb /axi3_to_inter_tb/BASEREG1
add wave -noupdate -expand -group tb /axi3_to_inter_tb/BASEREG2
add wave -noupdate -expand -group tb /axi3_to_inter_tb/clk
add wave -noupdate -expand -group tb /axi3_to_inter_tb/aclk
add wave -noupdate -expand -group tb /axi3_to_inter_tb/resetn
add wave -noupdate -expand -group tb /axi3_to_inter_tb/val
add wave -noupdate -expand -group tb /axi3_to_inter_tb/BASE_0_BYTE
add wave -noupdate -expand -group tb /axi3_to_inter_tb/BASE_1_BYTE
add wave -noupdate -expand -group tb /axi3_to_inter_tb/PS1
add wave -noupdate -expand -group tb /axi3_to_inter_tb/PS2
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/ADDR_WIDTH
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/TIMEOUT
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/rdata_fifo
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/rdata_fifo_addr_rd
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/rdata_fifo_addr_wr
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/rresp_fifo
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/read_phase
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/write_phase
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/wready
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/state_arbiter
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/cntr_timeout
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/timeout
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/araddr
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/awaddr
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/addr_count
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/arlen
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/awlen
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/arid
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/awid
add wave -noupdate -expand -group axi3_to_inter /axi3_to_inter_tb/axi3_to_inter_inst/bvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/aclk
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/resetn
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/araddr
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arburst
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arcache
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/arid
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
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/bresp
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/bvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rdata
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rlast
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rready
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rresp
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/rvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wvalid
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wready
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wlast
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wdata
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wstrb
add wave -noupdate -expand -group axi3 /axi3_to_inter_tb/axi3/wid
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/ADDR_WIDTH
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/DATA_WIDTH
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/clk
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/resetn
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/addr
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/wdata
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/rdata
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/rvalid
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/wr
add wave -noupdate -expand -group int_bus /axi3_to_inter_tb/int_bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16808690 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 426
configure wave -valuecolwidth 233
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
WaveRestoreZoom {16593320 ps} {17151160 ps}
