
transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:\PV_FPGA\SPI\src {D:\PV_FPGA\SPI\src\spi_module.sv}

vlog -sv -work work +incdir+D:\PV_FPGA\SPI\src {D:\PV_FPGA\SPI\tb\tb_spi_module.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_spi_module

add wave *
view structure
view signals
run -all