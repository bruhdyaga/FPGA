onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /axi2one_tb/clk
add wave -noupdate -expand -group tb /axi2one_tb/resetn
add wave -noupdate -expand -group tb /axi2one_tb/axi1_arvalid_start
add wave -noupdate -expand -group tb /axi2one_tb/axi1_awvalid_start
add wave -noupdate -expand -group tb /axi2one_tb/axi2_arvalid_start
add wave -noupdate -expand -group tb /axi2one_tb/axi2_awvalid_start
add wave -noupdate -expand -group tb /axi2one_tb/axi1_awready
add wave -noupdate -expand -group tb /axi2one_tb/axi2_arready
add wave -noupdate -expand -group tb /axi2one_tb/axi2_awready
add wave -noupdate -expand -group tb -radix hexadecimal /axi2one_tb/axi1_araddr
add wave -noupdate -expand -group tb /axi2one_tb/axi1_arvalid
add wave -noupdate -expand -group tb -radix hexadecimal /axi2one_tb/axi1_awaddr
add wave -noupdate -expand -group tb /axi2one_tb/axi1_awvalid
add wave -noupdate -expand -group tb -radix hexadecimal /axi2one_tb/axi1_wdata
add wave -noupdate -expand -group tb /axi2one_tb/axi1_arready
add wave -noupdate -expand -group tb -radix hexadecimal /axi2one_tb/axi2_araddr
add wave -noupdate -expand -group tb /axi2one_tb/axi2_arvalid
add wave -noupdate -expand -group tb -radix hexadecimal /axi2one_tb/axi2_awaddr
add wave -noupdate -expand -group tb /axi2one_tb/axi2_awvalid
add wave -noupdate -expand -group tb -radix hexadecimal /axi2one_tb/axi2_wdata
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/clk
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/resetn
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/axi1_araddr
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_arvalid
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/axi1_awaddr
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_awvalid
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/axi1_wdata
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_arready
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_awready
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_wready
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_rresp
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_bresp
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_rvalid
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_bvalid
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/axi2_araddr
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_arvalid
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/axi2_awaddr
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_awvalid
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/axi2_wdata
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_arready
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_awready
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_wready
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_rresp
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_bresp
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_rvalid
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_bvalid
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/axi_out_wdata
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/axi_out_addr
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi_out_wr_en
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi_out_rd_en
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/addr_mux_axi1
add wave -noupdate -expand -group axi2one -radix hexadecimal /axi2one_tb/axi2one_inst/addr_mux_axi2
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_out_wr_en
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_out_wr_en
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_out_rd_en
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_out_rd_en
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi1_en
add wave -noupdate -expand -group axi2one /axi2one_tb/axi2one_inst/axi2_en
add wave -noupdate -expand -group out_axi -radix hexadecimal /axi2one_tb/axi_out_wdata
add wave -noupdate -expand -group out_axi -radix hexadecimal /axi2one_tb/axi_out_addr
add wave -noupdate -expand -group out_axi /axi2one_tb/axi_out_wr_en
add wave -noupdate -expand -group out_axi /axi2one_tb/axi_out_rd_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {140 ns} 0}
configure wave -namecolwidth 356
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
WaveRestoreZoom {0 ns} {735 ns}
