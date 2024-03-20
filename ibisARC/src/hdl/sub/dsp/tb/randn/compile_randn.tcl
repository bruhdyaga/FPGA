set contents [glob $THIS_PATH/verilog/randn/*.sv]

foreach item $contents {
    # vlog -quiet -reportprogress 300 -work $WORK_LIB $item +incdir+$THIS_PATH/verilog
    vlog -quiet -reportprogress 300 -work $WORK_LIB $item
}