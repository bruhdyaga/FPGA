onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /freq_counter_tb/BASEADDR
add wave -noupdate -group tb /freq_counter_tb/FREQ_CNTR_BASE_ADDR
add wave -noupdate -group tb /freq_counter_tb/FREQ_CHANNELS
add wave -noupdate -group tb /freq_counter_tb/aclk
add wave -noupdate -group tb /freq_counter_tb/clk_50
add wave -noupdate -group tb /freq_counter_tb/adc_clk
add wave -noupdate -group tb /freq_counter_tb/rd
add wave -noupdate -group tb /freq_counter_tb/wr
add wave -noupdate -group tb /freq_counter_tb/rdata
add wave -noupdate -group tb /freq_counter_tb/addr
add wave -noupdate -group tb /freq_counter_tb/fix_pulse_cntr
add wave -noupdate -group tb /freq_counter_tb/fix_pulse
add wave -noupdate -group tb /freq_counter_tb/irq
add wave -noupdate -group bus /freq_counter_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /freq_counter_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /freq_counter_tb/bus/clk
add wave -noupdate -group bus /freq_counter_tb/bus/addr
add wave -noupdate -group bus /freq_counter_tb/bus/wdata
add wave -noupdate -group bus /freq_counter_tb/bus/rdata
add wave -noupdate -group bus /freq_counter_tb/bus/rvalid
add wave -noupdate -group bus /freq_counter_tb/bus/wr
add wave -noupdate -group bus /freq_counter_tb/bus/rd
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/BASEADDR
add wave -noupdate -expand -group freq -radix unsigned /freq_counter_tb/freq_counter/CHANNELS
add wave -noupdate -expand -group freq -radix unsigned /freq_counter_tb/freq_counter/FREQ_REF_HZ
add wave -noupdate -expand -group freq -radix unsigned /freq_counter_tb/freq_counter/MAX_FREQ
add wave -noupdate -expand -group freq -radix unsigned /freq_counter_tb/freq_counter/PERIOD_MS
add wave -noupdate -expand -group freq -radix unsigned /freq_counter_tb/freq_counter/PERIOD_MEAS_ND
add wave -noupdate -expand -group freq -radix unsigned /freq_counter_tb/freq_counter/PERIOD_MEAS
add wave -noupdate -expand -group freq -radix unsigned /freq_counter_tb/freq_counter/DATA_WIDTH
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/ref_clk
add wave -noupdate -expand -group freq -expand /freq_counter_tb/freq_counter/in_clk
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/rdata1
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/rdata2
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/rdata2_or
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/freq_rd
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/id_rd
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/chan_rd
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/period_rd
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/ref_rd
add wave -noupdate -expand -group freq -childformat {{{/freq_counter_tb/freq_counter/cntr_chan[4]} -radix unsigned} {{/freq_counter_tb/freq_counter/cntr_chan[3]} -radix unsigned} {{/freq_counter_tb/freq_counter/cntr_chan[2]} -radix unsigned} {{/freq_counter_tb/freq_counter/cntr_chan[1]} -radix unsigned} {{/freq_counter_tb/freq_counter/cntr_chan[0]} -radix unsigned}} -expand -subitemconfig {{/freq_counter_tb/freq_counter/cntr_chan[4]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/cntr_chan[3]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/cntr_chan[2]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/cntr_chan[1]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/cntr_chan[0]} {-height 15 -radix unsigned}} /freq_counter_tb/freq_counter/cntr_chan
add wave -noupdate -expand -group freq -childformat {{{/freq_counter_tb/freq_counter/data_freq[4]} -radix unsigned} {{/freq_counter_tb/freq_counter/data_freq[3]} -radix unsigned} {{/freq_counter_tb/freq_counter/data_freq[2]} -radix unsigned} {{/freq_counter_tb/freq_counter/data_freq[1]} -radix unsigned} {{/freq_counter_tb/freq_counter/data_freq[0]} -radix unsigned}} -expand -subitemconfig {{/freq_counter_tb/freq_counter/data_freq[4]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/data_freq[3]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/data_freq[2]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/data_freq[1]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/data_freq[0]} {-height 15 -radix unsigned}} /freq_counter_tb/freq_counter/data_freq
add wave -noupdate -expand -group freq -childformat {{{/freq_counter_tb/freq_counter/data_freq_24[4]} -radix unsigned} {{/freq_counter_tb/freq_counter/data_freq_24[3]} -radix unsigned} {{/freq_counter_tb/freq_counter/data_freq_24[2]} -radix unsigned} {{/freq_counter_tb/freq_counter/data_freq_24[1]} -radix unsigned} {{/freq_counter_tb/freq_counter/data_freq_24[0]} -radix unsigned}} -subitemconfig {{/freq_counter_tb/freq_counter/data_freq_24[4]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/data_freq_24[3]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/data_freq_24[2]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/data_freq_24[1]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/data_freq_24[0]} {-height 15 -radix unsigned}} /freq_counter_tb/freq_counter/data_freq_24
add wave -noupdate -expand -group freq -childformat {{{/freq_counter_tb/freq_counter/freq_hz[3]} -radix unsigned} {{/freq_counter_tb/freq_counter/freq_hz[2]} -radix unsigned} {{/freq_counter_tb/freq_counter/freq_hz[1]} -radix unsigned} {{/freq_counter_tb/freq_counter/freq_hz[0]} -radix unsigned}} -expand -subitemconfig {{/freq_counter_tb/freq_counter/freq_hz[3]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/freq_hz[2]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/freq_hz[1]} {-height 15 -radix unsigned} {/freq_counter_tb/freq_counter/freq_hz[0]} {-height 15 -radix unsigned}} /freq_counter_tb/freq_counter/freq_hz
add wave -noupdate -expand -group freq /freq_counter_tb/freq_counter/ref_cntr
add wave -noupdate -expand -group freq -expand /freq_counter_tb/freq_counter/puls_sync
add wave -noupdate -expand -group freq -expand /freq_counter_tb/freq_counter/puls_sync_ed
add wave -noupdate -expand -group freq -expand /freq_counter_tb/freq_counter/cntr_high_i
add wave -noupdate -expand -group freq -expand /freq_counter_tb/freq_counter/puls_ref
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {14000028620 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 322
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
WaveRestoreZoom {0 ps} {26250 us}
