set SUB_PATH "../.."

vlib correlator
# удаляем библиотеку для полной пересборки
vdel -all -lib correlator

# correlator
vlog -quiet -reportprogress 300 -work correlator ../verilog/ref_table_SigMag.sv
vlog -quiet -reportprogress 300 -work correlator ../verilog/corr.sv
vlog -quiet -reportprogress 300 -work correlator ../verilog/corr_ch.sv    +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/prn_gen.sv    +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/time_scale.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/irq_ctrl.sv   +incdir+../verilog +incdir+$SUB_PATH/interfaces

# run
# quit -sim
# vsim -novopt correlator.time_generator_tb
# do wave/time_generator_tb.do
# run 120 us
