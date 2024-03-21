`timescale 1ns/1fs

`define aclk     100    // MHz

module xadc_7000_tb();


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

// ADC interface
adc_interf#(
    .PORTS (1), // 0 - imitator
    .R     (2)
)adc ();

stream_intbus stream_intbus ();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

localparam XADC_BASE_ADDR = 32'h400000F8/4;
xadc_7000#(
    .BASEADDR (XADC_BASE_ADDR)
) XADC(
    .bus (bus)
);


endmodule