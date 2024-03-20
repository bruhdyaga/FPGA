`timescale 1 ns / 1 ns

module tb;

  reg CORE_CLK = 0;
  always
    #2 CORE_CLK = ~CORE_CLK;

  reg CLK_50 = 0;
  always
    #10 CLK_50 = ~CLK_50;
  
  reg CLK_RF = 0;
  always
    #100 CLK_RF = ~CLK_RF;

  axi3_interface s_axi3();
  
  ibisARC UUT (
    // AXI3
    .m_axi3   (s_axi3),
    // clocks
    .CLK_50   (CLK_50  ),
    .CORE_CLK (CORE_CLK),
    // IRQ
    .IRQ(),
    // PPS
    .PPS_OUT(),
    .PPS_IN (1'b0),
    // RF ADC
    .RF_sig (16'hABCD),
    .RF_mag (16'h0123),
    .RF_CLK (CLK_RF)
  );

endmodule