## Generated SDC file "top.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.1.1 Internal Build 593 12/11/2017 SJ Standard Edition"

## DATE    "Sat Jun 10 15:19:30 2023"

##
## DEVICE  "5CGXFC5C6F27C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 33.333 -waveform { 0.000 16.666 } [get_ports {altera_reserved_tck}]
create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {KEY0}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {KEY2}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX0[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX0[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX0[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX0[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX0[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX0[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX0[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX1[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX1[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX1[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX1[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX1[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX1[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX1[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX2[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX2[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX2[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX2[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX2[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX3[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX3[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX3[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX3[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX3[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX3[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.000 [get_ports {HEX3[6]}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

