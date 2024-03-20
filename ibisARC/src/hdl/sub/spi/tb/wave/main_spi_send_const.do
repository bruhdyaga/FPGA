onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main_spi_send_const_tb/main_spi_send_const_inst/clk
add wave -noupdate /main_spi_send_const_tb/main_spi_send_const_inst/reset
add wave -noupdate /main_spi_send_const_tb/main_spi_send_const_inst/reset_syn
add wave -noupdate -color Magenta /main_spi_send_const_tb/main_spi_send_const_inst/spi_ncs
add wave -noupdate -color Orange /main_spi_send_const_tb/main_spi_send_const_inst/spi_clk
add wave -noupdate -color Cyan /main_spi_send_const_tb/main_spi_send_const_inst/spi_mosi
add wave -noupdate -radix unsigned -childformat {{{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[7]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[6]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[5]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[4]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[3]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[2]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[1]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[0]} -radix unsigned}} -subitemconfig {{/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[7]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[6]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[5]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[4]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[3]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[2]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[1]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/div_cntr[0]} {-height 15 -radix unsigned}} /main_spi_send_const_tb/main_spi_send_const_inst/div_cntr
add wave -noupdate /main_spi_send_const_tb/main_spi_send_const_inst/clk_en
add wave -noupdate -radix unsigned -childformat {{{/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[5]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[4]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[3]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[2]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[1]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[0]} -radix unsigned}} -subitemconfig {{/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[5]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[4]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[3]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[2]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[1]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr[0]} {-height 15 -radix unsigned}} /main_spi_send_const_tb/main_spi_send_const_inst/bit_cntr
add wave -noupdate -radix unsigned /main_spi_send_const_tb/main_spi_send_const_inst/packet_cntr
add wave -noupdate -radix unsigned -childformat {{{/main_spi_send_const_tb/main_spi_send_const_inst/state[2]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/state[1]} -radix unsigned} {{/main_spi_send_const_tb/main_spi_send_const_inst/state[0]} -radix unsigned}} -subitemconfig {{/main_spi_send_const_tb/main_spi_send_const_inst/state[2]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/state[1]} {-height 15 -radix unsigned} {/main_spi_send_const_tb/main_spi_send_const_inst/state[0]} {-height 15 -radix unsigned}} /main_spi_send_const_tb/main_spi_send_const_inst/state
add wave -noupdate -radix unsigned /main_spi_send_const_tb/main_spi_send_const_inst/send_cntr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3707680 ps} 0}
configure wave -namecolwidth 375
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
WaveRestoreZoom {0 ps} {21 us}
