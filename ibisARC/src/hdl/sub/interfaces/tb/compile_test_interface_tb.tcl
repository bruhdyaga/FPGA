set SUB_PATH "../.."

vlib interface
# удаляем библиотеку для полной пересборки
vdel -all -lib interface

# interface
vlog -quiet -reportprogress 300 -work interface test_interface_tb.sv +incdir+../ +incdir+$SUB_PATH/correlator_systemverilog/verilog

vlog -quiet -reportprogress 300 -work interface ../intbus_interf.sv
vlog -quiet -reportprogress 300 -work interface ../regs_file.sv

# sync
vlog -quiet -reportprogress 300 -work interface $SUB_PATH/sync/verilog/level_sync.v
vlog -quiet -reportprogress 300 -work interface $SUB_PATH/sync/verilog/signal_sync.v
vlog -quiet -reportprogress 300 -work interface $SUB_PATH/sync/verilog/ed_det.v

# run
quit -sim
vsim -novopt interface.test_interface_tb
do wave/test_interface_tb.do
run 2 us
