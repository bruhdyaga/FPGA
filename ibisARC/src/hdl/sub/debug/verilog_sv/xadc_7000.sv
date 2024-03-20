`include "global_param.v"

module xadc_7000#(
    parameter BASEADDR = 0
)
(
    intbus_interf.slave bus,
    input [15:0] VAUXN,
    input [15:0] VAUXP
);

localparam SIZE_ID_REGS = 1;
localparam XADC_ID      = 16'h2452;
localparam XADC_REGS    = 129;
localparam NREGS        = SIZE_ID_REGS + XADC_REGS;
localparam SIZE_ID      = ((NREGS & 16'hFFFF) << 16) | XADC_ID;

logic busy;

intbus_interf    bus_sl();
pipe_line_bus#(
    .PS_FF ("y"),
    .PL_FF ("y")
) pipe_line_bus(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

assign reset_pulse = ((bus_sl.addr == BASEADDR) & bus_sl.wr & (bus_sl.wdata[0] == '1));

wire [`AXI_GP_WIDTH-1:0] id_rdata;
assign id_rvalid   = ((bus_sl.addr == BASEADDR)                 & bus_sl.rd);
assign busy_rvalid = ((bus_sl.addr == BASEADDR + XADC_REGS + 1) & bus_sl.rd);
assign id_rdata    = id_rvalid   ? SIZE_ID : '0;
assign busy_rdata  = busy_rvalid ? busy    : '0;

wire [6:0] xadc_daddr;
assign xadc_daddr = bus_sl.addr - BASEADDR - SIZE_ID_REGS;
assign xadc_rd = (bus_sl.addr > BASEADDR) & (bus_sl.addr <= (BASEADDR + XADC_REGS)) & bus_sl.rd;
assign xadc_wr = (bus_sl.addr > BASEADDR) & (bus_sl.addr <= (BASEADDR + XADC_REGS)) & bus_sl.wr;

wire [15:0] xadc_rdata;
XADC #(
    .INIT_40    (16'h2000), // INIT_40 - INIT_42: XADC configuration registers
    .INIT_41    (16'h20F0),
    .INIT_42    (16'h0400),
    .INIT_48    (16'h47E1), // INIT_48 - INIT_4F: Sequence Registers
    .INIT_49    (16'h040C),
    .INIT_4A    (16'h47E0),
    .INIT_4B    (16'h0008),
    .INIT_4C    (16'h0000),
    .INIT_4D    (16'h0000),
    .INIT_4E    (16'h0000),
    .INIT_4F    (16'h0000),
    .INIT_50    (16'h0000), // INIT_50 - INIT_58, INIT5C: Alarm Limit Registers
    .INIT_51    (16'h0000),
    .INIT_52    (16'h0000),
    .INIT_53    (16'h0000),
    .INIT_54    (16'h0000),
    .INIT_55    (16'h0000),
    .INIT_56    (16'h0000),
    .INIT_57    (16'h0000),
    .INIT_58    (16'h0000),
    .INIT_5C    (16'h0000),
    .SIM_DEVICE ("ZYNQ")
) XADC_HARD(
    .ALM          (), // 8-bit output: Output alarm for temp, Vccint, Vccaux and Vccbram
    .OT           (), // 1-bit output: Over-Temperature alarm
                  
    .BUSY         (busy), // 1-bit output: ADC busy output
    .CHANNEL      (), // 5-bit output: Channel selection outputs
    .EOC          (), // 1-bit output: End of Conversion
    .EOS          (), // 1-bit output: End of Sequence
    .JTAGBUSY     (), // 1-bit output: JTAG DRP transaction in progress output
    .JTAGLOCKED   (), // 1-bit output: JTAG requested DRP port lock
    .JTAGMODIFIED (), // 1-bit output: JTAG Write to the DRP has occurred
    .MUXADDR      (), // 5-bit output: External MUX channel decode
                  
    .VAUXN        (VAUXN), // 16-bit input: N-side auxiliary analog input
    .VAUXP        (VAUXP), // 16-bit input: P-side auxiliary analog input
                  
    .CONVST       ('0), // 1-bit input: Convert start input
    .CONVSTCLK    ('0), // 1-bit input: Convert start input
    .RESET        (reset_pulse), // 1-bit input: Active-high reset
                  
    .VN           ('0), // 1-bit input: N-side analog input
    .VP           ('0), // 1-bit input: P-side analog input
                  
    .DO           (xadc_rdata       ), // 16-bit output: DRP output data bus
    .DRDY         (xadc_rvalid      ), // 1-bit output: DRP data ready
    .DADDR        (xadc_daddr       ), // 7-bit input: DRP address bus
    .DCLK         (bus_sl.clk          ), // 1-bit input: DRP clock
    .DEN          (xadc_rd | xadc_wr), // 1-bit input: DRP enable signal
    .DI           (bus_sl.wdata[15:0]  ), // 16-bit input: DRP input data bus
    .DWE          (xadc_wr          ) // 1-bit input: DRP write enable
);

assign bus_sl.rvalid = id_rvalid | busy_rvalid | xadc_rvalid;
assign bus_sl.rdata  = id_rdata  | busy_rdata  | (xadc_rvalid ? xadc_rdata : 16'b0);

endmodule
