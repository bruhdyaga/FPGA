# ----------------------------------------------------------------------------------
# Important! Do not remove this constraint!
# This property ensures that all unused pins are set to high impedance.
# If the constraint is removed, all unused pins have to be set to HiZ in the top level file.
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLNONE [current_design]

# example
# # Clock 200MHz
#   create_clock -period 5.000 -name CLK_200_P [get_ports CLK_200_P]
#   set_property PACKAGE_PIN T5 [get_ports CLK_200_P]
#   set_property PACKAGE_PIN T4 [get_ports CLK_200_N]
#   set_property IOSTANDARD DIFF_HSTL_I_18   [get_ports CLK_200_P]
#   set_property IN_TERM    UNTUNED_SPLIT_50 [get_ports CLK_200_P]

# # clock 10Mhz
#   create_clock -period 100.000 -name CLK_10 [get_ports CLK_10]
#   set_property PACKAGE_PIN N5      [get_ports CLK_10]
#   set_property IOSTANDARD LVCMOS18 [get_ports CLK_10]

set_property PACKAGE_PIN G4  [get_ports DAC_D0];           # MEZ2_19_P
set_property PACKAGE_PIN F4  [get_ports DAC_D1];           # MEZ2_19_N
set_property PACKAGE_PIN D4  [get_ports DAC_D2];           # MEZ2_18_P
set_property PACKAGE_PIN E1  [get_ports DAC_D3];           # MEZ2_17_N
set_property PACKAGE_PIN D3  [get_ports DAC_D4];           # MEZ2_18_N
set_property PACKAGE_PIN E2  [get_ports DAC_D5];           # MEZ2_17_P
set_property PACKAGE_PIN F3  [get_ports DAC_D6];           # MEZ2_15_P
set_property PACKAGE_PIN E3  [get_ports DAC_D7];           # MEZ2_15_N
set_property PACKAGE_PIN B6  [get_ports DAC_D8];           # MEZ2_14_P
set_property PACKAGE_PIN C1  [get_ports DAC_D9];           # MEZ2_11_N
set_property PACKAGE_PIN C4  [get_ports DAC_D10];          # MEZ2_12_P
set_property PACKAGE_PIN C3  [get_ports DAC_D12];          # MEZ2_12_N
set_property PACKAGE_PIN D1  [get_ports DAC_D11];          # MEZ2_11_P
set_property PACKAGE_PIN B5  [get_ports DAC_D13];          # MEZ2_6_P
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D0]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D1]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D2]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D3]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D4]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D5]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D6]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D7]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D8]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D9]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D10]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D12]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D11]
set_property IOSTANDARD LVCMOS18 [get_ports DAC_D13]

set_property PACKAGE_PIN E5  [get_ports ADC_OUT4B_P];      # MEZ2_20_N
set_property PACKAGE_PIN F5  [get_ports ADC_OUT4B_N];      # MEZ2_20_P
set_property PACKAGE_PIN D5  [get_ports ADC_OUT4A_P];      # MEZ2_16_N
set_property PACKAGE_PIN E6  [get_ports ADC_OUT4A_N];      # MEZ2_16P

set_property PACKAGE_PIN C2  [get_ports ADC_OUT3B_P];      # MEZ2_13_P
set_property PACKAGE_PIN B1  [get_ports ADC_OUT3B_N];      # MEZ2_13_N
set_property PACKAGE_PIN D8  [get_ports ADC_OUT3A_P];      # MEZ2_9_N
set_property PACKAGE_PIN D9  [get_ports ADC_OUT3A_N];      # MEZ2_9_P

set_property PACKAGE_PIN A8  [get_ports ADC_OUT2B_P];      # MEZ2_3_N
set_property PACKAGE_PIN A9  [get_ports ADC_OUT2B_N];      # MEZ2_3_P
set_property PACKAGE_PIN B10 [get_ports ADC_OUT2A_P];      # MEZ2_4_P
set_property PACKAGE_PIN A10 [get_ports ADC_OUT2A_N];      # MEZ2_4_N

set_property PACKAGE_PIN B7  [get_ports ADC_OUT1B_P];      # MEZ2_2_P
set_property PACKAGE_PIN A7  [get_ports ADC_OUT1B_N];      # MEZ2_2_N
set_property PACKAGE_PIN A4  [get_ports ADC_OUT1A_P];      # MEZ2_0_P
set_property PACKAGE_PIN A3  [get_ports ADC_OUT1A_N];      # MEZ2_0_N

