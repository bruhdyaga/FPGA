`timescale 1ns/10ps
`include "adc_interconnect.svh"

`define aclk_freq     100    // MHz
`define pclk_freq     125    // MHz

module adc_interconnect_tb();
localparam BASEADDR  = 32'h0;
localparam IN_SIZE   = 13;
localparam OUT_SIZE  = 6;
localparam ADC_WIDTH = 5;

adc_interf#(
    .PORTS (IN_SIZE),
    .R     (ADC_WIDTH)
)adc_in[1] ();

adc_interf#(
    .PORTS (OUT_SIZE),
    .R     (ADC_WIDTH)
)adc_out[1] ();

reg aclk  = 1;
reg pclk  = 1;
reg presetn;

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;
always #((1000/`pclk_freq)/2)     pclk     <= !pclk;

axi3_interface axi3();
intbus_interf bus();

initial begin
    @(posedge pclk);
    presetn = 0;
    @(posedge pclk);
    @(posedge pclk);
    @(posedge pclk);
    presetn = 1'b1;
end

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

assign adc_in[0].clk    = pclk;
assign adc_in[0].valid  = presetn;

for(genvar i = 0; i < IN_SIZE; i = i + 1) begin
    assign adc_in[0].data[i] = i+1;
end

adc_interconnect#(
    .BASEADDR (BASEADDR),
    .IN_SIZE  (IN_SIZE),
    .OUT_SIZE (OUT_SIZE),
    .OUT_FF   (1)
) ADC_INTERCONNECT(
    .bus     (bus),
    .adc_in  (adc_in),
    .adc_out (adc_out)
);


endmodule
