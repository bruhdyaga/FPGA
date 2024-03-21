onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /mean_compens_v2_2_tb/in_adr
add wave -noupdate -expand -group tb -format Analog-Step -height 74 -max 15968.999999999998 -min 100.0 -radix decimal /mean_compens_v2_2_tb/in_dat_add_full
add wave -noupdate -expand -group tb /mean_compens_v2_2_tb/in_dat_add
add wave -noupdate -expand -group tb /mean_compens_v2_2_tb/out_dat
add wave -noupdate -expand -group tb /mean_compens_v2_2_tb/valid
add wave -noupdate -expand -group tb -radix unsigned /mean_compens_v2_2_tb/err_mean
add wave -noupdate -expand -group tb /mean_compens_v2_2_tb/clk
add wave -noupdate -expand -group tb /mean_compens_v2_2_tb/resetn
add wave -noupdate -expand -group mean_compens /mean_compens_v2_2_tb/mean_compens_v2_inst/clk
add wave -noupdate -expand -group mean_compens /mean_compens_v2_2_tb/mean_compens_v2_inst/resetn
add wave -noupdate -expand -group mean_compens /mean_compens_v2_2_tb/mean_compens_v2_inst/data_in
add wave -noupdate -expand -group mean_compens /mean_compens_v2_2_tb/mean_compens_v2_inst/data_out
add wave -noupdate -expand -group mean_compens -format Analog-Step -height 74 -max 7110.9999999999982 -min -8093.0 -radix decimal /mean_compens_v2_2_tb/mean_compens_v2_inst/data_in
add wave -noupdate -expand -group mean_compens -format Analog-Step -height 74 -max 7018.0000000000009 -min -8151.0 -radix decimal /mean_compens_v2_2_tb/mean_compens_v2_inst/data_out
add wave -noupdate -expand -group mean_compens /mean_compens_v2_2_tb/mean_compens_v2_inst/valid
add wave -noupdate -expand -group mean_compens -radix decimal /mean_compens_v2_2_tb/mean_compens_v2_inst/y_k
add wave -noupdate -expand -group mean_compens -radix decimal /mean_compens_v2_2_tb/mean_compens_v2_inst/y_k_32
add wave -noupdate -expand -group mean_compens -radix decimal /mean_compens_v2_2_tb/mean_compens_v2_inst/x_k_32
add wave -noupdate -expand -group mean_compens -radix decimal /mean_compens_v2_2_tb/mean_compens_v2_inst/x_k_1_32
add wave -noupdate -expand -group mean_compens -radix decimal /mean_compens_v2_2_tb/mean_compens_v2_inst/x_k
add wave -noupdate -expand -group mean_compens -format Analog-Step -height 74 -max 5439.0 -radix decimal -childformat {{{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[13]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[12]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[11]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[10]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[9]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[8]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[7]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[6]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[5]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[4]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[3]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[2]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[1]} -radix decimal} {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[0]} -radix decimal}} -subitemconfig {{/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[13]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[12]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[11]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[10]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[9]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[8]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[7]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[6]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[5]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[4]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[3]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[2]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[1]} {-height 15 -radix decimal} {/mean_compens_v2_2_tb/mean_compens_v2_inst/x_k[0]} {-height 15 -radix decimal}} /mean_compens_v2_2_tb/mean_compens_v2_inst/x_k
add wave -noupdate -expand -group mean_compens /mean_compens_v2_2_tb/mean_compens_v2_inst/mean_cntr
add wave -noupdate -expand -group mean_compens /mean_compens_v2_2_tb/mean_compens_v2_inst/up_RC_adpt
add wave -noupdate -expand -group mean_compens /mean_compens_v2_2_tb/mean_compens_v2_inst/tau_RC_adpt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {994940000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 383
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
WaveRestoreZoom {992207031 ps} {1000410157 ps}
