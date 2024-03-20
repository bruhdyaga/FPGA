set contents [glob $THIS_PATH/*.v $THIS_PATH/*.sv $THIS_PATH/dpi_c/sv/*.sv]

puts "COMPILE"

foreach item $contents {
    # if {$item=="../dma_intbus_axi_hp.sv" || $item=="../stream_intbus.sv"} {
        # puts $item
        # puts "break"
        # continue
    # }
        vlog -quiet -reportprogress 300 -work $WORK_LIB $item +incdir+$PATH_globalparam +incdir+$PATH_boardparam
}