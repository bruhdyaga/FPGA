// `timescale 1ns/10ps
`timescale 1ns/1fs

`include "global_param.v"

`define pclk     100.001500// MHz
`define aclk     100    // MHz

`include "macro.svh"

module corr_ch_test_tb();

// localparam BASEADDR     = 32'h40000000/4;
localparam BASEADDR     = 0;
localparam NCH          = 1;
localparam NBUSES       = NCH;

reg  pclk     = 1;
reg  aclk     = 1;

localparam PCLK_PERIOD = (1000/`pclk)/2;

always #((1000/`pclk)/2)     pclk     <= !pclk;
always #((1000/`aclk)/2)     aclk     <= !aclk;


axi3_interface   axi3();
intbus_interf    bus();
intbus_interf    bus_sl[NBUSES]();

localparam ADC_PORTS = 1;
// ADC interface
adc_interf#(
    .PORTS (ADC_PORTS), // 0 - imitator
    .R     (2)
)adc ();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES),
    .OUTFF      ("y"),
    .MASTERFF   ("y")
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

assign adc.clk    = pclk;
assign adc.data   = {'{'0}};

for(genvar i = 0; i < NCH; i = i + 1) begin
corr_ch#(
    .BASEADDR (BASEADDR + `HUBSIZE),
    .PRN_RAM  (1)
) CR_CH(
    .bus       (bus_sl[i]),
    .adc       (adc),
    .fix_pulse ('0),
    .irq_pulse ('0)
);
end

endmodule