set_property PACKAGE_PIN C7  [get_ports ADC_FR_P];         # MEZ2_8_N
set_property PACKAGE_PIN C8  [get_ports ADC_FR_N];         # MEZ2_8_P
set_property PACKAGE_PIN C6  [get_ports ADC_DCO_P];        # MEZ2_7_N
set_property PACKAGE_PIN D6  [get_ports ADC_DCO_N];        # MEZ2_7_P

set_property IOSTANDARD DIFF_HSTL_I_18   [get_ports ADC_OUT*]
# set_property IN_TERM    UNTUNED_SPLIT_50 [get_ports ADC_OUT*]
set_property IOSTANDARD DIFF_HSTL_I_18   [get_ports ADC_FR_P]
# set_property IN_TERM    UNTUNED_SPLIT_50 [get_ports ADC_FR_P]
set_property IOSTANDARD DIFF_HSTL_I_18   [get_ports ADC_DCO_P]
# set_property IN_TERM    UNTUNED_SPLIT_50 [get_ports ADC_DCO_P]

create_clock -period 2.000 -name ADC_DCO [get_ports ADC_DCO_P]


set_property PACKAGE_PIN J3  [get_ports MEZ1_LED_A];           # MEZ1_44
set_property PACKAGE_PIN E7  [get_ports MEZ1_LED_B];           # MEZ1_38
set_property PACKAGE_PIN F7  [get_ports MEZ1_LED_C];           # MEZ1_36
set_property IOSTANDARD LVCMOS18 [get_ports MEZ1_LED_A]
set_property IOSTANDARD LVCMOS18 [get_ports MEZ1_LED_B]
set_property IOSTANDARD LVCMOS18 [get_ports MEZ1_LED_C]

set_property PACKAGE_PIN G9  [get_ports MEZ1_ADC_CS];          # MEZ1_16
set_property PACKAGE_PIN F10 [get_ports MEZ1_DAC_CS];          # MEZ1_15
set_property PACKAGE_PIN G10 [get_ports MEZ1_ATT_0_CS];        # MEZ1_12
set_property PACKAGE_PIN E12 [get_ports MEZ1_ATT_1_CS];        # MEZ1_10
set_property PACKAGE_PIN F12 [get_ports MEZ1_ATT_2_CS];        # MEZ1_11

set_property PACKAGE_PIN E8  [get_ports MEZ1_PLL0_LD];         # MEZ1_18
set_property PACKAGE_PIN C11 [get_ports MEZ1_PLL0_CS];         # MEZ1_6
set_property PACKAGE_PIN J13 [get_ports MEZ1_PLL1_CS];         # MEZ1_2
set_property PACKAGE_PIN K13 [get_ports MEZ1_PLL1_LD];         # MEZ1_1
set_property PACKAGE_PIN H4  [get_ports MEZ1_PLL1_MUXOUT];     # MEZ1_41

set_property PACKAGE_PIN F9  [get_ports MEZ1_SPI_SDO];         # MEZ1_17
set_property PACKAGE_PIN D10 [get_ports MEZ1_SPI_SDI];         # MEZ1_8
set_property PACKAGE_PIN K12 [get_ports MEZ1_SPI_CLK];         # MEZ1_0
set_property PACKAGE_PIN K2  [get_ports MEZ1_SPI_2_SDO];       # MEZ1_37
set_property PACKAGE_PIN K3  [get_ports MEZ1_SPI_2_SDI];       # MEZ1_35
set_property PACKAGE_PIN G7  [get_ports MEZ1_SPI_2_CLK];       # MEZ1_33
set_property PACKAGE_PIN G6  [get_ports MEZ1_DAC_SPI_RESET];   # MEZ1_40

set_property PACKAGE_PIN E10 [get_ports MEZ1_CONV_CLK_SEL];    # MEZ1_14
set_property PACKAGE_PIN G12 [get_ports MEZ1_RF_CLK_SEL];      # MEZ1_4

set_property PACKAGE_PIN D11 [get_ports MEZ1_I2C_SCL];         # MEZ1_9
set_property PACKAGE_PIN B11 [get_ports MEZ1_I2C_SDA];         # MEZ1_7

set_property PACKAGE_PIN G5  [get_ports MEZ1_RESERVED_9];      # MEZ1_42
set_property PACKAGE_PIN J4  [get_ports MEZ1_RESERVED_3];      # MEZ1_39
set_property PACKAGE_PIN G11 [get_ports MEZ1_RESERVED_2];      # MEZ1_13
set_property PACKAGE_PIN H12 [get_ports MEZ1_RESERVED_8];      # MEZ1_5
set_property PACKAGE_PIN H16 [get_ports MEZ1_RESERVED_7];      # MEZ1_3

