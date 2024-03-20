set SUB_PATH "../.."

vlib correlator
# удаляем библиотеку для полной пересборки
vdel -all -lib correlator

# correlator
vlog -quiet -reportprogress 300 -work correlator ref_in_interpretator_tb.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/ref_in_interpretator.sv   +incdir+../verilog +incdir+$SUB_PATH/interfaces

# interface
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/intbus_interf.sv
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/adc_interf.sv
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/regs_file.sv

# sync
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/ed_det.v

# misc
vlog -quiet -reportprogress 300 -work correlator ../verilog/sin_gen.v


# run
quit -sim
vsim -novopt correlator.ref_in_interpretator_tb
do wave/ref_in_interpretator_tb.do
run 200 us
