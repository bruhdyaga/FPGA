set contents [glob $THIS_PATH/../verilog/*/*.v $THIS_PATH/../verilog/*/*.sv $THIS_PATH/../verilog_sv/*.sv]

foreach item $contents {
    vlog -quiet -reportprogress 300 -work $WORK_LIB $item \
                            +incdir+$THIS_PATH/../verilog \
                            +incdir+$THIS_PATH/../verilog_sv \
                            +incdir+$PATH_globalparam \
                            +incdir+$PATH_boardparam \
                            +incdir+$SUB_PATH/interfaces \
                            +incdir+$SUB_PATH/debug/verilog_sv
}
