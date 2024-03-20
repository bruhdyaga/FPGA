`timescale 1ns/10ps

`define clk           100        // MHz
`define clk_up       (`clk*3)    // MHz
`define clk_down     (`clk_up/4) // MHz
`define aclk          100        // MHz

module decimator_tb();

localparam BASEADDR    = 32'h40000000/4;
localparam WIDTH_DATA  = 14;
localparam WIDTH_COEF  = 14;
localparam IQ_WIDTH    = 9;
localparam PHASE_WIDTH = 10;
localparam ORDER       = 10;
localparam NCH         = 2;

reg clk          = 1;
reg clk_up       = 1;
reg clk_down     = 1;
reg aclk         = 1;
reg aresetn      = 1;
reg resetn       = 1;

always #((1000/`clk)/2)      clk      <= !clk;
always #((1000/`clk_up)/2)   clk_up   <= !clk_up;
always #((1000/`clk_down)/2) clk_down <= !clk_down;
always #((1000/`clk)/2)      clk      <= !clk;
always #((1000/`aclk)/2)     aclk     <= !aclk;

axi3_interface   axi3();
intbus_interf    bus();
intbus_interf    bus2();

adc_interf#(
    .PORTS (NCH),
    .R     (WIDTH_DATA)
)in ();

adc_interf#(
    .PORTS (NCH*2),
    .R     (WIDTH_DATA)
)out ();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

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

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

initial begin
    @(posedge clk);
    resetn = '0;
    @(posedge clk);
    resetn = '1;
end

wire signed [2:0] sin;

DDS_sin_cos DDS_sin_cos_inst(
    .clk       (clk),
    .resetn    (resetn),//asy
    .syn_reset ('0),
    .sin       (sin),
    .cos       (),
    .valid     (),
    .en        ('1),//разрешение на работу счетчика фазы
    .code_in   (32'h1FFFFFF),
    .bus       (bus2)
);

adc_interf#(
    .PORTS (1), // 0 - imitator
    .R     (2)
)adc_to_decim ();
adc_interf#(
    .PORTS (1), // 0 - imitator
    .R     (14)
)adc_from_decim ();

assign adc_to_decim.clk     = clk;
assign adc_to_decim.resetn  = resetn;
assign adc_to_decim.valid   = '1;
assign adc_to_decim.data[0][0] = '0;
assign adc_to_decim.data[0][1] = sin > 0;

decimator#(
    .BASEADDR   (BASEADDR),
    .IN_WIDTH   ("no"),
    .IN_SIGAMG  (1),
    .OUT_SIGAMG (0),
    .WIDTH_COEF (14),
    .ORDER      (10),
    // .PLL        ("INTERNAL"),
    .PLL_PERIOD (10.063),
    .PLL_M      (9),
    .PLL_D_UP   (3),
    .PLL_D_DOWN (12)
) DECIMATOR(
    .bus      (bus),
    .in       (adc_to_decim),
    .out      (adc_from_decim),
    .clk_up   (clk_up),
    .clk_down (clk_down)
);

endmodule