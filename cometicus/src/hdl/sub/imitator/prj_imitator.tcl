#!/usr/bin/tclsh
#
# Vivado (TM) v2015.3 (64-bit)
#
# prj_imitator.tcl: Tcl script for re-creating project 'imitator'
#
# Generated by Vivado on Tue Mar 22 10:11:05 +0300 2016
# IP Build 1367837 on Mon Sep 28 08:56:14 MDT 2015
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir 		"."
set sub_dir 		"sub"
set prj_name 		"imitator"
set prj_dir_name 	"prj_imitator"
set topmodule_name 	"imitator_top"


# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

variable script_file
set script_file "prj_$prj_name.tcl"

# Help information for this script
proc help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < [llength $::argc]} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir" { incr i; set origin_dir [lindex $::argv $i] }
      "--help"       { help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Create project
create_project $prj_name ./$prj_dir_name

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects $prj_name]
set_property "default_lib" "xil_defaultlib" $obj
set_property "part" "xc7z045fbg676-2" $obj
set_property "sim.ip.auto_export_scripts" "1" $obj
set_property "simulator_language" "Mixed" $obj
set_property "source_mgmt_mode" "DisplayOnly" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/verilog/top/$topmodule_name.v"]"\
 "[file normalize "$origin_dir/verilog/imitator.v"]"\
 "[file normalize "$origin_dir/verilog/imitator_channel.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_regfile.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_param.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_delay_reg.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_sin_table.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_cos_table.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_synthesizer.v"]"\
 "[file normalize "$origin_dir/verilog/wiper.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/flag_sync.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/flag_sync_n.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/channel_shift_reg.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/time_generator.v"]"\
 "[file normalize "$origin_dir/$sub_dir/sync/verilog/signal_sync.v"]"\
 "[file normalize "$origin_dir/$sub_dir/sync/verilog/level_sync.v"]"\
 "[file normalize "$origin_dir/$sub_dir/dsp/verilog/randn/randn.v"]"\
 "[file normalize "$origin_dir/$sub_dir/dsp/verilog/randn/randn_u.v"]"\
 "[file normalize "$origin_dir/$sub_dir/dsp/verilog/piped_adder/piped_adder.v"]"\
 "[file normalize "$origin_dir/$sub_dir/dsp/verilog/piped_adder/piped_adder_stage.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
# None


# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "include_dirs" "$origin_dir/verilog $origin_dir/verilog/top" $obj
set_property "top" "$topmodule_name" $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
# It should exist! If Vivado doesn't found it, once will be generated
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "source_set" "" $obj
set_property "top" "$topmodule_name" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj


# =============== imichnl_synthesizer module test bench ====================
# Create 'sim_imichnl_synthesizer' fileset (if not found)
if {[string equal [get_filesets -quiet sim_imichnl_synthesizer] ""]} {
  create_fileset -simset sim_imichnl_synthesizer
}

set obj [get_filesets sim_imichnl_synthesizer]
set files [list \
	       "[file normalize "$origin_dir/tb/imichnl_synthesizer_tb.v"]"\
	       "[file normalize "$origin_dir/tb/imichnl_synthesizer_tb_behav.wcfg"]"\
	       "[file normalize "$origin_dir/verilog/imichnl_synthesizer.v"]"\
	       ]
add_files -norecurse -fileset $obj $files

# Set 'sim_imichnl_synthesizer' fileset properties
set obj [get_filesets sim_imichnl_synthesizer]
set_property "source_set" "" $obj
set_property "top" "imichnl_synthesizer_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "$origin_dir/tb/imichnl_synthesizer_tb_behav.wcfg" $obj
# ============ End of imichnl_synthesizer module test bench ====================



# =============== imitator_channel module test bench ====================
# Create 'sim_imitator_channel' fileset (if not found)
if {[string equal [get_filesets -quiet sim_imitator_channel] ""]} {
  create_fileset -simset sim_imitator_channel
}

