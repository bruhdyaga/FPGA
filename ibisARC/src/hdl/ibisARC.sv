`include "global_param.v"
`include "trcv.svh"
`include "rgb.svh"
`include "axi_uart.svh"
`include "decimator.svh"
`include "dma.svh"

module ibisARC(
  // AXI3
  axi3_interface m_axi3
  // clocks
  ,input CLK_50
  ,input CORE_CLK
  // IRQ
  ,output IRQ
  // PPS  
  ,output PPS_OUT
  ,input  PPS_IN
  // RF ADC
  ,input  [16:1] RF_sig
  ,input  [16:1] RF_mag
  ,input         RF_CLK
);

// wires
  wire pps_in_sync;
  wire fix_pulse;
  wire irq;

// ADC interface
  localparam ADC_PORTS = 18;
  adc_interf#(
    .PORTS (ADC_PORTS), // 0,1 - imitator, 2..18 - ext ADC
    .R     (2)
  )adc ();

// IMI interface
  imi_interf#(
    .WIDTH (`IMI_OUTWIDTH)
  )imi ();

// AXI3 interface
// axi3_interface   m_axi3[`M_AXI_GP_NUM](); // connected from the top

// internal bus interface
  intbus_interf#(.ADDR_WIDTH (`ADDR_WIDTH) ) int_bus();

// AXI3 to internal bus
  axi3_to_inter#(
      .ADDR_WIDTH (`ADDR_WIDTH)
  )axi3_to_inter_0_inst(
      .axi3    (m_axi3),
      .int_bus (int_bus)
  );

// connect bus
  localparam NBUSES = 2;
  intbus_interf#(.ADDR_WIDTH (`ADDR_WIDTH) )bus_sl[NBUSES]();
  
  connectbus#(
      .N_BUSES    (NBUSES),
      .OUTFF      ("y"),
      .MASTERFF   ("y")
  ) connectbus_0_inst(
      .master_bus (int_bus),
      .slave_bus  (bus_sl)
  );

  assign adc.clk    = RF_CLK;
  assign adc.valid  = '1;

  assign adc.data[0]  = {imi.In[`IMI_OUTWIDTH-1],1'b0}; // for imi I
  assign adc.data[1]  = {imi.Qn[`IMI_OUTWIDTH-1],1'b0}; // for imi Q
  for(genvar i = 0; i <= 15; i ++) begin: INPUT_ADC
    assign adc.data[i+2][1] = RF_sig[i+1];
    assign adc.data[i+2][0] = RF_mag[i+1];
  end

  localparam TRCV_BASE_ADDR = `HUBSIZE;
  trcv#(
      .BASEADDR      (TRCV_BASE_ADDR),
      .ADC_PORTS     (ADC_PORTS)
  ) TRCV(
      .bus           (bus_sl[0]),
      .adc           (adc),
      .core_clk      (CORE_CLK),
      .fix_pulse     (fix_pulse), // out
      .irq           (IRQ),       // out
      .pps_in        (pps_in_sync),
      .pps_out       (PPS_OUT),
      .imi           (imi)
  );

  localparam FREQ_CNTR_BASE_ADDR = TRCV_BASE_ADDR + `TRCV_FULL_SIZE;
  localparam FREQ_CHANNELS = 6;

  localparam logic [7 : 0] FREQ_ID [FREQ_CHANNELS - 1 : 0] = '{
      8'hA0, // axi_0
      8'hFA, // facq
      8'h0E, // RF_CLK
      8'h0A, // adc.clk
      8'h01, // IRQ
      8'h02  // fix_pulse
  };

  freq_counter#(
      .BASEADDR    (FREQ_CNTR_BASE_ADDR),
      .CHANNELS    (FREQ_CHANNELS),
      .FREQ_REF_HZ (50_000_000   ),
      .MAX_FREQ    (200_000_000  ),
      .PERIOD_MS   (10),
      .FREQ_ID     (FREQ_ID ),
      .PULSE_MODE  ('b110000)
  ) FREQ_COUNTER(
      .bus     (bus_sl[1]),
      .ref_clk (CLK_50),
      .in_clk  ({fix_pulse
                ,IRQ
                ,adc.clk
                ,RF_CLK
                ,CORE_CLK
                ,m_axi3.aclk
               })
  );

  localparam NEXT_AVAILABLE_BASE_ADDR = FREQ_CNTR_BASE_ADDR + 4 + FREQ_CHANNELS;
  
  level_sync PPS_SYNC(
      .clk     (adc.clk),
      .async   (PPS_IN),
      .sync    (pps_in_sync)
  );

endmodule
