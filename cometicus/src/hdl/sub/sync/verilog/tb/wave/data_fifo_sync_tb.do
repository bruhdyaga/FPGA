onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /data_fifo_sync_tb/syn_data_compare
add wave -noupdate -expand -group tb /data_fifo_sync_tb/i_int
add wave -noupdate -expand -group tb /data_fifo_sync_tb/CLK_PER
add wave -noupdate -expand -group tb /data_fifo_sync_tb/JITTER
add wave -noupdate -expand -group tb /data_fifo_sync_tb/SEED1
add wave -noupdate -expand -group tb /data_fifo_sync_tb/SEED2
add wave -noupdate -expand -group tb /data_fifo_sync_tb/DEPTH_TEST
add wave -noupdate -expand -group tb /data_fifo_sync_tb/i_mem_d
add wave -noupdate -expand -group tb /data_fifo_sync_tb/test_data_mem
add wave -noupdate -expand -group tb /data_fifo_sync_tb/rd_data_mem
add wave -noupdate -expand -group tb -color Yellow -radix unsigned /data_fifo_sync_tb/wr_addr
add wave -noupdate -expand -group tb -radix unsigned /data_fifo_sync_tb/rd_addr
add wave -noupdate -expand -group tb /data_fifo_sync_tb/data_asy
add wave -noupdate -expand -group tb /data_fifo_sync_tb/data_syn
add wave -noupdate -expand -group tb -radix unsigned /data_fifo_sync_tb/cntr_1
add wave -noupdate -expand -group tb -radix unsigned /data_fifo_sync_tb/cntr_2
add wave -noupdate -expand -group tb /data_fifo_sync_tb/clk
add wave -noupdate -expand -group tb /data_fifo_sync_tb/rdclk_jit
add wave -noupdate -expand -group tb /data_fifo_sync_tb/wrclk_jit
add wave -noupdate -expand -group tb -format Analog-Step -height 74 -max 2.0 -min -2.0 -radix decimal /data_fifo_sync_tb/cntr_diff
add wave -noupdate -expand -group tb /data_fifo_sync_tb/error
add wave -noupdate -expand -group tb /data_fifo_sync_tb/num_errors
add wave -noupdate -expand -group tb /data_fifo_sync_tb/resetn
add wave -noupdate -expand -group tb /data_fifo_sync_tb/WIDTH
add wave -noupdate -expand -group tb /data_fifo_sync_tb/asy_data_compare
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/DEPTH
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/RAM_ADDR_BITS
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/WIDTH
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/wrresetn
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/rdresetn
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/fifo_full
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/async
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/error
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/ram
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/ram_out
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/rdaddr
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/rdclk
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/sync
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/synchro_rd
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/synchro_wr
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/wraddr
add wave -noupdate -expand -group fifo_syn /data_fifo_sync_tb/data_fifo_sync/wrclk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {306158 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 326
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {1050 ns}
