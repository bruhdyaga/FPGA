do compile.tcl

vsim -novopt tb.tb
do tmp/run.tcl
quit -f
