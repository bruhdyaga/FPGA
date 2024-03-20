onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /bus_interface_ahb_syn_tb/BUS_ADDR_WIDTH
add wave -noupdate -expand -group tb -color Red /bus_interface_ahb_syn_tb/resetn
add wave -noupdate -expand -group tb /bus_interface_ahb_syn_tb/AHB_SYN_addr
add wave -noupdate -expand -group tb /bus_interface_ahb_syn_tb/AHB_SYN_wdata
add wave -noupdate -expand -group tb /bus_interface_ahb_syn_tb/AHB_SYN_rdata
add wave -noupdate -expand -group tb /bus_interface_ahb_syn_tb/AHB_SYN_wr
add wave -noupdate -expand -group tb /bus_interface_ahb_syn_tb/AHB_SYN_rd
add wave -noupdate -expand -group tb -color Red /bus_interface_ahb_syn_tb/AHB_SYN_resetn
add wave -noupdate -expand -group tb /bus_interface_ahb_syn_tb/AHB_SYN_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {590 ps} 0}
configure wave -namecolwidth 426
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
WaveRestoreZoom {0 ps} {1050 ns}
