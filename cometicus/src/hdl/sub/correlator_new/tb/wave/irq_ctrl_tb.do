onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /irq_ctrl_tb/BASE_ADDR
add wave -noupdate -expand -group tb /irq_ctrl_tb/UNIQ_OFFS
add wave -noupdate -expand -group tb /irq_ctrl_tb/MAP_OFFS
add wave -noupdate -expand -group tb /irq_ctrl_tb/CFG_OFFS
add wave -noupdate -expand -group tb /irq_ctrl_tb/PERIOD_OFFS
add wave -noupdate -expand -group tb /irq_ctrl_tb/DURATION_OFFS
add wave -noupdate -expand -group tb /irq_ctrl_tb/irq
add wave -noupdate -expand -group tb /irq_ctrl_tb/rdata
add wave -noupdate -expand -group tb /irq_ctrl_tb/clk
add wave -noupdate -expand -group tb /irq_ctrl_tb/aclk
add wave -noupdate -expand -group tb /irq_ctrl_tb/resetn
add wave -noupdate -expand -group tb /irq_ctrl_tb/aresetn
add wave -noupdate -group bus /irq_ctrl_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /irq_ctrl_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /irq_ctrl_tb/bus/clk
add wave -noupdate -group bus /irq_ctrl_tb/bus/resetn
add wave -noupdate -group bus /irq_ctrl_tb/bus/addr
add wave -noupdate -group bus /irq_ctrl_tb/bus/wdata
add wave -noupdate -group bus /irq_ctrl_tb/bus/rdata
add wave -noupdate -group bus /irq_ctrl_tb/bus/rvalid
add wave -noupdate -group bus /irq_ctrl_tb/bus/wr
add wave -noupdate -group bus /irq_ctrl_tb/bus/rd
add wave -noupdate -expand -group irq_ctrl /irq_ctrl_tb/irq_ctrl_inst/INST
add wave -noupdate -expand -group irq_ctrl /irq_ctrl_tb/irq_ctrl_inst/NPULSE
add wave -noupdate -expand -group irq_ctrl /irq_ctrl_tb/irq_ctrl_inst/clk
add wave -noupdate -expand -group irq_ctrl /irq_ctrl_tb/irq_ctrl_inst/resetn
add wave -noupdate -expand -group irq_ctrl /irq_ctrl_tb/irq_ctrl_inst/irq
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/DATA_WIDTH
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/OUTFF
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/NREGS
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/INIT
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/NPULSE
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/clk
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/resetn
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/in
add wave -noupdate -expand -group irq_ctrl -group regs_file -expand -subitemconfig {/irq_ctrl_tb/irq_ctrl_inst/RF/out.CFG -expand} /irq_ctrl_tb/irq_ctrl_inst/RF/out
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/pulse
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/reg_wdata
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/reg_rdata
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/reg_rdata_int
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/reg_mem
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/reg_wr
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/reg_rd
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/sync_rd
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/pulse_reg
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/out_arr
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/in_arr
add wave -noupdate -expand -group irq_ctrl -group regs_file /irq_ctrl_tb/irq_ctrl_inst/RF/init_arr
add wave -noupdate -expand -group irq_ctrl /irq_ctrl_tb/irq_ctrl_inst/PL
add wave -noupdate -expand -group irq_ctrl -expand -subitemconfig {/irq_ctrl_tb/irq_ctrl_inst/PS.CFG -expand} /irq_ctrl_tb/irq_ctrl_inst/PS
add wave -noupdate -expand -group irq_ctrl /irq_ctrl_tb/irq_ctrl_inst/release_pulse
add wave -noupdate -expand -group irq_ctrl -radix unsigned -radixshowbase 0 /irq_ctrl_tb/irq_ctrl_inst/CNT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {406870 ps} 0} {{Cursor 2} {1130000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 277
configure wave -valuecolwidth 124
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
WaveRestoreZoom {0 ps} {2100 ns}
