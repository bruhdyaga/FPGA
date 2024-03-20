set SUB_PATH         "../.."
set WORK_LIB         "imitator"
set PATH_correlator  "$SUB_PATH/correlator_new"
set PATH_interface   "$SUB_PATH/interfaces"
set PATH_sync        "$SUB_PATH/sync/verilog"
set PATH_facq        "$SUB_PATH/acquisition/verilog_sv"
set PATH_imi         "$SUB_PATH/imitator/verilog"
set PATH_debug       "$SUB_PATH/debug"
set PATH_dsp         "$SUB_PATH/dsp"
set PATH_globalparam "$SUB_PATH/../verilog"
set PATH_boardparam  "$PATH_globalparam/clonicus"

vlib $WORK_LIB
# удаляем библиотеку для полной пересборки
vdel -all -lib $WORK_LIB

set THIS_PATH ../verilog
do compile_imitator.tcl

set THIS_PATH $PATH_correlator/verilog
do $PATH_correlator/tb/compile_correlator_new.tcl

set THIS_PATH $PATH_dsp/tb
do $PATH_dsp/tb/compile_dsp.tcl

set THIS_PATH $PATH_debug/tb_sv/
do $PATH_debug/tb_sv/compile_debug.tcl

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
file copy -force $PATH_interface/matlab/ID_DB.h              tmp_compile/
file copy -force $PATH_interface/global.h                    tmp_compile/
file copy -force $PATH_interface/dpi_c/c/src/axi_rw_sim.c    tmp_compile/
file copy -force $PATH_interface/dpi_c/c/include/axi_rw.h    tmp_compile/
file copy -force c/imitator_tb.c                             tmp_compile/


set contents [glob $PATH_dsp/verilog_sv/dds_iq_hd_*.txt]

foreach item $contents {
    # vlog -quiet -reportprogress 300 -work $WORK_LIB $item +incdir+$PATH_correlator +incdir+$SUB_PATH/interfaces +incdir+$PATH_globalparam +incdir+$PATH_boardparam
    file copy -force $item ./
}

# file copy -force $PATH_dsp/verilog_sv/dds_iq_hd_ph9_iq_10.txt ./

vlog -quiet -reportprogress 300 -work $WORK_LIB imitator_tb.sv \
+incdir+../verilog \
+incdir+$SUB_PATH/interfaces \
+incdir+$PATH_globalparam \
+incdir+$PATH_boardparam \
+incdir+$PATH_facq \
+incdir+$PATH_dsp \
+incdir+$PATH_imi

# vlog -quiet -reportprogress 300 -work $WORK_LIB test_ocm_tb.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces +incdir+$PATH_globalparam +incdir+$PATH_boardparam
# vlog -quiet -reportprogress 300 -work $WORK_LIB ../../../verilog/test_streambus.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces

vlog -quiet -reportprogress 300 -work $WORK_LIB $PATH_interface/dpi_c/sv/cpu_sim.sv \
tmp_compile/imitator_tb.c \
tmp_compile/axi_rw_sim.c

# run
quit -sim
vsim -voptargs=+acc $WORK_LIB.imitator_tb
do wave/imitator_tb.do
run 10 ms
# run 2.1 ms
