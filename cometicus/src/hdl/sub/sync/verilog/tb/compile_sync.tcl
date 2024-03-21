set contents [glob $THIS_PATH/*.sv]

foreach item $contents {
    vlog -quiet -reportprogress 300 -work $WORK_LIB $item
}