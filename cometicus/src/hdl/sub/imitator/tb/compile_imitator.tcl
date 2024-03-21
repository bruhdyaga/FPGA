set contents [glob $THIS_PATH/*.v $THIS_PATH/*.sv]

foreach item $contents {
    vlog -quiet -reportprogress 300 -work $WORK_LIB $item \
    +incdir+$PATH_correlator/verilog \
    +incdir+$PATH_interface \
    +incdir+$PATH_dsp/verilog_sv \
    +incdir+$PATH_globalparam \
    +incdir+$PATH_boardparam
}