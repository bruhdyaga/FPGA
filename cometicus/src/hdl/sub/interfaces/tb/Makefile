SRC_PATH := ../../..
WORK_LIB := cpu_lib

GUI ?= 0
VSIM_ARGS := -c

ifeq (${GUI}, 0)
	VSIM_ARGS=-c
else
	VSIM_ARGS=
endif

SRC_FILE := $(SRC_PATH)/sub/interfaces/intbus_interf.sv \
            $(SRC_PATH)/sub/interfaces/regs_file.sv \
            $(SRC_PATH)/sub/interfaces/axi3_interface.sv \
            $(SRC_PATH)/sub/interfaces/axi3_to_inter.sv \
            $(SRC_PATH)/sub/interfaces/cpu_sim.sv \
            $(SRC_PATH)/sub/interfaces/tb/c/multi_cpu_tb.c \
            $(SRC_PATH)/sub/interfaces/axi_rw.c

INC_DIR := +incdir+$(SRC_PATH)/verilog/ \
	   +incdir+$(SRC_PATH)/verilog/clonicus \
	   +incdir+$(SRC_PATH)/sub/interfaces

all: clean compile sim

compile : ${SRC_FILE} work
	vlog -sv ${SRC_FILE} ${INC_DIR} -work ${WORK_LIB} -ccflags "-g -std=c99" -dpiheader cpu_sim.h multi_cpu_tb.sv

work:
	vlib ${WORK_LIB}

sim:
	vsim ${VSIM_ARGS} -vopt -voptargs="+acc" ${WORK_LIB}.multi_cpu_tb -do "run 1us"

clean:
	rm -rf ${WORK_LIB} cpu_sim.h transcript
