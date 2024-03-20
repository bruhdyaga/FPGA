`include "global_param.v"
`include "trcv.svh"
`include "rgb.svh"
`include "axi_uart.svh"
`include "decimator.svh"
`include "dma.svh"

module cometicus(
  // ARM
  arm_interface.master arm
  
  // LED
  ,output RED_0
  ,output GRN_0
  ,output BLU_0
  ,output RED_1
  ,output GRN_1
  ,output BLU_1
  
  // DAC
  ,input wire DAC_D0
  ,input wire DAC_D1
  ,input wire DAC_D2
  ,input wire DAC_D3
  ,input wire DAC_D4
  ,input wire DAC_D5
  ,input wire DAC_D6
  ,input wire DAC_D7
  ,input wire DAC_D8
  ,input wire DAC_D9
  ,input wire DAC_D10
  ,input wire DAC_D12
  ,input wire DAC_D11
  ,input wire DAC_D13

  // ADC
  ,input wire ADC_OUT4B_P     // INVERT !!
  ,input wire ADC_OUT4B_N     // INVERT !!
  ,input wire ADC_OUT4A_P     // INVERT !!
  ,input wire ADC_OUT4A_N     // INVERT !!

  ,input wire ADC_OUT3B_P
  ,input wire ADC_OUT3B_N
  ,input wire ADC_OUT3A_P     // INVERT !!
  ,input wire ADC_OUT3A_N     // INVERT !!

  ,input wire ADC_OUT2B_P     // INVERT !!
  ,input wire ADC_OUT2B_N     // INVERT !!
  ,input wire ADC_OUT2A_P
  ,input wire ADC_OUT2A_N

  ,input wire ADC_OUT1B_P
  ,input wire ADC_OUT1B_N
  ,input wire ADC_OUT1A_P
  ,input wire ADC_OUT1A_N

  ,input wire ADC_FR_P        // INVERT !!
  ,input wire ADC_FR_N        // INVERT !!
  ,input wire ADC_DCO_P       // INVERT !!
  ,input wire ADC_DCO_N       // INVERT !!

  // PLD
  ,input  wire PLD_2
  ,input  wire PLD_1
  ,input  wire PLD_0
  ,output wire Tx1
  ,input  wire Rx1
  ,output wire PV
  ,input  wire RESETN
  ,input  wire CAN1_TX
  ,input  wire CAN1_RX
  ,output wire PPS
  ,input  wire Marker_0
  ,input  wire Marker_1
  ,input  wire Trig_0
  
  // NOMADA NT1065
  ,output wire RF_CLK_SEL
  ,output wire RF_1_NCS
  ,output wire RF_2_NCS
  ,output wire RF_SCLK
  ,output wire RF_MOSI
  ,input  wire RF_MISO
  
  // DA1, DA11
  ,input  [8:1] RF_sig
  ,input  [8:1] RF_mag
  ,input  RF_CLK_out_p
  ,input  RF_CLK_out_n
  ,input  RF_CLK2_out_p
  ,input  RF_CLK2_out_n
  
  // MISC I2C
  ,output MEMS_SYNC
  ,input  MEMS_INT
  ,input  RTC_INTA
  
  // MEZ MGTX NC
  // ,input wire MGTX_REFCLK0P   // 100 MHz in ZQ1
  // ,input wire MGTX_REFCLK0N   // 100 MHz in ZQ1
  // ,input wire MGTX_REFCLK1P
  // ,input wire MGTX_REFCLK1N
  // ,input wire MGTX_TXP0
  // ,input wire MGTX_TXN0
  // ,input wire MGTX_RXP0
  // ,input wire MGTX_RXN0
  
  // MEZ 1
  ,output wire MEZ1_LED_A          // MEZ1_44
  ,output wire MEZ1_LED_B          // MEZ1_38
  ,output wire MEZ1_LED_C          // MEZ1_36

  ,output wire MEZ1_ADC_CS         // MEZ1_16
  ,output wire MEZ1_DAC_CS         // MEZ1_15
  ,output wire MEZ1_ATT_0_CS       // MEZ1_12
  ,output wire MEZ1_ATT_1_CS       // MEZ1_10
  ,output wire MEZ1_ATT_2_CS       // MEZ1_11

  ,output wire MEZ1_PLL0_CS        // MEZ1_6
  ,input  wire MEZ1_PLL0_LD        // MEZ1_18
  ,output wire MEZ1_PLL1_CS        // MEZ1_2
  ,input  wire MEZ1_PLL1_LD        // MEZ1_1
  ,input  wire MEZ1_PLL1_MUXOUT    // MEZ1_41

  ,input  wire MEZ1_SPI_SDO        // MEZ1_17
  ,output wire MEZ1_SPI_SDI        // MEZ1_8
  ,output wire MEZ1_SPI_CLK        // MEZ1_0
  ,inout  wire MEZ1_SPI_2_SDO      // MEZ1_37
  ,output wire MEZ1_SPI_2_SDI      // MEZ1_35  // X12, pin 8
  ,output wire MEZ1_SPI_2_CLK      // MEZ1_33
  ,output wire MEZ1_DAC_SPI_RESET  // MEZ1_40

  ,output wire MEZ1_CONV_CLK_SEL   // MEZ1_14
  ,output wire MEZ1_RF_CLK_SEL     // MEZ1_4

  ,inout wire MEZ1_I2C_SCL         // MEZ1_9
  ,inout wire MEZ1_I2C_SDA         // MEZ1_7

  ,input wire MEZ1_RESERVED_9      // MEZ1_42
  ,input wire MEZ1_RESERVED_3      // MEZ1_39
  ,input wire MEZ1_RESERVED_2      // MEZ1_13
  ,input wire MEZ1_RESERVED_8      // MEZ1_5
  ,input wire MEZ1_RESERVED_7      // MEZ1_3
  // MEZ 2
  ,output wire MEZ2_PPS_OUT_P      // MEZ2_1_P
  ,output wire MEZ2_PPS_OUT_N      // MEZ2_1_N
  ,input  wire MEZ2_PPS_IN_P       // MEZ2_21_P
  ,input  wire MEZ2_PPS_IN_N       // MEZ2_21_N
  ,input  wire MEZ2_PLL0_MUXOUT    // MEZ2_14_N

  ,input wire MEZ2_SRC_CLK_N       // MEZ2_10_N
  ,input wire MEZ2_SRC_CLK_P       // MEZ2_10_P

  ,input wire MEZ2_RESERVED_4      // MEZ2_5_N
  ,input wire MEZ2_RESERVED_5      // MEZ2_6_N
  ,input wire MEZ2_RESERVED_6      // MEZ2_5_P
  ,input wire MEZ2_RESERVED_0      // MEZ2_22_N
  ,input wire MEZ2_RESERVED_1      // MEZ2_22_P

  // MEZ X12
  ,input wire RESERVED_9
  ,input wire RESERVED_3
  ,input wire RESERVED_2
  ,input wire RESERVED_8
  ,input wire RESERVED_7
  ,input wire RESERVED_4
  ,input wire RESERVED_5
  ,input wire RESERVED_6
  ,input wire RESERVED_0
  ,input wire RESERVED_1
);

