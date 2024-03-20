set SUB_PATH         "../.."
set WORK_LIB         "interfaces"
set PATH_interface   "$SUB_PATH/interfaces"
set PATH_sync        "$SUB_PATH/sync/verilog"
set PATH_globalparam "$SUB_PATH/../verilog"
set PATH_boardparam  "$PATH_globalparam/clonicus"

vlib $WORK_LIB
# удаляем библиотеку для полной пересборки
vdel -all -lib $WORK_LIB

set THIS_PATH "../"
do compile_interfaces.tcl

set THIS_PATH $PATH_sync
do $PATH_sync/tb/compile_sync.tcl

vlog -quiet -reportprogress 300 -work $WORK_LIB axi3_to_inter_tb.sv \
+incdir+../verilog \
+incdir+$SUB_PATH/interfaces \
+incdir+$PATH_globalparam \
+incdir+$PATH_boardparam

# run
quit -sim
vsim -novopt $WORK_LIB.axi3_to_inter_tb
do wave/axi3_to_inter_tb.do
run 17 us
