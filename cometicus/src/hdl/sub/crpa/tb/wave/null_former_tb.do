onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /null_former_tb/BASEADDR
add wave -noupdate -group tb /null_former_tb/NCH
add wave -noupdate -group tb /null_former_tb/WIDTH
add wave -noupdate -group tb /null_former_tb/C_WIDTH
add wave -noupdate -group tb /null_former_tb/NT
add wave -noupdate -group tb /null_former_tb/pclk
add wave -noupdate -group tb /null_former_tb/aclk
add wave -noupdate -group tb /null_former_tb/aresetn
add wave -noupdate -group bus /null_former_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /null_former_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /null_former_tb/bus/clk
add wave -noupdate -group bus /null_former_tb/bus/resetn
add wave -noupdate -group bus /null_former_tb/bus/addr
add wave -noupdate -group bus /null_former_tb/bus/wdata
add wave -noupdate -group bus /null_former_tb/bus/rdata
add wave -noupdate -group bus /null_former_tb/bus/rvalid
add wave -noupdate -group bus /null_former_tb/bus/wr
add wave -noupdate -group bus /null_former_tb/bus/rd
add wave -noupdate -expand -group null_former /null_former_tb/null_former/BASEADDR
add wave -noupdate -expand -group null_former -radix unsigned /null_former_tb/null_former/NCH
add wave -noupdate -expand -group null_former -radix unsigned /null_former_tb/null_former/NT
add wave -noupdate -expand -group null_former -radix unsigned /null_former_tb/null_former/C_WIDTH
add wave -noupdate -expand -group null_former -radix unsigned /null_former_tb/null_former/DIN_WIDTH
add wave -noupdate -expand -group null_former -radix unsigned /null_former_tb/null_former/FIR_WIDTH
add wave -noupdate -expand -group null_former -radix unsigned /null_former_tb/null_former/OUT_WIDTH
add wave -noupdate -expand -group null_former -radix unsigned /null_former_tb/null_former/NPULSE
add wave -noupdate -expand -group null_former /null_former_tb/null_former/ce
add wave -noupdate -expand -group null_former /null_former_tb/null_former/data_out
add wave -noupdate -expand -group null_former -group coeff_0 {/null_former_tb/null_former/coeff[0]/PORTS}
add wave -noupdate -expand -group null_former -group coeff_0 {/null_former_tb/null_former/coeff[0]/R}
add wave -noupdate -expand -group null_former -group coeff_0 -radix unsigned -childformat {{{/null_former_tb/null_former/coeff[0]/data[3]} -radix unsigned} {{/null_former_tb/null_former/coeff[0]/data[2]} -radix unsigned} {{/null_former_tb/null_former/coeff[0]/data[1]} -radix unsigned} {{/null_former_tb/null_former/coeff[0]/data[0]} -radix unsigned}} -expand -subitemconfig {{/null_former_tb/null_former/coeff[0]/data[3]} {-height 15 -radix unsigned} {/null_former_tb/null_former/coeff[0]/data[2]} {-height 15 -radix unsigned} {/null_former_tb/null_former/coeff[0]/data[1]} {-height 15 -radix unsigned} {/null_former_tb/null_former/coeff[0]/data[0]} {-height 15 -radix unsigned}} {/null_former_tb/null_former/coeff[0]/data}
add wave -noupdate -expand -group null_former -group coeff_0 {/null_former_tb/null_former/coeff[0]/clk}
add wave -noupdate -expand -group null_former -group coeff_0 {/null_former_tb/null_former/coeff[0]/resetn}
add wave -noupdate -expand -group null_former -group coeff_1 {/null_former_tb/null_former/coeff[1]/PORTS}
add wave -noupdate -expand -group null_former -group coeff_1 {/null_former_tb/null_former/coeff[1]/R}
add wave -noupdate -expand -group null_former -group coeff_1 -childformat {{{/null_former_tb/null_former/coeff[1]/data[3]} -radix unsigned} {{/null_former_tb/null_former/coeff[1]/data[2]} -radix unsigned} {{/null_former_tb/null_former/coeff[1]/data[1]} -radix unsigned} {{/null_former_tb/null_former/coeff[1]/data[0]} -radix unsigned}} -expand -subitemconfig {{/null_former_tb/null_former/coeff[1]/data[3]} {-height 15 -radix unsigned} {/null_former_tb/null_former/coeff[1]/data[2]} {-height 15 -radix unsigned} {/null_former_tb/null_former/coeff[1]/data[1]} {-height 15 -radix unsigned} {/null_former_tb/null_former/coeff[1]/data[0]} {-height 15 -radix unsigned}} {/null_former_tb/null_former/coeff[1]/data}
add wave -noupdate -expand -group null_former -group coeff_1 {/null_former_tb/null_former/coeff[1]/clk}
add wave -noupdate -expand -group null_former -group coeff_1 {/null_former_tb/null_former/coeff[1]/resetn}
add wave -noupdate -expand -group null_former -expand /null_former_tb/null_former/fir_data
add wave -noupdate -expand -group null_former -childformat {{/null_former_tb/null_former/PS.COEFF -radix unsigned -childformat {{{[0]} -radix unsigned -childformat {{{[0]} -radix unsigned} {{[1]} -radix unsigned} {{[2]} -radix unsigned} {{[3]} -radix unsigned}}} {{[1]} -radix unsigned -childformat {{{[0]} -radix unsigned} {{[1]} -radix unsigned} {{[2]} -radix unsigned} {{[3]} -radix unsigned}}}}}} -subitemconfig {/null_former_tb/null_former/PS.COEFF {-height 15 -radix unsigned -childformat {{{[0]} -radix unsigned -childformat {{{[0]} -radix unsigned} {{[1]} -radix unsigned} {{[2]} -radix unsigned} {{[3]} -radix unsigned}}} {{[1]} -radix unsigned -childformat {{{[0]} -radix unsigned} {{[1]} -radix unsigned} {{[2]} -radix unsigned} {{[3]} -radix unsigned}}}} -expand} {/null_former_tb/null_former/PS.COEFF[0]} {-radix unsigned -childformat {{{[0]} -radix unsigned} {{[1]} -radix unsigned} {{[2]} -radix unsigned} {{[3]} -radix unsigned}}} {/null_former_tb/null_former/PS.COEFF[0][0]} {-radix unsigned} {/null_former_tb/null_former/PS.COEFF[0][1]} {-radix unsigned} {/null_former_tb/null_former/PS.COEFF[0][2]} {-radix unsigned} {/null_former_tb/null_former/PS.COEFF[0][3]} {-radix unsigned} {/null_former_tb/null_former/PS.COEFF[1]} {-radix unsigned -childformat {{{[0]} -radix unsigned} {{[1]} -radix unsigned} {{[2]} -radix unsigned} {{[3]} -radix unsigned}}} {/null_former_tb/null_former/PS.COEFF[1][0]} {-radix unsigned} {/null_former_tb/null_former/PS.COEFF[1][1]} {-radix unsigned} {/null_former_tb/null_former/PS.COEFF[1][2]} {-radix unsigned} {/null_former_tb/null_former/PS.COEFF[1][3]} {-radix unsigned}} /null_former_tb/null_former/PS
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/N_args
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/arg_width
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/reset_type
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/dis_valid
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/tree_height
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/args_in_size
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/out_width
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/clk
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/reset
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/args_in
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/sum_out
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/we
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/valid
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/valid_arr
add wave -noupdate -expand -group null_former -expand -group FIR_SUMM /null_former_tb/null_former/FIR_summ/pipe
add wave -noupdate -expand -group null_former /null_former_tb/null_former/wr_coeff
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3242720 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 443
configure wave -valuecolwidth 104
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
