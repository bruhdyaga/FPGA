#
# Tcl script for re-creating Vivado project
#

# Project settings
  set projectName         cometicus
  set part                xc7z045fbg676-2
  set srcPath             "../../src"
  set libraryDir          "c:/modelsimLib"

# Create project
  create_project ${projectName} ./ -part ${part}

# Set project directory
  set proj_dir [get_property DIRECTORY [current_project]]

# Set project properties
  set_property "default_lib"        "xil_defaultlib" [current_project]
  set_property "part"               "${part}"        [current_project]
  set_property "simulator_language" "Mixed"          [current_project]
  set_property "target_language"    "Verilog"        [current_project]

  set_property "target_simulator"                        "Modelsim"     [current_project]
  set_property "compxlib.modelsim_compiled_library_dir"  ${libraryDir}  [current_project]

# Create filesets (if not found)
  if {[string equal [get_filesets -quiet sources_1] ""]} {
    create_fileset -srcset sources_1
  }
  if {[string equal [get_filesets -quiet constrs_1] ""]} {
    create_fileset -srcset constrs_1
  }

# add source and constraints to corresponding fileset
  package require fileutil
  package require struct::set
  
  # set allfiles      [::fileutil::findByPattern ${srcPath}/hdl -glob {*.sv *.svh *.xci *.vhd}]
  # set matchedfiles  [::fileutil::findByPattern ${srcPath}/hdl -glob {tb.*}]
  # set source_files  [struct::set difference $allfiles $matchedfiles]
  # # puts ${sourcefiles}
  
  add_files -norecurse -fileset sources_1 ${srcPath}/hdl/cometicus.sv

  set constr_files [::fileutil::findByPattern ${srcPath}/hdl -glob {*.xdc}]

  # add_files -norecurse -fileset sources_1 ${source_files}
  add_files -norecurse -fileset constrs_1 ${constr_files}
  
# Extra source files #misc#
  set source_files [glob -directory ${srcPath}/hdl/misc -type f *.{v,sv,svh,xci,vhd}]
  add_files -norecurse -fileset sources_1 ${source_files}

# Extra source files #imitator#
  set source_files [glob -directory ${srcPath}/hdl/sub/imitator/verilog/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}

# Extra source files #sync#
  set source_files [glob -directory ${srcPath}/hdl/sub/sync/verilog/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}

# Extra source files #interfaces#
  set source_files [glob -directory ${srcPath}/hdl/sub/interfaces/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}

# Extra source files #acquisition#
  set source_files [glob -directory ${srcPath}/hdl/sub/acquisition/verilog_sv/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}

# Extra source files #correlator_new#
  set source_files [glob -directory ${srcPath}/hdl/sub/correlator_new/verilog/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}

# Extra source files #dsp#
  set source_files [glob -directory ${srcPath}/hdl/sub/dsp/verilog_sv/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}
  set source_files [glob -directory ${srcPath}/hdl/sub/dsp/verilog/ -type f *.{v,vh}]
  add_files -norecurse -fileset sources_1 ${source_files}
  set source_files [glob -directory ${srcPath}/hdl/sub/dsp/verilog/piped_adder/ -type f *.{v,vh}]
  add_files -norecurse -fileset sources_1 ${source_files}
  set source_files [glob -directory ${srcPath}/hdl/sub/dsp/verilog/randn/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}
  
# Extra source files #uart#
  set source_files [glob -directory ${srcPath}/hdl/sub/uart/rtl/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}
  
# Extra source files #trcv#
  add_files -norecurse ${srcPath}/hdl/trcv/trcv.svh
  add_files -norecurse ${srcPath}/hdl/trcv/trcv.sv

# Extra source files #debug#
  set source_files [glob -directory ${srcPath}/hdl/sub/debug/verilog_sv/ -type f *.{sv,svh}]
  add_files -norecurse -fileset sources_1 ${source_files}
  set source_files [glob -directory ${srcPath}/hdl/sub/debug/verilog/ -type f *.{v,vh}]
  add_files -norecurse -fileset sources_1 ${source_files}

