set SUB_PATH "../.."

vlib correlator
# удаляем библиотеку для полной пересборки
vdel -all -lib correlator

# correlator
vlog -quiet -reportprogress 300 -work correlator calibration_tb.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/calibration.sv   +incdir+../verilog +incdir+$SUB_PATH/interfaces

# interface
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/intbus_interf.sv
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/adc_interf.sv
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/regs_file.sv

# sync
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/ed_det.v
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/level_sync.v

# misc
vlog -quiet -reportprogress 300 -work correlator ../verilog/sin_gen.v
vlog -quiet -reportprogress 300 -work correlator ../verilog/channel_cmplx_table.v
vlog -quiet -reportprogress 300 -work correlator ../verilog/channel_cos_table.v
vlog -quiet -reportprogress 300 -work correlator ../verilog/channel_sin_table.v


# run
quit -sim
vsim -novopt correlator.calibration_tb
do wave/calibration_tb.do
run 10 ms
