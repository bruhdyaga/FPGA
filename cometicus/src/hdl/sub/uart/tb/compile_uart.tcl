set contents [glob $THIS_PATH/*.v $THIS_PATH/*.sv]

puts "COMPILE"

foreach item $contents {
        vlog -quiet -reportprogress 300 -work $WORK_LIB $item +incdir+$PATH_globalparam +incdir+$PATH_boardparam +incdir+$SUB_PATH/interfaces
}