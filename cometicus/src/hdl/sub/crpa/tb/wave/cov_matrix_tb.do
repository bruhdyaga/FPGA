onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /cov_matrix_tb/BASEADDR
add wave -noupdate -expand -group tb /cov_matrix_tb/NCH
add wave -noupdate -expand -group tb /cov_matrix_tb/WIDTH
add wave -noupdate -expand -group tb /cov_matrix_tb/NT
add wave -noupdate -expand -group tb /cov_matrix_tb/MACCS_NUM
add wave -noupdate -expand -group tb /cov_matrix_tb/ACCUM_WIDTH
add wave -noupdate -expand -group tb /cov_matrix_tb/pclk
add wave -noupdate -expand -group tb /cov_matrix_tb/aclk
add wave -noupdate -expand -group tb /cov_matrix_tb/aresetn
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/aclk
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/resetn
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/araddr
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arburst
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arcache
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arlen
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arlock
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arprot
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arqos
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arready
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arsize
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/arvalid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awaddr
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awburst
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awcache
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awlen
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awlock
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awprot
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awqos
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awready
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awsize
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/awvalid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/bid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/bready
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/bresp
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/bvalid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/rdata
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/rid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/rlast
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/rready
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/rresp
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/rvalid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/wdata
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/wid
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/wlast
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/wready
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/wstrb
add wave -noupdate -group axi3 /cov_matrix_tb/axi3/wvalid
add wave -noupdate -group bus /cov_matrix_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /cov_matrix_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /cov_matrix_tb/bus/clk
add wave -noupdate -group bus /cov_matrix_tb/bus/resetn
add wave -noupdate -group bus /cov_matrix_tb/bus/addr
add wave -noupdate -group bus /cov_matrix_tb/bus/wdata
add wave -noupdate -group bus /cov_matrix_tb/bus/rdata
add wave -noupdate -group bus /cov_matrix_tb/bus/rvalid
add wave -noupdate -group bus /cov_matrix_tb/bus/wr
add wave -noupdate -group bus /cov_matrix_tb/bus/rd
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/BASEADDR
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/NCH
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/NT
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/WIDTH
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/MACCS_NUM
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/ACCUM_WIDTH
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/NPULSE
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/sclk}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/dclk}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/sreset_n}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/dreset_n}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/start}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/ready}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/rqst_start_s}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/finish_rqst_d}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/finish_rqst_s}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/rqst_start_d}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/finish_d_start}
add wave -noupdate -expand -group CVM -group pulse {/cov_matrix_tb/CVM/RF/WR_GEN[0]/PULSING/genblk1[0]/genblk1[0]/genblk1/PULSE_SYNC/finish_d_stop}
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/Nin
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/WIDTH
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/NT
add wave -noupdate -expand -group CVM -group DLA -group data_in /cov_matrix_tb/CVM/DLA/data_in/PORTS
add wave -noupdate -expand -group CVM -group DLA -group data_in /cov_matrix_tb/CVM/DLA/data_in/R
add wave -noupdate -expand -group CVM -group DLA -group data_in -childformat {{{/cov_matrix_tb/CVM/DLA/data_in/data[1]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_in/data[0]} -radix decimal}} -expand -subitemconfig {{/cov_matrix_tb/CVM/DLA/data_in/data[1]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_in/data[0]} {-height 15 -radix decimal}} /cov_matrix_tb/CVM/DLA/data_in/data
add wave -noupdate -expand -group CVM -group DLA -group data_in /cov_matrix_tb/CVM/DLA/data_in/clk
add wave -noupdate -expand -group CVM -group DLA -group data_in /cov_matrix_tb/CVM/DLA/data_in/resetn
add wave -noupdate -expand -group CVM -group DLA -group data_dly /cov_matrix_tb/CVM/DLA/data_dly/PORTS
add wave -noupdate -expand -group CVM -group DLA -group data_dly /cov_matrix_tb/CVM/DLA/data_dly/GROUP
add wave -noupdate -expand -group CVM -group DLA -group data_dly /cov_matrix_tb/CVM/DLA/data_dly/R
add wave -noupdate -expand -group CVM -group DLA -group data_dly -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0]} -radix decimal -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1]} -radix decimal -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][13]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][12]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][11]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][10]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][9]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][8]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][7]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][6]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][5]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][4]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][3]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][2]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][1]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][0]} -radix decimal}}} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0]} -radix decimal -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][13]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][12]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][11]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][10]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][9]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][8]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][7]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][6]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][5]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][4]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][3]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][2]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][1]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][0]} -radix decimal}}}}}} -subitemconfig {{/cov_matrix_tb/CVM/DLA/data_dly/data[0]} {-height 15 -radix decimal -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1]} -radix decimal -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][13]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][12]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][11]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][10]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][9]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][8]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][7]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][6]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][5]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][4]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][3]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][2]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][1]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][0]} -radix decimal}}} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0]} -radix decimal -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][13]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][12]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][11]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][10]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][9]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][8]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][7]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][6]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][5]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][4]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][3]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][2]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][1]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][0]} -radix decimal}}}} -expand} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1]} {-height 15 -radix decimal -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][13]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][12]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][11]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][10]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][9]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][8]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][7]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][6]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][5]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][4]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][3]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][2]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][1]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][0]} -radix decimal}}} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][13]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][12]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][11]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][10]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][9]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][8]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][7]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][6]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][5]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][4]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][3]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][2]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][1]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][1][0]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0]} {-height 15 -radix decimal -childformat {{{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][13]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][12]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][11]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][10]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][9]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][8]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][7]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][6]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][5]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][4]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][3]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][2]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][1]} -radix decimal} {{/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][0]} -radix decimal}}} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][13]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][12]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][11]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][10]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][9]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][8]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][7]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][6]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][5]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][4]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][3]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][2]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][1]} {-height 15 -radix decimal} {/cov_matrix_tb/CVM/DLA/data_dly/data[0][0][0]} {-height 15 -radix decimal}} /cov_matrix_tb/CVM/DLA/data_dly/data
add wave -noupdate -expand -group CVM -group DLA -group data_dly /cov_matrix_tb/CVM/DLA/data_dly/clk
add wave -noupdate -expand -group CVM -group DLA -group data_dly /cov_matrix_tb/CVM/DLA/data_dly/resetn
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/first_in
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/first_out
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/last_in
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/last_out
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/valid_dly
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/last_dly
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/first_dly
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/we
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/valid
add wave -noupdate -expand -group CVM -group DLA /cov_matrix_tb/CVM/DLA/ce
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/SIZEIN}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/SIZEACC}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/clk}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/resetn}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/ce}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/first}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/a}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/b}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/we}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/accum}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/a_reg}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/b_reg}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/mult_reg}
add wave -noupdate -expand -group CVM -group MA_0 {/cov_matrix_tb/CVM/MACS[0]/MA/first_reg}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/SIZEIN}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/SIZEACC}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/clk}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/resetn}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/ce}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/first}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/a}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/b}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/we}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/accum}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/a_reg}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/b_reg}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/mult_reg}
add wave -noupdate -expand -group CVM -group MA_1 {/cov_matrix_tb/CVM/MACS[1]/MA/first_reg}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/SIZEIN}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/SIZEACC}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/clk}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/resetn}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/ce}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/first}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/a}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/b}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/we}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/accum}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/a_reg}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/b_reg}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/mult_reg}
add wave -noupdate -expand -group CVM -group MA_2 {/cov_matrix_tb/CVM/MACS[2]/MA/first_reg}
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/ce
add wave -noupdate -expand -group CVM -group data_dly /cov_matrix_tb/CVM/data_dly/PORTS
add wave -noupdate -expand -group CVM -group data_dly /cov_matrix_tb/CVM/data_dly/GROUP
add wave -noupdate -expand -group CVM -group data_dly /cov_matrix_tb/CVM/data_dly/R
add wave -noupdate -expand -group CVM -group data_dly /cov_matrix_tb/CVM/data_dly/data
add wave -noupdate -expand -group CVM -group data_dly /cov_matrix_tb/CVM/data_dly/clk
add wave -noupdate -expand -group CVM -group data_dly /cov_matrix_tb/CVM/data_dly/resetn
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/PL
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/PS
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/start
add wave -noupdate -expand -group CVM -radix unsigned -radixshowbase 0 /cov_matrix_tb/CVM/cntr
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/we_data
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/first_to_dly
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/first_to_mac
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/last_to_dly
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/last_to_mac
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/last_to_mac_dly
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/completion
add wave -noupdate -expand -group CVM /cov_matrix_tb/CVM/valid_dly
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1217670 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 277
configure wave -valuecolwidth 133
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
WaveRestoreZoom {0 ps} {11550 ns}
