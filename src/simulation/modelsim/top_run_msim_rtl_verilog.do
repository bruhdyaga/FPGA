transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src {C:/intelFPGA/17.1/top/timer/src/debouncing.sv}
vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src {C:/intelFPGA/17.1/top/timer/src/_1ms.sv}
vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src {C:/intelFPGA/17.1/top/timer/src/transformer.sv}
vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src {C:/intelFPGA/17.1/top/timer/src/time_pkg.sv}
vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src {C:/intelFPGA/17.1/top/timer/src/seg7_control.sv}
vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src {C:/intelFPGA/17.1/top/timer/src/main_cntrl.sv}
vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src {C:/intelFPGA/17.1/top/timer/src/timer_ssms.sv}
vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src {C:/intelFPGA/17.1/top/timer/src/main.sv}

vlog -sv -work work +incdir+C:/intelFPGA/17.1/top/timer/src/../tb {C:/intelFPGA/17.1/top/timer/src/../tb/tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run -all
