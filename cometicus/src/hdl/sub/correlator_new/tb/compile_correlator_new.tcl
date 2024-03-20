set contents [glob $THIS_PATH/*.v $THIS_PATH/*.sv]

foreach item $contents {
    vlog -quiet -reportprogress 300 -work $WORK_LIB $item +incdir+$SUB_PATH/interfaces +incdir+$PATH_globalparam +incdir+$PATH_boardparam
}