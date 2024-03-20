set contents [glob $THIS_PATH/../verilog_sv/*.sv]

foreach item $contents {
    vlog +define+SIMULATE -quiet -reportprogress 300 -work $WORK_LIB $item \
                            +incdir+$THIS_PATH/../verilog_sv \
                            +incdir+$SUB_PATH/interfaces \
                            +incdir+$PATH_correlator/verilog \
                            +incdir+$PATH_debug/verilog_sv \
                            +incdir+$PATH_globalparam \
                            +incdir+$PATH_boardparam
}
