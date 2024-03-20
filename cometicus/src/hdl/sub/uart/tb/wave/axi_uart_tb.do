onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /axi_uart_tb/BASEADDR
add wave -noupdate -expand -group tb /axi_uart_tb/AXI_UART_0_BASE_ADDR
add wave -noupdate -expand -group tb /axi_uart_tb/AXI_UART_1_BASE_ADDR
add wave -noupdate -expand -group tb /axi_uart_tb/rdata
add wave -noupdate -expand -group tb /axi_uart_tb/aclk
add wave -noupdate -expand -group tb /axi_uart_tb/pclk
add wave -noupdate -expand -group tb /axi_uart_tb/presetn
add wave -noupdate -expand -group tb /axi_uart_tb/aresetn
add wave -noupdate -expand -group tb /axi_uart_tb/uart_irq
add wave -noupdate -expand -group tb /axi_uart_tb/srach_cntr
add wave -noupdate -expand -group tb /axi_uart_tb/srach
add wave -noupdate -expand -group tb /axi_uart_tb/tx
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/BASEADDR
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/DATA_WIDTH
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/FIFO_SIZE
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/FIFO_ADDR_BITS
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/DATA_WIDTH
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/clk
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/resetn
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/s_axis_tdata
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/s_axis_tvalid
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/s_axis_tready
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/m_axis_tdata
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/m_axis_tvalid
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/m_axis_tready
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/DATA_WIDTH
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/clk
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/resetn
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/s_axis_tdata
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/s_axis_tvalid
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/s_axis_tready
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/txd
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/busy
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/prescale
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/s_axis_tready_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/txd_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/busy_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/data_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/prescale_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group tx /axi_uart_tb/axi_uart_0_inst/UART/uart_tx_inst/bit_cnt
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/DATA_WIDTH
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/clk
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/resetn
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/m_axis_tdata
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/m_axis_tvalid
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/m_axis_tready
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/rxd
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/busy
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/overrun_error
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/frame_error
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/prescale
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/m_axis_tdata_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/m_axis_tvalid_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/rxd_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/busy_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/overrun_error_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/frame_error_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/data_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/prescale_reg
add wave -noupdate -expand -group uart_0 -group uart -expand -group rx /axi_uart_tb/axi_uart_0_inst/UART/uart_rx_inst/bit_cnt
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/rxd
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/txd
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/tx_busy
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/rx_busy
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/rx_overrun_error
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/rx_frame_error
add wave -noupdate -expand -group uart_0 -group uart /axi_uart_tb/axi_uart_0_inst/UART/prescale
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/irq
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/tx
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/rx
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/tx_ready
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/rx_full
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/prescale
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/rx_syn
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/tx_ready_syn
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/rx_reset
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/tx_reset
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/tx_fifo
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/rx_fifo
add wave -noupdate -expand -group uart_0 -radix unsigned /axi_uart_tb/axi_uart_0_inst/rx_cntr_depth
add wave -noupdate -expand -group uart_0 -radix unsigned /axi_uart_tb/axi_uart_0_inst/tx_cntr_rd
add wave -noupdate -expand -group uart_0 -radix unsigned /axi_uart_tb/axi_uart_0_inst/tx_cntr_wr
add wave -noupdate -expand -group uart_0 -radix unsigned /axi_uart_tb/axi_uart_0_inst/tx_next_wr
add wave -noupdate -expand -group uart_0 -radix unsigned /axi_uart_tb/axi_uart_0_inst/rx_cntr_rd
add wave -noupdate -expand -group uart_0 -radix unsigned /axi_uart_tb/axi_uart_0_inst/rx_cntr_wr
add wave -noupdate -expand -group uart_0 -radix unsigned /axi_uart_tb/axi_uart_0_inst/rx_next_wr
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/irq_rx
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/irq_tx
add wave -noupdate -expand -group uart_0 -radix unsigned /axi_uart_tb/axi_uart_0_inst/irq_tx_cntr
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/irq_tx_dly
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/RxFIFO_EMPTY
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/TxFIFO_EMPTY
add wave -noupdate -expand -group uart_0 -subitemconfig {/axi_uart_tb/axi_uart_0_inst/PL.STAT -expand} /axi_uart_tb/axi_uart_0_inst/PL
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/PS
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/bus_wr
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/bus_rd
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/s_axis_tvalid
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/s_axis_tready
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/tx_busy
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/rx_busy
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/m_axis_tdata
add wave -noupdate -expand -group uart_0 /axi_uart_tb/axi_uart_0_inst/m_axis_tvalid
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/BASEADDR
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/DATA_WIDTH
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/FIFO_SIZE
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/FIFO_ADDR_BITS
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/irq
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx_reset
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx_reset
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx_fifo
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx_fifo
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx_ready
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx_full
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/prescale
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx_ready_syn
add wave -noupdate -group uart_1 -radix unsigned /axi_uart_tb/axi_uart_1_inst/rx_cntr_depth
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx_cntr_rd
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx_cntr_wr
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx_next_wr
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx_cntr_rd
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx_cntr_wr
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx_next_wr
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/irq_rx
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/irq_tx
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/RxFIFO_EMPTY
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/TxFIFO_EMPTY
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/s_axis_tvalid
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/PL
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/PS
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/bus_wr
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/bus_rd
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx_syn
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/m_axis_tdata
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/s_axis_tready
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/m_axis_tvalid
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/tx_busy
add wave -noupdate -group uart_1 /axi_uart_tb/axi_uart_1_inst/rx_busy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1781186 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 464
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
WaveRestoreZoom {187531250 ps} {200656250 ps}
