set WORK_LIB         "correlator"
set SUB_PATH "../.."
set PATH_globalparam "$SUB_PATH/../verilog"
set PATH_boardparam  "$PATH_globalparam/clonicus"
set PATH_sync        "$SUB_PATH/sync/verilog"

vlib correlator
# удаляем библиотеку для полной пересборки
vdel -all -lib correlator

set THIS_PATH $PATH_sync
do $PATH_sync/tb/compile_sync.tcl

# correlator
vlog -quiet -reportprogress 300 -work correlator prn_gen_tb.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/prn_gen.sv    +incdir+../verilog +incdir+$SUB_PATH/interfaces +incdir+$PATH_globalparam +incdir+$PATH_boardparam
# vlog -quiet -reportprogress 300 -work correlator ../verilog/time_scale.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces

# interface
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/intbus_interf.sv
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/regs_file.sv

# run
quit -sim
vsim -novopt correlator.prn_gen_tb
do wave/prn_gen_tb.do
run 2 us
