onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_ADDR_WIDTH
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/DATA_COLL_CONST
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/DATA_COLL_CONST_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/DATA_COLL_NUM_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/NUM_PORTS_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/DATA_WIDTH_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/DATA_DEPTH_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/SOFT_RESETN_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/BUS_CHAN_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/TRIG_EN_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/EN_WR_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/WR_DEPTH_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/RW_REG_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/RAM_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/ADDR_WIDTH
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/NUM
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/BASE_ADDR
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/NUM_PORTS
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/DATA_WIDTH
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/DATA_DEPTH
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_SYN_addr
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_SYN_wdata
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_SYN_rdata
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_HBURST
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_HMASTLOCK
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_HPROT
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_HREADY
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_HRESP
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_HSIZE
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_HTRANS
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_HWRITE
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_SYN_resetn
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/AHB_SYN_clk
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/resetn
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/ahb_syn_addr_reg
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/ahb_syn_rd
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/ahb_syn_wr
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/WRITE_AHB_SYN_TASK/waddr
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/WRITE_AHB_SYN_TASK/wdata
add wave -noupdate -group tb /bus_interface_ahb_syn_tb/WRITE_AHB_SYN_TASK/num_trans
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ADDR_WIDTH
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_clk
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_resetn
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_haddr
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_hburst
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_hmastlock
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_hprot
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_hready
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_hresp
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_hsize
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_htrans
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_hwrite
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/ahb_hsel
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/addr_reg
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/rd
add wave -noupdate -group bus_int_ahb_syn /bus_interface_ahb_syn_tb/bus_interface_ahb_syn_inst/wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/DATA_COLL_CONST
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/DATA_COLL_CONST_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/DATA_COLL_NUM_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/NUM_PORTS_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/DATA_WIDTH_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/DATA_DEPTH_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/SOFT_RESETN_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/BUS_CHAN_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/TRIG_EN_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/EN_WR_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/WR_DEPTH_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/RW_REG_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/RAM_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/BUS_ADDR_WIDTH
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/NUM
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/BASE_ADDR
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/NUM_PORTS
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/DATA_WIDTH
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/DATA_DEPTH
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/RAM_ADDR_WIDTH
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/WR_DEPTH_REG_WIDTH
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/BUS_CHAN_WIDTH
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/clk
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/resetn
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/data
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/data_out
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_clk
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_resetn
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_addr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_wdata
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_rdata
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/addr_wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/addr_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/trig_en
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/trig_en_syn
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/en_wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/wr_stop
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/wr_stop_syn
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/wr_depth
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/rw_reg
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/data_parse
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/ram_out
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_chan
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/soft_resetn_int
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/soft_resetn_cntr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/soft_resetn
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/data_coll_const_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/data_coll_num_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/num_ports_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/data_width_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/data_depth_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_chan_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/trig_en_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/en_wr_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/wr_depth_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/rw_reg_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/ram_rd
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/soft_resetn_wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/bus_chan_wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/trig_en_wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/en_wr_wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/wr_depth_wr
add wave -noupdate -expand -group data_coll /bus_interface_ahb_syn_tb/data_collector_inst/rw_reg_wr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {487390 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 421
configure wave -valuecolwidth 113
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
