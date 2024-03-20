set SUB_PATH         "../.."
set WORK_LIB         "facq"
set PATH_interface   "$SUB_PATH/interfaces"
set PATH_correlator  "$SUB_PATH/correlator_new/verilog"
set PATH_dsp         "$SUB_PATH/dsp"
set PATH_sync        "$SUB_PATH/sync/verilog"
set PATH_globalparam "$SUB_PATH/../verilog"
set PATH_boardparam  "$PATH_globalparam/clonicus"

vlib $WORK_LIB
# удаляем библиотеку для полной пересборки
vdel -all -lib $WORK_LIB

set THIS_PATH $PATH_correlator
do $PATH_correlator/../tb/compile_correlator_new.tcl

set THIS_PATH $PATH_interface
do $PATH_interface/tb/compile_interfaces.tcl

set THIS_PATH $PATH_sync
do $PATH_sync/tb/compile_sync.tcl

# vlog -quiet -reportprogress 300 -work $WORK_LIB ../verilog/prn_gen_facq.sv +incdir+../verilog/ +incdir+$PATH_correlator +incdir+$PATH_interface +incdir+$PATH_boardparam +incdir+$PATH_globalparam
vlog -quiet -reportprogress 300 -work $WORK_LIB prn_gen_tb.sv +incdir+../verilog/ +incdir+$PATH_correlator +incdir+$PATH_interface +incdir+$PATH_boardparam +incdir+$PATH_globalparam

# run
quit -sim
vsim -novopt $WORK_LIB.prn_gen_tb
do wave/prn_gen_tb.do
run 200 us