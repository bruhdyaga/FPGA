set SUB_PATH "../.."
set WORK_LIB "correlator"
set PATH_correlator "$SUB_PATH/correlator_new/verilog"
set PATH_interface "$SUB_PATH/interfaces"
set PATH_sync      "$SUB_PATH/sync/verilog"
set PATH_globalparam "$SUB_PATH/../verilog"
set PATH_boardparam  "$PATH_globalparam/clonicus"

vlib $WORK_LIB
# удаляем библиотеку для полной пересборки
vdel -all -lib $WORK_LIB

set THIS_PATH "../verilog"
do compile_correlator_new.tcl

set THIS_PATH $PATH_interface
do $PATH_interface/tb/compile_interfaces.tcl

set THIS_PATH $PATH_sync
do $PATH_sync/tb/compile_sync.tcl

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
file copy -force c/prn_ram_tb.c                 tmp_compile/

vlog -quiet -reportprogress 300 -work $WORK_LIB prn_ram_tb.sv +incdir+$PATH_globalparam +incdir+$PATH_boardparam +incdir+$PATH_correlator +incdir+$PATH_interface

vlog -quiet -reportprogress 300 -work $WORK_LIB $PATH_interface/cpu_sim.sv \
tmp_compile/prn_ram_tb.c \
tmp_compile/axi_rw.c

# run
quit -sim
vsim -novopt $WORK_LIB.prn_ram_tb
do wave/prn_ram_tb.do
run 50 us
