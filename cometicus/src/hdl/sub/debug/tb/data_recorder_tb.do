onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /data_recorder_tb/BUS_ADDR_WIDTH
add wave -noupdate -group tb /data_recorder_tb/DATA_RECORDER_CONST
add wave -noupdate -group tb /data_recorder_tb/DATA_RECORDER_CONST_ADDR
add wave -noupdate -group tb /data_recorder_tb/DATA_RECORDER_NUM_ADDR
add wave -noupdate -group tb /data_recorder_tb/NUM_PORTS_ADDR
add wave -noupdate -group tb /data_recorder_tb/DATA_WIDTH_ADDR
add wave -noupdate -group tb /data_recorder_tb/DATA_DEPTH_ADDR
add wave -noupdate -group tb /data_recorder_tb/SOFT_RESETN_ADDR
add wave -noupdate -group tb /data_recorder_tb/BUS_CHAN_ADDR
add wave -noupdate -group tb /data_recorder_tb/RD_START_ADDR
add wave -noupdate -group tb /data_recorder_tb/RD_DEPTH_ADDR
add wave -noupdate -group tb /data_recorder_tb/RW_REG_ADDR
add wave -noupdate -group tb /data_recorder_tb/RAM_ADDR
add wave -noupdate -group tb /data_recorder_tb/NUM
add wave -noupdate -group tb /data_recorder_tb/BASE_ADDR
add wave -noupdate -group tb /data_recorder_tb/NUM_PORTS
add wave -noupdate -group tb /data_recorder_tb/DATA_WIDTH
add wave -noupdate -group tb /data_recorder_tb/DATA_DEPTH
add wave -noupdate -group tb /data_recorder_tb/BIS_addr
add wave -noupdate -group tb /data_recorder_tb/BIS_wdata
add wave -noupdate -group tb /data_recorder_tb/BIS_rdata
add wave -noupdate -group tb /data_recorder_tb/BIS_wr
add wave -noupdate -group tb /data_recorder_tb/BIS_rd
add wave -noupdate -group tb /data_recorder_tb/BIS_resetn
add wave -noupdate -group tb /data_recorder_tb/BIS_clk
add wave -noupdate -group tb /data_recorder_tb/clk
add wave -noupdate -group tb /data_recorder_tb/data_out
add wave -noupdate -group tb /data_recorder_tb/resetn
add wave -noupdate -group tb /data_recorder_tb/valid
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/DATA_RECORDER_CONST
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/DATA_RECORDER_CONST_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/DATA_RECORDER_NUM_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/NUM_PORTS_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/DATA_WIDTH_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/DATA_DEPTH_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/SOFT_RESETN_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/BUS_CHAN_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/RD_START_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/RD_DEPTH_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/RW_REG_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/RAM_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/BUS_ADDR_WIDTH
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/NUM
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/BASE_ADDR
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/NUM_PORTS
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/DATA_WIDTH
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/DATA_DEPTH
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/RAM_ADDR_WIDTH
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/WR_DEPTH_REG_WIDTH
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/BUS_CHAN_WIDTH
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/clk
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/resetn
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/data_out
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/OUT_REG}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/WIDTH}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/DEPTH}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/AWIDTH}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/wr_clk}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/rd_clk}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/we}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/re}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/dat_in}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/dat_out}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/wr_addr}
add wave -noupdate -expand -group data_recorder -group data_ram {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/rd_addr}
add wave -noupdate -expand -group data_recorder -group data_ram -expand {/data_recorder_tb/data_recorder_inst/loop_data_parse[0]/bram_block_v2_inst/ram}
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/valid
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_clk
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_resetn
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_addr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_wdata
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_rdata
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_wr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/data_parse
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/addr_wr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/addr_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rd_depth
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rw_reg
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_chan
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rd_start
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/soft_resetn_int
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/soft_resetn_cntr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/soft_resetn
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/data_recorder_const_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/data_recorder_num_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/num_ports_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/data_width_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/data_depth_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_chan_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rd_start_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rd_depth_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rw_reg_rd
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/soft_resetn_wr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/bus_chan_wr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rd_start_wr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rd_depth_wr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/rw_reg_wr
add wave -noupdate -expand -group data_recorder /data_recorder_tb/data_recorder_inst/ram_wr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1053390 ps} 0} {{Cursor 2} {1510650 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 513
configure wave -valuecolwidth 99
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
