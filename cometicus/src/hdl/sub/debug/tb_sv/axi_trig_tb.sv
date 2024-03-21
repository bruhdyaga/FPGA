`timescale 1ns/10ps

`include "global_param.v"

`define aclk     100    // MHz

module axi_trig_tb();

localparam BASEADDR     = 32'h40000000/4;

reg  aclk     = 1;
reg  aresetn  = 1;

always #((1000/`aclk)/2)     aclk     <= !aclk;

initial begin
    @ (negedge aclk)
      aresetn = 0;
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
      aresetn = 1;
end

axi3_interface   axi3();
intbus_interf    bus();

localparam ADC_PORTS = 1;
// ADC interface
adc_interf#(
    .PORTS (ADC_PORTS), // 0 - imitator
    .R     (2)
)adc ();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

axi_trig#(
    .BASEADDR (BASEADDR)
) axi_trig(
    .axi3 (axi3),
    .trig (trig_axi_debug),
    .bus  (bus)
);

endmodule