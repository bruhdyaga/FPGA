onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /lim_cntr_tb/IN_WIDTH
add wave -noupdate -expand -group tb /lim_cntr_tb/OUT_WIDTH
add wave -noupdate -expand -group tb /lim_cntr_tb/PERIOD_2N
add wave -noupdate -expand -group tb /lim_cntr_tb/clk
add wave -noupdate -expand -group tb -format Analog-Step -height 74 -max 126.99999999999997 -min -128.0 -radix decimal /lim_cntr_tb/in
add wave -noupdate -expand -group tb /lim_cntr_tb/val
add wave -noupdate -expand -group tb /lim_cntr_tb/resetn
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/BASEADDR
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/IN_WIDTH
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/OUT_WIDTH
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/PERIOD_2N
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/CUT_DIG
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/NPULSE
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/clk
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/resetn
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/we
add wave -noupdate -expand -group lim_cntr -format Analog-Step -height 74 -max 126.99999999999997 -min -128.0 -radix decimal /lim_cntr_tb/lim_cntr_inst/in
add wave -noupdate -expand -group lim_cntr -expand -subitemconfig {/lim_cntr_tb/lim_cntr_inst/PL.CFG -expand} /lim_cntr_tb/lim_cntr_inst/PL
add wave -noupdate -expand -group lim_cntr /lim_cntr_tb/lim_cntr_inst/sync
add wave -noupdate -expand -group lim_cntr -radix unsigned /lim_cntr_tb/lim_cntr_inst/cntr
add wave -noupdate -expand -group lim_cntr -format Analog-Step -height 74 -max 511.0 -radix unsigned /lim_cntr_tb/lim_cntr_inst/cntr_ovfl
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/clk
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/addr
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/wdata
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/rdata
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/rvalid
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/wr
add wave -noupdate -expand -group bus /lim_cntr_tb/bus/rd
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/D_WIDTH
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/ID_WIDTH
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/WSTRB_W
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/aclk
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/araddr
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arburst
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arcache
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arlen
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arlock
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arprot
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arqos
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arready
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arsize
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/arvalid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awaddr
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awburst
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awcache
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awlen
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awlock
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awprot
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awqos
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awready
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awsize
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/awvalid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/bid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/bready
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/bresp
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/bvalid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/rdata
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/rid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/rlast
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/rready
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/rresp
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/rvalid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/wdata
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/wid
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/wlast
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/wready
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/wstrb
add wave -noupdate -expand -group axi3 /lim_cntr_tb/axi3/wvalid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16420580 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 284
configure wave -valuecolwidth 130
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
WaveRestoreZoom {0 ps} {26250 ns}
