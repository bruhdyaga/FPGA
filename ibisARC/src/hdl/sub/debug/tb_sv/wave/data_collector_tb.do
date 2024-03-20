onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /data_collector_tb/BASE_ADDR
add wave -noupdate -expand -group tb -radix unsigned /data_collector_tb/NUM_PORTS
add wave -noupdate -expand -group tb /data_collector_tb/aclk
add wave -noupdate -expand -group tb /data_collector_tb/pclk
add wave -noupdate -expand -group tb /data_collector_tb/presetn
add wave -noupdate -expand -group tb /data_collector_tb/aresetn
add wave -noupdate -expand -group tb /data_collector_tb/rdata
add wave -noupdate -expand -group tb -expand -subitemconfig {{/data_collector_tb/cntr[1]} -expand {/data_collector_tb/cntr[0]} -expand} /data_collector_tb/cntr
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/BASEADDR
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/NUM_PORTS
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/DATA_WIDTH
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/DATA_DEPTH
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/RAM_TYPE
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/RAM_ADDR_WIDTH
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/NPULSE
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/RVALID_FF
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/clk
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/resetn
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/OUT_REG}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/WIDTH}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/DEPTH}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/AWIDTH}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/wr_clk}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/rd_clk}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/we}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/re}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/dat_in}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/dat_out}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/wr_addr}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/rd_addr}
add wave -noupdate -expand -group dat_col -group RAM_0 {/data_collector_tb/data_collector_inst/RAM_GEN[0]/genblk1/bram_block_v2_inst/ram}
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/BASEADDR
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/ID
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/DATA_WIDTH
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/OUTFF
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/NREGS
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/INIT
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/NPULSE
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/RVALID_FF
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/clk
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/resetn
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/in
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/out
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/pulse
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/wr
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/rd
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/reg_wdata
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/reg_rdata
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/reg_rdata_const
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/reg_rdata_int
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/reg_mem
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/reg_mem_const
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/reg_const_rd
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/sync_rd
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/pulse_reg
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/out_arr
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/in_arr
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/init_arr
add wave -noupdate -expand -group dat_col -expand -group RF /data_collector_tb/data_collector_inst/RF/rvalid_arr
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/bus_rd
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/bus_wr
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/data
add wave -noupdate -expand -group dat_col -expand /data_collector_tb/data_collector_inst/ram_in
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/we
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/PL
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/PS
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/trig_en_pulse
add wave -noupdate -expand -group dat_col -radix unsigned /data_collector_tb/data_collector_inst/addr_wr
add wave -noupdate -expand -group dat_col -radix unsigned /data_collector_tb/data_collector_inst/addr_rd
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/trig_en
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/wr
add wave -noupdate -expand -group dat_col /data_collector_tb/data_collector_inst/ram_out
add wave -noupdate -expand -group bus /data_collector_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group bus /data_collector_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group bus /data_collector_tb/bus/clk
add wave -noupdate -expand -group bus /data_collector_tb/bus/resetn
add wave -noupdate -expand -group bus /data_collector_tb/bus/addr
add wave -noupdate -expand -group bus /data_collector_tb/bus/wdata
add wave -noupdate -expand -group bus /data_collector_tb/bus/rdata
add wave -noupdate -expand -group bus /data_collector_tb/bus/rvalid
add wave -noupdate -expand -group bus /data_collector_tb/bus/wr
add wave -noupdate -expand -group bus /data_collector_tb/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1104000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 414
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {5250 ns}