// ADC LTC2175 interface
  wire [9:0] sADClvdsPpin;
  wire [9:0] sADClvdsNpin;
  wire [9:0] sADClvdsP;
  wire [9:0] sADClvdsN;

  assign sADClvdsPpin = {
    ADC_DCO_P, ADC_FR_P,
    ADC_OUT4B_P, ADC_OUT4A_P, ADC_OUT3B_P, ADC_OUT3A_P,
    ADC_OUT2B_P, ADC_OUT2A_P, ADC_OUT1B_P, ADC_OUT1A_P
  };

  assign sADClvdsNpin = {
    ADC_DCO_N, ADC_FR_N,
    ADC_OUT4B_N, ADC_OUT4A_N, ADC_OUT3B_N, ADC_OUT3A_N,
    ADC_OUT2B_N, ADC_OUT2A_N, ADC_OUT1B_N, ADC_OUT1A_N
  };

  // invert data
  // 10bit - {Dco,Fr,4b,4a,3b,3a,2b,2a,1b,1a}
  localparam bit[9:0] SwapAdc = 10'b1111011000;

  genvar i;
  generate
  for(i = 0;i <10; i = i + 1) begin : g_SwapLines
    assign sADClvdsP[i] = (SwapAdc[i]) ? sADClvdsNpin[i] : sADClvdsPpin[i];
    assign sADClvdsN[i] = (SwapAdc[i]) ? sADClvdsPpin[i] : sADClvdsNpin[i];
  end
  endgenerate
  
  wire        sADCclk;
  wire [13:0] sADCdata [3:0];
  deserLTC217x deserLTC217x_i (
    .iADCclkP (sADClvdsP[9]),
    .iADCclkN (sADClvdsN[9]),
    .iADCfrmP (sADClvdsP[8]),
    .iADCfrmN (sADClvdsN[8]),
    .iADCdataP(sADClvdsP[7:0]),
    .iADCdataN(sADClvdsN[7:0]),

    .iClkRef    (sClk200    ),
    .iClkRefLock(mmcm_locked),

    .oClk    (sADCclk),
    .oADCdata(sADCdata)
  );

