onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /axi_trig_tb/BASEADDR
add wave -noupdate -expand -group tb /axi_trig_tb/ADC_PORTS
add wave -noupdate -expand -group tb /axi_trig_tb/aclk
add wave -noupdate -expand -group tb /axi_trig_tb/aresetn
add wave -noupdate -expand -group tb /axi_trig_tb/trig_axi_debug
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/BASEADDR
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/CNTRWIDTH
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/SEL_BASE_ADDR
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/NPULSE
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/trig
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/cntr
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/axi_active
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/en
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/axi_curr
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/axi_prev
add wave -noupdate -expand -group axi_trig -childformat {{/axi_trig_tb/axi_trig/PS.TIMEOUT -radix unsigned}} -expand -subitemconfig {/axi_trig_tb/axi_trig/PS.TIMEOUT {-radix unsigned}} /axi_trig_tb/axi_trig/PS
add wave -noupdate -expand -group axi_trig /axi_trig_tb/axi_trig/reset_pulse
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/aclk
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/resetn
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/araddr
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arburst
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arcache
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arlen
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arlock
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arprot
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arqos
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arready
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arsize
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/arvalid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awaddr
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awburst
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awcache
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awlen
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awlock
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awprot
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awqos
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awready
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awsize
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/awvalid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/bid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/bready
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/bresp
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/bvalid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/rdata
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/rid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/rlast
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/rready
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/rresp
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/rvalid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/wdata
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/wid
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/wlast
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/wready
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/wstrb
add wave -noupdate -expand -group axi3 /axi_trig_tb/axi3/wvalid
add wave -noupdate -expand -group bus /axi_trig_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group bus /axi_trig_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group bus /axi_trig_tb/bus/clk
add wave -noupdate -expand -group bus /axi_trig_tb/bus/resetn
add wave -noupdate -expand -group bus /axi_trig_tb/bus/addr
add wave -noupdate -expand -group bus /axi_trig_tb/bus/wdata
add wave -noupdate -expand -group bus /axi_trig_tb/bus/rdata
add wave -noupdate -expand -group bus /axi_trig_tb/bus/rvalid
add wave -noupdate -expand -group bus /axi_trig_tb/bus/wr
add wave -noupdate -expand -group bus /axi_trig_tb/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1345340 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 301
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
WaveRestoreZoom {0 ps} {4200 ns}
