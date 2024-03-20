# set STANDALONE_PATH "d:/my_git/subs/c_tests/facq"
# # set LIBFACQ_PATH "d:/my_git/subs/c_tests/libfacq"
# set SUB_PATH "../.."

set SUB_PATH         "../../../sub"
set WORK_LIB         "facq"
set PATH_dsp         "$SUB_PATH/dsp"
set PATH_facq        "$SUB_PATH/acquisition"
set PATH_interface   "$SUB_PATH/interfaces"
set PATH_correlator  "$SUB_PATH/correlator_new"
set PATH_sync        "$SUB_PATH/sync/verilog"
set PATH_debug       "$SUB_PATH/debug"
set PATH_globalparam "$SUB_PATH/../misc"
set PATH_boardparam  "$PATH_globalparam"
set LIBFACQ_PATH     "../../../../c/libfacq"

vlib $WORK_LIB
# удаляем библиотеку для полной пересборки
vdel -all -lib $WORK_LIB

set THIS_PATH $PATH_facq/tb_sv/
do $PATH_facq/tb_sv/compile_facq.tcl

set THIS_PATH $PATH_correlator/verilog/
do $PATH_correlator/tb/compile_correlator_new.tcl

set THIS_PATH $PATH_dsp/tb/
do $PATH_dsp/tb/compile_dsp.tcl

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
file copy -force c/src/acq_api_tb.c                                   tmp_compile/
file copy -force c/inc/acq_api_tb.h                                   tmp_compile/

file mkdir tmp_compile/libfacq/
file mkdir tmp_compile/libfacq/libfacq/

file copy -force $PATH_interface/dpi_c/c/src/axi_rw_sim.c             tmp_compile/libfacq/libfacq/
file copy -force $LIBFACQ_PATH/src/facq.c                             tmp_compile/libfacq/
file copy -force $LIBFACQ_PATH/src/psp_init_functions.c               tmp_compile/libfacq/
file copy -force $LIBFACQ_PATH/src/service_func.c                     tmp_compile/libfacq/
file copy -force $LIBFACQ_PATH/src/fsm.c                              tmp_compile/libfacq/

file copy -force $PATH_interface/dpi_c/c/include/axi_rw.h             tmp_compile/libfacq/libfacq/
file copy -force $LIBFACQ_PATH/include/libfacq/facq.h                 tmp_compile/libfacq/libfacq/
file copy -force $LIBFACQ_PATH/include/libfacq/signal_types.h         tmp_compile/libfacq/libfacq/
file copy -force $LIBFACQ_PATH/include/libfacq/service_func.h         tmp_compile/libfacq/libfacq/
file copy -force $LIBFACQ_PATH/include/libfacq/psp_init_functions.h   tmp_compile/libfacq/libfacq/
file copy -force $LIBFACQ_PATH/include/libfacq/fsm.h                  tmp_compile/libfacq/libfacq/
file copy -force $LIBFACQ_PATH/include/libfacq/ID_DB.h                tmp_compile/libfacq/libfacq/
file copy -force $LIBFACQ_PATH/include/libfacq/fsm_targets.h          tmp_compile/libfacq/libfacq/

# tb
# file copy -force ../sub/acquisition/matlab/acq_test_signal/sig_I.txt ../sub/acquisition/tb_sv/
vlog -quiet -work $WORK_LIB ila_0_stub.v
vlog -quiet -work $WORK_LIB vio_0_stub.v
vlog +define+SIMULATE -quiet -reportprogress 300 -work $WORK_LIB acq_api_tb.sv \
+incdir+../verilog_sv \
+incdir+$SUB_PATH/interfaces/ \
+incdir+$SUB_PATH/correlator_new/verilog/ \
+incdir+$PATH_debug/verilog_sv \
+incdir+$PATH_globalparam \
+incdir+$PATH_boardparam

vlog +define+SIM_SV -quiet -reportprogress 300 -work $WORK_LIB \
tmp_compile/libfacq/libfacq/axi_rw_sim.c \
tmp_compile/acq_api_tb.c \
tmp_compile/libfacq/facq.c \
tmp_compile/libfacq/psp_init_functions.c \
tmp_compile/libfacq/service_func.c \
tmp_compile/libfacq/fsm.c

# acq
quit -sim
vsim -voptargs=+acc $WORK_LIB.acq_api_tb

# run 6 ms

do wave/facq_api_tb.do
# run 1400 us
run 4.41 ms

WaveRestoreZoom {4125 us} {4400 us}
update