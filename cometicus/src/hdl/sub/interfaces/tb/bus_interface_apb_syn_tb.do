onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/aclk
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/resetn
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/apb_bridge_0_M_APB_PADDR
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/apb_bridge_0_M_APB_PSEL
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/apb_bridge_0_M_APB_PENABLE
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/apb_bridge_0_M_APB_PWRITE
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/apb_bridge_0_M_APB_PWDATA
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/apb_bridge_0_M_APB_PREADY
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/apb_bridge_0_M_APB_PSLVERR
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/out_wdata
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/out_addr
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/out_rd
add wave -noupdate -expand -group interface_apb /bus_interface_apb_syn_tb/bus_interface_apb_syn_inst/out_wr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 508
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
WaveRestoreZoom {0 ns} {630 ns}
