onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /intbus_interf_tb/CPU_FREQ
add wave -noupdate /intbus_interf_tb/N_BUSES
add wave -noupdate /intbus_interf_tb/aclk
add wave -noupdate /intbus_interf_tb/resetn
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/ADDR_WIDTH
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/DATA_WIDTH
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/clk
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/resetn
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/addr
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/wdata
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/rdata
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/rvalid
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/wr
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/rd
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/asize
add wave -noupdate -expand -group master_bus /intbus_interf_tb/master_bus/baseaddr
add wave -noupdate -expand -group CB /intbus_interf_tb/CB/N_BUSES
add wave -noupdate -expand -group CB /intbus_interf_tb/CB/DATA_WIDTH
add wave -noupdate -expand -group CB /intbus_interf_tb/CB/OUTFF
add wave -noupdate -expand -group CB /intbus_interf_tb/CB/clk
add wave -noupdate -expand -group CB /intbus_interf_tb/CB/resetn
add wave -noupdate -expand -group CB /intbus_interf_tb/CB/rdata_array_transp
add wave -noupdate -expand -group CB /intbus_interf_tb/CB/rdata_array
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/clk}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/resetn}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/addr}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/wdata}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/rdata}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/rvalid}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/wr}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/rd}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/asize}
add wave -noupdate -expand -group slave_0 {/intbus_interf_tb/hub_bus[0]/baseaddr}
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/MANUAL_BASEADDR
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/DIS_BUS_BASEADDR
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/DATA_WIDTH
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/OUTFF
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/NREGS
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/INIT
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/ADDR_WIDTH
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/DATA_WIDTH
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/clk
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/resetn
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/addr
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/wdata
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/rdata
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/wr
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/rd
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/baseaddr
add wave -noupdate -expand -group regfile_0 -expand -group bus /intbus_interf_tb/regs_file_0_inst/bus/asize
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/clk
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/resetn
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/in
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/out
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/reg_wdata
add wave -noupdate -expand -group regfile_0 -expand /intbus_interf_tb/regs_file_0_inst/reg_rdata
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/reg_mem
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/reg_wr
add wave -noupdate -expand -group regfile_0 -expand /intbus_interf_tb/regs_file_0_inst/reg_rd
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/base_addr
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/out_arr
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/in_arr
add wave -noupdate -expand -group regfile_0 /intbus_interf_tb/regs_file_0_inst/init_arr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {587740 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 337
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
WaveRestoreZoom {0 ps} {1050 ns}
