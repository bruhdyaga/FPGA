onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /data_collector_tb/NUM
add wave -noupdate -group tb /data_collector_tb/BASE_ADDR
add wave -noupdate -group tb /data_collector_tb/NUM_PORTS
add wave -noupdate -group tb /data_collector_tb/DATA_WIDTH
add wave -noupdate -group tb /data_collector_tb/DATA_DEPTH
add wave -noupdate -group tb -radix decimal /data_collector_tb/BIS_addr
add wave -noupdate -group tb /data_collector_tb/BIS_wdata
add wave -noupdate -group tb /data_collector_tb/BIS_rdata
add wave -noupdate -group tb /data_collector_tb/BIS_wr
add wave -noupdate -group tb /data_collector_tb/BIS_rd
add wave -noupdate -group tb /data_collector_tb/BIS_resetn
add wave -noupdate -group tb /data_collector_tb/BIS_clk
add wave -noupdate -group tb /data_collector_tb/clk
add wave -noupdate -group tb -color Red /data_collector_tb/resetn
add wave -noupdate -group tb /data_collector_tb/test_data_cong
add wave -noupdate -group tb -radix hexadecimal -radixshowbase 0 /data_collector_tb/rdata
add wave -noupdate -group tb /data_collector_tb/we
add wave -noupdate -group tb /data_collector_tb/addr_data
add wave -noupdate -group tb /data_collector_tb/i_mem_d
add wave -noupdate -group tb /data_collector_tb/i_mem_p
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/NUM
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/BASE_ADDR
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/NUM_PORTS
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/DATA_WIDTH
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/DATA_DEPTH
add wave -noupdate -expand -group data_coll -expand /data_collector_tb/data_collector_inst/clk
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/resetn
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/data
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/bus_clk
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/bus_resetn
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/bus_addr
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/bus_wdata
add wave -noupdate -expand -group data_coll -expand -group bus -radix hexadecimal -radixshowbase 0 /data_collector_tb/data_collector_inst/bus_rdata
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/bus_wr
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/bus_rd
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/data_coll_const_rd
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/data_coll_num_rd
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/num_ports_rd
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/data_width_rd
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/data_depth_rd
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/soft_resetn_wr
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/bus_chan_wr
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/trig_en_rd
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/trig_en_wr
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/en_wr_wr
add wave -noupdate -expand -group data_coll -expand -group bus /data_collector_tb/data_collector_inst/wr_depth_wr
add wave -noupdate -expand -group data_coll -childformat {{{/data_collector_tb/data_collector_inst/addr_wr[0]} -radix unsigned}} -expand -subitemconfig {{/data_collector_tb/data_collector_inst/addr_wr[0]} {-height 18 -radix unsigned}} /data_collector_tb/data_collector_inst/addr_wr
add wave -noupdate -expand -group data_coll -radix unsigned /data_collector_tb/data_collector_inst/addr_rd
add wave -noupdate -expand -group data_coll -expand /data_collector_tb/data_collector_inst/we
add wave -noupdate -expand -group data_coll -expand /data_collector_tb/data_collector_inst/wr_perm
add wave -noupdate -expand -group data_coll -expand /data_collector_tb/data_collector_inst/wr
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/we_dis
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/trig_en
add wave -noupdate -expand -group data_coll -expand /data_collector_tb/data_collector_inst/trig_en_syn
add wave -noupdate -expand -group data_coll -expand /data_collector_tb/data_collector_inst/wr_stop
add wave -noupdate -expand -group data_coll -radix unsigned -childformat {{{/data_collector_tb/data_collector_inst/wr_depth[14]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[13]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[12]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[11]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[10]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[9]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[8]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[7]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[6]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[5]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[4]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[3]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[2]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[1]} -radix unsigned} {{/data_collector_tb/data_collector_inst/wr_depth[0]} -radix unsigned}} -subitemconfig {{/data_collector_tb/data_collector_inst/wr_depth[14]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[13]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[12]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[11]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[10]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[9]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[8]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[7]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[6]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[5]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[4]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[3]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[2]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[1]} {-height 15 -radix unsigned} {/data_collector_tb/data_collector_inst/wr_depth[0]} {-height 18 -radix unsigned}} /data_collector_tb/data_collector_inst/wr_depth
add wave -noupdate -expand -group data_coll -childformat {{{/data_collector_tb/data_collector_inst/data_parse[0]} -radix hexadecimal}} -expand -subitemconfig {{/data_collector_tb/data_collector_inst/data_parse[0]} {-height 18 -radix hexadecimal}} /data_collector_tb/data_collector_inst/data_parse
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/bus_chan
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/bus_rdata1
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/rd
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/ram_rd
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/wr_stop_syn
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/rw_reg
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/ram_out
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/soft_resetn_int
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/soft_resetn_cntr
add wave -noupdate -expand -group data_coll /data_collector_tb/data_collector_inst/soft_resetn
add wave -noupdate /data_collector_tb/READ_BIS_TASK/raddr
add wave -noupdate /data_collector_tb/READ_BIS_TASK/data_out
add wave -noupdate /data_collector_tb/READ_BIS_TASK/en_disp
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/OUT_REG}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/WIDTH}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/DEPTH}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/SRAM_WIDTH}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/SRAM_DEPTH}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/SRAM_AWIDTH}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/AWIDTH}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/NUM_SRAM_W}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/NUM_SRAM_D}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/wr_clk}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/rd_clk}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/we}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/re}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/dat_in}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/dat_out}
add wave -noupdate -group bram_block_sram -radix unsigned -radixshowbase 0 {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/wr_addr}
add wave -noupdate -group bram_block_sram -radix unsigned -radixshowbase 0 {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/rd_addr}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/ram}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/QA}
add wave -noupdate -group bram_block_sram -radix unsigned -radixshowbase 0 {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/AA}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/AB}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/DB}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/wr_addr_page}
add wave -noupdate -group bram_block_sram {/data_collector_tb/data_collector_inst/loop_data_parse[0]/bram_block_v2_inst/rd_addr_page}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1116000 ps} 1} {{Cursor 2} {124450000 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 528
configure wave -valuecolwidth 110
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
WaveRestoreZoom {0 ps} {6300 us}