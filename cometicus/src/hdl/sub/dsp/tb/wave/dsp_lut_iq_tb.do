onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /dsp_lut_iq_tb/IN_WIDTH
add wave -noupdate -expand -group tb /dsp_lut_iq_tb/OUT_WIDTH
add wave -noupdate -expand -group tb /dsp_lut_iq_tb/aclk
add wave -noupdate -expand -group tb /dsp_lut_iq_tb/rf_clk
add wave -noupdate -expand -group tb -height 15 -max 126.99999999999997 -min -128.0 -radix decimal /dsp_lut_iq_tb/q_in
add wave -noupdate -expand -group tb -height 15 -max 127.0 -min -127.0 -radix decimal /dsp_lut_iq_tb/q_out
add wave -noupdate -expand -group tb -expand -group analog -format Analog-Step -height 305 -max 126.99999999999994 -min -128.0 -radix decimal -childformat {{{/dsp_lut_iq_tb/i_in[7]} -radix decimal} {{/dsp_lut_iq_tb/i_in[6]} -radix decimal} {{/dsp_lut_iq_tb/i_in[5]} -radix decimal} {{/dsp_lut_iq_tb/i_in[4]} -radix decimal} {{/dsp_lut_iq_tb/i_in[3]} -radix decimal} {{/dsp_lut_iq_tb/i_in[2]} -radix decimal} {{/dsp_lut_iq_tb/i_in[1]} -radix decimal} {{/dsp_lut_iq_tb/i_in[0]} -radix decimal}} -subitemconfig {{/dsp_lut_iq_tb/i_in[7]} {-radix decimal} {/dsp_lut_iq_tb/i_in[6]} {-radix decimal} {/dsp_lut_iq_tb/i_in[5]} {-radix decimal} {/dsp_lut_iq_tb/i_in[4]} {-radix decimal} {/dsp_lut_iq_tb/i_in[3]} {-radix decimal} {/dsp_lut_iq_tb/i_in[2]} {-radix decimal} {/dsp_lut_iq_tb/i_in[1]} {-radix decimal} {/dsp_lut_iq_tb/i_in[0]} {-radix decimal}} /dsp_lut_iq_tb/i_in
add wave -noupdate -expand -group tb -expand -group analog -format Analog-Step -height 341 -max 126.99999999999999 -min -127.0 -radix decimal /dsp_lut_iq_tb/i_out
add wave -noupdate -expand -group tb /dsp_lut_iq_tb/we
add wave -noupdate -expand -group tb /dsp_lut_iq_tb/data_valid
add wave -noupdate -expand -group tb /dsp_lut_iq_tb/valid
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/BASEADDR
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/IN_WIDTH
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/OUT_WIDTH
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/DEPTH
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/NPULSE
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/clk
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/i_in
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/q_in
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/i_out
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/q_out
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/we
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/valid
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/ram
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/ram_out_a
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/ram_out_b
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/addr_a
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/addr_b
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/addr_wr
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/PS
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/clr
add wave -noupdate -expand -group dsp_lut_iq -group abs_i /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_i_in_inst/WIDTH
add wave -noupdate -expand -group dsp_lut_iq -group abs_i /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_i_in_inst/FF
add wave -noupdate -expand -group dsp_lut_iq -group abs_i /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_i_in_inst/clk
add wave -noupdate -expand -group dsp_lut_iq -group abs_i /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_i_in_inst/in
add wave -noupdate -expand -group dsp_lut_iq -group abs_i /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_i_in_inst/out
add wave -noupdate -expand -group dsp_lut_iq -group abs_i /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_i_in_inst/we
add wave -noupdate -expand -group dsp_lut_iq -group abs_i /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_i_in_inst/valid
add wave -noupdate -expand -group dsp_lut_iq -group abs_i /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_i_in_inst/in_abs
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/wr_ram
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/abs_valid
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/ram_valid
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/q_sign
add wave -noupdate -expand -group dsp_lut_iq /dsp_lut_iq_tb/dsp_lut_iq_inst/i_sign
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/clk
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/addr
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/wdata
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/rdata
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/rvalid
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/wr
add wave -noupdate -group bus /dsp_lut_iq_tb/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17171790 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 336
configure wave -valuecolwidth 97
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
WaveRestoreZoom {0 ps} {36750 ns}
