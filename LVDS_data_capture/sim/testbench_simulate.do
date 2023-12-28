######################################################################
#
# File name : testbench_simulate.do
# Created on: Thu Dec 28 11:44:43 +0300 2023
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -voptargs="+acc" -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.testbench xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {testbench_wave.do}
add wave sim:/testbench/LVDS_capture/clk
add wave sim:/testbench/LVDS_capture/iddr_data_even
add wave sim:/testbench/LVDS_capture/iddr_data_odd
view wave
view structure
view signals

do {testbench.udo}

run 1000ns