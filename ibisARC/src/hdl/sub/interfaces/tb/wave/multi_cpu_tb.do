onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/ADDR_WIDTH}
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/DATA_WIDTH}
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/clk}
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/addr}
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/wdata}
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/rdata}
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/rvalid}
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/wr}
add wave -noupdate -expand -group bus_0 {/multi_cpu_tb/bus[0]/rd}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/ADDR_WIDTH}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/DATA_WIDTH}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/clk}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/addr}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/wdata}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/rdata}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/rvalid}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/wr}
add wave -noupdate -expand -group bus_1 {/multi_cpu_tb/bus[1]/rd}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/ADDR_WIDTH}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/DATA_WIDTH}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/clk}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/addr}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/wdata}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/rdata}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/rvalid}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/wr}
add wave -noupdate -expand -group bus_2 {/multi_cpu_tb/bus[2]/rd}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2991910 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
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
WaveRestoreZoom {2890400 ps} {3689430 ps}
