onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /fir_tb/WIDTH_DATA
add wave -noupdate -group tb /fir_tb/WIDTH_COEF
add wave -noupdate -group tb /fir_tb/ORDER
add wave -noupdate -group tb /fir_tb/NCH
add wave -noupdate -group tb /fir_tb/clk
add wave -noupdate -group tb /fir_tb/aclk
add wave -noupdate -expand -group FIR /fir_tb/FIR/BASEADDR
add wave -noupdate -expand -group FIR -radix unsigned /fir_tb/FIR/WIDTH_COEF
add wave -noupdate -expand -group FIR -radix unsigned /fir_tb/FIR/ORDER
add wave -noupdate -expand -group FIR -radix unsigned /fir_tb/FIR/NCH
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/BASEADDR
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/ID
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/DATA_WIDTH
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/OUTFF
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/NREGS
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/INIT
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/NPULSE
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/clk
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/in
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/out
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/pulse
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/wr
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/rd
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/reg_wdata
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/reg_rdata
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/reg_rdata_const
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/reg_rdata_int
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/reg_mem
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/reg_mem_const
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/reg_const_rd
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/sync_rd
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/pulse_reg
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/out_arr
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/in_arr
add wave -noupdate -expand -group FIR -group RF /fir_tb/FIR/RF/init_arr
add wave -noupdate -expand -group FIR -expand -group in /fir_tb/FIR/in/PORTS
add wave -noupdate -expand -group FIR -expand -group in /fir_tb/FIR/WIDTH_IN_DATA
add wave -noupdate -expand -group FIR -expand -group in /fir_tb/FIR/in/R
add wave -noupdate -expand -group FIR -expand -group in -childformat {{{/fir_tb/FIR/in/data[1]} -radix decimal} {{/fir_tb/FIR/in/data[0]} -radix decimal}} -expand -subitemconfig {{/fir_tb/FIR/in/data[1]} {-height 15 -radix decimal} {/fir_tb/FIR/in/data[0]} {-height 15 -radix decimal}} /fir_tb/FIR/in/data
add wave -noupdate -expand -group FIR -expand -group in /fir_tb/FIR/in/clk
add wave -noupdate -expand -group FIR -expand -group out /fir_tb/FIR/out/PORTS
add wave -noupdate -expand -group FIR -expand -group out /fir_tb/FIR/out/R
add wave -noupdate -expand -group FIR -expand -group out -childformat {{{/fir_tb/FIR/out/data[1]} -radix decimal} {{/fir_tb/FIR/out/data[0]} -radix decimal -childformat {{{/fir_tb/FIR/out/data[0][13]} -radix decimal} {{/fir_tb/FIR/out/data[0][12]} -radix decimal} {{/fir_tb/FIR/out/data[0][11]} -radix decimal} {{/fir_tb/FIR/out/data[0][10]} -radix decimal} {{/fir_tb/FIR/out/data[0][9]} -radix decimal} {{/fir_tb/FIR/out/data[0][8]} -radix decimal} {{/fir_tb/FIR/out/data[0][7]} -radix decimal} {{/fir_tb/FIR/out/data[0][6]} -radix decimal} {{/fir_tb/FIR/out/data[0][5]} -radix decimal} {{/fir_tb/FIR/out/data[0][4]} -radix decimal} {{/fir_tb/FIR/out/data[0][3]} -radix decimal} {{/fir_tb/FIR/out/data[0][2]} -radix decimal} {{/fir_tb/FIR/out/data[0][1]} -radix decimal} {{/fir_tb/FIR/out/data[0][0]} -radix decimal}}}} -expand -subitemconfig {{/fir_tb/FIR/out/data[1]} {-height 15 -radix decimal} {/fir_tb/FIR/out/data[0]} {-height 15 -radix decimal -childformat {{{/fir_tb/FIR/out/data[0][13]} -radix decimal} {{/fir_tb/FIR/out/data[0][12]} -radix decimal} {{/fir_tb/FIR/out/data[0][11]} -radix decimal} {{/fir_tb/FIR/out/data[0][10]} -radix decimal} {{/fir_tb/FIR/out/data[0][9]} -radix decimal} {{/fir_tb/FIR/out/data[0][8]} -radix decimal} {{/fir_tb/FIR/out/data[0][7]} -radix decimal} {{/fir_tb/FIR/out/data[0][6]} -radix decimal} {{/fir_tb/FIR/out/data[0][5]} -radix decimal} {{/fir_tb/FIR/out/data[0][4]} -radix decimal} {{/fir_tb/FIR/out/data[0][3]} -radix decimal} {{/fir_tb/FIR/out/data[0][2]} -radix decimal} {{/fir_tb/FIR/out/data[0][1]} -radix decimal} {{/fir_tb/FIR/out/data[0][0]} -radix decimal}}} {/fir_tb/FIR/out/data[0][13]} {-radix decimal} {/fir_tb/FIR/out/data[0][12]} {-radix decimal} {/fir_tb/FIR/out/data[0][11]} {-radix decimal} {/fir_tb/FIR/out/data[0][10]} {-radix decimal} {/fir_tb/FIR/out/data[0][9]} {-radix decimal} {/fir_tb/FIR/out/data[0][8]} {-radix decimal} {/fir_tb/FIR/out/data[0][7]} {-radix decimal} {/fir_tb/FIR/out/data[0][6]} {-radix decimal} {/fir_tb/FIR/out/data[0][5]} {-radix decimal} {/fir_tb/FIR/out/data[0][4]} {-radix decimal} {/fir_tb/FIR/out/data[0][3]} {-radix decimal} {/fir_tb/FIR/out/data[0][2]} {-radix decimal} {/fir_tb/FIR/out/data[0][1]} {-radix decimal} {/fir_tb/FIR/out/data[0][0]} {-radix decimal}} /fir_tb/FIR/out/data
add wave -noupdate -expand -group FIR -expand -group out /fir_tb/FIR/out/clk
add wave -noupdate -expand -group FIR /fir_tb/FIR/sum
add wave -noupdate -expand -group FIR /fir_tb/FIR/mul
add wave -noupdate -expand -group FIR /fir_tb/FIR/SYN_COEF
add wave -noupdate -expand -group FIR /fir_tb/FIR/ACC_SUM_WIDTH
add wave -noupdate -expand -group FIR /fir_tb/FIR/PRE_SUM_WIDTH
add wave -noupdate -expand -group FIR /fir_tb/FIR/NPULSE
add wave -noupdate -expand -group FIR /fir_tb/FIR/coef_mirr
add wave -noupdate -expand -group FIR /fir_tb/FIR/slr
add wave -noupdate -expand -group FIR /fir_tb/FIR/pre_sum
add wave -noupdate -expand -group FIR /fir_tb/FIR/coef_wr
add wave -noupdate -expand -group FIR /fir_tb/FIR/A1_reg
add wave -noupdate -expand -group FIR /fir_tb/FIR/A2_reg
add wave -noupdate -expand -group FIR /fir_tb/FIR/D_reg
add wave -noupdate -expand -group FIR /fir_tb/FIR/AD_reg
add wave -noupdate -expand -group FIR -expand -subitemconfig {{/fir_tb/FIR/B1_reg[1]} -expand {/fir_tb/FIR/B1_reg[0]} -expand} /fir_tb/FIR/B1_reg
add wave -noupdate -expand -group FIR /fir_tb/FIR/M_reg
add wave -noupdate -expand -group FIR -expand -subitemconfig {{/fir_tb/FIR/P_reg[0]} -expand} /fir_tb/FIR/P_reg
add wave -noupdate -expand -group FIR /fir_tb/FIR/MIRR_COEF
add wave -noupdate -expand -group FIR /fir_tb/FIR/PL
add wave -noupdate -expand -group FIR -expand -subitemconfig {/fir_tb/FIR/PS.CFG -expand /fir_tb/FIR/PS.COEF -expand} /fir_tb/FIR/PS
add wave -noupdate /fir_tb/FIR/PS.CFG.WIDTH_COEF_CONST
add wave -noupdate -group in /fir_tb/in/PORTS
add wave -noupdate -group in /fir_tb/in/R
add wave -noupdate -group in /fir_tb/in/data
add wave -noupdate -group in /fir_tb/in/clk
add wave -noupdate -group out /fir_tb/out/PORTS
add wave -noupdate -group out /fir_tb/out/R
add wave -noupdate -group out -expand /fir_tb/out/data
add wave -noupdate -group out /fir_tb/out/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1104110 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
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
WaveRestoreZoom {0 ps} {10500 ns}
