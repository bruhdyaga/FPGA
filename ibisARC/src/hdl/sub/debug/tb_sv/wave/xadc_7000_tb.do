onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/BASEADDR
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/SIZE_ID_REGS
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/XADC_ID
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/NREGS
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/SIZE_ID
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/clk
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/resetn
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/addr
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/wdata
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/rdata
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/rvalid
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/wr
add wave -noupdate -expand -group XADC -expand -group bus /xadc_7000_tb/bus/rd
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/reset_pulse
add wave -noupdate -expand -group XADC /xadc_7000_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/xadc_reset_asy_n
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/xadc_reset_n
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/ADDR_MAX
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/xadc_rvalid
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/ADDR_TEST
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/ADDR_DIFF
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/ADDR_MORE
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/ADDR_LESS
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/id_rdata
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/id_rvalid
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/xadc_daddr
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/xadc_rd
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/xadc_wr
add wave -noupdate -expand -group XADC /xadc_7000_tb/XADC/xadc_rdata
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/ADDR_WIDTH
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/TIMEOUT
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/rdata_fifo
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/rdata_fifo_addr_rd
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/rdata_fifo_addr_wr
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/rresp_fifo
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/read_phase
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/write_phase
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/state_arbiter
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/cntr_timeout
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/timeout
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/araddr
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/awaddr
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/addr_count
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/arlen
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/awlen
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/arid
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/awid
add wave -noupdate -group axi3_to_inter /xadc_7000_tb/axi3_to_inter_inst/bvalid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/aclk
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/resetn
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/araddr
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arburst
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arcache
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arlen
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arlock
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arprot
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arqos
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arready
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arsize
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/arvalid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awaddr
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awburst
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awcache
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awlen
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awlock
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awprot
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awqos
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awready
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awsize
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/awvalid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/bid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/bready
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/bresp
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/bvalid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/rdata
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/rid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/rlast
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/rready
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/rresp
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/rvalid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/wdata
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/wid
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/wlast
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/wready
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/wstrb
add wave -noupdate -group axi3 /xadc_7000_tb/axi3/wvalid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5639357745 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 286
configure wave -valuecolwidth 119
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
WaveRestoreZoom {5625937500 fs} {6019687500 fs}
