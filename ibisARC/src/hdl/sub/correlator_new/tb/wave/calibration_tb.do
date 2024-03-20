onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /calibration_tb/BASEADDR
add wave -noupdate -expand -group tb /calibration_tb/NBUSES
add wave -noupdate -expand -group tb /calibration_tb/ADC_PORTS
add wave -noupdate -expand -group tb /calibration_tb/BASE_CALIB
add wave -noupdate -expand -group tb /calibration_tb/pclk
add wave -noupdate -expand -group tb /calibration_tb/aclk
add wave -noupdate -expand -group tb /calibration_tb/presetn
add wave -noupdate -expand -group tb /calibration_tb/aresetn
add wave -noupdate -expand -group tb -radix unsigned /calibration_tb/sec_pulse_cntr
add wave -noupdate -expand -group tb /calibration_tb/sec_pulse_ed
add wave -noupdate -expand -group tb -format Analog-Step -height 74 -max 3.0 -min -3.0 -radix decimal /calibration_tb/sin
add wave -noupdate -expand -group calib /calibration_tb/CALIB/BASEADDR
add wave -noupdate -expand -group calib /calibration_tb/CALIB/sec_pulse_ed
add wave -noupdate -expand -group calib /calibration_tb/CALIB/PL
add wave -noupdate -expand -group calib -childformat {{/calibration_tb/CALIB/PS.PHASE_RATE -radix unsigned}} -expand -subitemconfig {/calibration_tb/CALIB/PS.PHASE_RATE {-radix unsigned}} /calibration_tb/CALIB/PS
add wave -noupdate -expand -group calib /calibration_tb/CALIB/phase_next
add wave -noupdate -expand -group calib /calibration_tb/CALIB/PHASE
add wave -noupdate -expand -group calib /calibration_tb/CALIB/CAR_CYCLES
add wave -noupdate -expand -group calib -expand -group CH_MUL /calibration_tb/CALIB/CH_MUL/adc_re
add wave -noupdate -expand -group calib -expand -group CH_MUL /calibration_tb/CALIB/CH_MUL/adc_im
add wave -noupdate -expand -group calib -expand -group CH_MUL /calibration_tb/CALIB/CH_MUL/phase
add wave -noupdate -expand -group calib -expand -group CH_MUL /calibration_tb/CALIB/CH_MUL/i_prod
add wave -noupdate -expand -group calib -expand -group CH_MUL /calibration_tb/CALIB/CH_MUL/q_prod
add wave -noupdate -expand -group calib -format Analog-Step -height 74 -max 11.0 -min -11.0 -radix decimal /calibration_tb/CALIB/cos_product
add wave -noupdate -expand -group calib -format Analog-Step -height 74 -max 11.0 -min -11.0 -radix decimal /calibration_tb/CALIB/sin_product
add wave -noupdate -expand -group calib -radix decimal /calibration_tb/CALIB/I
add wave -noupdate -expand -group calib -radix decimal /calibration_tb/CALIB/Q
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/BASEADDR
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/BUS_EN
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/cos_shift
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/clk
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/resetn
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/syn_reset
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/sin
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/cos
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/valid
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/en
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/code_in
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/code
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/sum_cntr
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/adr
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/adr_cos_wide
add wave -noupdate -group DDS /calibration_tb/DDS_sin_cos_inst/adr_cos
add wave -noupdate -group adc /calibration_tb/adc/PORTS
add wave -noupdate -group adc /calibration_tb/adc/R
add wave -noupdate -group adc /calibration_tb/adc/data
add wave -noupdate -group adc /calibration_tb/adc/clk
add wave -noupdate -group adc /calibration_tb/adc/resetn
add wave -noupdate -group adc /calibration_tb/adc/valid
add wave -noupdate -expand -group bus /calibration_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group bus /calibration_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group bus /calibration_tb/bus/clk
add wave -noupdate -expand -group bus /calibration_tb/bus/resetn
add wave -noupdate -expand -group bus /calibration_tb/bus/addr
add wave -noupdate -expand -group bus /calibration_tb/bus/wdata
add wave -noupdate -expand -group bus /calibration_tb/bus/rdata
add wave -noupdate -expand -group bus /calibration_tb/bus/rvalid
add wave -noupdate -expand -group bus /calibration_tb/bus/wr
add wave -noupdate -expand -group bus /calibration_tb/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1199102880 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 280
configure wave -valuecolwidth 104
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
WaveRestoreZoom {1198831054 ps} {1200061524 ps}
