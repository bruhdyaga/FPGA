set SUB_PATH "../.."

vlib correlator
# удаляем библиотеку для полной пересборки
vdel -all -lib correlator

# correlator
vlog -quiet -reportprogress 300 -work correlator irq_ctrl_tb.sv +incdir+../verilog +incdir+$SUB_PATH/interfaces
vlog -quiet -reportprogress 300 -work correlator ../verilog/irq_ctrl.sv   +incdir+../verilog +incdir+$SUB_PATH/interfaces

# interface
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/intbus_interf.sv
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/interfaces/regs_file.sv

# sync
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/level_sync.v
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/signal_sync.v
vlog -quiet -reportprogress 300 -work correlator $SUB_PATH/sync/verilog/ed_det.v

# run
quit -sim
vsim -novopt correlator.irq_ctrl_tb
do wave/irq_ctrl_tb.do
run 2 us
