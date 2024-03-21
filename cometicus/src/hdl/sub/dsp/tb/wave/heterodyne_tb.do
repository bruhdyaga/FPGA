onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /heterodyne_tb/BASEADDR
add wave -noupdate -expand -group tb /heterodyne_tb/WIDTH_DATA
add wave -noupdate -expand -group tb /heterodyne_tb/WIDTH_COEF
add wave -noupdate -expand -group tb /heterodyne_tb/ORDER
add wave -noupdate -expand -group tb -radix unsigned /heterodyne_tb/IQ_WIDTH
add wave -noupdate -expand -group tb -radix unsigned /heterodyne_tb/PHASE_WIDTH
add wave -noupdate -expand -group tb /heterodyne_tb/NCH
add wave -noupdate -expand -group tb /heterodyne_tb/clk
add wave -noupdate -expand -group tb /heterodyne_tb/aclk
add wave -noupdate -expand -group tb /heterodyne_tb/aresetn
add wave -noupdate -expand -group tb /heterodyne_tb/resetn
add wave -noupdate -expand -group tb /heterodyne_tb/sin
add wave -noupdate -expand -group tb /heterodyne_tb/cos
add wave -noupdate -expand -group tb /heterodyne_tb/sin_12
add wave -noupdate -expand -group tb /heterodyne_tb/cos_12
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/BASEADDR
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/WIDTH_DATA
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/WIDTH_COEF
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/IQ_WIDTH
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/PHASE_WIDTH
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/ORDER
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/NCH
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/FIR_CH
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/FIR_IN_WIDTH
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/NBUSES
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/BASE_REGFILE
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/FIR_BASE_ADDR
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/RECORDER_BASE_ADDR
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/DATA_COLL_BASE_ADDR
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/DATACOLL_BUS_NUM
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/PS
add wave -noupdate -expand -group HETERODYNE /heterodyne_tb/HETERODYNE/PL
add wave -noupdate -expand -group HETERODYNE -group in /heterodyne_tb/HETERODYNE/in/PORTS
add wave -noupdate -expand -group HETERODYNE -group in /heterodyne_tb/HETERODYNE/in/R
add wave -noupdate -expand -group HETERODYNE -group in /heterodyne_tb/HETERODYNE/in/data
add wave -noupdate -expand -group HETERODYNE -group in /heterodyne_tb/HETERODYNE/in/clk
add wave -noupdate -expand -group HETERODYNE -group in /heterodyne_tb/HETERODYNE/in/resetn
add wave -noupdate -expand -group HETERODYNE -group in /heterodyne_tb/HETERODYNE/in/valid
add wave -noupdate -expand -group HETERODYNE -group out /heterodyne_tb/HETERODYNE/out/PORTS
add wave -noupdate -expand -group HETERODYNE -group out /heterodyne_tb/HETERODYNE/out/R
add wave -noupdate -expand -group HETERODYNE -group out /heterodyne_tb/HETERODYNE/out/data
add wave -noupdate -expand -group HETERODYNE -group out /heterodyne_tb/HETERODYNE/out/clk
add wave -noupdate -expand -group HETERODYNE -group out /heterodyne_tb/HETERODYNE/out/resetn
add wave -noupdate -expand -group HETERODYNE -group out /heterodyne_tb/HETERODYNE/out/valid
add wave -noupdate -expand -group HETERODYNE -group recorder_data /heterodyne_tb/HETERODYNE/recorder_data/PORTS
add wave -noupdate -expand -group HETERODYNE -group recorder_data /heterodyne_tb/HETERODYNE/recorder_data/R
add wave -noupdate -expand -group HETERODYNE -group recorder_data -expand /heterodyne_tb/HETERODYNE/recorder_data/data
add wave -noupdate -expand -group HETERODYNE -group recorder_data /heterodyne_tb/HETERODYNE/recorder_data/clk
add wave -noupdate -expand -group HETERODYNE -group recorder_data /heterodyne_tb/HETERODYNE/recorder_data/resetn
add wave -noupdate -expand -group HETERODYNE -group recorder_data /heterodyne_tb/HETERODYNE/recorder_data/valid
add wave -noupdate -expand -group HETERODYNE -group fir_in_IQ /heterodyne_tb/HETERODYNE/fir_in_IQ/PORTS
add wave -noupdate -expand -group HETERODYNE -group fir_in_IQ /heterodyne_tb/HETERODYNE/fir_in_IQ/R
add wave -noupdate -expand -group HETERODYNE -group fir_in_IQ -expand /heterodyne_tb/HETERODYNE/fir_in_IQ/data
add wave -noupdate -expand -group HETERODYNE -group fir_in_IQ /heterodyne_tb/HETERODYNE/fir_in_IQ/clk
add wave -noupdate -expand -group HETERODYNE -group fir_in_IQ /heterodyne_tb/HETERODYNE/fir_in_IQ/resetn
add wave -noupdate -expand -group HETERODYNE -group fir_in_IQ /heterodyne_tb/HETERODYNE/fir_in_IQ/valid
add wave -noupdate -expand -group HETERODYNE -group in_mux /heterodyne_tb/HETERODYNE/in_mux/PORTS
add wave -noupdate -expand -group HETERODYNE -group in_mux /heterodyne_tb/HETERODYNE/in_mux/R
add wave -noupdate -expand -group HETERODYNE -group in_mux -expand /heterodyne_tb/HETERODYNE/in_mux/data
add wave -noupdate -expand -group HETERODYNE -group in_mux /heterodyne_tb/HETERODYNE/in_mux/clk
add wave -noupdate -expand -group HETERODYNE -group in_mux /heterodyne_tb/HETERODYNE/in_mux/resetn
add wave -noupdate -expand -group HETERODYNE -group in_mux /heterodyne_tb/HETERODYNE/in_mux/valid
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/BASEADDR
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/NUM_PORTS
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/DATA_WIDTH
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/DATA_DEPTH
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/RAM_TYPE
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/RAM_ADDR_WIDTH
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/NPULSE
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/RVALID_FF
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/clk
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/resetn
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/valid
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/data
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/PL
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/PS
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/bus_rd
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/bus_wr
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/trig_en_pulse
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/soft_reset
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/addr_wr
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/addr_rd
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/trig_en
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/ram_out
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/ram_in
add wave -noupdate -expand -group HETERODYNE -group RECORDER /heterodyne_tb/HETERODYNE/DATA_RECORDER/cpu_rd_ram
add wave -noupdate -expand -group HETERODYNE -group DDS_HD -radix unsigned /heterodyne_tb/HETERODYNE/DDS_IQ_HD/IQ_WIDTH
add wave -noupdate -expand -group HETERODYNE -group DDS_HD -radix unsigned /heterodyne_tb/HETERODYNE/DDS_IQ_HD/PHASE_WIDTH
add wave -noupdate -expand -group HETERODYNE -group DDS_HD -radix unsigned /heterodyne_tb/HETERODYNE/DDS_IQ_HD/ROM_WIDTH
add wave -noupdate -expand -group HETERODYNE -group DDS_HD /heterodyne_tb/HETERODYNE/DDS_IQ_HD/clk
add wave -noupdate -expand -group HETERODYNE -group DDS_HD /heterodyne_tb/HETERODYNE/DDS_IQ_HD/resetn
add wave -noupdate -expand -group HETERODYNE -group DDS_HD /heterodyne_tb/HETERODYNE/DDS_IQ_HD/sin
add wave -noupdate -expand -group HETERODYNE -group DDS_HD /heterodyne_tb/HETERODYNE/DDS_IQ_HD/cos
add wave -noupdate -expand -group HETERODYNE -group DDS_HD /heterodyne_tb/HETERODYNE/DDS_IQ_HD/code
add wave -noupdate -expand -group HETERODYNE -group DDS_HD /heterodyne_tb/HETERODYNE/DDS_IQ_HD/rom
add wave -noupdate -expand -group HETERODYNE -group DDS_HD /heterodyne_tb/HETERODYNE/DDS_IQ_HD/rom_reg
add wave -noupdate -expand -group HETERODYNE -group DDS_HD /heterodyne_tb/HETERODYNE/DDS_IQ_HD/addr
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/BASEADDR
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/WIDTH_IN_DATA
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/WIDTH_COEF
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/ORDER
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/NCH
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/NPULSE
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/sum
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/mul
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/A1_reg
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/A2_reg
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/B1_reg
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/M_reg
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/P_reg
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/PL
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/PS
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group in /heterodyne_tb/HETERODYNE/FIR/in/PORTS
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group in /heterodyne_tb/HETERODYNE/FIR/in/R
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group in /heterodyne_tb/HETERODYNE/FIR/in/data
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group in /heterodyne_tb/HETERODYNE/FIR/in/clk
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group in /heterodyne_tb/HETERODYNE/FIR/in/resetn
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group in /heterodyne_tb/HETERODYNE/FIR/in/valid
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group out /heterodyne_tb/HETERODYNE/FIR/out/PORTS
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group out /heterodyne_tb/HETERODYNE/FIR/out/R
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group out -expand /heterodyne_tb/HETERODYNE/FIR/out/data
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group out /heterodyne_tb/HETERODYNE/FIR/out/clk
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group out /heterodyne_tb/HETERODYNE/FIR/out/resetn
add wave -noupdate -expand -group HETERODYNE -expand -group FIR -expand -group out /heterodyne_tb/HETERODYNE/FIR/out/valid
add wave -noupdate -expand -group HETERODYNE -expand -group FIR /heterodyne_tb/HETERODYNE/FIR/coef_wr
add wave -noupdate -expand -group HETERODYNE -format Analog-Step -height 74 -max 254.99999999999997 -min -255.0 -radix decimal -childformat {{{/heterodyne_tb/HETERODYNE/sin[8]} -radix decimal} {{/heterodyne_tb/HETERODYNE/sin[7]} -radix decimal} {{/heterodyne_tb/HETERODYNE/sin[6]} -radix decimal} {{/heterodyne_tb/HETERODYNE/sin[5]} -radix decimal} {{/heterodyne_tb/HETERODYNE/sin[4]} -radix decimal} {{/heterodyne_tb/HETERODYNE/sin[3]} -radix decimal} {{/heterodyne_tb/HETERODYNE/sin[2]} -radix decimal} {{/heterodyne_tb/HETERODYNE/sin[1]} -radix decimal} {{/heterodyne_tb/HETERODYNE/sin[0]} -radix decimal}} -subitemconfig {{/heterodyne_tb/HETERODYNE/sin[8]} {-height 15 -radix decimal} {/heterodyne_tb/HETERODYNE/sin[7]} {-height 15 -radix decimal} {/heterodyne_tb/HETERODYNE/sin[6]} {-height 15 -radix decimal} {/heterodyne_tb/HETERODYNE/sin[5]} {-height 15 -radix decimal} {/heterodyne_tb/HETERODYNE/sin[4]} {-height 15 -radix decimal} {/heterodyne_tb/HETERODYNE/sin[3]} {-height 15 -radix decimal} {/heterodyne_tb/HETERODYNE/sin[2]} {-height 15 -radix decimal} {/heterodyne_tb/HETERODYNE/sin[1]} {-height 15 -radix decimal} {/heterodyne_tb/HETERODYNE/sin[0]} {-height 15 -radix decimal}} /heterodyne_tb/HETERODYNE/sin
add wave -noupdate -expand -group HETERODYNE -format Analog-Step -height 74 -max 254.99999999999997 -min -255.0 -radix decimal /heterodyne_tb/HETERODYNE/cos
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29370740 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 375
configure wave -valuecolwidth 127
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
WaveRestoreZoom {29190180 ps} {30010500 ps}
