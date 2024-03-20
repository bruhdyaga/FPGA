onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BASE_ADDR
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BIS_addr
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BIS_clk
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BIS_rd
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BIS_rdata
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BIS_resetn
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BIS_wdata
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BIS_wr
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/BUS_ADDR_WIDTH
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/LINES
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/TEST_DATA_WIDTH
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/clk
add wave -noupdate -expand -group tb -childformat {{{/hist_sig_mag_v2_tb/rand_data[6]} -radix decimal} {{/hist_sig_mag_v2_tb/rand_data[5]} -radix decimal} {{/hist_sig_mag_v2_tb/rand_data[4]} -radix decimal} {{/hist_sig_mag_v2_tb/rand_data[3]} -radix decimal} {{/hist_sig_mag_v2_tb/rand_data[2]} -radix decimal} {{/hist_sig_mag_v2_tb/rand_data[1]} -radix decimal} {{/hist_sig_mag_v2_tb/rand_data[0]} -radix decimal}} -subitemconfig {{/hist_sig_mag_v2_tb/rand_data[6]} {-height 15 -radix decimal} {/hist_sig_mag_v2_tb/rand_data[5]} {-height 15 -radix decimal} {/hist_sig_mag_v2_tb/rand_data[4]} {-height 15 -radix decimal} {/hist_sig_mag_v2_tb/rand_data[3]} {-height 15 -radix decimal} {/hist_sig_mag_v2_tb/rand_data[2]} {-height 15 -radix decimal} {/hist_sig_mag_v2_tb/rand_data[1]} {-height 15 -radix decimal} {/hist_sig_mag_v2_tb/rand_data[0]} {-height 15 -radix decimal}} /hist_sig_mag_v2_tb/rand_data
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/resetn
add wave -noupdate -expand -group tb -radix decimal /hist_sig_mag_v2_tb/CNTR_LENGTH
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/i_int
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/j_int
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/rdata
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/sig
add wave -noupdate -expand -group tb /hist_sig_mag_v2_tb/mag
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/BASE_ADDR
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/BUS_ADDR_WIDTH
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/CNTR_LENGTH
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/ID
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/ID_ADDR
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/LENGTH_ADDR
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/LINES
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/RES_MAG_ADDR
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/RES_SIG_ADDR
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/addr
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/bus_clk
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/bus_resetn
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/clk
add wave -noupdate -group sig_mag {/hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/cntr[15]}
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/cntr
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/id_rd
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/length_rd
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/mag
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/mag_cntr
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/mag_res_rd
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/mag_result
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/mag_result_syn
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/rd
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/rdata
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/resetn
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/sig
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/sig_cntr
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/sig_res_rd
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/sig_result
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/sig_result_syn
add wave -noupdate -group sig_mag /hist_sig_mag_v2_tb/hist_sig_mag_v2_inst/wr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {160160090 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 390
configure wave -valuecolwidth 94
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {1261050 ns}
