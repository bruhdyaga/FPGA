SRC_PATH := ../../..
WORK_LIB := dsp_lib

GUI ?= 0
RUN ?= 50 us
VSIM_ARGS :=
WAVE_ARGS :=
VOPT_ARGS :=

ifeq (${GUI}, 0)
	VSIM_ARGS=-c
else
	WAVE_ARGS=-do "wave/normalizer.do"
	VOPT_ARGS=-voptargs="+acc"
endif

CPP_FILE := $(SRC_PATH)/../libgennav/src/rgb.cpp
CPP_INC := $(SRC_PATH)/../libgennav/include

SRC_FILE := $(SRC_PATH)/sub/interfaces/intbus_interf.sv \
            $(SRC_PATH)/sub/interfaces/regs_file.sv \
            $(SRC_PATH)/sub/interfaces/axi3_interface.sv \
            $(SRC_PATH)/sub/interfaces/axi3_to_inter.sv \
            $(SRC_PATH)/sub/interfaces/cpu_sim.sv \
            $(SRC_PATH)/sub/interfaces/axi_rw.c \
            $(SRC_PATH)/sub/dsp/tb/c/normalizer.c \
            $(SRC_PATH)/sub/dsp/verilog_sv/normalizer.sv \
            $(SRC_PATH)/sub/dsp/verilog_sv/dds_iq_hd.sv \
            $(SRC_PATH)/sub/debug/verilog_sv/data_collector.sv \
            $(SRC_PATH)/sub/debug/verilog/bram_block_v2.v \
            $(SRC_PATH)/sub/sync/verilog/conv_reg.sv \
            $(SRC_PATH)/sub/sync/verilog/signal_sync.sv \
            $(SRC_PATH)/sub/sync/verilog/level_sync.sv \
            $(SRC_PATH)/sub/sync/verilog/ed_det.sv

INC_DIR := +incdir+$(SRC_PATH)/verilog/ \
           +incdir+$(SRC_PATH)/verilog/clonicus \
           +incdir+$(SRC_PATH)/sub/interfaces \
           +incdir+$(SRC_PATH)/sub/dsp/verilog_sv \
           +incdir+$(SRC_PATH)/sub/dsp/verilog

all: clean compile sim

compile : ${SRC_FILE} work
	vlog -sv ${SRC_FILE} ${INC_DIR} -work ${WORK_LIB} -ccflags "-g -std=c99" -ccflags "-I${SRC_PATH}/sub/interfaces" \
	-dpiheader cpu_sim.h normalizer_tb.sv

compile_cpp:
	vlog ${CPP_FILE} -ccflags "-I${CPP_INC}"

work:
	vlib ${WORK_LIB}

sim:
	vsim ${VSIM_ARGS} -vopt ${VOPT_ARGS} ${WORK_LIB}.normalizer_tb ${WAVE_ARGS} -do "run ${RUN}"

clean:
	rm -rf ${WORK_LIB} cpu_sim.h transcript