set obj [get_filesets sim_imitator_channel]
set files [list \
 "[file normalize "$origin_dir/tb/imitator_channel_tb.v"]"\
 "[file normalize "$origin_dir/verilog/top/global_param.v"]"\
 "[file normalize "$origin_dir/verilog/imitator_channel.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_synthesizer.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_sin_table.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_param.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_regfile.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_cos_table.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_delay_reg.v"]"\
 "[file normalize "$origin_dir/verilog/wiper.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/flag_sync.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/flag_sync_n.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/time_generator.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/channel_shift_reg.v"]"\
 "[file normalize "$origin_dir/$sub_dir/sync/verilog/level_sync.v"]"\
 "[file normalize "$origin_dir/$sub_dir/sync/verilog/signal_sync.v"]"\
 "[file normalize "$origin_dir/tb/imitator_channel_tb_behav.wcfg"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_imitator_channel' fileset properties
set obj [get_filesets sim_imitator_channel]
set_property "include_dirs" "$origin_dir/verilog $origin_dir/verilog/top" $obj
set_property "runtime" "3000000ns" $obj
set_property "source_set" "" $obj
set_property "top" "imitator_channel_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.simulate.runtime" "3000000ns" $obj
set_property "xsim.view" "$origin_dir/tb/imitator_channel_tb_behav.wcfg" $obj
# ============ End of imitator_channel module test bench ====================


# =============== imitator module test bench ====================
# Create 'sim_imitator' fileset (if not found)
if {[string equal [get_filesets -quiet sim_imitator] ""]} {
  create_fileset -simset sim_imitator
}

set obj [get_filesets sim_imitator]
set files [list \
 "[file normalize "$origin_dir/tb/imitator/imitator_tb.v"]"\
 "[file normalize "$origin_dir/tb/imitator/global_param.v"]"\
 "[file normalize "$origin_dir/tb/imitator/imitator_tb_behav.wcfg"]"\
 "[file normalize "$origin_dir/verilog/imitator.v"]"\
 "[file normalize "$origin_dir/verilog/imitator_channel.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_regfile.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_param.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_delay_reg.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_sin_table.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_cos_table.v"]"\
 "[file normalize "$origin_dir/verilog/imichnl_synthesizer.v"]"\
 "[file normalize "$origin_dir/verilog/wiper.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/flag_sync.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/flag_sync_n.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/channel_shift_reg.v"]"\
 "[file normalize "$origin_dir/$sub_dir/correlator/verilog/time_generator.v"]"\
 "[file normalize "$origin_dir/$sub_dir/sync/verilog/signal_sync.v"]"\
 "[file normalize "$origin_dir/$sub_dir/sync/verilog/level_sync.v"]"\
 "[file normalize "$origin_dir/$sub_dir/dsp/verilog/randn/randn.v"]"\
 "[file normalize "$origin_dir/$sub_dir/dsp/verilog/randn/randn_u.v"]"\
 "[file normalize "$origin_dir/$sub_dir/dsp/verilog/piped_adder/piped_adder.v"]"\
 "[file normalize "$origin_dir/$sub_dir/dsp/verilog/piped_adder/piped_adder_stage.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_imitator' fileset properties
set obj [get_filesets sim_imitator]
set_property "include_dirs" "$origin_dir/verilog $origin_dir/tb/imitator" $obj
set_property "runtime" "3000000ns" $obj
set_property "source_set" "" $obj
set_property "top" "imitator_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.simulate.runtime" "3000000ns" $obj
set_property "xsim.view" "$origin_dir/tb/imitator/imitator_tb_behav.wcfg" $obj
# ============ End of imitator module test bench ====================


current_fileset -simset [ get_filesets sim_imitator_channel ]


# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7z045fbg676-2 -flow {Vivado Synthesis 2014} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2014" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property "part" "xc7z045fbg676-2" $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7z045fbg676-2 -flow {Vivado Implementation 2015} -strategy "Performance_Explore" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Performance_Explore" [get_runs impl_1]
  set_property flow "Vivado Implementation 2015" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property "part" "xc7z045fbg676-2" $obj
set_property "steps.opt_design.args.directive" "Explore" $obj
set_property "steps.place_design.args.directive" "Explore" $obj
set_property "steps.phys_opt_design.is_enabled" "1" $obj
set_property "steps.phys_opt_design.args.directive" "Explore" $obj
set_property "steps.route_design.args.directive" "Explore" $obj
set_property "steps.write_bitstream.args.readback_file" "0" $obj
set_property "steps.write_bitstream.args.verbose" "0" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:$prj_name"