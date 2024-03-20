`timescale 1ns/10ps

`include "global_param.v"

`define clk     105.6 // MHz
`define aclk    100   // MHz

module fir_tb();

localparam WIDTH_DATA = 14;
localparam WIDTH_COEF = 14;
localparam ORDER      = 3;
localparam NCH        = 2;

reg clk     = 1;
reg aclk    = 1;

reg [WIDTH_DATA-1:0] test_data = '0;

always #((1000/`clk)/2)     clk     <= !clk;
always #((1000/`aclk)/2)    aclk    <= !aclk;

axi3_interface   axi3();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus();

adc_interf#(
    .PORTS (NCH),
    .R     (WIDTH_DATA)
)in ();

adc_interf#(
    .PORTS (NCH),
    .R     (WIDTH_DATA)
)out ();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

assign in.clk     = clk;
assign in.data[0] = test_data;

initial begin
    #2000
    @(posedge clk);
        // test_data = 2**(WIDTH_DATA-1)-1;
        test_data = 1;
    @(posedge clk);
        test_data = '0;
end

fir_syst#(
    .BASEADDR      (0         ),
    .WIDTH_IN_DATA (WIDTH_DATA),
    .WIDTH_COEF    (WIDTH_COEF),
    .ORDER         (ORDER     ),
    .NCH           (NCH       )
)FIR (
    .bus (bus),
    .in  (in),
    .out (out)
);

endmodule