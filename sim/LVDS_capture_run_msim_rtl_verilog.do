
vlog -sv {A:\LVDS_data_capture\src\LVDS_capture.sv}
vlog -sv {A:\LVDS_data_capture\tb\testbench.sv}
vsim -t 1ps testbench
add wave *
add wave -position 2  sim:/testbench/LVDS_capture/clk
add wave -position 2  sim:/testbench/LVDS_capture/data
add wave -position 6  sim:/testbench/LVDS_capture/out_reg
view structure
view signals
run 200ns
