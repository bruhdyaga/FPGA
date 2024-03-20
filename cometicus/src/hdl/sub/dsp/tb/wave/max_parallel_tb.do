onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /max_parallel_tb/WIDTH
add wave -noupdate -expand -group tb /max_parallel_tb/N_CH
add wave -noupdate -expand -group tb /max_parallel_tb/clk
add wave -noupdate -expand -group tb -childformat {{{/max_parallel_tb/data[9]} -radix unsigned} {{/max_parallel_tb/data[8]} -radix unsigned} {{/max_parallel_tb/data[7]} -radix unsigned} {{/max_parallel_tb/data[6]} -radix unsigned} {{/max_parallel_tb/data[5]} -radix unsigned} {{/max_parallel_tb/data[4]} -radix unsigned} {{/max_parallel_tb/data[3]} -radix unsigned} {{/max_parallel_tb/data[2]} -radix unsigned} {{/max_parallel_tb/data[1]} -radix unsigned} {{/max_parallel_tb/data[0]} -radix unsigned}} -expand -subitemconfig {{/max_parallel_tb/data[9]} {-radix unsigned} {/max_parallel_tb/data[8]} {-radix unsigned} {/max_parallel_tb/data[7]} {-radix unsigned} {/max_parallel_tb/data[6]} {-radix unsigned} {/max_parallel_tb/data[5]} {-radix unsigned} {/max_parallel_tb/data[4]} {-radix unsigned} {/max_parallel_tb/data[3]} {-radix unsigned} {/max_parallel_tb/data[2]} {-radix unsigned} {/max_parallel_tb/data[1]} {-radix unsigned} {/max_parallel_tb/data[0]} {-radix unsigned}} /max_parallel_tb/data
add wave -noupdate -expand -group tb /max_parallel_tb/data_flat
add wave -noupdate -expand -group MAX /max_parallel_tb/MAX_INST/WIDTH
add wave -noupdate -expand -group MAX /max_parallel_tb/MAX_INST/N_CH
add wave -noupdate -expand -group MAX /max_parallel_tb/MAX_INST/FL_EN
add wave -noupdate -expand -group MAX /max_parallel_tb/MAX_INST/clk
add wave -noupdate -expand -group MAX /max_parallel_tb/MAX_INST/data_in
add wave -noupdate -expand -group MAX -radix unsigned /max_parallel_tb/MAX_INST/data_out
add wave -noupdate -expand -group MAX -childformat {{{/max_parallel_tb/MAX_INST/max_branch[8]} -radix unsigned} {{/max_parallel_tb/MAX_INST/max_branch[7]} -radix unsigned} {{/max_parallel_tb/MAX_INST/max_branch[6]} -radix unsigned} {{/max_parallel_tb/MAX_INST/max_branch[5]} -radix unsigned} {{/max_parallel_tb/MAX_INST/max_branch[4]} -radix unsigned} {{/max_parallel_tb/MAX_INST/max_branch[3]} -radix unsigned} {{/max_parallel_tb/MAX_INST/max_branch[2]} -radix unsigned} {{/max_parallel_tb/MAX_INST/max_branch[1]} -radix unsigned} {{/max_parallel_tb/MAX_INST/max_branch[0]} -radix unsigned}} -expand -subitemconfig {{/max_parallel_tb/MAX_INST/max_branch[8]} {-radix unsigned} {/max_parallel_tb/MAX_INST/max_branch[7]} {-radix unsigned} {/max_parallel_tb/MAX_INST/max_branch[6]} {-radix unsigned} {/max_parallel_tb/MAX_INST/max_branch[5]} {-radix unsigned} {/max_parallel_tb/MAX_INST/max_branch[4]} {-radix unsigned} {/max_parallel_tb/MAX_INST/max_branch[3]} {-radix unsigned} {/max_parallel_tb/MAX_INST/max_branch[2]} {-radix unsigned} {/max_parallel_tb/MAX_INST/max_branch[1]} {-radix unsigned} {/max_parallel_tb/MAX_INST/max_branch[0]} {-radix unsigned}} /max_parallel_tb/MAX_INST/max_branch
add wave -noupdate -expand -group MAX /max_parallel_tb/MAX_INST/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {83 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 447
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ns} {1050 ns}
