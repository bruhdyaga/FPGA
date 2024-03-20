onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /crpa_tb/BASEADDR
add wave -noupdate -group tb /crpa_tb/pclk
add wave -noupdate -group tb /crpa_tb/aclk
add wave -noupdate -group tb /crpa_tb/inp_ram
add wave -noupdate -group tb -radix unsigned -radixshowbase 0 /crpa_tb/ram_cntr
add wave -noupdate -group tb /crpa_tb/aresetn
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/BASEADDR
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/CRPA_CH
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/NBUSES
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/NPULSE
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/BASEREG
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/CRPA_INTERCONNECT_BASE_ADDR
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/BASECVM
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/BASENULL
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/NULL_BUS_NUM
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/HETERODYNE_BASE_ADDR
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/HETERODYNE_BUS_NUM
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/IQ_WIDTH
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/PHASE_WIDTH
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/DATCOL_CRPA_BASE_ADDR
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/CRPA_DATCOLL_BUS_NUM
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/BASEADDR}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/WIDTH_DATA}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/WIDTH_COEF}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/IQ_WIDTH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/PHASE_WIDTH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/ORDER}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/NCH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR_CH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR_IN_WIDTH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/NBUSES}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/BASE_REGFILE}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR_BASE_ADDR}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/DATA_COLL_BASE_ADDR}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/DATACOLL_BUS_NUM}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/BASEADDR}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/WIDTH_IN_DATA}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/WIDTH_COEF}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/ORDER}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/NCH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/SYN_COEF}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/NPULSE}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/coef_mirr}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/sum}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/mul}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/A1_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/A2_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/B1_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/MIRR_COEF}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/M_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/P_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/PL}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/PS}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/bus_wr}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/FIR/coef_wr}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/PS}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/PL}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/sin}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_0 {/crpa_tb/CRPA/HETERODYNE_i[0]/HETERODYNE/cos}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/BASEADDR}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/WIDTH_DATA}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/WIDTH_COEF}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/IQ_WIDTH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/PHASE_WIDTH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/ORDER}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/NCH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR_CH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR_IN_WIDTH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/NBUSES}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/BASE_REGFILE}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR_BASE_ADDR}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/DATA_COLL_BASE_ADDR}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/DATACOLL_BUS_NUM}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/BASEADDR}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/WIDTH_IN_DATA}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/WIDTH_COEF}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/ORDER}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/NCH}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/SYN_COEF}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/NPULSE}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/coef_mirr}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/sum}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/mul}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/A1_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/A2_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/B1_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/MIRR_COEF}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/M_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/P_reg}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/PL}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/PS}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/bus_wr}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 -expand -group FIR {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/FIR/coef_wr}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/PS}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/PL}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/sin}
add wave -noupdate -expand -group CRPA -expand -group HETERODYNE_1 {/crpa_tb/CRPA/HETERODYNE_i[1]/HETERODYNE/cos}
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/ce
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/PL
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/PS
add wave -noupdate -expand -group CRPA /crpa_tb/CRPA/null_coef_mirr
add wave -noupdate -group bus /crpa_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /crpa_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /crpa_tb/bus/clk
add wave -noupdate -group bus /crpa_tb/bus/resetn
add wave -noupdate -group bus /crpa_tb/bus/addr
add wave -noupdate -group bus /crpa_tb/bus/wdata
add wave -noupdate -group bus /crpa_tb/bus/rdata
add wave -noupdate -group bus /crpa_tb/bus/rvalid
add wave -noupdate -group bus /crpa_tb/bus/wr
add wave -noupdate -group bus /crpa_tb/bus/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14817413 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 589
configure wave -valuecolwidth 182
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
WaveRestoreZoom {14766211 ps} {15012305 ps}
