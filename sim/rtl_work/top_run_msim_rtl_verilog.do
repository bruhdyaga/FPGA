transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+d:\FPGA_prjcts\src {D:\FPGA_prjcts\timer\src\transformer.sv}
vlog -sv -work work +incdir+d:\FPGA_prjcts\src {D:\FPGA_prjcts\timer\src\time_pkg.sv}
vlog -sv -work work +incdir+d:\FPGA_prjcts\src {D:\FPGA_prjcts\timer\src\seg7_control.sv}
vlog -sv -work work +incdir+d:\FPGA_prjcts\src {D:\FPGA_prjcts\timer\src\debouncing.sv}
vlog -sv -work work +incdir+d:\FPGA_prjcts\src {D:\FPGA_prjcts\timer\src\_1ms.sv}
vlog -sv -work work +incdir+d:\FPGA_prjcts\src {D:\FPGA_prjcts\timer\src\timer_ssms.sv}
vlog -sv -work work +incdir+d:\FPGA_prjcts\src {D:\FPGA_prjcts\timer\src\main_cntrl.sv}
vlog -sv -work work +incdir+d:\FPGA_prjcts\src {D:\FPGA_prjcts\timer\src\main.sv}

vlog -sv -work work +incdir+d:\FPGA_prjcts\tb {D:\FPGA_prjcts\timer\tb\tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
add wave -position end sim:/tb/testbench/megatron/*
add wave -position end sim:/tb/testbench/timer/*
add wave -position end sim:/tb/testbench/button/*


view structure
view signals
run 1000ps