localparam NBUSES    = 6;
localparam ADC_PORTS = 10;

wire ref_clk_src;
wire rx_clk = AD_rx_clk;
wire pps_in_ext_board;
wire pps_out;
wire mez1_test0;
wire mez1_test1;
wire mez1_test2;
wire mez2_test2;
wire mez2_test1;
wire mez2_test0;
wire ref_clk_ext;
wire AD_rx_clk;
wire PCLK_MUX;

wire CPU_MISO;
wire CPU_MOSI;
wire CPU_SCLK;

// ADC interface
adc_interf#(
    .PORTS (ADC_PORTS), // 0 - imitator
    .R     (2)
)adc ();

// IMI interface
imi_interf#(
    .WIDTH (`IMI_OUTWIDTH)
)imi ();

axi3_interface   m_axi3[`M_AXI_GP_NUM]();
axi3_interface#(
    .ID_WIDTH (6)
)s_axi3();

intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)int_bus[`M_AXI_GP_NUM]();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus_sl[NBUSES]();

wire fix_pulse;
wire irq;
wire [3:0] axi_uart_irq;
wire [31:0] gpio_i;
wire [31:0] gpio_o;
wire [31:0] gpio_t;

cpu_top cpu_top_inst(
    .arm           (arm),
    .m_axi3        (m_axi3),
    .s_axi3        (s_axi3),
    .gpio_i        (gpio_i),
    .gpio_o        (gpio_o),
    .gpio_t        (gpio_t),
    .irq           ({axi_uart_irq,irq}),
    .clk_50        (clk_50),
    .uart_1_rxd    (Rx1),
    .uart_1_txd    (Tx1)
);

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_0_inst(
    .axi3    (m_axi3[0]),
    .int_bus (int_bus[0])
);

connectbus#(
    .N_BUSES    (NBUSES),
    .OUTFF      ("y"),
    .MASTERFF   ("y")
) connectbus_0_inst(
    .master_bus (int_bus[0]),
    .slave_bus  (bus_sl)
);

wire core_clk;
wire core_clk_unbuf;
wire sClk200;
wire sClk200_unbuf;
wire mmcm_locked;
reg  mmcm_reset;
MMCME2_ADV  #(
    .BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKOUT1_DIVIDE       (`FACQ_FREQ_DIV),
    .CLKOUT2_DIVIDE       (5),
    .CLKOUT3_DIVIDE       (1),
    .CLKOUT4_DIVIDE       (1),
    .CLKOUT5_DIVIDE       (1),
    .CLKOUT6_DIVIDE       (1),
    .CLKFBOUT_MULT_F      (20.000),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (5),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (20.000),
    .REF_JITTER1          (0.010))
