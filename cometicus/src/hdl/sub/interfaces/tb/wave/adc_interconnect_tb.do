onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /adc_interconnect_tb/BASEADDR
add wave -noupdate -expand -group tb /adc_interconnect_tb/IN_SIZE
add wave -noupdate -expand -group tb /adc_interconnect_tb/OUT_SIZE
add wave -noupdate -expand -group tb /adc_interconnect_tb/aclk
add wave -noupdate -expand -group tb /adc_interconnect_tb/pclk
add wave -noupdate -expand -group tb /adc_interconnect_tb/presetn
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/BASEADDR
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/IN_SIZE
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/OUT_SIZE
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/OUT_FF
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/PL
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/PS
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/bus_wr
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/mux_reg
add wave -noupdate -expand -group adc_interconnect /adc_interconnect_tb/ADC_INTERCONNECT/bus_wr_pl
add wave -noupdate -expand -group adc_in /adc_interconnect_tb/adc_in[0]/PORTS
add wave -noupdate -expand -group adc_in /adc_interconnect_tb/adc_in[0]/R
add wave -noupdate -expand -group adc_in /adc_interconnect_tb/adc_in[0]/data
add wave -noupdate -expand -group adc_in /adc_interconnect_tb/adc_in[0]/clk
add wave -noupdate -expand -group adc_in /adc_interconnect_tb/adc_in[0]/valid
add wave -noupdate -expand -group adc_out /adc_interconnect_tb/adc_out[0]/PORTS
add wave -noupdate -expand -group adc_out /adc_interconnect_tb/adc_out[0]/R
add wave -noupdate -expand -group adc_out /adc_interconnect_tb/adc_out[0]/data
add wave -noupdate -expand -group adc_out /adc_interconnect_tb/adc_out[0]/clk
add wave -noupdate -expand -group adc_out /adc_interconnect_tb/adc_out[0]/valid
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/clk
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/addr
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/wdata
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/rdata
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/rvalid
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/wr
add wave -noupdate -expand -group bus /adc_interconnect_tb/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3032720 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 347
configure wave -valuecolwidth 116
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
WaveRestoreZoom {0 ps} {1050 ns}
