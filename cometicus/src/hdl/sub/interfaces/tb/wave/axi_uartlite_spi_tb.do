onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/BASEADDR
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/AXI_UARTLITE_SPI_0_BASE_ADDR
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/AXI_UARTLITE_SPI_1_BASE_ADDR
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/ADDR_WIDTH
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/DATA_WIDTH
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/clk
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/resetn
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/addr
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/wdata
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/rdata
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/rvalid
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/wr
add wave -noupdate -expand -group tb -expand -group bus /axi_uartlite_spi_tb/bus/rd
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/rdata
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/aclk
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/pclk
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/presetn
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/aresetn
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/uart_lite_irq
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/spi_clk_out_0
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/spi_cs_out_0
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/spi_data_out_0
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/spi_clk_out_1
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/spi_cs_out_1
add wave -noupdate -expand -group tb /axi_uartlite_spi_tb/spi_data_out_1
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/BASEADDR
add wave -noupdate -expand -group UART_0 -radix unsigned /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/FIFO_SIZE
add wave -noupdate -expand -group UART_0 -radix unsigned /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/FIFO_ADDR_BITS
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_clk
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/irq
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/spi_clk_out
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/spi_cs_out
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/spi_data_out
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/spi_clk_in
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/spi_cs_in
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/spi_data_in
add wave -noupdate -expand -group UART_0 -radix unsigned /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_cntr_wr
add wave -noupdate -expand -group UART_0 -radix unsigned /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_cntr_rd
add wave -noupdate -expand -group UART_0 -radix unsigned /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_next_wr
add wave -noupdate -expand -group UART_0 -radix unsigned /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_cntr_wr
add wave -noupdate -expand -group UART_0 -radix unsigned /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_cntr_rd
add wave -noupdate -expand -group UART_0 -radix unsigned /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_next_wr
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/TxFIFO_EMPTY_asy
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/TxFIFO_EMPTY_syncpu
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/TxFIFO_EMPTY_syntx
add wave -noupdate -expand -group UART_0 -childformat {{{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[15]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[14]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[13]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[12]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[11]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[10]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[9]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[8]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[7]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[6]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[5]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[4]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[3]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[2]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[1]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[0]} -radix unsigned}} -expand -subitemconfig {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[15]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[14]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[13]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[12]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[11]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[10]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[9]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[8]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[7]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[6]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[5]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[4]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[3]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[2]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[1]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo[0]} {-radix unsigned}} /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_fifo
add wave -noupdate -expand -group UART_0 -childformat {{{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[15]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[14]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[13]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[12]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[11]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[10]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[9]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[8]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[7]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[6]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[5]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[4]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[3]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[2]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[1]} -radix unsigned} {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[0]} -radix unsigned}} -expand -subitemconfig {{/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[15]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[14]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[13]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[12]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[11]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[10]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[9]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[8]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[7]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[6]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[5]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[4]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[3]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[2]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[1]} {-radix unsigned} {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo[0]} {-radix unsigned}} /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_fifo
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/irq_rx
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/irq_tx
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_reg
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_reg
add wave -noupdate -expand -group UART_0 -radix unsigned -radixshowbase 0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_shift_cntr
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_reg_upd
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/tx_shift
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/RxFIFO_EMPTY_asy
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/RxFIFO_EMPTY_syncpu
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/rx_reg_upd
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/resetn_spi_in
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/resetn_spi_out
add wave -noupdate -expand -group UART_0 -expand -subitemconfig {/axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/PL.STAT -expand} /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/PL
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/PS
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/bus_wr
add wave -noupdate -expand -group UART_0 /axi_uartlite_spi_tb/axi_uartlite_spi_0_inst/bus_rd
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/BASEADDR
add wave -noupdate -group UART_1 -radix unsigned -radixshowbase 0 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/FIFO_SIZE
add wave -noupdate -group UART_1 -radix unsigned -radixshowbase 0 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/FIFO_ADDR_BITS
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/irq
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/spi_clk_out
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/spi_cs_out
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/spi_data_out
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/spi_clk_in
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/spi_cs_in
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/spi_data_in
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/PL
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/PS
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/bus_wr
add wave -noupdate -group UART_1 /axi_uartlite_spi_tb/axi_uartlite_spi_1_inst/bus_rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4873870 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 386
configure wave -valuecolwidth 177
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {15750080 ps}
