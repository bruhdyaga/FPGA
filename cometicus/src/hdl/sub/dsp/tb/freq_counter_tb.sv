`timescale 1ns/10ps
`include "global_param.v"

`define aclk    100       // MHz
`define clk_50  50        // MHz
`define adc_clk 99.375    // MHz

module freq_counter_tb();

localparam BASEADDR    = 32'h40000000/4;

localparam FREQ_CNTR_BASE_ADDR = 0;

axi3_interface axi3();
intbus_interf  bus();

logic aclk    = 1;
logic clk_50  = 1;
logic adc_clk = 1;

logic rd = 0;
logic wr = 0;
logic [31:0] rdata;
logic [29:0] addr;

always #((1000/`aclk)/2)    aclk    <= !aclk;
always #((1000/`clk_50)/2)  clk_50  <= !clk_50;
always #((1000/`adc_clk)/2) adc_clk <= !adc_clk;

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_0_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

assign axi3.aclk = aclk;

always begin
    $display("freq_counter initial");
    #1000000
    axi3.readReg(FREQ_CNTR_BASE_ADDR, 4*4, 0); $display("rdata = 0x%08X", axi3.rdata);
    axi3.readReg(FREQ_CNTR_BASE_ADDR, 5*4, 0); $display("rdata = 0x%08X", axi3.rdata);
    axi3.readReg(FREQ_CNTR_BASE_ADDR, 6*4, 0); $display("rdata = 0x%08X", axi3.rdata);
    axi3.readReg(FREQ_CNTR_BASE_ADDR, 7*4, 0); $display("rdata = 0x%08X", axi3.rdata);
    axi3.readReg(FREQ_CNTR_BASE_ADDR, 8*4, 0); $display("rdata = 0x%08X", axi3.rdata);
end

logic [23:0] fix_pulse_cntr = '0;
logic [23:0] irq_cntr = '0;
logic fix_pulse;
logic irq;

always_ff@(posedge aclk)
if(fix_pulse) begin
    fix_pulse_cntr <= '0;
end else begin
    fix_pulse_cntr <= fix_pulse_cntr + 1'b1;
end
assign fix_pulse = fix_pulse_cntr == (100_000 - 1);

always_ff@(posedge aclk)
if(irq) begin
    irq_cntr <= '0;
end else begin
    irq_cntr <= irq_cntr + 1'b1;
end
assign irq = irq_cntr == (60_000 - 1);

localparam FREQ_CHANNELS = 5;

localparam logic [7 : 0] FREQ_ID [FREQ_CHANNELS - 1 : 0] = '{
    8'hA1,
    8'hB2,
    8'hC3,
    8'hD4,
    8'hE5
};

freq_counter#(
    .BASEADDR    (FREQ_CNTR_BASE_ADDR),
    .CHANNELS    (FREQ_CHANNELS),
    .FREQ_REF_HZ (50_000_000),
    .MAX_FREQ    (200_000_000),
    .PERIOD_MS   (10),
    .FREQ_ID     (FREQ_ID),
    .PULSE_MODE  (5'b11000)
)
freq_counter(
    .bus     (bus),
    .ref_clk (clk_50),
    .in_clk  ({irq,fix_pulse,adc_clk,aclk,clk_50})
);

endmodule
