onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /signal_sync_tb/SCLK_FREQ
add wave -noupdate -expand -group tb /signal_sync_tb/DCLK_FREQ
add wave -noupdate -expand -group tb /signal_sync_tb/sclk
add wave -noupdate -expand -group tb /signal_sync_tb/dclk
add wave -noupdate -expand -group tb /signal_sync_tb/start
add wave -noupdate -expand -group tb /signal_sync_tb/ready
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/sclk
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/dclk
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/start
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/ready
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/rqst_start_s
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/finish_rqst_d
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/finish_rqst_s
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/rqst_start_d
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/finish_d_start
add wave -noupdate -expand -group signal_sync /signal_sync_tb/signal_sync_inst/finish_d_stop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {236500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 422
configure wave -valuecolwidth 69
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
WaveRestoreZoom {0 ps} {1050 ns}
