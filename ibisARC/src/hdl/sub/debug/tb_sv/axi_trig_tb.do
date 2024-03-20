onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /axi_trig_tb/clk
add wave -noupdate -expand -group tb /axi_trig_tb/resetn
add wave -noupdate -expand -group tb /axi_trig_tb/TRIGADDR
add wave -noupdate -expand -group tb /axi_trig_tb/trig
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/TIMEOUT
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/TRIGADDR
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/CNTRWIDTH
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/clk
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/resetn
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/trig
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/cntr
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/axi_active
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/en
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/axi_prev
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig_inst/axi_curr
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/ADDR_WIDTH
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/DATA_WIDTH
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/clk
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/resetn
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/addr
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/wdata
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/rdata
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/rvalid
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/wr
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/rd
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/baseaddr
add wave -noupdate -group int_bus /axi_trig_tb/int_bus/asize
add wave -noupdate -group axi3 /axi_trig_tb/axi3/aclk
add wave -noupdate -group axi3 /axi_trig_tb/axi3/resetn
add wave -noupdate -group axi3 /axi_trig_tb/axi3/araddr
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arburst
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arcache
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arlen
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arlock
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arprot
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arqos
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arready
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arsize
add wave -noupdate -group axi3 /axi_trig_tb/axi3/arvalid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awaddr
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awburst
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awcache
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awlen
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awlock
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awprot
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awqos
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awready
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awsize
add wave -noupdate -group axi3 /axi_trig_tb/axi3/awvalid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/bid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/bready
add wave -noupdate -group axi3 /axi_trig_tb/axi3/bresp
add wave -noupdate -group axi3 /axi_trig_tb/axi3/bvalid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/rdata
add wave -noupdate -group axi3 /axi_trig_tb/axi3/rid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/rlast
add wave -noupdate -group axi3 /axi_trig_tb/axi3/rready
add wave -noupdate -group axi3 /axi_trig_tb/axi3/rresp
add wave -noupdate -group axi3 /axi_trig_tb/axi3/rvalid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/wdata
add wave -noupdate -group axi3 /axi_trig_tb/axi3/wid
add wave -noupdate -group axi3 /axi_trig_tb/axi3/wlast
add wave -noupdate -group axi3 /axi_trig_tb/axi3/wready
add wave -noupdate -group axi3 /axi_trig_tb/axi3/wstrb
add wave -noupdate -group axi3 /axi_trig_tb/axi3/wvalid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {550000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 264
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
WaveRestoreZoom {0 ps} {1952400 ps}
