UNIT_PATH=../../verilog
TMP=tmp 

UNIT=$(UNIT_PATH)/NFBF_wrapper.v

TEST=test.v

DEPS=$(UNIT_PATH)/NullFormer_n.v \
     $(UNIT_PATH)/kix_filter_n.v \
     $(UNIT_PATH)/delay_line.v   \
     $(UNIT_PATH)/multi_sum_n.v  \
     $(UNIT_PATH)/sum_1_step_n.v \
     $(UNIT_PATH)/conv_reg_n.v   \
     $(UNIT_PATH)/Mult.v \
     $(UNIT_PATH)/cov_matrix.v \
     $(UNIT_PATH)/macc_ctrl.v \
     $(UNIT_PATH)/macc.v \
     $(UNIT_PATH)/MUX_CVM.v

SRC=$(UNIT) $(TEST) $(DEPS)

INC=../../verilog $(TMP)


.PHONY: all show batch compile clean

all: show

show: compile
	vsim -do ../Sub/show.tcl

batch: compile
	@ vsim -c -do ../Sub/batch.tcl > /dev/null
	@ for i in `ls tmp/*.txt`; do \
		cat $$i | sed 's/[xXzZ]/NaN/g' > tmp/tmp; \
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

tb:
	@ if [ ! -d tb ]; then \
	    vsim -c -do ../Sub/lib.tcl > /dev/null; \
	fi

clean:
	rm -Rf *.txt transcript vsim.wlf tb vlog.opt compile.tcl tmp modelsim.ini
