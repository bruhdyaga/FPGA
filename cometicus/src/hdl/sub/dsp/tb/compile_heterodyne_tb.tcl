set SUB_PATH         "../.."
set WORK_LIB         "heterodyne"
set PATH_dsp         "$SUB_PATH/dsp"
set PATH_interface   "$SUB_PATH/interfaces"
set PATH_sync        "$SUB_PATH/sync/verilog"
set PATH_debug       "$SUB_PATH/debug"
set PATH_globalparam "$SUB_PATH/../verilog"
set PATH_boardparam  "$PATH_globalparam/octo_z706"

vlib $WORK_LIB
# удаляем библиотеку для полной пересборки
vdel -all -lib $WORK_LIB

set THIS_PATH $PATH_dsp/tb/
do compile_dsp.tcl

set THIS_PATH $PATH_interface
do $PATH_interface/tb/compile_interfaces.tcl

set THIS_PATH $PATH_sync
do $PATH_sync/tb/compile_sync.tcl

set THIS_PATH $PATH_debug/tb_sv/
do $PATH_debug/tb_sv/compile_debug.tcl

# CPU
# сносим временный котел компиляции
file delete -force tmp_compile
# создаем временный котел компиляции
file mkdir tmp_compile
# копируем все исходники в котел для компиляции
file copy -force $PATH_interface/matlab/ID_DB.h  tmp_compile/
file copy -force $PATH_interface/global.h        tmp_compile/
file copy -force $PATH_interface/axi_rw.c        tmp_compile/
file copy -force $PATH_interface/axi_rw.h        tmp_compile/
file copy -force c/test_heterodyne_tb.c          tmp_compile/

vlog -quiet -reportprogress 300 -work $WORK_LIB heterodyne_tb.sv +incdir+$PATH_dsp/verilog_sv
 # \
# +incdir+../verilog \
# +incdir+$SUB_PATH/interfaces \
# +incdir+$PATH_globalparam \
# +incdir+$PATH_boardparam



vlog -quiet -reportprogress 300 -work $WORK_LIB $PATH_interface/cpu_sim.sv \
tmp_compile/test_heterodyne_tb.c \
tmp_compile/axi_rw.c

# run
quit -sim
vsim -novopt $WORK_LIB.heterodyne_tb
do wave/heterodyne_tb.do
# run 5.2 us
run 50 us
