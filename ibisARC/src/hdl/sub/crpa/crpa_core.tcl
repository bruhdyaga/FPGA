
#*****************************************************************************************

# Set defines for DIRECTORIES
	set origin_dir 		"."
	set sub_dir 		"sub"
	set prj_name 		"CRPA_CORE"
	set prj_dir_name 	"Project_CRPA_CORE"
	set topmodule_name 	"CRPA_wrapper_top"

	variable script_file
	set script_file "$prj_name.tcl"
	
	# Use origin directory path location variable, if specified in the tcl shell
	if { [info exists ::origin_dir_loc] } {
		set origin_dir $::origin_dir_loc
	}

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

# ======== CREATE PROJECT ===========
	create_project $prj_name ./$prj_dir_name

# Set the directory path for the new project
	set proj_dir [get_property directory [current_project]]		
		
# Set project properties
	set obj [get_projects $prj_name]
	set_property "part" "xc7z045ffg900-2" $obj
	set_property "board_part" "xilinx.com:zc706:part0:1.2" $obj
	set_property "default_lib" "xil_defaultlib" $obj
	set_property "sim.ip.auto_export_scripts" "1" $obj
	set_property "simulator_language" "Mixed" $obj
	set_property "source_mgmt_mode" "DisplayOnly" $obj

	
# ======== ADD SOURCE FILES =========	
	
# Create 'sources_1' fileset (if not found)
	if {[string equal [get_filesets -quiet sources_1] ""]} {
	create_fileset -srcset sources_1
	}	
	
# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
# Empty (no sources present)

# Disable SIM for all files
#	foreach source_file $files {
#		set file "$source_file"
#		set file [file normalize $file]
#		set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
#		set_property "used_in" "synthesis implementation" $file_obj
#		set_property "used_in_simulation" "0" $file_obj
#	}

# Set TOPMODULE & INCLUDE_DIRS
	set obj [get_filesets sources_1]
	set_property "include_dirs" "$origin_dir/verilog" $obj
	set_property "top" "CRPA_wrapper_top" $obj

# ========== ADD CONSTRAINTS ===========	

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Empty (no sources present)

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]


# ======== CREATE SIM FILESETS ==========

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


# ======== CRPA_tb ==========

# Create 'sim_CRPA' fileset (if not found)
if {[string equal [get_filesets -quiet sim_CRPA] ""]} {
  create_fileset -simset sim_CRPA
}

