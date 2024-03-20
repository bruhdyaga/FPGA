UNIT_PATH=../../verilog
TMP=tmp 

UNIT=$(UNIT_PATH)/CRPA.v

NAME=test
TEST=$(NAME).v
LOG_FILE=$(NAME).log

DEPS=$(UNIT_PATH)/CRPA_regs.v \
     $(UNIT_PATH)/BeamFormer.v \
     $(UNIT_PATH)/NullFormer.v \
     $(UNIT_PATH)/fir_filter.v \
     $(UNIT_PATH)/delay_line.v   \
     $(UNIT_PATH)/Mult.v \
     ../../sub/dsp/verilog/piped_adder/piped_adder.v \
     ../../sub/dsp/verilog/piped_adder/piped_adder_stage.v \
     ../../sub/dsp/verilog/piped_adder/conv_reg.v \
     ../../sub/dsp/verilog/sig_mag_v2.v \
     $(UNIT_PATH)/cov_matrix.v  \
     $(UNIT_PATH)/delays_array.v \
     $(UNIT_PATH)/maccs_array.v \
     $(UNIT_PATH)/cvm_intrcnct_mux.v \
     $(UNIT_PATH)/cvm_intrcnct.v \
     $(UNIT_PATH)/macc2.v \
     ../../sub/sync/verilog/ed_det.v \
     ../../sub/sync/verilog/level_sync.v



SRC=$(UNIT) $(TEST) $(DEPS)

INC=../../verilog $(TMP) ../../sub/debug/tb ../../sub/dsp/verilog


.PHONY: all show batch compile clean

all: show

show: compile
	vsim -do ../Sub/show.tcl

batch: compile
	@ vsim -c -do ../Sub/batch.tcl >> $(LOG_FILE)
	@ for i in `ls tmp/*.txt`; do \
		cat $$i | sed 's/x/NaN/g' | sed 's/z/NaN/g' > tmp/tmp; \
		mv tmp/tmp $$i > /dev/null; \
	done

compile: tb
	@ if [ -f vlog.opt ]; then rm vlog.opt; fi
	@ for i in $(INC); do \
		echo "+incdir+$$i" >> vlog.opt; \
	done

	@ if [ -f compile.tcl ]; then rm -f compile.tcl; fi
	@ for i in $(SRC); do \
		echo "vlog -reportprogress 300 -work tb $$i" >> compile.tcl; \
	done

	@ if [ ! -d $(TMP) ]; then mkdir $(TMP); fi
	@ echo '[vlog]' > modelsim.ini
	@ echo 'OptionFile = vlog.opt' >> modelsim.ini

tb: delete-log
	@ if [ ! -d tb ]; then \
	    vsim -c -do ../Sub/lib.tcl >> $(LOG_FILE); \
	fi

batch-nc: compile-nc
	@ if [ -f ./tmp/run.tcl ]; then \
		echo "exit" >> ./tmp/run.tcl; \
	fi
	@ ncsim -nocopyright -input ./tmp/run.tcl tb >> $(LOG_FILE)
	@ for i in `ls tmp/*.txt`; do \
		cat $$i | sed 's/x/NaN/g' | sed 's/z/NaN/g' > tmp/tmp; \
		mv tmp/tmp $$i > /dev/null; \
	done

compile-nc: tb-nc
	@ if [ -f ncvlog.opt ]; then rm ncvlog.opt; fi
	@ for i in $(INC); do \
		echo "-incdir $$i" >> ncvlog.opt; \
	done

	@ for i in $(SRC); do \
		ncvlog -nocopyright -nowarn NONPRT -file ncvlog.opt -work tb $$i >> $(LOG_FILE); \
	done	
	@ ncelab -nocopyright -timescale '1ns/1ps' tb >> $(LOG_FILE)

tb-nc: delete-log
	@ if [ ! -d tb-nc ]; then \
		mkdir tb-nc; \
	fi	
	@ if [ -f cds.lib ]; then rm cds.lib; fi	
	@ echo "DEFINE tb ./tb-nc" >> cds.lib;
	@ echo "" >> hdl.var;

delete-log:
	@ if [ -f $(LOG_FILE) ]; then rm $(LOG_FILE); fi

clean:
	rm -Rf *.txt transcript vsim.wlf tb tb-nc vlog.opt ncvlog.opt cds.lib hdl.var compile.tcl tmp modelsim.ini *.vstf $(LOG_FILE) *.log
