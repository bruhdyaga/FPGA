`timescale 1ns/10ps
`include "sigmag_test.svh"

module sigmag_test_tb();

`define aclk_freq     59  // MHz
`define pclk_freq     125 // MHz

localparam BASE_ADDR = 32'h40000000;

localparam CH_NUM = 3;

localparam UNIQ_OFFS     = 0;
localparam MAP_OFFS      = 1;
localparam CFG_OFFS      = 2;
localparam RESULT_OFFS   = 3;

localparam DONE_BIT      = 0;
localparam RESETP_BIT    = 1;
localparam HIST_INP_BIT  = 2;
localparam LENGTH_BIT    = 7;
localparam MAG_OFF       = 0;
localparam SIG_OFF       = CNTR_LENGTH;
localparam MASK          = 2**CNTR_LENGTH - 1;

reg aclk  = 1;
reg pclk  = 1;
reg presetn = 1;
reg aresetn = 1;
reg done = 0;

logic [31:0] rdata;

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;
always #((1000/`pclk_freq)/2)     pclk     <= !pclk;

axi3_interface axi3();
intbus_interf  bus();

// ADC interface
adc_interf#(
    .PORTS (11),
    .R     (2)
)adc ();

initial begin
    @(posedge pclk);
    presetn = 0;
    @(posedge pclk);
    @(posedge pclk);
    @(posedge pclk);
    presetn = 1'b1;
end

initial begin
    bus.init;
    @(negedge presetn);
    aresetn = 0;
    @(posedge presetn);
    bus.waitClks(1);
    aresetn = 1'b1;
end

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

assign adc.clk     = pclk;
assign adc.resetn  = presetn;

reg [1:0] cntr;

always@(posedge pclk or negedge presetn)
if(presetn == '0) begin
    cntr <= '0;
end else begin
    cntr <= cntr + 1'b1;
end

assign adc.data[0][1] = cntr[1] == '1;
assign adc.data[0][0] = cntr == '0;

assign adc.data[1][1] = cntr[1] == '1;
assign adc.data[1][0] = cntr != '0;

assign adc.data[2][1] = '1;
assign adc.data[2][0] = '1;

sigmag_test#(
    .BASEADDR (BASE_ADDR/4)
) SIGMAG_TEST(
    .adc (adc),
    .bus (bus)
);

endmodule