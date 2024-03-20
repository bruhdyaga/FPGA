onerror {resume}
quietly virtual signal -install /corr_ch_tb/corr_ch/TIME_SCALE_CH { /corr_ch_tb/corr_ch/TIME_SCALE_CH/phase_next[31:28]} time_cntr
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /corr_ch_tb/NCH
add wave -noupdate -group tb /corr_ch_tb/NUM_ADC
add wave -noupdate -group tb /corr_ch_tb/BASE_ADDR
add wave -noupdate -group tb /corr_ch_tb/TIME_SHIFT
add wave -noupdate -group tb /corr_ch_tb/TIME_DO_RQST_OFFS
add wave -noupdate -group tb /corr_ch_tb/TIME_CHIP_EPOCH_MAX_OFFS
add wave -noupdate -group tb /corr_ch_tb/TIME_CODE_RATE_OFFS
add wave -noupdate -group tb /corr_ch_tb/PRN_SHIFT
add wave -noupdate -group tb /corr_ch_tb/pclk
add wave -noupdate -group tb /corr_ch_tb/aclk
add wave -noupdate -group tb /corr_ch_tb/aresetn
add wave -noupdate -group tb /corr_ch_tb/rdata
add wave -noupdate -group tb /corr_ch_tb/NCH
add wave -noupdate -group tb /corr_ch_tb/NUM_ADC
add wave -noupdate -group tb /corr_ch_tb/BASE_ADDR
add wave -noupdate -group tb /corr_ch_tb/TIME_SHIFT
add wave -noupdate -group tb /corr_ch_tb/TIME_DO_RQST_OFFS
add wave -noupdate -group tb /corr_ch_tb/TIME_CHIP_EPOCH_MAX_OFFS
add wave -noupdate -group tb /corr_ch_tb/TIME_CODE_RATE_OFFS
add wave -noupdate -group tb /corr_ch_tb/PRN_SHIFT
add wave -noupdate -group tb /corr_ch_tb/pclk
add wave -noupdate -group tb /corr_ch_tb/aclk
add wave -noupdate -group tb /corr_ch_tb/aresetn
add wave -noupdate -group tb /corr_ch_tb/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/BASEADDR
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/BASENEXT
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/ID
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/INST
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/OUTFF
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/NREGS
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/INIT
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/NPULSE
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/in
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/out
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/pulse
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_rdata_const
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_rdata_int
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_mem
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_mem_const
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_const_rd
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/sync_rd
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/pulse_reg
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/out_arr
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/in_arr
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/init_arr
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/BASEADDR
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/BASENEXT
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/ID
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/INST
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/OUTFF
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/NREGS
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/INIT
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/NPULSE
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/in
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/out
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/pulse
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_rdata_const
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_rdata_int
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_mem
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_mem_const
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/reg_const_rd
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/sync_rd
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/pulse_reg
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/out_arr
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/in_arr
add wave -noupdate -expand -group corr_ch -group time_ch -group RF /corr_ch_tb/corr_ch/TIME_SCALE_CH/RF/init_arr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group time_ch -group bus /corr_ch_tb/corr_ch/TIME_SCALE_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/BASEADDR
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/BASENEXT
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/INST
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/NPULSE
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/clk
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/resetn
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/chip_pulse
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/epoch_pulse
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/sec_pulse
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/fix_pulse
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/do_rqst
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/eph_apply
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/time_out
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/phase_hi
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/PL
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/PS
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/T
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/eph_rqst
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/eph_set
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/phase_next
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/week_pulse
add wave -noupdate -expand -group corr_ch -group time_ch /corr_ch_tb/corr_ch/TIME_SCALE_CH/time_cntr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/ADDR_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/clk
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/addr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rdata
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rvalid
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/wr
add wave -noupdate -expand -group corr_ch -group prn_ch -group bus /corr_ch_tb/corr_ch/PRN_GEN_CH/bus/rd
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/BASEADDR
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/BASENEXT
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/INST
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/BDSS_CH
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/BDSS_EN
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/clk
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/resetn
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr_shift
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/phase_hi
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/update
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/code
add wave -noupdate -expand -group corr_ch -group prn_ch -color {Medium Violet Red} /corr_ch_tb/corr_ch/PRN_GEN_CH/boc_mod
add wave -noupdate -expand -group corr_ch -group prn_ch -color Cyan /corr_ch_tb/corr_ch/PRN_GEN_CH/code_out
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/mask
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/bdss_psp
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr1
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr2
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/prn_counter
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/prn_reset
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/gps_l5_reset
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr1_xor
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr2_xor
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr1_out
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr2_out
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/PS
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr2_fb
add wave -noupdate -expand -group corr_ch -group prn_ch /corr_ch_tb/corr_ch/PRN_GEN_CH/sr2_xor_fb
add wave -noupdate -expand -group corr_ch -group prn_ch -expand /corr_ch_tb/corr_ch/PRN_GEN_CH/phase_hi_reg
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/BASEADDR
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/BASENEXT
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/ID
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/INST
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/DATA_WIDTH
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/OUTFF
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/NREGS
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/INIT
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/NPULSE
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/clk
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/resetn
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/in
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/out
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/pulse
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/wr
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/rd
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/reg_wdata
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/reg_rdata
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/reg_rdata_const
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/reg_rdata_int
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/reg_mem
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/reg_mem_const
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/reg_const_rd
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/sync_rd
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/pulse_reg
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/out_arr
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/in_arr
add wave -noupdate -expand -group corr_ch -group RF /corr_ch_tb/corr_ch/RF/init_arr
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/BASEADDR
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/BASENEXT
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/INST
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/BDSS_CH
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/BDSS_EN
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/IQ_DIGS
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/NBUSES
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/BASETIME
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/BASEPRN
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/BASEREGFILE
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/BASEENDREGFILE
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/fix_pulse
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/irq_pulse
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/chip_pulse
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/bdss_psp
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/PL
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/PS
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/epoch_pulse
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/do_rqst
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/eph_apply
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/time_out
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/phase_hi
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/PN
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/mask
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/PN_LINE
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/PN_dly
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/mask_LINE
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/mask_dly
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/PHASE_RATE
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/phase_next
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/PHASE
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/CAR_CYCLES
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/cos_prod
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/sin_prod
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/cos_prod32
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/sin_prod32
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/I
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/Q
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/INPUT_I
add wave -noupdate -expand -group corr_ch /corr_ch_tb/corr_ch/INPUT_Q
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group bus /corr_ch_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /corr_ch_tb/bus/clk
add wave -noupdate -group bus /corr_ch_tb/bus/resetn
add wave -noupdate -group bus /corr_ch_tb/bus/addr
add wave -noupdate -group bus /corr_ch_tb/bus/wdata
add wave -noupdate -group bus /corr_ch_tb/bus/rdata
add wave -noupdate -group bus /corr_ch_tb/bus/rvalid
add wave -noupdate -group bus /corr_ch_tb/bus/wr
add wave -noupdate -group bus /corr_ch_tb/bus/rd
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group adc /corr_ch_tb/adc/PORTS
add wave -noupdate -group adc /corr_ch_tb/adc/R
add wave -noupdate -group adc /corr_ch_tb/adc/data
add wave -noupdate -group adc /corr_ch_tb/adc/clk
add wave -noupdate -group adc /corr_ch_tb/adc/resetn
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/WIDTH
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/INIT_STATE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/RESET_TYPE
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/clk
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/reset_n
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/async
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync1
add wave -noupdate -group ADC_RESET_N /corr_ch_tb/ADC_RESETN/sync2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1173040 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 512
configure wave -valuecolwidth 90
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
WaveRestoreZoom {0 ps} {16800 ns}
