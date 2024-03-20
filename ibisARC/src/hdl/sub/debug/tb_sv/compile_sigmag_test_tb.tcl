set STANDALONE_PATH "d:/my_git/subs/c_tests/sigmag_test"
set LIBDEBUG_PATH "../../../../libdebug"
# set LIBFACQ_PATH "d:/my_git/subs/c_tests/libfacq"
set SUB_PATH "../.."

# сносим временный котел компиляции
file delete -force tmp_compile

quit -sim
file delete -force debug

# создаем временный котел компиляции
file mkdir tmp_compile
file mkdir tmp_compile/libdebug

vlib debug
# удаляем библиотеку для полной пересборки
vdel -all -lib debug

# CPU
# копируем все исходники в котел для компиляции
file copy -force $STANDALONE_PATH/src/sigmag_test_tb.c                  tmp_compile/
file copy -force $STANDALONE_PATH/inc/sigmag_test_tb.h                  tmp_compile/
file copy -force $SUB_PATH/interfaces/matlab/ID_DB.h                 tmp_compile/libdebug/
file copy -force $LIBDEBUG_PATH/src/axi_rw.c                         tmp_compile/
file copy -force $LIBDEBUG_PATH/src/sigmag_test.c                           tmp_compile/
file copy -force $LIBDEBUG_PATH/include/libdebug/axi_rw.h             tmp_compile/libdebug/
file copy -force $LIBDEBUG_PATH/include/libdebug/sigmag_test.h               tmp_compile/libdebug/
file copy -force $SUB_PATH/interfaces/global.h                       tmp_compile/libdebug/

vlog -quiet -reportprogress 300 -work debug $SUB_PATH/interfaces/cpu_sim.sv \
tmp_compile/sigmag_test_tb.c \
tmp_compile/axi_rw.c \
tmp_compile/sigmag_test.c

# debug
vlog -quiet -reportprogress 300 -work debug sigmag_test_tb.sv +incdir+../verilog_sv +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work debug ../verilog_sv/sigmag_test.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces

# interface
vlog -quiet -reportprogress 300 -work debug $SUB_PATH/interfaces/adc_interf.sv
vlog -quiet -reportprogress 300 -work debug $SUB_PATH/interfaces/intbus_interf.sv
vlog -quiet -reportprogress 300 -work debug $SUB_PATH/interfaces/regs_file.sv
vlog -quiet -reportprogress 300 -work debug $SUB_PATH/interfaces/axi3_interface.sv
vlog -quiet -reportprogress 300 -work debug $SUB_PATH/interfaces/axi3_to_inter.sv

# sync
vlog -quiet -reportprogress 300 -work debug $SUB_PATH/sync/verilog/level_sync.v
vlog -quiet -reportprogress 300 -work debug $SUB_PATH/sync/verilog/signal_sync.v
vlog -quiet -reportprogress 300 -work debug $SUB_PATH/sync/verilog/ed_det.v

# run
quit -sim
vsim -novopt debug.sigmag_test_tb
do wave/sigmag_test_tb.do
run 60 us