set_property PACKAGE_PIN B2  [get_ports MEZ2_PPS_OUT_P];       # MEZ2_1_P
set_property PACKAGE_PIN A2  [get_ports MEZ2_PPS_OUT_N];       # MEZ2_1_N
set_property PACKAGE_PIN H2  [get_ports MEZ2_PPS_IN_P];        # MEZ2_21_P
set_property PACKAGE_PIN G1  [get_ports MEZ2_PPS_IN_N];        # MEZ2_21_N
set_property PACKAGE_PIN B9  [get_ports MEZ2_SRC_CLK_N];       # MEZ2_10_N
set_property PACKAGE_PIN C9  [get_ports MEZ2_SRC_CLK_P];       # MEZ2_10_P
set_property PACKAGE_PIN A5  [get_ports MEZ2_PLL0_MUXOUT];     # MEZ2_14_N

set_property PACKAGE_PIN F2  [get_ports MEZ2_RESERVED_4];      # MEZ2_5_N
set_property PACKAGE_PIN B4  [get_ports MEZ2_RESERVED_5];      # MEZ2_6_N
set_property PACKAGE_PIN G2  [get_ports MEZ2_RESERVED_6];      # MEZ2_5_P
set_property PACKAGE_PIN H1  [get_ports MEZ2_RESERVED_0];      # MEZ2_22_N
set_property PACKAGE_PIN J1  [get_ports MEZ2_RESERVED_1];      # MEZ2_22_P

set_property IOSTANDARD LVCMOS18 [get_ports MEZ2_*]
set_property IOSTANDARD LVCMOS18 [get_ports MEZ1_*]
set_property IOSTANDARD LVDS     [get_ports MEZ2_PPS_IN_P]
set_property IOSTANDARD LVDS     [get_ports MEZ2_PPS_IN_N]
set_property IOSTANDARD LVDS     [get_ports MEZ2_PPS_OUT_P]
set_property IOSTANDARD LVDS     [get_ports MEZ2_PPS_OUT_N]
set_property IOSTANDARD LVDS     [get_ports MEZ2_SRC_CLK_P]
set_property IOSTANDARD LVDS     [get_ports MEZ2_SRC_CLK_N]

set_property PACKAGE_PIN Y12   [get_ports GRN_0]
set_property PACKAGE_PIN AB12  [get_ports RED_0]
set_property PACKAGE_PIN AB10  [get_ports BLU_0]
set_property PACKAGE_PIN Y15   [get_ports GRN_1]
set_property PACKAGE_PIN AA15  [get_ports RED_1]
set_property PACKAGE_PIN AA12  [get_ports BLU_1]
set_property IOSTANDARD LVCMOS33 [get_ports GRN_0]
set_property IOSTANDARD LVCMOS33 [get_ports RED_0]
set_property IOSTANDARD LVCMOS33 [get_ports BLU_0]
set_property IOSTANDARD LVCMOS33 [get_ports GRN_1]
set_property IOSTANDARD LVCMOS33 [get_ports RED_1]
set_property IOSTANDARD LVCMOS33 [get_ports BLU_1]

set_property PACKAGE_PIN L9    [get_ports MEMS_INT]
set_property PACKAGE_PIN M8    [get_ports RTC_INTA]
set_property PACKAGE_PIN L8    [get_ports MEMS_SYNC]
set_property IOSTANDARD LVCMOS18 [get_ports MEMS_INT]
set_property IOSTANDARD LVCMOS18 [get_ports RTC_INTA]
set_property IOSTANDARD LVCMOS18 [get_ports MEMS_SYNC]

set_property PACKAGE_PIN AB16  [get_ports PLD_2]
set_property PACKAGE_PIN AC16  [get_ports PLD_1]
set_property PACKAGE_PIN AC17  [get_ports PLD_0]
set_property PACKAGE_PIN AE16  [get_ports Tx1]
set_property PACKAGE_PIN AE15  [get_ports Rx1]
set_property PACKAGE_PIN AF15  [get_ports PV]
set_property PACKAGE_PIN AD16  [get_ports RESETN]
set_property PACKAGE_PIN AF24  [get_ports CAN1_TX]
set_property PACKAGE_PIN AF25  [get_ports CAN1_RX]
set_property PACKAGE_PIN AF14  [get_ports PPS]
set_property PACKAGE_PIN AE17  [get_ports Marker_0]
set_property PACKAGE_PIN AF13  [get_ports Marker_1]
set_property PACKAGE_PIN AF17  [get_ports Trig_0]
set_property IOSTANDARD LVCMOS33 [get_ports PLD_2]
set_property IOSTANDARD LVCMOS33 [get_ports PLD_1]
set_property IOSTANDARD LVCMOS33 [get_ports PLD_0]
set_property IOSTANDARD LVCMOS33 [get_ports Tx1]
set_property IOSTANDARD LVCMOS33 [get_ports Rx1]
set_property IOSTANDARD LVCMOS33 [get_ports PV]
set_property IOSTANDARD LVCMOS33 [get_ports RESETN]
set_property IOSTANDARD LVCMOS33 [get_ports CAN1_TX]
set_property IOSTANDARD LVCMOS33 [get_ports CAN1_RX]
set_property IOSTANDARD LVCMOS33 [get_ports PPS]
set_property IOSTANDARD LVCMOS33 [get_ports Marker_0]
set_property IOSTANDARD LVCMOS33 [get_ports Marker_1]
set_property IOSTANDARD LVCMOS33 [get_ports Trig_0]

