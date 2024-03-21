set SUB_PATH         "../.."
set WORK_LIB         "calibration"
set PATH_interface   "$SUB_PATH/interfaces"
set PATH_sync        "$SUB_PATH/sync/verilog"
set PATH_facq        "$SUB_PATH/acquisition/verilog_sv"
set PATH_imi         "$SUB_PATH/imitator/verilog"
set PATH_dsp         "$SUB_PATH/dsp"
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

set THIS_PATH $PATH_dsp/tb/
do $PATH_dsp/tb/compile_dsp.tcl

vlog -quiet -reportprogress 300 -work $WORK_LIB $PATH_facq/DDS_sin_cos.sv \
+incdir+$PATH_facq \
+incdir+$PATH_interface \
+incdir+$PATH_globalparam \
+incdir+$PATH_boardparam


# CPU
# сносим временный котел компиляции
file delete -force tmp_compile
# создаем временный котел компиляции
file mkdir tmp_compile
# копируем все исходники в котел для компиляции
file copy -force $PATH_interface/matlab/ID_DB.h             tmp_compile/
file copy -force $PATH_interface/global.h                   tmp_compile/
file copy -force $PATH_interface/dpi_c/c/src/axi_rw_sim.c   tmp_compile/
file copy -force $PATH_interface/dpi_c/c/include/axi_rw.h   tmp_compile/
file copy -force c/calibration_tb.c                         tmp_compile/

vlog -quiet -reportprogress 300 -work $WORK_LIB calibration_tb.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces +incdir+$PATH_globalparam +incdir+$PATH_boardparam
vlog -quiet -reportprogress 300 -work $WORK_LIB ../../../verilog/test_streambus.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces

vlog -quiet -reportprogress 300 -work $WORK_LIB $PATH_interface/dpi_c/sv/cpu_sim.sv \
tmp_compile/calibration_tb.c \
tmp_compile/axi_rw_sim.c

# run
quit -sim
vsim -novopt $WORK_LIB.calibration_tb
do wave/calibration_tb.do
run 1.2 ms
