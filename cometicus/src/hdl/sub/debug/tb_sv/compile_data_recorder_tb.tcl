set SUB_PATH         "../.."
set WORK_LIB         "debug"
set PATH_interface   "$SUB_PATH/interfaces"
set PATH_sync        "$SUB_PATH/sync/verilog"
set PATH_dsp         "$SUB_PATH/dsp"
set PATH_debug       "$SUB_PATH/debug"
set PATH_globalparam "$SUB_PATH/../verilog"
set PATH_boardparam  "$PATH_globalparam/octo_z706"

vlib $WORK_LIB
# удаляем библиотеку для полной пересборки
vdel -all -lib $WORK_LIB

set THIS_PATH $PATH_interface
do $PATH_interface/tb/compile_interfaces.tcl

set THIS_PATH $PATH_sync
do $PATH_sync/tb/compile_sync.tcl

set THIS_PATH $PATH_dsp/tb/
do $PATH_dsp/tb/compile_dsp.tcl

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
file copy -force c/data_recorder_tb.c            tmp_compile/

# debug
vlog -quiet -reportprogress 300 -work debug data_recorder_tb.sv +incdir+../verilog_sv +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work debug ../verilog_sv/data_recorder.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces
# vlog -quiet -reportprogress 300 -work debug ../verilog/bram_block_v2.v +incdir+$SUB_PATH/dsp/verilog

vlog -quiet -reportprogress 300 -work $WORK_LIB $PATH_interface/cpu_sim.sv \
tmp_compile/data_recorder_tb.c \
tmp_compile/axi_rw.c

# run
quit -sim
vsim -novopt debug.data_recorder_tb
do wave/data_recorder_tb.do
run 25 us
