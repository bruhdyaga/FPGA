module deserLTC217x (
  input        iADCclkP,
  input        iADCclkN,
  input        iADCfrmP,
  input        iADCfrmN,
  input  [7:0] iADCdataP,
  input  [7:0] iADCdataN,
  
  input         iClkRef,
  input         iClkRefLock,
                
  output        oClk,
  output [13:0] oADCdata [3:0]
);

wire sADCclkDiv;

wire sRstIdelay = ~iClkRefLock;
wire sRdyIdelay;
wire sRst = ~sRdyIdelay;
IDELAYCTRL IDELAYCTRL_ins (
  .RDY   (sRdyIdelay),  // 1-bit output: Ready output
  .REFCLK(iClkRef),     // 1-bit input: Reference clock input
  .RST   (sRstIdelay)   // 1-bit input: Active high reset input
);

// https://www.xilinx.com/support/documentation/application_notes/xapp524-serial-lvds-adc-interface.pdf

// // // // // // //
// Clock input
// // // // // // //
  // diff. data clock to SE data clock
  wire sADCclk;
  IBUFDS #(
    .DIFF_TERM   ("TRUE"),   // Differential Termination
    .IBUF_LOW_PWR("FALSE"),  // Low power="TRUE", Highest performance="FALSE"
    .IOSTANDARD  ("DEFAULT") // Specify the input I/O standard
  ) IBUFDS_ADCclkIn (
    .O (sADCclk),  // Buffer output
    .I (iADCclkP), // Diff_p buffer input (connect directly to top-level port)
    .IB(iADCclkN)  // Diff_n buffer input (connect directly to top-level port)
  );
  
  // clock IDELAY2
  wire sADCclkDly;
  IDELAYE2 #(
    .CINVCTRL_SEL          ("FALSE"),   // Enable dynamic clock inversion (FALSE, TRUE)
    .DELAY_SRC             ("IDATAIN"), // Delay input (IDATAIN, DATAIN)
    .HIGH_PERFORMANCE_MODE ("TRUE"),    // Reduced jitter ("TRUE"), Reduced power ("FALSE")
    .IDELAY_TYPE           ("FIXED"),   // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
    .IDELAY_VALUE          (0),         // Input delay tap setting (0-31)
    .PIPE_SEL              ("FALSE"),   // Select pipelined mode, FALSE, TRUE
    .REFCLK_FREQUENCY      (200.0),     // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
    .SIGNAL_PATTERN        ("CLOCK")    // DATA, CLOCK input signal
    )
    IDELAYE2_ADCclk (
    .CNTVALUEOUT (),            // 5-bit output: Counter value output
    .DATAOUT     (sADCclkDly),  // 1-bit output: Delayed data output
    .C           (sADCclkDiv),  // 1-bit input: Clock input
    .CE          (1'b0),        // 1-bit input: Active high enable increment/decrement input
    .CINVCTRL    (1'b0),        // 1-bit input: Dynamic clock inversion input
    .CNTVALUEIN  (5'b00000),    // 5-bit input: Counter value input
    .DATAIN      (1'b0),        // 1-bit input: Internal delay data input
    .IDATAIN     (sADCclk),     // 1-bit input: Data input from the I/O
    .INC         (1'b0),        // 1-bit input: Increment / Decrement tap delay input
    .LD          (1'b0),        // 1-bit input: Load IDELAY_VALUE input
    .LDPIPEEN    (1'b0),        // 1-bit input: Enable PIPELINE register to load data input
    .REGRST      (sRst)         // 1-bit input: Active-high reset tap-delay input
  );

  // data clock to BUFIO
  wire sADCclkBUFio;
  wire sADCclkBUFioN = ~sADCclkBUFio;
  BUFIO BUFIOdlck (
    .O(sADCclkBUFio), // 1-bit output: Clock output (connect to I/O clock loads).
    .I(sADCclkDly)    // 1-bit input: Clock input (connect to an IBUFG or BUFMR).
  );

  // data clock divider
  wire sADCclkDivBUFR;
  BUFR #(
    .BUFR_DIVIDE("4"),      // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
    .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
  )
  BUFR_ADCclkDiv (
    .O  (sADCclkDivBUFR), // 1-bit output: Clock output port
    .CE (sRdyIdelay), // 1-bit input: Active high, clock enable (Divided modes only)
    .CLR(1'b0),       // 1-bit input: Active high, asynchronous clear (Divided modes only)
    .I  (sADCclkDly)  // 1-bit input: Clock buffer input driven by an IBUFG, MMCM or local interconnect
  );
  //
  BUFG BUFG_PLXCLK (.I(sADCclkDivBUFR), .O(sADCclkDiv));
  //  
  wire [7:0] ADCclkPar;
  // clock ISERDES2
    ISERDESE2 #(
      .DATA_RATE        ("DDR"),   // DDR, SDR
      .DATA_WIDTH       (8),       // Parallel data width (2-8,10,14)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      .DYN_CLK_INV_EN   ("FALSE"), // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1          (1'b0),
      .INIT_Q2          (1'b0),
      .INIT_Q3          (1'b0),
      .INIT_Q4          (1'b0),
      .INTERFACE_TYPE   ("NETWORKING"), // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY         ("BOTH"),       // NONE, BOTH, IBUF, IFD
      .NUM_CE           (1),            // Number of clock enables (1,2)
      .OFB_USED         ("FALSE"),      // Select OFB path (FALSE, TRUE)
      .SERDES_MODE      ("MASTER"),     // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1         (1'b0),
      .SRVAL_Q2         (1'b0),
      .SRVAL_Q3         (1'b0),
      .SRVAL_Q4         (1'b0)
    )
      ISERDESE2_clock (
      .O (), // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit (each) output: Registered data outputs
      .Q1(ADCclkPar[0]),
      .Q2(ADCclkPar[1]),
      .Q3(ADCclkPar[2]),
      .Q4(ADCclkPar[3]),
      .Q5(ADCclkPar[4]),
      .Q6(ADCclkPar[5]),
      .Q7(ADCclkPar[6]),
      .Q8(ADCclkPar[7]),
      // SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),
      .SHIFTOUT2(),
      .BITSLIP  (1'b0), // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
      // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
      // to Q8 output ports will shift, as in a barrel-shifter operation, one
      // position every time Bitslip is invoked (DDR operation is different from
      // SDR).
      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1    (1'b1),
      .CE2    (1'b1),
      .CLKDIVP(1'b0),       // 1-bit input: TBD
      // Clocks: 1-bit (each) input: ISERDESE2 clock input ports
      .CLK    (sADCclkBUFio), // 1-bit input: High-speed clock
      .CLKB   (sADCclkBUFioN),// 1-bit input: High-speed secondary clock
      .CLKDIV (sADCclkDiv),   // 1-bit input: Divided clock
      .OCLK   (1'b0),         // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0),  // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL   (1'b0),  // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
      .D    (sADCclk),        // 1-bit input: Data input
      .DDLY (1'b0),         // 1-bit input: Serial data from IDELAYE2
      .OFB  (1'b0),         // 1-bit input: Data feedback from OSERDESE2
      .OCLKB(1'b0),         // 1-bit input: High speed negative edge output clock
      .RST  (sRst),         // 1-bit input: Active high asynchronous reset
      // SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0)
    );

// // // // // // //
// Data wires
// // // // // // //
  wire [8:0] sADCdataP;
  wire [8:0] sADCdataN;
  wire [8:0] sADCdataSE;
  wire [8:0] sADCdataDly;
  wire [8:0] sADCdataPar [7:0];
  reg        sBitSlipEn = 1'b0;
  /*wire*/ reg [4:0] sIdlyCntIn;
  
  assign sADCdataP = {iADCfrmP, iADCdataP};
  assign sADCdataN = {iADCfrmN, iADCdataN};

  genvar i;
  for (i=0; i<9; i=i+1) begin : serdata
    // diff. data to SE
    IBUFDS #(.DIFF_TERM("TRUE"), .IBUF_LOW_PWR("FALSE"), .IOSTANDARD  ("DEFAULT"))
    IBUFDSdlck (.O (sADCdataSE[i]), .I (sADCdataP[i]), .IB(sADCdataN[i]));
    // data IDELAYE2
    IDELAYE2 #(
      .CINVCTRL_SEL          ("FALSE"),   // Enable dynamic clock inversion (FALSE, TRUE)
      .DELAY_SRC             ("IDATAIN"), // Delay input (IDATAIN, DATAIN)
      .HIGH_PERFORMANCE_MODE ("TRUE"),    // Reduced jitter ("TRUE"), Reduced power ("FALSE")
      .IDELAY_TYPE           ("VAR_LOAD"),// FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      // .IDELAY_TYPE           ("FIXED"),   // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      .IDELAY_VALUE          (12),        // Input delay tap setting (0-31)
      .PIPE_SEL              ("FALSE"),   // Select pipelined mode, FALSE, TRUE
      .REFCLK_FREQUENCY      (200.0),     // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
      .SIGNAL_PATTERN        ("DATA")     // DATA, CLOCK input signal
      )
      IDELAYE2_ADCdata (
      .CNTVALUEOUT (),               // 5-bit output: Counter value output
      .DATAOUT     (sADCdataDly[i]), // 1-bit output: Delayed data output
      .C           (sADCclkDiv),     // 1-bit input: Clock input
      .CE          (1'b0),           // 1-bit input: Active high enable increment/decrement input
      .CINVCTRL    (1'b0),           // 1-bit input: Dynamic clock inversion input
      .CNTVALUEIN  (sIdlyCntIn),     // 5-bit input: Counter value input
      .DATAIN      (1'b0),           // 1-bit input: Internal delay data input
      .IDATAIN     (sADCdataSE[i]),  // 1-bit input: Data input from the I/O
      .INC         (1'b0),           // 1-bit input: Increment / Decrement tap delay input
      .LD          (1'b1),           // 1-bit input: Load IDELAY_VALUE input
      .LDPIPEEN    (1'b0),           // 1-bit input: Enable PIPELINE register to load data input
      .REGRST      (sRst)            // 1-bit input: Active-high reset tap-delay input
    );
    // data ISERDES2
    ISERDESE2 #(
      .DATA_RATE        ("DDR"),   // DDR, SDR
      .DATA_WIDTH       (8),       // Parallel data width (2-8,10,14)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      .DYN_CLK_INV_EN   ("FALSE"), // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1          (1'b0),
      .INIT_Q2          (1'b0),
      .INIT_Q3          (1'b0),
      .INIT_Q4          (1'b0),
      .INTERFACE_TYPE   ("NETWORKING"), // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY         ("IFD"),        // NONE, BOTH, IBUF, IFD
      .NUM_CE           (1),            // Number of clock enables (1,2)
      .OFB_USED         ("FALSE"),      // Select OFB path (FALSE, TRUE)
      .SERDES_MODE      ("MASTER"),     // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1         (1'b0),
      .SRVAL_Q2         (1'b0),
      .SRVAL_Q3         (1'b0),
      .SRVAL_Q4         (1'b0)
    )
      ISERDESE2_data (
      .O (), // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit (each) output: Registered data outputs
      .Q1(sADCdataPar[i][0]),
      .Q2(sADCdataPar[i][1]),
      .Q3(sADCdataPar[i][2]),
      .Q4(sADCdataPar[i][3]),
      .Q5(sADCdataPar[i][4]),
      .Q6(sADCdataPar[i][5]),
      .Q7(sADCdataPar[i][6]),
      .Q8(sADCdataPar[i][7]),
      // SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),
      .SHIFTOUT2(),
      .BITSLIP  (sBitSlipEn), // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
      // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
      // to Q8 output ports will shift, as in a barrel-shifter operation, one
      // position every time Bitslip is invoked (DDR operation is different from
      // SDR).
      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1    (1'b1),
      .CE2    (1'b1),
      .CLKDIVP(1'b0),       // 1-bit input: TBD
      // Clocks: 1-bit (each) input: ISERDESE2 clock input ports
      .CLK    (sADCclkBUFio), // 1-bit input: High-speed clock
      .CLKB   (sADCclkBUFioN),// 1-bit input: High-speed secondary clock
      .CLKDIV (sADCclkDiv),   // 1-bit input: Divided clock
      .OCLK   (1'b0),         // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0),  // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL   (1'b0),  // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
      .D    (1'b0),         // 1-bit input: Data input
      .DDLY (sADCdataDly[i]),   // 1-bit input: Serial data from IDELAYE2
      .OFB  (1'b0),         // 1-bit input: Data feedback from OSERDESE2
      .OCLKB(1'b0),         // 1-bit input: High speed negative edge output clock
      .RST  (sRst),         // 1-bit input: Active high asynchronous reset
      // SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0)
    );
  end
 
  // bitslip
  always @(posedge sADCclkDiv) begin
    if (sADCdataPar[8] != 8'hF0) sBitSlipEn <= 1'b1; else sBitSlipEn <= 1'b0;
  end
  
  // data collect
  reg  [15:0] sADCdata [3:0];
  for (i=0; i<4; i=i+1) always @(posedge sADCclkDiv) begin
                                          // OUT_A                OUT_B
     sADCdata[i] <= {sADCdataPar[2*i][7], sADCdataPar[2*i+1][7]
                                         ,sADCdataPar[2*i][6], sADCdataPar[2*i+1][6]
                                         ,sADCdataPar[2*i][5], sADCdataPar[2*i+1][5]
                                         ,sADCdataPar[2*i][4], sADCdataPar[2*i+1][4]
                                         ,sADCdataPar[2*i][3], sADCdataPar[2*i+1][3]
                                         ,sADCdataPar[2*i][2], sADCdataPar[2*i+1][2]
                                         ,sADCdataPar[2*i][1], sADCdataPar[2*i+1][1]
                                         ,sADCdataPar[2*i][0], sADCdataPar[2*i+1][0]
                                         };
  end
  
  assign oClk        = sADCclkDiv;
  assign oADCdata[3] = sADCdata[3][15:2];
  assign oADCdata[2] = sADCdata[2][15:2];
  assign oADCdata[1] = sADCdata[1][15:2];
  assign oADCdata[0] = sADCdata[0][15:2];

  // // // // // // // // // //
  // delay initialization FSM
  // // // // // // // // // //
  
  reg [13:0] exADCdata2 = 13'b1111111111111;
  reg [13:0] exADCdata3 = 13'b0101010101010;
  reg [4:0]  sIdlyCntInL,
             sIdlyCntInH,
             sIdlyCntInR;
  logic      val,initLR,initHR;
  
  
  always @(posedge sADCclkDiv) begin
  val = (oADCdata[2] == exADCdata2) * (oADCdata[3] == exADCdata3);
  if(!initLR && !initHR) begin
  case (val)
     1'b0:begin
            if(!initLR)begin
                         sIdlyCntIn  = sIdlyCntIn + 1'b1;
                       end 
            else       begin
                         sIdlyCntInH = sIdlyCntIn;
                       end 
                 
           end
      
     1'b1:begin      
            if(!initLR)begin
                         sIdlyCntInL = sIdlyCntIn;
                         sIdlyCntIn  = sIdlyCntIn + 1'b1;
                       end 
            else       begin
                         sIdlyCntIn  = sIdlyCntIn + 1'b1;
                       end 
          end 

  default:
    begin
     sIdlyCntIn  = 5'b00000;
     sIdlyCntInL = 5'b00000;
     sIdlyCntInH = 5'b00000;
     initLR      = 1'b0;
     initHR      = 1'b0;
    end
  endcase
  end
  else begin
  sIdlyCntInR = (sIdlyCntInL + sIdlyCntInR);  //initialization ready
  end
  end 
  


  // // //
  // debug
  // // //
  
//  ila_adc ila_adc (
//    .clk(sADCclkDiv),
//    .probe0({0,
//      sADCdataPar[0],
//      sADCdataPar[1],
//      sADCdata[0],
//      sADCdataPar[8],
//      sBitSlipEn
//    })
//  );

//  vio_adc vio_adc (
//    .clk        (sADCclkDiv),
//    .probe_out0 (sIdlyCntIn)
//  );
endmodule