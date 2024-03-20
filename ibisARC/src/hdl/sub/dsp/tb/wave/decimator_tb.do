onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /decimator_tb/BASEADDR
add wave -noupdate -expand -group tb /decimator_tb/WIDTH_DATA
add wave -noupdate -expand -group tb /decimator_tb/WIDTH_COEF
add wave -noupdate -expand -group tb /decimator_tb/IQ_WIDTH
add wave -noupdate -expand -group tb /decimator_tb/PHASE_WIDTH
add wave -noupdate -expand -group tb /decimator_tb/ORDER
add wave -noupdate -expand -group tb /decimator_tb/NCH
add wave -noupdate -expand -group tb /decimator_tb/clk
add wave -noupdate -expand -group tb /decimator_tb/clk_up
add wave -noupdate -expand -group tb /decimator_tb/clk_down
add wave -noupdate -expand -group tb /decimator_tb/aclk
add wave -noupdate -expand -group tb /decimator_tb/aresetn
add wave -noupdate -expand -group tb /decimator_tb/resetn
add wave -noupdate -expand -group tb -expand -group data_from_decim /decimator_tb/adc_from_decim/PORTS
add wave -noupdate -expand -group tb -expand -group data_from_decim /decimator_tb/adc_from_decim/R
add wave -noupdate -expand -group tb -expand -group data_from_decim -radix decimal /decimator_tb/adc_from_decim/data
add wave -noupdate -expand -group tb -expand -group data_from_decim /decimator_tb/adc_from_decim/clk
add wave -noupdate -expand -group tb -expand -group data_from_decim /decimator_tb/adc_from_decim/resetn
add wave -noupdate -expand -group tb -expand -group data_from_decim /decimator_tb/adc_from_decim/valid
add wave -noupdate -expand -group tb -format Analog-Step -height 74 -max 3.0 -min -3.0 -radix decimal /decimator_tb/sin
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/BASEADDR
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/IN_WIDTH
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/IN_SIGAMG
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/OUT_SIGAMG
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/WIDTH_COEF
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/ORDER
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/PLL
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/PLL_PERIOD
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/PLL_M
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/PLL_D_UP
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/PLL_D_DOWN
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/DATA_IN_WIDTH
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/FIR_WIDTH
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/BASEADDR
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/WIDTH_IN_DATA
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/WIDTH_COEF
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/ORDER
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/NCH
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/SYN_COEF
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/NPULSE
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/coef_mirr
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/sum
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/mul
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/A1_reg
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/A2_reg
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/B1_reg
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/MIRR_COEF
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/M_reg
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/P_reg
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/PL
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/PS
add wave -noupdate -expand -group dicimator -expand -group FIR /decimator_tb/DECIMATOR/FIR/coef_wr
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/NBUSES
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/BASEREG
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/FIR_BASE_ADDR
add wave -noupdate -expand -group dicimator -expand -group in /decimator_tb/DECIMATOR/in/PORTS
add wave -noupdate -expand -group dicimator -expand -group in /decimator_tb/DECIMATOR/in/R
add wave -noupdate -expand -group dicimator -expand -group in -radix decimal /decimator_tb/DECIMATOR/in/data
add wave -noupdate -expand -group dicimator -expand -group in /decimator_tb/DECIMATOR/in/clk
add wave -noupdate -expand -group dicimator -expand -group in /decimator_tb/DECIMATOR/in/resetn
add wave -noupdate -expand -group dicimator -expand -group in /decimator_tb/DECIMATOR/in/valid
add wave -noupdate -expand -group dicimator -expand -group out /decimator_tb/DECIMATOR/out/PORTS
add wave -noupdate -expand -group dicimator -expand -group out /decimator_tb/DECIMATOR/out/R
add wave -noupdate -expand -group dicimator -expand -group out -radix decimal /decimator_tb/DECIMATOR/out/data
add wave -noupdate -expand -group dicimator -expand -group out /decimator_tb/DECIMATOR/out/clk
add wave -noupdate -expand -group dicimator -expand -group out /decimator_tb/DECIMATOR/out/resetn
add wave -noupdate -expand -group dicimator -expand -group out /decimator_tb/DECIMATOR/out/valid
add wave -noupdate -expand -group dicimator -expand -group data_up /decimator_tb/DECIMATOR/data_up/PORTS
add wave -noupdate -expand -group dicimator -expand -group data_up /decimator_tb/DECIMATOR/data_up/R
add wave -noupdate -expand -group dicimator -expand -group data_up -radix decimal /decimator_tb/DECIMATOR/data_up/data
add wave -noupdate -expand -group dicimator -expand -group data_up /decimator_tb/DECIMATOR/data_up/clk
add wave -noupdate -expand -group dicimator -expand -group data_up /decimator_tb/DECIMATOR/data_up/resetn
add wave -noupdate -expand -group dicimator -expand -group data_up /decimator_tb/DECIMATOR/data_up/valid
add wave -noupdate -expand -group dicimator -expand -group data_fir /decimator_tb/DECIMATOR/data_fir/PORTS
add wave -noupdate -expand -group dicimator -expand -group data_fir /decimator_tb/DECIMATOR/data_fir/R
add wave -noupdate -expand -group dicimator -expand -group data_fir -radix decimal /decimator_tb/DECIMATOR/data_fir/data
add wave -noupdate -expand -group dicimator -expand -group data_fir /decimator_tb/DECIMATOR/data_fir/clk
add wave -noupdate -expand -group dicimator -expand -group data_fir /decimator_tb/DECIMATOR/data_fir/resetn
add wave -noupdate -expand -group dicimator -expand -group data_fir /decimator_tb/DECIMATOR/data_fir/valid
add wave -noupdate -expand -group dicimator -expand -group data_fir_down /decimator_tb/DECIMATOR/data_fir_down/PORTS
add wave -noupdate -expand -group dicimator -expand -group data_fir_down /decimator_tb/DECIMATOR/data_fir_down/R
add wave -noupdate -expand -group dicimator -expand -group data_fir_down -radix decimal /decimator_tb/DECIMATOR/data_fir_down/data
add wave -noupdate -expand -group dicimator -expand -group data_fir_down /decimator_tb/DECIMATOR/data_fir_down/clk
add wave -noupdate -expand -group dicimator -expand -group data_fir_down /decimator_tb/DECIMATOR/data_fir_down/resetn
add wave -noupdate -expand -group dicimator -expand -group data_fir_down /decimator_tb/DECIMATOR/data_fir_down/valid
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/clk_up
add wave -noupdate -expand -group dicimator /decimator_tb/DECIMATOR/clk_down
add wave -noupdate -expand -group dicimator -format Analog-Step -height 74 -max 1.0 -min -1.0 -radix decimal /decimator_tb/DECIMATOR/data_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44886750 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 343
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
WaveRestoreZoom {43252870 ps} {56377990 ps}