MMCM (
    .CLKFBOUT            (CLKFBOUT),
    .CLKFBOUTB           (),
    .CLKOUT0             (),
    .CLKOUT0B            (),
    .CLKOUT1             (core_clk_unbuf),
    .CLKOUT1B            (),
    .CLKOUT2             (sClk200_unbuf),
    .CLKOUT2B            (),
    .CLKOUT3             (),
    .CLKOUT3B            (),
    .CLKOUT4             (),
    .CLKOUT5             (),
    .CLKOUT6             (),
    .CLKFBIN             (CLKFBOUT),
    .CLKIN1              (clk_50),
    .CLKIN2              (1'b0),
    .CLKINSEL            (1'b1),
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (),
    .DRDY                (),
    .DWE                 (1'b0),
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (),
    .LOCKED              (mmcm_locked),
    .CLKINSTOPPED        (),
    .CLKFBSTOPPED        (),
    .PWRDWN              (1'b0),
    .RST                 (mmcm_reset)
);

BUFG BUFG_CORE_CLK (
    .O (core_clk),
    .I (core_clk_unbuf)
);

BUFG BUFG_CLK200 (
    .O (sClk200),
    .I (sClk200_unbuf)
);

// Городим схему ресета для MMCM
reg [20:0] lock_counter = 0;  // считает 100 мс (при клоках 20 МГц) пока устаканится DCM
always @(posedge clk_50)
begin
    lock_counter <= lock_counter + 1'b1;
end

reg [2:0] mmcm_reset_count = 0; // нужен чтобы держать reset несколько тактов как положено по даташиту
always @(posedge clk_50)
if (lock_counter[20:0] == {21{1'b1}})
    mmcm_reset_count <= 0;
else
    mmcm_reset_count <= mmcm_reset_count + 1'b1;

always @(posedge clk_50)
if (lock_counter[20:0] == {21{1'b1}})
    if (!mmcm_locked)
        mmcm_reset <= 1'b1;
    else
        mmcm_reset <= 1'b0;
else
    if (mmcm_reset_count[2:0] == {3{1'b1}})
        mmcm_reset <= 1'b0;

wire rf_clk_0;
wire rf_clk_1;
IBUFGDS #(
    .DIFF_TERM ("TRUE")
) IBUFGDS_RF_0(
    .I   (RF_CLK_out_p),
    .IB  (RF_CLK_out_n),
    .O   (rf_clk_0)
);
IBUFGDS #(
    .DIFF_TERM ("TRUE")
) IBUFGDS_RF_1(
    .I   (RF_CLK2_out_p),
    .IB  (RF_CLK2_out_n),
    .O   (rf_clk_1)
);

BUFGMUX#(
    .CLK_SEL_TYPE ("ASYNC")
) ADC_CLK_MUX(
    .O  (adc.clk),
    .I0 (AD_rx_clk), // S=0
    .I1 (rf_clk_0),  // S=1
    .S  (PCLK_MUX)
);

assign adc.valid  = '1;

assign adc.data[0]  = {imi.In[`IMI_OUTWIDTH-1],1'b0}; // for imi I
assign adc.data[1]  = {imi.Qn[`IMI_OUTWIDTH-1],1'b0}; // for imi Q
for(genvar i = 0; i <= 7; i ++) begin: IDDR_ADC
IDDR #(
    .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED" 
    .INIT_Q1     (1'b0),            // Initial value of Q1: 1'b0 or 1'b1
    .INIT_Q2     (1'b0),            // Initial value of Q2: 1'b0 or 1'b1
    .SRTYPE      ("SYNC")           // Set/Reset type: "SYNC" or "ASYNC" 
) IDDR_sig_inst (
    .Q1(adc.data[i+2][1]), // 1-bit output for positive edge of clock
    .Q2(),               // 1-bit output for negative edge of clock
    .C (adc.clk),        // 1-bit clock input
    .CE('1),             // 1-bit clock enable input
    .D (RF_sig[i+1]),       // 1-bit DDR data input
    .R ('0),             // 1-bit reset
    .S ('0)              // 1-bit set
);
IDDR #(
    .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED" 
    .INIT_Q1     (1'b0),            // Initial value of Q1: 1'b0 or 1'b1
    .INIT_Q2     (1'b0),            // Initial value of Q2: 1'b0 or 1'b1
    .SRTYPE      ("SYNC")           // Set/Reset type: "SYNC" or "ASYNC" 
) IDDR_mag_inst (
    .Q1(adc.data[i+2][0]), // 1-bit output for positive edge of clock
    .Q2(),                 // 1-bit output for negative edge of clock
    .C (adc.clk),          // 1-bit clock input
    .CE('1),               // 1-bit clock enable input
    .D (RF_mag[i+1]),      // 1-bit DDR data input
    .R ('0),               // 1-bit reset
    .S ('0)                // 1-bit set
);
end

  wire [11:0] ad_data_mean_I, ad_data_mean_Q;
  // mean_compens_v3#(
    // .WIDTH   (12),
    // .PERIODN (12)
  // ) mean_compens_v3_AD9361_I(
    // .clk      (adc.clk),
    // .we       ('1),
    // .data_in  (AD_I),
    // .data_out (ad_data_mean_I),
    // .valid    ()
  // );

  // mean_compens_v3#(
    // .WIDTH   (12),
    // .PERIODN (12)
  // ) mean_compens_v3_AD9361_Q(
    // .clk      (adc.clk),
    // .we       ('1),
    // .data_in  (AD_Q),
    // .data_out (ad_data_mean_Q),
    // .valid    ()
  // );
  
  // sig_mag_v3#(
    // .WIDTH (12)
  // )sig_mag_v3_AD9361_I(
    // .clk        (adc.clk),
    // .data_in    (ad_data_mean_I),
    // .we         ('1),
    // .clr        ('0),
    // .sig        (adc.data[10][1]),
    // .mag        (adc.data[10][0]),
    // .valid      (),
    // .por_out    (),
    // .por_in     ('0),
    // .por_manual ('0)
  // );
  
  // sig_mag_v3#(
    // .WIDTH (12)
  // )sig_mag_v3_AD9361_Q(
    // .clk        (adc.clk),
    // .data_in    (ad_data_mean_Q),
    // .we         ('1),
    // .clr        ('0),
    // .sig        (adc.data[11][1]),
    // .mag        (adc.data[11][0]),
    // .valid      (),
    // .por_out    (),
    // .por_in     ('0),
    // .por_manual ('0)
  // );
    
// assign adc.data[10]  = AD_I[11:10]; // DEBUG: I data from AD9361
// assign adc.data[11]  = AD_Q[11:10]; // DEBUG: Q data from AD9361

localparam TRCV_BASE_ADDR = `HUBSIZE;
trcv#(
    .BASEADDR        (TRCV_BASE_ADDR),
    .ADC_PORTS       (ADC_PORTS)
) TRCV(
    .bus           (bus_sl[0]),
    .adc           (adc),
    .core_clk      (core_clk),
    .fix_pulse     (fix_pulse), // out
    .irq           (irq), // out
    .pps_in        (pps_in_ext_board),
    .pps_out       (pps_out),
    .imi           (imi)
);

localparam FREQ_CNTR_BASE_ADDR = TRCV_BASE_ADDR + `TRCV_FULL_SIZE;
localparam FREQ_CHANNELS = 10;

localparam logic [7 : 0] FREQ_ID [FREQ_CHANNELS - 1 : 0] = '{
    8'hA0, // axi_0
    8'hFA, // facq
    8'h0E, // nomada_clk_0
    8'h0F, // nomada_clk_1
    8'h0A, // adc.clk
    8'h01, // irq
    8'h02, // fix_pulse
    8'h00, // AD_rx_clk //!!!
    8'h00, // ref_clk_src
    8'h00  // rx_clk
};

freq_counter#(
    .BASEADDR    (FREQ_CNTR_BASE_ADDR),
    .CHANNELS    (FREQ_CHANNELS),
    .FREQ_REF_HZ (50_000_000),
    .MAX_FREQ    (200_000_000),
    .PERIOD_MS   (10),
    .FREQ_ID     (FREQ_ID),
    .PULSE_MODE  ('b0001100000)
) FREQ_COUNTER(
    .bus     (bus_sl[1]),
    .ref_clk (clk_50),
    .in_clk  ({rx_clk,ref_clk_src,AD_rx_clk,fix_pulse,irq,adc.clk,rf_clk_1,rf_clk_0,core_clk,m_axi3[0].aclk})
);

localparam RGB_0_BASE_ADDR = FREQ_CNTR_BASE_ADDR + 4 + FREQ_CHANNELS;
rgb#(
    .BASEADDR (RGB_0_BASE_ADDR)
) RGB_0(
    .bus (bus_sl[2]),
    .R   (RED_0),
    .G   (GRN_0),
    .B   (BLU_0)
);

localparam RGB_1_BASE_ADDR = RGB_0_BASE_ADDR + `RGB_FULL_SIZE;
rgb#(
    .BASEADDR (RGB_1_BASE_ADDR)
) RGB_1(
    .bus (bus_sl[3]),
    .R   (RED_1),
    .G   (GRN_1),
    .B   (BLU_1)
);

localparam RGB_2_BASE_ADDR = RGB_1_BASE_ADDR + `RGB_FULL_SIZE;
rgb#(
    .BASEADDR (RGB_2_BASE_ADDR)
) RGB_2(
    .bus (bus_sl[4]),
    .R   (MEZ1_LED_A),
    .G   (MEZ1_LED_B),
    .B   (MEZ1_LED_C)
);

// assign PV       = '0;
// assign Marker_0 = fix_pulse;
// assign Marker_1 = '0;
// assign CAN1_TX  = '0;

ODDR #(
    .DDR_CLK_EDGE ("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
    .INIT         (1'b0),            // Initial value of Q: 1'b0 or 1'b1
    .SRTYPE       ("SYNC")           // Set/Reset type: "SYNC" or "ASYNC" 
) ODDR_PV_inst (
    .Q  (PV),       // 1-bit DDR output
    .C  (adc.clk),   // 1-bit clock input
    .CE ('1),        // 1-bit clock enable input
    .D1 ('1),   // 1-bit data input (positive edge)
    .D2 ('0),   // 1-bit data input (negative edge)
    .R  ('0),        // 1-bit reset
    .S  ('0)         // 1-bit set
);
assign PPS = pps_out;

// gpio I2C connection - not used
  IOBUF #(
    .DRIVE        (12),        // Specify the output drive strength
    .IBUF_LOW_PWR ("TRUE"),    // Low Power - "TRUE", High Performance = "FALSE" 
    .IOSTANDARD   ("DEFAULT"), // Specify the I/O standard
    .SLEW         ("SLOW")     // Specify the output slew rate
  ) IOBUF_MEZ1_I2C_SDA_inst (
    .O  (gpio_i[31]),         // Buffer output
    .IO (MEZ1_I2C_SDA),       // Buffer inout port (connect directly to top-level port)
    .I  (gpio_o[31]),         // Buffer input
    .T  (gpio_t[31])          // 3-state enable input, high=input, low=output
  );
  
  IOBUF #(
    .DRIVE        (12),        // Specify the output drive strength
    .IBUF_LOW_PWR ("TRUE"),    // Low Power - "TRUE", High Performance = "FALSE" 
    .IOSTANDARD   ("DEFAULT"), // Specify the I/O standard
    .SLEW         ("SLOW")     // Specify the output slew rate
  ) IOBUF_MEZ1_I2C_SCL_inst (
    .O  (gpio_i[30]),         // Buffer output
    .IO (MEZ1_I2C_SCL),       // Buffer inout port (connect directly to top-level port)
    .I  (gpio_o[30]),         // Buffer input
    .T  (gpio_t[30])          // 3-state enable input, high=input, low=output
  );
// gpio continue
  //
  assign gpio_i[20]         =  MEZ1_PLL1_LD;
  assign gpio_i[19]         =  MEZ1_PLL0_LD;
  assign MEZ1_PLL1_CS       =  gpio_o[18];
  assign MEZ1_PLL0_CS       =  gpio_o[17];
  assign MEZ1_ATT_2_CS      =  gpio_o[16];
  assign MEZ1_ATT_1_CS      =  gpio_o[15];
  assign gpio_i[14]         =  irq;
  assign MEZ1_ATT_0_CS      =  gpio_o[13];
  assign MEZ1_DAC_SPI_RESET =  gpio_o[12];
  assign MEZ1_DAC_CS        =  gpio_o[11];
  // connected to SDIO DAC AD9707
  IOBUF #(
    .DRIVE        (12),        // Specify the output drive strength
    .IBUF_LOW_PWR ("TRUE"),    // Low Power - "TRUE", High Performance = "FALSE" 
    .IOSTANDARD   ("DEFAULT"), // Specify the I/O standard
    .SLEW         ("SLOW")     // Specify the output slew rate
  ) IOBUF_MEZ1_SPI_2_SDO_inst (
    .O  (gpio_i[10]),         // Buffer output
    .IO (MEZ1_SPI_2_SDO),     // Buffer inout port (connect directly to top-level port)
    .I  (gpio_o[10]),         // Buffer input
    .T  (gpio_t[10])          // 3-state enable input, high=input, low=output
  );
  assign MEZ1_ADC_CS        =  gpio_o[ 9];
  assign MEZ1_CONV_CLK_SEL  =  gpio_o[ 8];
  assign RF_2_NCS           =  gpio_o[ 7];
  assign RF_1_NCS           =  gpio_o[ 6];
  assign MEZ1_RF_CLK_SEL    =  gpio_o[ 5];
  assign RF_CLK_SEL         = !gpio_o[ 4];
  assign PCLK_MUX           =  gpio_o[ 3];
  assign gpio_i[2]          =  CPU_MISO;
  assign CPU_MOSI           =  gpio_o[1];
  assign CPU_SCLK           =  gpio_o[0];

  assign CPU_MISO   = ((RF_1_NCS & RF_2_NCS) == '0) ? RF_MISO : MEZ1_SPI_SDO;

  assign RF_SCLK           = CPU_SCLK;
  assign MEZ1_SPI_CLK      = CPU_SCLK;
  assign MEZ1_SPI_2_CLK    = CPU_SCLK;

  assign RF_MOSI           = CPU_MOSI;
  assign MEZ1_SPI_SDI      = CPU_MOSI;
  assign MEZ1_SPI_2_SDI    = CPU_MOSI; // X12, pin 8

  assign MEMS_SYNC         = 1'b0;
// PPS
ODDR #(
    .DDR_CLK_EDGE ("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
    .INIT         (1'b0),            // Initial value of Q: 1'b0 or 1'b1
    .SRTYPE       ("SYNC")           // Set/Reset type: "SYNC" or "ASYNC" 
) ODDR_PPS_inst (
    .Q  (pps_out_ddr), // 1-bit DDR output
    .C  (adc.clk),     // 1-bit clock input
    .CE ('1),          // 1-bit clock enable input
    .D1 (pps_out),     // 1-bit data input (positive edge)
    .D2 (pps_out),     // 1-bit data input (negative edge)
    .R  ('0),          // 1-bit reset
    .S  ('0)           // 1-bit set
);

OBUFDS #(
    .IOSTANDARD ("LVDS"), // Specify the output I/O standard
    .SLEW       ("FAST")  // Specify the output slew rate
) OBUFDS_PPS_OUT (
    .O  (MEZ2_PPS_OUT_P),
    .OB (MEZ2_PPS_OUT_N),
    .I  (pps_out_ddr)
);

IBUFDS #(
    .DIFF_TERM    ("TRUE"),     // Differential Termination
    .IBUF_LOW_PWR ("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    .IOSTANDARD   ("DEFAULT")   // Specify the input I/O standard
) IBUFDS_PPS_IN (
    .O  (pps_in_ext_board_buf),
    .I  (MEZ2_PPS_IN_P),
    .IB (MEZ2_PPS_IN_N)
);

IDDR #(
    .DDR_CLK_EDGE ("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED" 
    .INIT_Q1      (1'b0),                  // Initial value of Q1: 1'b0 or 1'b1
    .INIT_Q2      (1'b0),                  // Initial value of Q2: 1'b0 or 1'b1
    .SRTYPE       ("SYNC")                 // Set/Reset type: "SYNC" or "ASYNC" 
) IDDR_PPS_inst(
    .Q1 (pps_in_ext_board_iddr), // 1-bit output for positive edge of clock
    .Q2 (),                      // 1-bit output for negative edge of clock
    .C  (adc.clk),               // 1-bit clock input
    .CE ('1),                    // 1-bit clock enable input
    .D  (pps_in_ext_board_buf),  // 1-bit DDR data input
    .R  ('0),                    // 1-bit reset
    .S  ('0)                     // 1-bit set
);

level_sync PPS_SYNC(
    .clk     (adc.clk),
    .async   (pps_in_ext_board_iddr),
    .sync    (pps_in_ext_board)
);

wire ref_clk_src_unbuf;
IBUFDS #(
    .DIFF_TERM    ("TRUE"),     // Differential Termination
    .IBUF_LOW_PWR ("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    .IOSTANDARD   ("DEFAULT")   // Specify the input I/O standard
) IBUFDS_REF_CLK_SRC (
    .O  (ref_clk_src_unbuf),
    .I  (MEZ2_SRC_CLK_P),
    .IB (MEZ2_SRC_CLK_N)
);

BUFR #(
   .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
   .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
)
BUFR_ref_clk_src (
   .O  (ref_clk_src),      // 1-bit output: Clock output port
   .CE (1'b1),             // 1-bit input: Active high, clock enable (Divided modes only)
   .CLR(1'b0),             // 1-bit input: Active high, asynchronous clear (Divided modes only)
   .I  (ref_clk_src_unbuf) // 1-bit input: Clock buffer input driven by an IBUF, MMCM or local interconnect
);

localparam BASE_DMA = RGB_2_BASE_ADDR + `RGB_FULL_SIZE;
dma#(
    .BASEADDR (BASE_DMA)
) dma_inst(
    .bus     (bus_sl[5]),
    .s_axi3  (s_axi3),
    .irq     (irq)
);

wire [11:0] AD_I;
wire [11:0] AD_Q;
wire adc_pn_oos;
wire adc_pn_err;
wire [ 7:0] sDbgAD936X;

localparam BASE_AD936X_DESER = BASE_DMA + `DMA_STRUCT_FULL_SIZE;
// AD936X_ddr_deser #(
    // .BASEADDR (BASE_AD936X_DESER)
  // ) AD936X_ddr_deser_inst(
    // .iClk       (core_clk),
    // .iClk200MHz (sClk200),
    // .iLock200MHz(mmcm_locked),
    // .bus        (bus_sl[6]),
    // .RX_CLK_P   (AD_RX_CLK_P),
    // .RX_CLK_N   (AD_RX_CLK_N),
    // .RX_FRAME_P (AD_RX_FRAME_P),
    // .RX_FRAME_N (AD_RX_FRAME_N),
    // .RX_D_P     (AD_RX_D_P),
    // .RX_D_N     (AD_RX_D_N),
    // .TX_CLK_P   (AD_TX_CLK_P),
    // .TX_CLK_N   (AD_TX_CLK_N),
    // .TX_FRAME_P (AD_TX_FRAME_P),
    // .TX_FRAME_N (AD_TX_FRAME_N),
    // .TX_D_P     (AD_TX_D_P),
    // .TX_D_N     (AD_TX_D_N),
    // .oClk       (AD_rx_clk),
    // .I_rx       (AD_I),
    // .Q_rx       (AD_Q),
    // .I_tx       (imi.I),
    // .Q_tx       (imi.Q),
    // .oDbg       (sDbgAD936X),
    // .resetn     (gpio_o[19])
// );


// assign Marker_1 = sDbgAD936X[1];  // XP12, pin 20 - yellow
// assign Marker_0 = sDbgAD936X[0];  // XP12, pin 8  - green

// localparam BASE_AD936X_DATCOLL = BASE_AD936X_DESER + `AD936X_DESER_FULL_SIZE;
  // data_collector#(
    // .BASEADDR   (BASE_AD936X_DATCOLL),
    // .NUM_PORTS  (4),
    // .DATA_WIDTH (12),
    // .DATA_DEPTH (4_096)
  // ) DATA_COLLECTOR(
    // .clk    (AD_rx_clk),
    // .we     ('1),
    // .data   ({imi.Q, imi.I, AD_Q, AD_I}),
    // .bus    (bus_sl[7])
  // );

endmodule
