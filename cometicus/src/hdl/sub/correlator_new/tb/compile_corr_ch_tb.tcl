set SUB_PATH "../.."

vlib correlator
# удаляем библиотеку для полной пересборки
vdel -all -lib correlator

# correlator
vlog -quiet -reportprogress 300 -work correlator corr_ch_tb.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces

vlog -quiet -reportprogress 300 -work correlator ../verilog/corr_ch.sv    +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/prn_gen.sv    +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/time_scale_ch.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/ch_mul.sv
# vlog -quiet -reportprogress 300 -work correlator ../verilog/irq_ctrl.sv   +incdir+../verilog +incdir+$SUB_PATH/interfaces

# interface
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/adc_interf.sv
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/intbus_interf.sv
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/regs_file.sv

# sync
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/level_sync.v
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/signal_sync.v
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/ed_det.v

# run
quit -sim
vsim -novopt correlator.corr_ch_tb
do wave/corr_ch_tb.do
run 16 us
