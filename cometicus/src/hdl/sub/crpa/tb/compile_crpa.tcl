# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/cov_matrix_tb.sv
# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/null_former_tb.sv
# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/crpa_tb.sv +incdir+$THIS_PATH/../verilog +incdir+$SUB_PATH/interfaces

# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/../verilog/cov_matrix.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces
# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/../verilog/macc2.sv
# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/../verilog/delays_array.sv
# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/../verilog/mult.sv
# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/../verilog/fir.sv
# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/../verilog/null_former.sv +incdir+$SUB_PATH/interfaces
# vlog -quiet -reportprogress 300 -work $WORK_LIB $THIS_PATH/../verilog/crpa.sv +incdir+$SUB_PATH/interfaces

set contents [glob $THIS_PATH/../verilog/*.sv]

foreach item $contents {
    vlog -quiet -reportprogress 300 -work $WORK_LIB $item \
    +incdir+$THIS_PATH/../verilog \
    +incdir+$PATH_globalparam \
    +incdir+$PATH_boardparam \
    +incdir+$SUB_PATH/interfaces \
    +incdir+$SUB_PATH/dsp/verilog_sv \
    +incdir+$SUB_PATH/debug/verilog_sv
}