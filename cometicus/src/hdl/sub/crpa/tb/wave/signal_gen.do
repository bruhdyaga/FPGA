onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /signal_gen_tb/aclk
add wave -noupdate -radix decimal /signal_gen_tb/aresetn
add wave -noupdate -radix decimal /signal_gen_tb/sload
add wave -noupdate -radix decimal /signal_gen_tb/code_freq
add wave -noupdate -radix decimal /signal_gen_tb/ena
add wave -noupdate -radix decimal /signal_gen_tb/test_select
add wave -noupdate -radix decimal -childformat {{{/signal_gen_tb/dsin[7]} -radix decimal} {{/signal_gen_tb/dsin[6]} -radix decimal} {{/signal_gen_tb/dsin[5]} -radix decimal} {{/signal_gen_tb/dsin[4]} -radix decimal} {{/signal_gen_tb/dsin[3]} -radix decimal} {{/signal_gen_tb/dsin[2]} -radix decimal} {{/signal_gen_tb/dsin[1]} -radix decimal} {{/signal_gen_tb/dsin[0]} -radix decimal}} -expand -subitemconfig {{/signal_gen_tb/dsin[7]} {-format Analog-Step -height 60 -max 7.0 -min -7.0 -radix decimal} {/signal_gen_tb/dsin[6]} {-format Analog-Step -height 60 -max 7.0 -min -7.0 -radix decimal} {/signal_gen_tb/dsin[5]} {-format Analog-Step -height 60 -max 7.0 -min -7.0 -radix decimal} {/signal_gen_tb/dsin[4]} {-format Analog-Step -height 60 -max 7.0 -min -7.0 -radix decimal} {/signal_gen_tb/dsin[3]} {-format Analog-Step -height 60 -max 7.0 -min -7.0 -radix decimal} {/signal_gen_tb/dsin[2]} {-format Analog-Step -height 60 -max 7.0 -min -7.0 -radix decimal} {/signal_gen_tb/dsin[1]} {-format Analog-Step -height 60 -max 7.0 -min -7.0 -radix decimal} {/signal_gen_tb/dsin[0]} {-format Analog-Step -height 60 -max 7.0 -min -7.0 -radix decimal}} /signal_gen_tb/dsin
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21545970 ps} 0}
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {22511616 ps}
