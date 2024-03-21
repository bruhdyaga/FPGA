set SUB_PATH         "../../../sub"
set WORK_LIB         "dsp"
set PATH_dsp         "$SUB_PATH/dsp"
# set PATH_facq        "$SUB_PATH/acquisition"
set PATH_interface   "$SUB_PATH/interfaces"
# set PATH_correlator  "$SUB_PATH/correlator_new"
set PATH_sync        "$SUB_PATH/sync/verilog"
# set PATH_debug       "$SUB_PATH/debug"
set PATH_globalparam "$SUB_PATH/../verilog"
set PATH_boardparam  "$PATH_globalparam/clonicus"
# set LIBFACQ_PATH     "../../../../libfacq"

vlib $WORK_LIB
# удаляем библиотеку для полной пересборки
vdel -all -lib $WORK_LIB

# set THIS_PATH $PATH_facq/tb_sv/
# do $PATH_facq/tb_sv/compile_facq.tcl

# set THIS_PATH $PATH_correlator/verilog/
# do $PATH_correlator/tb/compile_correlator_new.tcl

set THIS_PATH $PATH_dsp/tb/
do $PATH_dsp/tb/compile_dsp.tcl

set THIS_PATH $PATH_interface
do $PATH_interface/tb/compile_interfaces.tcl

set THIS_PATH $PATH_sync
do $PATH_sync/tb/compile_sync.tcl

# set THIS_PATH $PATH_debug/tb_sv/
# do $PATH_debug/tb_sv/compile_debug.tcl

# CPU
# сносим временный котел компиляции
file delete -force tmp_compile
# создаем временный котел компиляции
file mkdir tmp_compile
# копируем все исходники в котел для компиляции
file copy -force c/dsp_lut_iq_tb.c              tmp_compile/
file copy -force $PATH_interface/axi_rw.c       tmp_compile/
file copy -force $PATH_interface/axi_rw.h       tmp_compile/

# tb
# file copy -force ../sub/acquisition/matlab/acq_test_signal/sig_I.txt ../sub/acquisition/tb_sv/
vlog -quiet -reportprogress 300 -work $WORK_LIB dsp_lut_iq_tb.sv \
+incdir+../verilog_sv \
+incdir+$SUB_PATH/interfaces/ \
+incdir+$PATH_globalparam \
+incdir+$PATH_boardparam


vlog -quiet -reportprogress 300 -work $WORK_LIB $SUB_PATH/interfaces/cpu_sim.sv \
tmp_compile/dsp_lut_iq_tb.c \
tmp_compile/axi_rw.c

# acq
quit -sim
vsim -novopt $WORK_LIB.dsp_lut_iq_tb
do wave/dsp_lut_iq_tb.do
run 35 us
