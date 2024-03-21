onerror {resume}
quietly virtual function -install /sig_mag_v2_tb/sig_mag_v2_inst -env /sig_mag_v2_tb/sig_mag_v2_inst { &{/sig_mag_v2_tb/sig_mag_v2_inst/cntr[9], /sig_mag_v2_tb/sig_mag_v2_inst/cntr[8], /sig_mag_v2_tb/sig_mag_v2_inst/cntr[7], /sig_mag_v2_tb/sig_mag_v2_inst/cntr[6] }} cntr_cut
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group sigmag /sig_mag_v2_tb/sig_mag_v2_inst/width
add wave -noupdate -expand -group sigmag /sig_mag_v2_tb/sig_mag_v2_inst/clk
add wave -noupdate -expand -group sigmag -color Red /sig_mag_v2_tb/sig_mag_v2_inst/resetn
add wave -noupdate -expand -group sigmag -radix decimal /sig_mag_v2_tb/sig_mag_v2_inst/data_in
add wave -noupdate -expand -group sigmag /sig_mag_v2_tb/sig_mag_v2_inst/sig
add wave -noupdate -expand -group sigmag /sig_mag_v2_tb/sig_mag_v2_inst/mag
add wave -noupdate -expand -group sigmag -format Analog-Step -height 74 -max 4094.9999999999991 -min 15.0 -radix unsigned -childformat {{{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[12]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[11]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[10]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[9]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[8]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[7]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[6]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[5]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[4]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[3]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[2]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[1]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[0]} -radix unsigned}} -subitemconfig {{/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[12]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[11]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[10]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[9]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[8]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[7]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[6]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[5]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[4]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[3]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[2]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[1]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/por_reg[0]} {-height 15 -radix unsigned}} /sig_mag_v2_tb/sig_mag_v2_inst/por_reg
add wave -noupdate -expand -group sigmag -radix unsigned /sig_mag_v2_tb/sig_mag_v2_inst/por_reg_a
add wave -noupdate -expand -group sigmag -radix unsigned /sig_mag_v2_tb/sig_mag_v2_inst/por_reg_b
add wave -noupdate -expand -group sigmag /sig_mag_v2_tb/sig_mag_v2_inst/mag_bisec
add wave -noupdate -expand -group sigmag /sig_mag_v2_tb/sig_mag_v2_inst/sig_reg
add wave -noupdate -expand -group sigmag /sig_mag_v2_tb/sig_mag_v2_inst/mag_reg
add wave -noupdate -expand -group sigmag -radix unsigned /sig_mag_v2_tb/sig_mag_v2_inst/por_res
add wave -noupdate -expand -group sigmag -radix unsigned /sig_mag_v2_tb/sig_mag_v2_inst/cntr_iter
add wave -noupdate -expand -group sigmag -radix unsigned -childformat {{{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[13]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[12]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[11]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[10]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[9]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[8]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[7]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[6]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[5]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[4]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[3]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[2]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[1]} -radix unsigned} {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[0]} -radix unsigned}} -subitemconfig {{/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[13]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[12]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[11]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[10]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[9]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[8]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[7]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[6]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[5]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[4]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[3]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[2]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[1]} {-height 15 -radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr[0]} {-height 15 -radix unsigned}} /sig_mag_v2_tb/sig_mag_v2_inst/mag_cntr
add wave -noupdate -expand -group sigmag /sig_mag_v2_tb/sig_mag_v2_inst/valid
add wave -noupdate -expand -group sigmag -radix unsigned -childformat {{(3) -radix unsigned} {(2) -radix unsigned} {(1) -radix unsigned} {(0) -radix unsigned}} -subitemconfig {{/sig_mag_v2_tb/sig_mag_v2_inst/cntr[9]} {-radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/cntr[8]} {-radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/cntr[7]} {-radix unsigned} {/sig_mag_v2_tb/sig_mag_v2_inst/cntr[6]} {-radix unsigned}} /sig_mag_v2_tb/sig_mag_v2_inst/cntr_cut
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/N_dig_in
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/LENGTH_N
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/LENGTH
add wave -noupdate -expand -group tb -radix decimal -childformat {{{/sig_mag_v2_tb/in_dat_reg[13]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[12]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[11]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[10]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[9]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[8]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[7]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[6]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[5]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[4]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[3]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[2]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[1]} -radix decimal} {{/sig_mag_v2_tb/in_dat_reg[0]} -radix decimal}} -subitemconfig {{/sig_mag_v2_tb/in_dat_reg[13]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[12]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[11]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[10]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[9]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[8]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[7]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[6]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[5]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[4]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[3]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[2]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[1]} {-height 15 -radix decimal} {/sig_mag_v2_tb/in_dat_reg[0]} {-height 15 -radix decimal}} /sig_mag_v2_tb/in_dat_reg
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/k_scale
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/in_adr
add wave -noupdate -expand -group tb /sig_mag_v2_tb/in_dat
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/sigmag_cntr_period
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/sig_cntr
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/mag_cntr
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/sig_res
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/mag_res
add wave -noupdate -expand -group tb -radix unsigned /sig_mag_v2_tb/SIG_CNTR_SIZE
add wave -noupdate -expand -group tb /sig_mag_v2_tb/sig
add wave -noupdate -expand -group tb /sig_mag_v2_tb/mag
add wave -noupdate -expand -group tb /sig_mag_v2_tb/sigmag_lch
add wave -noupdate -expand -group tb /sig_mag_v2_tb/clk
add wave -noupdate -expand -group tb /sig_mag_v2_tb/resetn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2696610 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 289
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ns} {5250 us}
