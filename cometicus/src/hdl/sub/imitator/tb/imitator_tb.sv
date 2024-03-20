`timescale 1ns/10ps

`include "global_param.v"
`include "macro.svh"

`define clk      125  // MHz
`define aclk     100  // MHz


module imitator_tb();

localparam BASEADDR     = 0;
localparam N_TCOM       = 6; // количество шкал времени
localparam N_BUSES      = 2;

// `ifdef FACQ
// localparam FACQ_EN = 1;
// `else
localparam FACQ_EN = 0;
// `endif

// `ifdef BDSS
// localparam BDSS_EN = 1;
// `else
localparam BDSS_EN = 0;
// `endif

`ifdef CALIBRATION
localparam CALIBRATION_EN = 1;
`else
localparam CALIBRATION_EN = 0;
`endif

`ifdef IMITATOR
localparam IMITATOR_EN = 1;
`else
localparam IMITATOR_EN = 0;
`endif

reg  clk     = 1;
reg  aclk    = 1;

always #((1000/`clk)/2)      clk      <= !clk;
always #((1000/`aclk)/2)     aclk     <= !aclk;


axi3_interface   axi3();
intbus_interf    bus();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

// IMI interface
imi_interf#(
    .WIDTH (`IMI_OUTWIDTH)
)imi ();

reg [9:0] fix_cntr = '0;
always_ff@(posedge clk) begin
    fix_cntr <= fix_cntr + 1'b1;
end

assign fix_pulse = fix_cntr == '1;

imitator#(
    .BASEADDR (BASEADDR)
) IMITATOR(
    .clk           (clk),
    .fix_pulse     (fix_pulse),
    .irq_pulse     ('0),
    .bus           (bus),
    .imi           (imi)
);

endmodule