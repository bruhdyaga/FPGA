`timescale 1ns/10ps
`include "corr_ch.svh"
`include "irq_ctrl.svh"

`define pclk 105.6  // MHz
`define aclk 100    // MHz

module corr_ch_tb();

localparam NCH        = 1;
localparam NUM_ADC    = 1;
localparam BASE_ADDR  = 32'h40000000;


// IRQ -----------------------
// localparam IRQ_BASE_ADDR = 32'h4000000C;

// localparam IRQ_PERIOD_MCS = 600;     // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// localparam IRQ_PERIOD_MCS_AAA = 600; // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// localparam IRQ_PERIOD     = 32'd50-1;
// localparam IRQ_DURATION   = 32'd1;
// localparam IRQ_enable     = 1;
// localparam IRQ_sensitive  = 0;
// localparam IRQ_polarity   = 0;

// localparam IRQ_UNIQ_OFFS     = 0;
// localparam IRQ_MAP_OFFS      = 1;
// localparam IRQ_CFG_OFFS      = 2;
// localparam IRQ_PERIOD_OFFS   = 3;
// localparam IRQ_DURATION_OFFS = 4;

// localparam IRQ_ENABLE_BIT    = 0;
// localparam IRQ_SENSITIVE_BIT = 1;
// localparam IRQ_POLARITY_BIT  = 2;
// localparam IRQ_RELEASE_BIT   = 3;

// localparam IRQ_CFG = ((IRQ_enable << IRQ_ENABLE_BIT) | (IRQ_sensitive << IRQ_SENSITIVE_BIT) | (IRQ_polarity << IRQ_POLARITY_BIT));
// IRQ -----------------------

// TIME -----------------------
localparam TIME_SHIFT = 3;
localparam TIME_DO_RQST_OFFS        = `RWREGSSIZE + 0;
localparam TIME_CHIP_EPOCH_MAX_OFFS = `RWREGSSIZE + 3;
localparam TIME_CODE_RATE_OFFS      = `RWREGSSIZE + 4;
// TIME -----------------------

// PRN -----------------------
localparam PRN_SHIFT = TIME_SHIFT + 7;

localparam PRN_CODE_STATES_OFFS       = `RWREGSSIZE + 0;
localparam PRN_CODE_BITMASKS_OFFS     = `RWREGSSIZE + 1;
localparam PRN_CODE_OUT_BITMASKS_OFFS = `RWREGSSIZE + 2;
localparam PRN_BDSS_CNTR_OFFS         = `RWREGSSIZE + 3;
// PRN -----------------------

// CORR_CH -----------------------
localparam CORR_CH_SHIFT = PRN_SHIFT + 6;

localparam CORR_CH_CFG_OFFS        = `RWREGSSIZE + 0;
localparam CORR_CH_PHASE_RATE_OFFS = `RWREGSSIZE + 1;
// CORR_CH -----------------------

reg pclk = 1;
reg aclk = 1;

always #((1000/`pclk)/2) pclk <= !pclk;
always #((1000/`aclk)/2) aclk <= !aclk;

reg aresetn = 1;

logic [31:0] rdata;

// ADC interface
adc_interf#(
    .PORTS (NUM_ADC),
    .R     (2)
)adc ();

assign adc.clk     = pclk;

always@(posedge adc.clk or negedge adc.resetn)
if(adc.resetn == '0)
    adc.data[0] <= '0;
else
    adc.data[0] <= {$random,$random};

level_sync ADC_RESETN(
    .clk     (adc.clk),
    .reset_n (aresetn),
    .async   (aresetn),
    .sync    (adc.resetn)
);

intbus_interf bus();


initial begin
    bus.init;
    @(posedge aclk);
    aresetn = '0;
    @(posedge aclk);
    aresetn = '1;
end

assign bus.clk      = aclk;
assign bus.resetn   = aresetn;

always@(posedge adc.resetn) begin
    @(negedge adc.resetn);
    @(posedge adc.resetn);
    
    bus.readReg(BASE_ADDR/4,TIME_SHIFT,rdata);
    // if(rdata[15:0] != `TIME_SCALE_CH_ID_CONST) begin
        // $display ("ERROR read IRQ_ID; read = %08X",rdata);
    // end else begin
        // $display ("VALID IRQ_ID");
    // end
    
    bus.readReg(BASE_ADDR/4,PRN_SHIFT,rdata);
    // if(rdata[15:0] != `PRN_GEN_ID_CONST) begin
        // $display ("ERROR read PRN_GEN_ID; read = %08X",rdata);
    // end else begin
        // $display ("VALID PRN_GEN_ID");
    // end
    
    bus.readReg(BASE_ADDR/4,CORR_CH_SHIFT,rdata);
    
    bus.writeReg(BASE_ADDR/4,CORR_CH_SHIFT + CORR_CH_CFG_OFFS        ,32'h6400);
    bus.writeReg(BASE_ADDR/4,CORR_CH_SHIFT + CORR_CH_PHASE_RATE_OFFS ,32'hE04A7904);
    
    bus.writeReg(BASE_ADDR/4,PRN_SHIFT     + PRN_CODE_STATES_OFFS      ,32'h215EF0F5);
    bus.writeReg(BASE_ADDR/4,PRN_SHIFT     + PRN_CODE_BITMASKS_OFFS    ,32'h2494953C);
    bus.writeReg(BASE_ADDR/4,PRN_SHIFT     + PRN_CODE_OUT_BITMASKS_OFFS,32'h14000000);
    bus.writeReg(BASE_ADDR/4,PRN_SHIFT     + PRN_BDSS_CNTR_OFFS        ,32'h000027F5);
    
    bus.writeReg(BASE_ADDR/4,TIME_SHIFT    + TIME_CODE_RATE_OFFS,32'h013B3819);
    bus.writeReg(BASE_ADDR/4,TIME_SHIFT    + TIME_CHIP_EPOCH_MAX_OFFS,32'h07CC03FE);
    bus.writeReg(BASE_ADDR/4,TIME_SHIFT    + TIME_DO_RQST_OFFS,1); // DO RQST]
end

corr_ch#(
    .BASEADDR (BASE_ADDR/4),
    .BDSS_CH  ('0),
    .BDSS_EN  ('0)
) corr_ch(
    .bus        (bus),
    .adc        (adc),
    .fix_pulse  ('0),
    .irq_pulse  ('0),
    .chip_pulse (),
    .bdss_psp   ('0)
);

endmodule