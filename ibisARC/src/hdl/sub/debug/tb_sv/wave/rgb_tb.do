onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /rgb_tb/RGB_BASE_ADDR
add wave -noupdate -group tb /rgb_tb/R
add wave -noupdate -group tb /rgb_tb/G
add wave -noupdate -group tb /rgb_tb/B
add wave -noupdate -group tb /rgb_tb/RGB_DATA
add wave -noupdate -group tb /rgb_tb/aclk
add wave -noupdate -group tb /rgb_tb/rdata
add wave -noupdate -group bus /rgb_tb/bus/ADDR_WIDTH
add wave -noupdate -group bus /rgb_tb/bus/DATA_WIDTH
add wave -noupdate -group bus /rgb_tb/bus/clk
add wave -noupdate -group bus /rgb_tb/bus/resetn
add wave -noupdate -group bus /rgb_tb/bus/addr
add wave -noupdate -group bus /rgb_tb/bus/wdata
add wave -noupdate -group bus /rgb_tb/bus/rdata
add wave -noupdate -group bus /rgb_tb/bus/rvalid
add wave -noupdate -group bus /rgb_tb/bus/wr
add wave -noupdate -group bus /rgb_tb/bus/rd
add wave -noupdate -expand -group rgb /rgb_tb/RGB/BASEADDR
add wave -noupdate -expand -group rgb -radix unsigned /rgb_tb/RGB/FREQ
add wave -noupdate -expand -group rgb -radix unsigned /rgb_tb/RGB/FPS
add wave -noupdate -expand -group rgb -radix unsigned /rgb_tb/RGB/PER
add wave -noupdate -expand -group rgb -radix unsigned /rgb_tb/RGB/L_elem
add wave -noupdate -expand -group rgb -radix unsigned /rgb_tb/RGB/L_WIDTH
add wave -noupdate -expand -group rgb /rgb_tb/RGB/l_cntr
add wave -noupdate -expand -group rgb /rgb_tb/RGB/l_elem_pulse
add wave -noupdate -expand -group rgb /rgb_tb/RGB/rgb_reset_cntr
add wave -noupdate -expand -group rgb /rgb_tb/RGB/rgb_reset
add wave -noupdate -expand -group rgb -expand -subitemconfig {/rgb_tb/RGB/D.RGB {-height 15 -childformat {{B -radix unsigned} {G -radix unsigned} {R -radix unsigned}} -expand} /rgb_tb/RGB/D.RGB.B {-radix unsigned} /rgb_tb/RGB/D.RGB.G {-radix unsigned} /rgb_tb/RGB/D.RGB.R {-radix unsigned}} /rgb_tb/RGB/D
add wave -noupdate -expand -group rgb -expand -subitemconfig {/rgb_tb/RGB/M.RGB -expand} /rgb_tb/RGB/M
add wave -noupdate -expand -group rgb /rgb_tb/RGB/R
add wave -noupdate -expand -group rgb /rgb_tb/RGB/G
add wave -noupdate -expand -group rgb /rgb_tb/RGB/B
add wave -noupdate -expand -group rgb /rgb_tb/RGB/PL
add wave -noupdate -expand -group rgb -expand -subitemconfig {/rgb_tb/RGB/PS.RGB {-height 15 -childformat {{B -radix unsigned -childformat {{{[3]} -radix unsigned} {{[2]} -radix unsigned} {{[1]} -radix unsigned} {{[0]} -radix unsigned}}} {G -radix unsigned} {R -radix unsigned}} -expand} /rgb_tb/RGB/PS.RGB.B {-radix unsigned -childformat {{{[3]} -radix unsigned} {{[2]} -radix unsigned} {{[1]} -radix unsigned} {{[0]} -radix unsigned}}} {/rgb_tb/RGB/PS.RGB.B[3]} {-radix unsigned} {/rgb_tb/RGB/PS.RGB.B[2]} {-radix unsigned} {/rgb_tb/RGB/PS.RGB.B[1]} {-radix unsigned} {/rgb_tb/RGB/PS.RGB.B[0]} {-radix unsigned} /rgb_tb/RGB/PS.RGB.G {-radix unsigned} /rgb_tb/RGB/PS.RGB.R {-radix unsigned}} /rgb_tb/RGB/PS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3333530000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 374
configure wave -valuecolwidth 137
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
WaveRestoreZoom {0 ps} {15750 us}
