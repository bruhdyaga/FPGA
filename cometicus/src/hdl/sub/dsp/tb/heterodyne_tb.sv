`timescale 1ns/10ps

`define clk     105.6 // MHz
`define aclk    100   // MHz

module heterodyne_tb();

localparam BASEADDR    = 32'h40000000/4;
localparam WIDTH_DATA  = 14;
localparam WIDTH_COEF  = 14;
localparam IQ_WIDTH    = 9;
localparam PHASE_WIDTH = 10;
localparam ORDER       = 10;
localparam NCH         = 2;

reg clk     = 1;
reg aclk    = 1;
reg aresetn = 1;
reg resetn  = 1;

always #((1000/`clk)/2)     clk     <= !clk;
always #((1000/`aclk)/2)    aclk    <= !aclk;

axi3_interface   axi3();
intbus_interf    bus();

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

wire signed [IQ_WIDTH-1:0] sin;
wire signed [IQ_WIDTH-1:0] cos;

wire signed [11:0] sin_12;
wire signed [11:0] cos_12;
dds_iq_hd#(
    .IQ_WIDTH    (IQ_WIDTH),
    .PHASE_WIDTH (PHASE_WIDTH),
    .TABLE_NAME  ("dds_iq_hd_ph10_iq_9.txt")
)DDS_IQ_HD (
    .clk    (clk),
    .resetn (resetn),
    .sin    (sin),
    .cos    (cos),
    // .code   (36843545)
    .code   (268435456), // 2^28
    .phase_cntr ()
);

assign in.clk     = clk;
assign in.resetn  = resetn;
assign in.data[0] = sin <<< (WIDTH_DATA-IQ_WIDTH);

assign sin_12 = sin <<< 3;
assign cos_12 = cos <<< 3;

heterodyne#(
    .BASEADDR    (BASEADDR),
    .WIDTH_DATA  (WIDTH_DATA),
    .WIDTH_COEF  (WIDTH_COEF),
    .IQ_WIDTH    (IQ_WIDTH),
    .PHASE_WIDTH (PHASE_WIDTH),
    .ORDER       (ORDER),
    .NCH         (NCH)
)HETERODYNE (
    .bus (bus),
    .in  (in),
    .out (out)
);

endmodule