# Set 'sim_CRPA' fileset object
set obj [get_filesets sim_CRPA]
set files [list \
 "[file normalize "$origin_dir/tb/CRPA_tb.v"]"\
 "[file normalize "$origin_dir/verilog/conv_reg_n.v"]"\
 "[file normalize "$origin_dir/verilog/sum_1_step_n.v"]"\
 "[file normalize "$origin_dir/verilog/reg_delay_n.v"]"\
 "[file normalize "$origin_dir/verilog/multi_sum_n.v"]"\
 "[file normalize "$origin_dir/verilog/kix_filter_n.v"]"\
 "[file normalize "$origin_dir/verilog/BeamFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/NullFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/NFBF_wrapper.v"]"\
 "[file normalize "$origin_dir/verilog/bus_interface_ahb.v"]"\
 "[file normalize "$origin_dir/verilog/CRPA_regfile.v"]"\
 "[file normalize "$origin_dir/verilog/CRPA_wrapper_top.v"]"\
 "[file normalize "$origin_dir/sub/sync/verilog/ed_det.v"]"\
 "[file normalize "$origin_dir/sub/sync/verilog/level_sync.v"]"\
 "[file normalize "$origin_dir/tb/wave/CRPA_tb_behav.wcfg"]"\
 "[file normalize "$origin_dir/verilog/macc.v"]"\
 "[file normalize "$origin_dir/verilog/macc_ctrl.v"]"\
 "[file normalize "$origin_dir/verilog/cov_matrix.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_CRPA' fileset properties
set obj [get_filesets sim_CRPA]
set_property "include_dirs" "C:/Work/GIT/crpa/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "CRPA_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "C:/Work/GIT/crpa/tb/wave/CRPA_tb_behav.wcfg" $obj


# Строка исключает добавление всех файлов проекта в конкретный файлсет
# set_property "source_set" "" $obj	 



	

# Create 'sim_NullFormer' fileset (if not found)
if {[string equal [get_filesets -quiet sim_NullFormer] ""]} {
  create_fileset -simset sim_NullFormer
}

# Set 'sim_NullFormer' fileset object
set obj [get_filesets sim_NullFormer]
set files [list \
 "[file normalize "$origin_dir/tb/Nulformer_tb.v"]"\
 "[file normalize "$origin_dir/verilog/NullFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/kix_filter_n.v"]"\
 "[file normalize "$origin_dir/verilog/conv_reg_n.v"]"\
 "[file normalize "$origin_dir/verilog/multi_sum_n.v"]"\
 "[file normalize "$origin_dir/verilog/sum_1_step_n.v"]"\
 "[file normalize "$origin_dir/verilog/reg_delay_n.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_NullFormer' fileset file properties for remote files
# None

# Set 'sim_NullFormer' fileset file properties for local files
# None

# Set 'sim_NullFormer' fileset properties
set obj [get_filesets sim_NullFormer]
set_property "include_dirs" "C:/Work/GIT/crpa/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "Nulformer_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj

# Create 'sim_NFBF_wrapper' fileset (if not found)
if {[string equal [get_filesets -quiet sim_NFBF_wrapper] ""]} {
  create_fileset -simset sim_NFBF_wrapper
}

# Set 'sim_NFBF_wrapper' fileset object
set obj [get_filesets sim_NFBF_wrapper]
set files [list \
 "[file normalize "$origin_dir/tb/NF_wrapper_tb.v"]"\
 "[file normalize "$origin_dir/verilog/NFBF_wrapper.v"]"\
 "[file normalize "$origin_dir/verilog/kix_filter_n.v"]"\
 "[file normalize "$origin_dir/verilog/NullFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/BeamFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/reg_delay_n.v"]"\
 "[file normalize "$origin_dir/verilog/conv_reg_n.v"]"\
 "[file normalize "$origin_dir/verilog/multi_sum_n.v"]"\
 "[file normalize "$origin_dir/verilog/sum_1_step_n.v"]"\
 "[file normalize "$origin_dir/tb/wave/NF_wrapper_tb_behav.wcfg"]"\
 "[file normalize "$origin_dir/verilog/macc.v"]"\
 "[file normalize "$origin_dir/verilog/macc_ctrl.v"]"\
 "[file normalize "$origin_dir/verilog/cov_matrix.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_NFBF_wrapper' fileset file properties for remote files
# None

# Set 'sim_NFBF_wrapper' fileset file properties for local files
# None

# Set 'sim_NFBF_wrapper' fileset properties
set obj [get_filesets sim_NFBF_wrapper]
set_property "include_dirs" "C:/Work/GIT/crpa/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "NF_wrapper_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "C:/Work/GIT/crpa/tb/wave/NF_wrapper_tb_behav.wcfg" $obj

# Create 'sim_MACC' fileset (if not found)
if {[string equal [get_filesets -quiet sim_MACC] ""]} {
  create_fileset -simset sim_MACC
}

# Set 'sim_MACC' fileset object
set obj [get_filesets sim_MACC]
set files [list \
 "[file normalize "$origin_dir/tb/macc_tb.v"]"\
 "[file normalize "$origin_dir/verilog/macc.v"]"\
 "[file normalize "$origin_dir/verilog/macc_ctrl.v"]"\
 "[file normalize "$origin_dir/tb/wave/macc_tb_behav.wcfg"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_MACC' fileset file properties for remote files
# None

# Set 'sim_MACC' fileset file properties for local files
# None

# Set 'sim_MACC' fileset properties
set obj [get_filesets sim_MACC]
set_property "include_dirs" "C:/Work/GIT/crpa/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "macc_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "C:/Work/GIT/crpa/tb/wave/macc_tb_behav.wcfg" $obj

# Create 'sim_COV_MATR' fileset (if not found)
if {[string equal [get_filesets -quiet sim_COV_MATR] ""]} {
  create_fileset -simset sim_COV_MATR
}

# Set 'sim_COV_MATR' fileset object
set obj [get_filesets sim_COV_MATR]
set files [list \
 "[file normalize "$origin_dir/tb/cov_matrix_tb.v"]"\
 "[file normalize "$origin_dir/verilog/reg_delay_n.v"]"\
 "[file normalize "$origin_dir/verilog/macc.v"]"\
 "[file normalize "$origin_dir/verilog/cov_matrix.v"]"\
 "[file normalize "$origin_dir/verilog/macc_ctrl.v"]"\
 "[file normalize "$origin_dir/tb/wave/cov_matrix_tb_behav.wcfg"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_COV_MATR' fileset file properties for remote files
# None

# Set 'sim_COV_MATR' fileset file properties for local files
# None

# Set 'sim_COV_MATR' fileset properties
set obj [get_filesets sim_COV_MATR]
set_property "include_dirs" "C:/Work/GIT/crpa/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "cov_matrix_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "C:/Work/GIT/crpa/tb/wave/cov_matrix_tb_behav.wcfg" $obj

# Create 'sim_FirFilter' fileset (if not found)
if {[string equal [get_filesets -quiet sim_FirFilter] ""]} {
  create_fileset -simset sim_FirFilter
}

# Set 'sim_FirFilter' fileset object
set obj [get_filesets sim_FirFilter]
# Empty (no sources present)

# Set 'sim_FirFilter' fileset properties
set obj [get_filesets sim_FirFilter]
set_property "include_dirs" "C:/Work/GIT/crpa/verilog" $obj
set_property "source_set" "" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj



# ======== sim_NullFormer ==========

# Create 'sim_NullFormer' fileset (if not found)
if {[string equal [get_filesets -quiet sim_NullFormer] ""]} {
  create_fileset -simset sim_NullFormer
}

# Set 'sim_NullFormer' fileset object
set obj [get_filesets sim_NullFormer]
set files [list \
 "[file normalize "$origin_dir/tb/Nulformer_tb.v"]"\
 "[file normalize "$origin_dir/verilog/NullFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/kix_filter_n.v"]"\
 "[file normalize "$origin_dir/verilog/conv_reg_n.v"]"\
 "[file normalize "$origin_dir/verilog/multi_sum_n.v"]"\
 "[file normalize "$origin_dir/verilog/sum_1_step_n.v"]"\
 "[file normalize "$origin_dir/verilog/reg_delay_n.v"]"\
 "[file normalize "$origin_dir/tb/wave/Nulformer_tb_behav.wcfg"]"\
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
 "[file normalize "$origin_dir/verilog/Mult.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_NullFormer' fileset file properties for remote files
# None

# Set 'sim_NullFormer' fileset file properties for local files
# None

# Set 'sim_NullFormer' fileset properties
set obj [get_filesets sim_NullFormer]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "Nulformer_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "$origin_dir/tb/wave/Nulformer_tb_behav.wcfg" $obj



# ======== sim_NFBF_wrapper ==========

# Create 'sim_NFBF_wrapper' fileset (if not found)
if {[string equal [get_filesets -quiet sim_NFBF_wrapper] ""]} {
  create_fileset -simset sim_NFBF_wrapper
}

# Set 'sim_NFBF_wrapper' fileset object
set obj [get_filesets sim_NFBF_wrapper]
set files [list \
 "[file normalize "$origin_dir/tb/NF_wrapper_tb.v"]"\
 "[file normalize "$origin_dir/verilog/NFBF_wrapper.v"]"\
 "[file normalize "$origin_dir/verilog/kix_filter_n.v"]"\
 "[file normalize "$origin_dir/verilog/NullFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/BeamFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/conv_reg_n.v"]"\
 "[file normalize "$origin_dir/verilog/multi_sum_n.v"]"\
 "[file normalize "$origin_dir/verilog/sum_1_step_n.v"]"\
 "[file normalize "$origin_dir/tb/wave/NF_wrapper_tb_behav.wcfg"]"\
 "[file normalize "$origin_dir/verilog/macc.v"]"\
 "[file normalize "$origin_dir/verilog/macc_ctrl.v"]"\
 "[file normalize "$origin_dir/verilog/cov_matrix.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct_mux.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct.v"]"\
 "[file normalize "$origin_dir/verilog/delays_array.v"]"\
 "[file normalize "$origin_dir/verilog/macc2.v"]"\
 "[file normalize "$origin_dir/verilog/maccs_array.v"]"\
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
 "[file normalize "$origin_dir/verilog/Mult.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_NFBF_wrapper' fileset file properties for remote files
# None

# Set 'sim_NFBF_wrapper' fileset file properties for local files
# None

# Set 'sim_NFBF_wrapper' fileset properties
set obj [get_filesets sim_NFBF_wrapper]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "NF_wrapper_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "$origin_dir/tb/wave/NF_wrapper_tb_behav.wcfg" $obj



# ======== sim_MACC ==========

# Create 'sim_MACC' fileset (if not found)
if {[string equal [get_filesets -quiet sim_MACC] ""]} {
  create_fileset -simset sim_MACC
}

# Set 'sim_MACC' fileset object
set obj [get_filesets sim_MACC]
set files [list \
 "[file normalize "$origin_dir/tb/macc_tb.v"]"\
 "[file normalize "$origin_dir/verilog/macc.v"]"\
 "[file normalize "$origin_dir/verilog/macc_ctrl.v"]"\
 "[file normalize "$origin_dir/tb/wave/macc_tb_behav.wcfg"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_MACC' fileset file properties for remote files
# None

# Set 'sim_MACC' fileset file properties for local files
# None

# Set 'sim_MACC' fileset properties
set obj [get_filesets sim_MACC]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "macc_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "$origin_dir/tb/wave/macc_tb_behav.wcfg" $obj



# ======== sim_CVM ==========

# Create 'sim_CVM' fileset (if not found)
if {[string equal [get_filesets -quiet sim_CVM] ""]} {
  create_fileset -simset sim_CVM
}

# Set 'sim_CVM' fileset object
set obj [get_filesets sim_CVM]
set files [list \
 "[file normalize "$origin_dir/tb/cov_matrix_tb.v"]"\
 "[file normalize "$origin_dir/verilog/reg_delay_n.v"]"\
 "[file normalize "$origin_dir/verilog/macc.v"]"\
 "[file normalize "$origin_dir/verilog/cov_matrix.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct_mux.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct.v"]"\
 "[file normalize "$origin_dir/verilog/delays_array.v"]"\
 "[file normalize "$origin_dir/verilog/macc2.v"]"\
 "[file normalize "$origin_dir/verilog/maccs_array.v"]"\
 "[file normalize "$origin_dir/verilog/macc_ctrl.v"]"\
 "[file normalize "$origin_dir/tb/wave/cov_matrix_tb_behav.wcfg"]"\
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
 "[file normalize "$origin_dir/verilog/MUX_CVM.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_CVM' fileset file properties for remote files
# None

# Set 'sim_CVM' fileset file properties for local files
# None

# Set 'sim_CVM' fileset properties
set obj [get_filesets sim_CVM]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "cov_matrix_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "$origin_dir/tb/wave/cov_matrix_tb_behav.wcfg" $obj



# ======== sim_KIX ==========

# Create 'sim_KIX' fileset (if not found)
if {[string equal [get_filesets -quiet sim_KIX] ""]} {
  create_fileset -simset sim_KIX
}

# Set 'sim_KIX' fileset object
set obj [get_filesets sim_KIX]
set files [list \
 "[file normalize "$origin_dir/verilog/kix_filter_n.v"]"\
 "[file normalize "$origin_dir/verilog/sum_1_step_n.v"]"\
 "[file normalize "$origin_dir/tb/kix_filter_tb.v"]"\
 "[file normalize "$origin_dir/verilog/conv_reg_n.v"]"\
 "[file normalize "$origin_dir/verilog/multi_sum_n.v"]"\
 "[file normalize "$origin_dir/verilog/reg_delay_n.v"]"\
 "[file normalize "$origin_dir/tb/wave/kix_filter_tb_behav.wcfg"]"\
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
 "[file normalize "$origin_dir/verilog/Mult.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_KIX' fileset file properties for remote files
# None

# Set 'sim_KIX' fileset file properties for local files
# None

# Set 'sim_KIX' fileset properties
set obj [get_filesets sim_KIX]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "kix_filter_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj
set_property "xsim.view" "$origin_dir/tb/wave/kix_filter_tb_behav.wcfg" $obj



# ======== sim_MUX2 ==========

# Create 'sim_MUX2' fileset (if not found)
if {[string equal [get_filesets -quiet sim_MUX2] ""]} {
  create_fileset -simset sim_MUX2
}

# Set 'sim_MUX2' fileset object
set obj [get_filesets sim_MUX2]
set files [list \
 "[file normalize "$origin_dir/tb/MUX2_tb.v"]"\
 "[file normalize "$origin_dir/verilog/mean_compens_v2.v"]"\
 "[file normalize "$origin_dir/verilog/MUX2.v"]"\
 "[file normalize "$origin_dir/verilog/hist_sig_mag_v2.v"]"\
 "[file normalize "$origin_dir/verilog/sig_mag_v2.v"]"\
 "[file normalize "$origin_dir/verilog/conv_reg_n.v"]"\
 "[file normalize "$origin_dir/sub/sync/verilog/level_sync.v"]"\
 "[file normalize "$origin_dir/verilog/sin_gen.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_MUX2' fileset file properties for remote files
# None

# Set 'sim_MUX2' fileset file properties for local files
# None

# Set 'sim_MUX2' fileset properties
set obj [get_filesets sim_MUX2]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "MUX2_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj



# ======== sim_DLL ==========

# Create 'sim_DLL' fileset (if not found)
if {[string equal [get_filesets -quiet sim_DLL] ""]} {
  create_fileset -simset sim_DLL
}

# Set 'sim_DLL' fileset object
set obj [get_filesets sim_DLL]
set files [list \
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
 "[file normalize "$origin_dir/tb/delay_line_tb.v"]"\
 "[file normalize "$origin_dir/tb/wave/delay_line_tb_behav.wcfg"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_DLL' fileset file properties for remote files
# None

# Set 'sim_DLL' fileset file properties for local files
# None

# Set 'sim_DLL' fileset properties
set obj [get_filesets sim_DLL]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "delay_line_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj



# ======== sim_CRPA ==========

# Create 'sim_CRPA' fileset (if not found)
if {[string equal [get_filesets -quiet sim_CRPA] ""]} {
  create_fileset -simset sim_CRPA
}

# Set 'sim_CRPA' fileset object
set obj [get_filesets sim_CRPA]
set files [list \
 "[file normalize "$origin_dir/verilog/CRPA_wrapper_top.v"]"\
 "[file normalize "$origin_dir/verilog/NFBF_wrapper.v"]"\
 "[file normalize "$origin_dir/verilog/kix_filter_n.v"]"\
 "[file normalize "$origin_dir/verilog/clkgate.v"]"\
 "[file normalize "$origin_dir/verilog/mean_compens_v2.v"]"\
 "[file normalize "$origin_dir/verilog/conv_reg_n.v"]"\
 "[file normalize "$origin_dir/verilog/sig_mag_v2.v"]"\
 "[file normalize "$origin_dir/verilog/multi_sum_n.v"]"\
 "[file normalize "$origin_dir/verilog/sin_gen.v"]"\
 "[file normalize "$origin_dir/verilog/cov_matrix.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct_mux.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct.v"]"\
 "[file normalize "$origin_dir/verilog/delays_array.v"]"\
 "[file normalize "$origin_dir/verilog/macc2.v"]"\
 "[file normalize "$origin_dir/verilog/maccs_array.v"]"\
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
 "[file normalize "$origin_dir/verilog/sum_1_step_n.v"]"\
 "[file normalize "$origin_dir/verilog/bus_interface_ahb.v"]"\
 "[file normalize "$origin_dir/verilog/Mult.v"]"\
 "[file normalize "$origin_dir/verilog/NullFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/BeamFormer_n.v"]"\
 "[file normalize "$origin_dir/verilog/clkgate_ctrl.v"]"\
 "[file normalize "$origin_dir/verilog/test_gen.v"]"\
 "[file normalize "$origin_dir/verilog/reg_delay_n.v"]"\
 "[file normalize "$origin_dir/verilog/MUX2.v"]"\
 "[file normalize "$origin_dir/verilog/CRPA_regfile.v"]"\
 "[file normalize "$origin_dir/verilog/MUX1.v"]"\
 "[file normalize "$origin_dir/verilog/clkand.v"]"\
 "[file normalize "$origin_dir/verilog/hist_sig_mag_v2.v"]"\
 "[file normalize "$origin_dir/verilog/macc.v"]"\
 "[file normalize "$origin_dir/verilog/macc_ctrl.v"]"\
 "[file normalize "$origin_dir/sub/sync/verilog/ed_det.v"]"\
 "[file normalize "$origin_dir/sub/sync/verilog/level_sync.v"]"\
 "[file normalize "$origin_dir/tb/CRPA_tb.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_CRPA' fileset file properties for remote files
# None

# Set 'sim_CRPA' fileset file properties for local files
# None

# Set 'sim_CRPA' fileset properties
set obj [get_filesets sim_CRPA]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "CRPA_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj



# ======== sim_MUX_CVM ==========

# Create 'sim_MUX_CVM' fileset (if not found)
if {[string equal [get_filesets -quiet sim_MUX_CVM] ""]} {
  create_fileset -simset sim_MUX_CVM
}

# Set 'sim_MUX_CVM' fileset object
set obj [get_filesets sim_MUX_CVM]
set files [list \
 "[file normalize "$origin_dir/verilog/MUX_CVM.v"]"\
 "[file normalize "$origin_dir/tb/MUX_CVM_tb.v"]"\
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_MUX_CVM' fileset file properties for remote files
# None

# Set 'sim_MUX_CVM' fileset file properties for local files
# None

# Set 'sim_MUX_CVM' fileset properties
set obj [get_filesets sim_MUX_CVM]
set_property "include_dirs" "$origin_dir/verilog" $obj
set_property "source_set" "" $obj
set_property "top" "MUX_CVM_tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj



# ======== sim_auto_cov_matrix ==========
set tbname             "auto_cov_matrix"
# Create fileset (if not found)
if {[string equal [get_filesets -quiet sim_$tbname] ""]} {
  create_fileset -simset sim_$tbname
}

# Set fileset object
set obj [get_filesets sim_$tbname]
set files [list \
 "[file normalize "$origin_dir/verilog/cov_matrix.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct_mux.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct.v"]"\
 "[file normalize "$origin_dir/verilog/delays_array.v"]"\
 "[file normalize "$origin_dir/verilog/macc2.v"]"\
 "[file normalize "$origin_dir/verilog/maccs_array.v"]"\
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
 "[file normalize "$origin_dir/test/cov_matrix/test.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set fileset properties
set obj [get_filesets sim_$tbname]
set_property "include_dirs" "$origin_dir/verilog $origin_dir/test/cov_matrix/tmp" $obj
set_property "source_set" "" $obj
set_property "top" "tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj



# ======== sim_auto_CRPA ==========
set tbname             "auto_CRPA"
# Create fileset (if not found)
if {[string equal [get_filesets -quiet sim_$tbname] ""]} {
  create_fileset -simset sim_$tbname
}

# Set fileset object
set obj [get_filesets sim_$tbname]
set files [list \
 "[file normalize "$origin_dir/verilog/CRPA.v"]"\
 "[file normalize "$origin_dir/verilog/CRPA_regs.v"]"\
 "[file normalize "$origin_dir/verilog/BeamFormer.v"]"\
 "[file normalize "$origin_dir/verilog/NullFormer.v"]"\
 "[file normalize "$origin_dir/verilog/fir_filter.v"]"\
 "[file normalize "$origin_dir/verilog/delay_line.v"]"\
 "[file normalize "$origin_dir/verilog/Mult.v"]"\
 "[file normalize "$origin_dir/sub/dsp/verilog/piped_adder/piped_adder.v"]"\
 "[file normalize "$origin_dir/sub/dsp/verilog/piped_adder/piped_adder_stage.v"]"\
 "[file normalize "$origin_dir/sub/dsp/verilog/piped_adder/conv_reg.v"]"\
 "[file normalize "$origin_dir/sub/dsp/verilog/sig_mag_v2.v"]"\
 "[file normalize "$origin_dir/verilog/cov_matrix.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct_mux.v"]"\
 "[file normalize "$origin_dir/verilog/cvm_intrcnct.v"]"\
 "[file normalize "$origin_dir/verilog/delays_array.v"]"\
 "[file normalize "$origin_dir/verilog/macc2.v"]"\
 "[file normalize "$origin_dir/verilog/maccs_array.v"]"\
 "[file normalize "$origin_dir/test/CRPA/test.v"]"\
]
add_files -norecurse -fileset $obj $files

# Set fileset properties
set obj [get_filesets sim_$tbname]
set_property "include_dirs" "$origin_dir/verilog $origin_dir/sub/debug/tb $origin_dir/test/CRPA/tmp" $obj
set_property "source_set" "" $obj
set_property "top" "tb" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj


# =========== CREATE RUNS ===============

# SYNTH RUNS
	# Create 'synth_1' run (if not found)
		if {[string equal [get_runs -quiet synth_1] ""]} {
		create_run -name synth_1 -part xc7z045ffg900-2 -flow {Vivado Synthesis 2015} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
		} else {
		set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
		set_property flow "Vivado Synthesis 2015" [get_runs synth_1]
		}
		set obj [get_runs synth_1]

# IMPL RUNS
	# Create 'impl_1' run (if not found)
		if {[string equal [get_runs -quiet impl_1] ""]} {
		create_run -name impl_1 -part xc7z045ffg900-2 -flow {Vivado Implementation 2015} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
		} else {
		set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
		set_property flow "Vivado Implementation 2015" [get_runs impl_1]
		}
		set obj [get_runs impl_1]
		set_property "steps.write_bitstream.args.readback_file" "0" $obj
		set_property "steps.write_bitstream.args.verbose" "0" $obj


# Set the CURRENT SYNTH & IMPL runs
	current_run -synthesis 		[get_runs synth_1]
	current_run -implementation [get_runs impl_1]

puts "INFO: Project created: CRPA_core"
