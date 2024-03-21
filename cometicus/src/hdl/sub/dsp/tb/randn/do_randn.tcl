set SUB_PATH         "../../.."
set WORK_LIB         "randn"
set PATH_dsp         "$SUB_PATH/dsp"
set PATH_sync        "$SUB_PATH/sync/verilog"
# set PATH_globalparam "$SUB_PATH/../verilog"
# set PATH_boardparam  "$PATH_globalparam/clonicus"


# удаляем библиотеку для полной пересборки
vlib $WORK_LIB
vdel -all -lib $WORK_LIB

vlib $WORK_LIB

set THIS_PATH $PATH_sync
do $PATH_sync/tb/compile_sync.tcl

set THIS_PATH $PATH_dsp
do $PATH_dsp/tb/randn/compile_randn.tcl

# set THIS_PATH $PATH_sync
# do $PATH_sync/tb/compile_sync.tcl

vlog -quiet -reportprogress 300 -work $WORK_LIB randn_tb.v

# run
quit -sim
vsim -novopt $WORK_LIB.randn_tb
do wave/randn_tb.do
run 5 us
