onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /SRAM_tb/addr_width
add wave -noupdate -expand -group tb /SRAM_tb/clka
add wave -noupdate -expand -group tb /SRAM_tb/clkb
add wave -noupdate -expand -group tb /SRAM_tb/resetn
add wave -noupdate -expand -group tb -radix hexadecimal -radixshowbase 0 /SRAM_tb/QA
add wave -noupdate -expand -group tb -radix hexadecimal -radixshowbase 0 /SRAM_tb/QB
add wave -noupdate -expand -group tb -radix unsigned -radixshowbase 0 /SRAM_tb/addra
add wave -noupdate -expand -group tb /SRAM_tb/web
add wave -noupdate -expand -group tb /SRAM_tb/cea
add wave -noupdate -expand -group tb /SRAM_tb/ceb
add wave -noupdate -expand -group tb -radix unsigned -childformat {{{/SRAM_tb/addrb[10]} -radix unsigned} {{/SRAM_tb/addrb[9]} -radix unsigned} {{/SRAM_tb/addrb[8]} -radix unsigned} {{/SRAM_tb/addrb[7]} -radix unsigned} {{/SRAM_tb/addrb[6]} -radix unsigned} {{/SRAM_tb/addrb[5]} -radix unsigned} {{/SRAM_tb/addrb[4]} -radix unsigned} {{/SRAM_tb/addrb[3]} -radix unsigned} {{/SRAM_tb/addrb[2]} -radix unsigned} {{/SRAM_tb/addrb[1]} -radix unsigned} {{/SRAM_tb/addrb[0]} -radix unsigned}} -radixshowbase 0 -subitemconfig {{/SRAM_tb/addrb[10]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[9]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[8]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[7]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[6]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[5]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[4]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[3]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[2]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[1]} {-height 15 -radix unsigned -radixshowbase 0} {/SRAM_tb/addrb[0]} {-height 15 -radix unsigned -radixshowbase 0}} /SRAM_tb/addrb
add wave -noupdate -expand -group tb /SRAM_tb/datab
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/BITS
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/word_depth
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/addr_width
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/wordx
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/addrx
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/QA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/CLKA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/CENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/WENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/AA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/DA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/QB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/CLKB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/CENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/WENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/AB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/DB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/mem
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CONTA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CONTB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_WENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA0
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA1
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA2
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA3
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA4
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA5
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA6
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA7
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA8
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA9
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA10
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA0
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA1
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA2
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA3
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA4
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA5
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA6
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA7
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CLKA_PER
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CLKA_MINH
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CLKA_MINL
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_WENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB0
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB1
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB2
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB3
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB4
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB5
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB6
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB7
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB8
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB9
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB10
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_AB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB0
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB1
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB2
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB3
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB4
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB5
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB6
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB7
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_DB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CLKB_PER
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CLKB_MINH
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/NOT_CLKB_MINL
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_WENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_AA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_DA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CLKA_PER
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CLKA_MINH
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CLKA_MINL
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_WENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_AB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_DB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CLKB_PER
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CLKB_MINH
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CLKB_MINL
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CONTA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_NOT_CONTB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/contA_flag
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/contB_flag
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/cont_flag
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_QA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_AA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_CLKA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_CENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_WENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_DA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/re_flagA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/re_data_flagA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_QB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_AB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_CLKB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_CENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_WENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/_DB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/re_flagB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/re_data_flagB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LATCHED_CENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LATCHED_WENA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LATCHED_AA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LATCHED_DA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LATCHED_CENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LATCHED_WENB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LATCHED_AB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LATCHED_DB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/CENAi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/WENAi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/AAi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/DAi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/QAi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_QAi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/CENBi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/WENBi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/ABi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/DBi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/QBi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_QBi
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_CLKA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/LAST_CLKB
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/valid_cycleA
add wave -noupdate -expand -group sram /SRAM_tb/SRAM2_2Kx8_inst/valid_cycleB
add wave -noupdate -group write_mem /SRAM_tb/SRAM2_2Kx8_inst/write_mem/a
add wave -noupdate -group write_mem /SRAM_tb/SRAM2_2Kx8_inst/write_mem/d
add wave -noupdate -expand -group read_mem_A /SRAM_tb/SRAM2_2Kx8_inst/read_memA/r_wb
add wave -noupdate -expand -group read_mem_A /SRAM_tb/SRAM2_2Kx8_inst/read_memA/xflag
add wave -noupdate -expand -group read_mem_A /SRAM_tb/SRAM2_2Kx8_inst/AAi
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14020000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 337
configure wave -valuecolwidth 40
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
configure wave -timelineunits ns
update
WaveRestoreZoom {13953360 ps} {14076440 ps}
