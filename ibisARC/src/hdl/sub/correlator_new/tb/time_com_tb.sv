`timescale 1ns/10ps

`define pclk 105.6  // MHz
`define aclk 100    // MHz

module time_com_tb();

localparam BASEADDR    = 32'h40000000/4;

reg  pclk = 1;
reg  aclk = 1;
reg  aresetn = 1;
wire presetn;

always #((1000/`pclk)/2) pclk <= !pclk;
always #((1000/`aclk)/2) aclk <= !aclk;


axi3_interface axi3();
intbus_interf  bus();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
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

level_sync ADC_RESETN(
    .clk     (pclk),
    .reset_n (aresetn),
    .async   (aresetn),
    .sync    (presetn)
);

reg trig_pps = '1;
always begin
    #10000
    @ (posedge pclk)
    trig_pps <= '1;

    #100
    @ (posedge pclk)
    trig_pps <= '0;
end

reg fix_pulse;
time_scale_com#(
    .BASEADDR (BASEADDR)
)TIME_COM (
    .bus         (bus),
    .clk         (pclk),
    .resetn      (presetn),
    .trig_facq   ('0),
    .trig_pps    (trig_pps),
    .epoch_pulse (epoch_pulse),
    .sec_pulse   (),
    .fix_pulse   (fix_pulse),
    .pps_out     ()
);

always_ff@(posedge pclk or negedge presetn)
if(presetn == '0) begin
    fix_pulse <= '0;
end else begin
    fix_pulse <= epoch_pulse;
end

endmodule