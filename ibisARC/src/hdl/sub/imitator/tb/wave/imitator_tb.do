onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/phase_hi     }
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/prn_counter  }
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/prn_reset    }
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/code         }
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/PS}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sTimeSlotMask}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sPNcnt}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/mask}

add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/data_symb}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/PN_dly}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/do_rqst}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/chip_pulse}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/epoch_pulse}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/sec_pulse}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/pn_gen}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/pn_gen}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/mask_gen}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gsin}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/I}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Q}

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1282304000 ps} 0} {{Cursor 2} {282304000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 525
configure wave -valuecolwidth 112
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
WaveRestoreZoom {0 ps} {1890 us}