# Set source properties
  set_property FILE_TYPE         {SystemVerilog}  [get_files -all -of_objects [get_fileset sources_1] {*.sv}]
  set_property FILE_TYPE         {Verilog Header} [get_files -all -of_objects [get_fileset sources_1] {*.svh}]
  set_property FILE_TYPE         {Verilog Header} [get_files -all -of_objects [get_fileset sources_1] {math.v}]
  set_property FILE_TYPE         {Verilog Header} [get_files -all -of_objects [get_fileset sources_1] {board_param.v}]
  set_property IS_GLOBAL_INCLUDE  1               [get_files -all -of_objects [get_fileset sources_1] {board_param.v}]
  set_property IS_GLOBAL_INCLUDE  1               [get_files -all -of_objects [get_fileset sources_1] {global_param.v}]

# re-create block design
# prepare .coe files
# # #   set coePath "./${projectName}.srcs/sources_1/bd/csiTxBD/src/hdl/coe/"
# # #   file mkdir ${coePath}
# # #   file copy -force {*}[glob ${srcPath}/hdl/coe/*.coe] ${coePath}

# Block Design
# ################################################
  source "${srcPath}/hdl/bd/zynq.tcl"

# set .elf to MicroBlaze
# # # set_property used_in_simulation 0 [get_files sdi-mipi-hdmi_appl.elf]
# # # set_property SCOPED_TO_REF    design_1            [get_files -all -of_objects [get_fileset sources_1] {sdi-mipi-hdmi_appl.elf}]
# # # set_property SCOPED_TO_CELLS { CPU/microblaze_0 } [get_files -all -of_objects [get_fileset sources_1] {sdi-mipi-hdmi_appl.elf}]

  close_bd_design zynq
# ################################################

# timing constraints are only relevant for implementation
  set_property used_in_synthesis false [get_files *.xdc]

# set strategies
  set_property strategy "Performance_Explore" [get_runs impl_1]

# set post Bitstream .tcl
  if {[string equal [get_filesets -quiet utils_1] ""]} {
    create_fileset -srcset utils_1
  }
  add_files -norecurse -fileset utils_1 "${srcPath}/../scripts/write_hw_files.tcl"
  set_property STEPS.WRITE_BITSTREAM.TCL.POST [ get_files -of [get_filesets utils_1]] [get_runs impl_1]

# update sources
  set_property top ${projectName} [current_fileset]
  update_compile_order -fileset sources_1

  puts "INFO: Project created:${projectName}."

  after 10000

# Vivado generates the Synthesis script: synth_1/<top_level_filename>.tcl.
# But in case of spaces in absolute path doesn't put figure brackets in path for read_checkpoint command that cause Synthesis error.
# This is workaround for spaces issue - read_checkpoint is disabled.
# # # set_property AUTO_INCREMENTAL_CHECKPOINT 0 [get_runs synth_1]

# write_bitstream
  reset_run synth_1
  launch_runs impl_1 -to_step write_bitstream -jobs 16
  wait_on_run impl_1

  puts "INFO: write_bitstream for ${projectName} is over."

# .ltx file created after post Bitstream .tcl so copy .ltx here
  # save previous .ltx
  set fileName     "${projectName}"
  set bitPath    "./${projectName}.runs/impl_1"
  set rootPath   "../.."
  if {   ([file exists       "${bitPath}/${fileName}.ltx"] == 1)   \
      && ([file exists  "${rootPath}/bin/${fileName}.ltx"] == 1) } \
  {file copy -force     "${rootPath}/bin/${fileName}.ltx" "${rootPath}/bin/${fileName}_prev.ltx";}
  # copy .ltx file
  if { [file exists      "${bitPath}/${fileName}.ltx"] != 1 } {puts "WARNING: ${bitPath}/${fileName}.ltx not exist!";} \
  else {file copy -force "${bitPath}/${fileName}.ltx" "${rootPath}/bin/${fileName}.ltx";}
  
# EOF