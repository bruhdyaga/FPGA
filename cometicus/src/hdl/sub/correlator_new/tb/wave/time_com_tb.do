onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /time_com_tb/BASEADDR
add wave -noupdate -group tb /time_com_tb/pclk
add wave -noupdate -group tb /time_com_tb/aclk
add wave -noupdate -group tb /time_com_tb/aresetn
add wave -noupdate -group tb /time_com_tb/presetn
add wave -noupdate -group tb /time_com_tb/fix_pulse
add wave -noupdate -group tb /time_com_tb/epoch_pulse
add wave -noupdate -group bus /time_com_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /time_com_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /time_com_tb/bus/clk
add wave -noupdate -group bus /time_com_tb/bus/resetn
add wave -noupdate -group bus /time_com_tb/bus/addr
add wave -noupdate -group bus /time_com_tb/bus/wdata
add wave -noupdate -group bus /time_com_tb/bus/rdata
add wave -noupdate -group bus /time_com_tb/bus/rvalid
add wave -noupdate -group bus /time_com_tb/bus/wr
add wave -noupdate -group bus /time_com_tb/bus/rd
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/BASEADDR
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/NPULSE
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/clk
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/resetn
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/trig_facq
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/trig_pps
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/epoch_pulse
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/sec_pulse
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/fix_pulse
add wave -noupdate -expand -group time_com -expand -subitemconfig {/time_com_tb/TIME_COM/PL.TM_TRIG_PPS -expand} /time_com_tb/TIME_COM/PL
add wave -noupdate -expand -group time_com -expand -subitemconfig {/time_com_tb/TIME_COM/PS.PPS_CFG -expand} /time_com_tb/TIME_COM/PS
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/T
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/do_rqst
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/eph_rqst
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/trig_pps_clean
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/eph_apply
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/apply
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/eph_set
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/week_pulse
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/epch_cntr
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/pps_len
add wave -noupdate -expand -group time_com -radix unsigned -radixshowbase 0 /time_com_tb/TIME_COM/pps_dly_cntr
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/pps_10_cntr
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/pps_done
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/set_pps
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/rst_pps
add wave -noupdate -expand -group time_com /time_com_tb/TIME_COM/pps_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {407451660 ps} 0} {{Cursor 2} {397764620 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 300
configure wave -valuecolwidth 108
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
WaveRestoreZoom {332139620 ps} {463389620 ps}