set_property PACKAGE_PIN AA10  [get_ports RF_CLK_SEL]
set_property PACKAGE_PIN Y17   [get_ports RF_1_NCS]
set_property PACKAGE_PIN W14   [get_ports RF_2_NCS]
set_property PACKAGE_PIN Y13   [get_ports RF_SCLK]
set_property PACKAGE_PIN Y16   [get_ports RF_MOSI]
set_property PACKAGE_PIN Y10   [get_ports RF_MISO]
set_property IOSTANDARD LVCMOS33 [get_ports RF_CLK_SEL]
set_property IOSTANDARD LVCMOS33 [get_ports RF_1_NCS]
set_property IOSTANDARD LVCMOS33 [get_ports RF_2_NCS]
set_property IOSTANDARD LVCMOS33 [get_ports RF_SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports RF_MOSI]
set_property IOSTANDARD LVCMOS33 [get_ports RF_MISO]

set_property PACKAGE_PIN F14  [get_ports RF_sig[1]]
set_property PACKAGE_PIN D14  [get_ports RF_mag[1]]
set_property PACKAGE_PIN D16  [get_ports RF_sig[2]]
set_property PACKAGE_PIN C17  [get_ports RF_mag[2]]
set_property PACKAGE_PIN F15  [get_ports RF_sig[3]]
set_property PACKAGE_PIN E15  [get_ports RF_mag[3]]
set_property PACKAGE_PIN D13  [get_ports RF_sig[4]]
set_property PACKAGE_PIN B12  [get_ports RF_mag[4]]
set_property PACKAGE_PIN B15  [get_ports RF_sig[5]]
set_property PACKAGE_PIN C14  [get_ports RF_mag[5]]
set_property PACKAGE_PIN A15  [get_ports RF_sig[6]]
set_property PACKAGE_PIN B16  [get_ports RF_mag[6]]
set_property PACKAGE_PIN B17  [get_ports RF_sig[7]]
set_property PACKAGE_PIN E16  [get_ports RF_mag[7]]
set_property PACKAGE_PIN G15  [get_ports RF_sig[8]]
set_property PACKAGE_PIN G14  [get_ports RF_mag[8]]
set_property PACKAGE_PIN J14  [get_ports RF_CLK_out_p]
set_property PACKAGE_PIN H14  [get_ports RF_CLK_out_n]
set_property PACKAGE_PIN M6   [get_ports RF_CLK2_out_p]
set_property PACKAGE_PIN M5   [get_ports RF_CLK2_out_n]
set_property IOSTANDARD LVCMOS18 [get_ports RF_sig[*]]
set_property IOSTANDARD LVCMOS18 [get_ports RF_mag[*]]

set_property IOSTANDARD LVDS     [get_ports RF_CLK_out_p]
set_property IOSTANDARD LVDS     [get_ports RF_CLK2_out_p]

# set_property PACKAGE_PIN R6    [get_ports MGTX_REFCLK0P]
# set_property PACKAGE_PIN R5    [get_ports MGTX_REFCLK0N]
# set_property PACKAGE_PIN U6    [get_ports MGTX_REFCLK1P]
# set_property PACKAGE_PIN U5    [get_ports MGTX_REFCLK1N]
# set_property PACKAGE_PIN AA2   [get_ports MGTX_TXP0]
# set_property PACKAGE_PIN AA1   [get_ports MGTX_TXN0]
# set_property PACKAGE_PIN AB4   [get_ports MGTX_RXP0]
# set_property PACKAGE_PIN AB3   [get_ports MGTX_RXN0]

# False Paths
set_false_path -from [get_clocks clk_fpga_1] -to [get_clocks core_clk*]
set_false_path -from [get_clocks core_clk*] -to [get_clocks clk_fpga_1]

set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks core_clk*]
set_false_path -from [get_clocks core_clk*] -to [get_clocks clk_fpga_0]


# EOB

