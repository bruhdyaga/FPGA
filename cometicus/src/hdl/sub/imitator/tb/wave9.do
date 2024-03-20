onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/clk}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr_shift}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/phase_hi}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/update}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/code_out}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/mask}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr1}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr2}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/prn_counter}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/prn_reset}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/gps_l5_reset}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr1_xor}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr2_xor}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr1_out}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr2_out}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/PS}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr2_fb}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/sr2_xor_fb}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/phase_hi_reg}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/boc_mod}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/genblk1/PRN_GEN_CH/code}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/dds_iq_hd/clk}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/dds_iq_hd/phase_cntr_reg}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/dds_iq_hd/phase_cntr}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/dds_iq_hd/code}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/dds_iq_hd/sin}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/dds_iq_hd/cos}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/GcGd}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/mask_dly}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/PN}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/MASK}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/pn_gen}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/pn_ram}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/mask_gen}
add wave -noupdate -expand -group DDS_IQ_HD {/imitator_tb/IMITATOR/CH[0]/IMI_CH/mask_ram}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/fix_pulse}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/chip_pulse}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/epoch_pulse}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/sec_pulse}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/pn_gen}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/mask_gen}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gsin}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/I}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Q}
add wave -noupdate {/imitator_tb/IMITATOR/CH[0]/IMI_CH/PL}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/PS}
add wave -noupdate -group IMI -expand -group CH_0 -group analog -format Analog-Step -height 74 -max 2171.0 -min -2172.0 -radix decimal {/imitator_tb/IMITATOR/CH[0]/IMI_CH/I}
add wave -noupdate -group IMI -expand -group CH_0 -group analog -radix decimal {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Q}
add wave -noupdate -group IMI -expand -group CH_0 -group analog -format Analog-Step -height 74 -max 511.0 -min -511.0 -radix decimal {/imitator_tb/IMITATOR/CH[0]/IMI_CH/cos_product}
add wave -noupdate -group IMI -expand -group CH_0 -group analog -format Analog-Step -height 74 -max 511.0 -min -511.0 -radix decimal {/imitator_tb/IMITATOR/CH[0]/IMI_CH/sin_product}
add wave -noupdate -group IMI -expand -group CH_0 -group analog -format Analog-Step -height 74 -max 511.0 -min -511.0 -radix decimal -childformat {{{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[9]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[8]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[7]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[6]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[5]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[4]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[3]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[2]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[1]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[0]} -radix decimal}} -subitemconfig {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[9]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[8]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[7]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[6]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[5]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[4]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[3]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[2]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[1]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos[0]} {-height 15 -radix decimal}} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gcos}
add wave -noupdate -group IMI -expand -group CH_0 -group analog -radix decimal {/imitator_tb/IMITATOR/CH[0]/IMI_CH/Gsin}
add wave -noupdate -group IMI -expand -group CH_0 -group analog -format Analog-Step -height 74 -max 8687.0 -min -8687.0 -radix decimal -childformat {{{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[17]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[16]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[15]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[14]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[13]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[12]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[11]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[10]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[9]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[8]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[7]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[6]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[5]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[4]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[3]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[2]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[1]} -radix decimal} {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[0]} -radix decimal}} -subitemconfig {{/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[17]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[16]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[15]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[14]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[13]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[12]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[11]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[10]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[9]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[8]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[7]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[6]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[5]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[4]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[3]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[2]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[1]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos[0]} {-height 15 -radix decimal}} {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGcos}
add wave -noupdate -group IMI -expand -group CH_0 -group analog -radix decimal {/imitator_tb/IMITATOR/CH[0]/IMI_CH/AGsin}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/phase_hi}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/phase_cntr}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/do_rqst}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/eph_apply}
add wave -noupdate -group IMI -expand -group CH_0 -expand {/imitator_tb/IMITATOR/CH[0]/IMI_CH/time_out}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/PN}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/PN_LINE}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/PN_dly}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/PHASE_RATE}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/CAR_CYCLES}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/data_symb}
add wave -noupdate -group IMI -expand -group CH_0 {/imitator_tb/IMITATOR/CH[0]/IMI_CH/GcGd}
add wave -noupdate -group IMI /imitator_tb/IMITATOR/clk
add wave -noupdate -group IMI /imitator_tb/IMITATOR/fix_pulse
add wave -noupdate -group IMI /imitator_tb/IMITATOR/PL
add wave -noupdate -group IMI /imitator_tb/IMITATOR/PS
add wave -noupdate -group IMI /imitator_tb/IMITATOR/awgnIraw
add wave -noupdate -group IMI /imitator_tb/IMITATOR/awgnQraw
add wave -noupdate -group IMI -radix decimal /imitator_tb/IMITATOR/mQ
add wave -noupdate -group IMI -radix decimal /imitator_tb/IMITATOR/awgnI
add wave -noupdate -group IMI -radix decimal /imitator_tb/IMITATOR/awgnQ
add wave -noupdate -group IMI -radix decimal /imitator_tb/IMITATOR/Inoised_full
add wave -noupdate -group IMI -radix decimal /imitator_tb/IMITATOR/Qnoised_full
add wave -noupdate -group IMI -group analog -format Analog-Step -height 74 -max 475.00000000000006 -min -501.0 -radix decimal /imitator_tb/IMITATOR/awgnIraw
add wave -noupdate -group IMI -group analog -format Analog-Step -height 74 -max 483.0 -min -469.0 -radix decimal /imitator_tb/IMITATOR/awgnQraw
add wave -noupdate -group IMI -group analog -format Analog-Step -height 74 -max 2171.0 -min -2172.0 -radix decimal /imitator_tb/IMITATOR/mI
add wave -noupdate -group IMI -group analog -format Analog-Step -height 74 -max 2171.0 -min -2172.0 -radix decimal /imitator_tb/IMITATOR/mQ
add wave -noupdate -group IMI -group analog -format Analog-Step -height 74 -max 384.0 -min -512.0 -radix decimal -childformat {{{/imitator_tb/IMITATOR/awgnI[16]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[15]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[14]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[13]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[12]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[11]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[10]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[9]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[8]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[7]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[6]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[5]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[4]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[3]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[2]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[1]} -radix decimal} {{/imitator_tb/IMITATOR/awgnI[0]} -radix decimal}} -subitemconfig {{/imitator_tb/IMITATOR/awgnI[16]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[15]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[14]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[13]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[12]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[11]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[10]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[9]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[8]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[7]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[6]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[5]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[4]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[3]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[2]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[1]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/awgnI[0]} {-height 15 -radix decimal}} /imitator_tb/IMITATOR/awgnI
add wave -noupdate -group IMI -group analog -format Analog-Step -height 74 -max 384.0 -min -512.0 -radix decimal /imitator_tb/IMITATOR/awgnQ
add wave -noupdate -group IMI -group analog -format Analog-Step -height 74 -max 2555.0 -min -2684.0 -radix decimal /imitator_tb/IMITATOR/Inoised_full
add wave -noupdate -group IMI -group analog -format Analog-Step -height 74 -max 2555.0 -min -2684.0 -radix decimal /imitator_tb/IMITATOR/Qnoised_full
add wave -noupdate -group IMI -radix decimal -childformat {{{/imitator_tb/IMITATOR/Ich[0]} -radix decimal -childformat {{{/imitator_tb/IMITATOR/Ich[0][17]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][16]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][15]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][14]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][13]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][12]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][11]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][10]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][9]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][8]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][7]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][6]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][5]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][4]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][3]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][2]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][1]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][0]} -radix decimal}}}} -subitemconfig {{/imitator_tb/IMITATOR/Ich[0]} {-format Analog-Step -height 74 -max 2171.0 -min -2172.0 -radix decimal -childformat {{{/imitator_tb/IMITATOR/Ich[0][17]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][16]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][15]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][14]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][13]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][12]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][11]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][10]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][9]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][8]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][7]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][6]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][5]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][4]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][3]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][2]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][1]} -radix decimal} {{/imitator_tb/IMITATOR/Ich[0][0]} -radix decimal}}} {/imitator_tb/IMITATOR/Ich[0][17]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][16]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][15]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][14]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][13]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][12]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][11]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][10]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][9]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][8]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][7]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][6]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][5]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][4]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][3]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][2]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][1]} {-height 15 -radix decimal} {/imitator_tb/IMITATOR/Ich[0][0]} {-height 15 -radix decimal}} /imitator_tb/IMITATOR/Ich
add wave -noupdate -group IMI -radix decimal -childformat {{{/imitator_tb/IMITATOR/Qch[0]} -radix decimal}} -subitemconfig {{/imitator_tb/IMITATOR/Qch[0]} {-height 15 -radix decimal}} /imitator_tb/IMITATOR/Qch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {1282304000 ps} 0} {{Cursor 3} {282304000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 296
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
