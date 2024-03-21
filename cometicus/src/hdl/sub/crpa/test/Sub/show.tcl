do compile.tcl

vsim -novopt tb.tb

do wave.tcl

do tmp/run.tcl  # Длительность моделирования определяет Matlab
# run 100ns
