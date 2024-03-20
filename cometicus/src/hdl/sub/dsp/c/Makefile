CC=/usr/local/Vivado_2017_3/SDK/2017.3/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin/arm-xilinx-linux-gnueabi-g++

CFLAGS = -Wno-packed-bitfield-compat -Wno-attributes -O3 -g -lrt

SOURCES = vitdec_standalone_test.cpp

EXENAME = vitdec_standalone_test

all:
	$(CC) $(CFLAGS) $(SOURCES) -o $(EXENAME)