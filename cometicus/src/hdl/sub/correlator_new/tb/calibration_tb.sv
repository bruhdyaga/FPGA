`timescale 1ns/10ps

`define pclk     106.344// MHz
`define aclk     100    // MHz

`include "global_param.v"
`include "macro.svh"

module calibration_tb();

localparam BASEADDR     = 32'h40000000/4;
localparam NBUSES       = 2;

reg  pclk = 1;
reg  aclk = 1;

wire presetn;
reg  aresetn = 1;

always #((1000/`pclk)/2) pclk <= !pclk;
always #((1000/`aclk)/2) aclk <= !aclk;

axi3_interface   axi3();
intbus_interf    bus();
intbus_interf    bus_sl[NBUSES]();

localparam ADC_PORTS = 2;
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
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
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
    .async   (aresetn),
    .sync    (presetn)
);

assign adc.clk    = pclk;
assign adc.resetn = presetn;

wire signed [2:0] sin;
DDS_sin_cos#(
    .BASEADDR (0),
    .BUS_EN   (0)
) DDS_sin_cos_inst(
    .clk       (adc.clk),
    .resetn    (adc.resetn),//asy
    .syn_reset ('0),
    .sin       (sin),
    .cos       (),
    .valid     (),
    .en        ('1),//разрешение на работу счетчика фазы
    .code_in   (403_874_905),
    .bus       (bus_sl[1])
);

sig_mag_v3#(
    .WIDTH (3)
) sig_mag_v3_sin_inst(
    .clk        (adc.clk),
    .resetn     (adc.resetn),
    .data_in    (sin),
    .we         ('1),
    .sig        (adc.data[0][1]),
    .mag        (adc.data[0][0]),
    .valid      (),
    .por_out    (),
    .por_in     ('0),
    .por_manual ('0)
);

reg [26:0] sec_pulse_cntr;
localparam PULSE_PERIOD = `pclk * 1_000 - 1;
assign sec_pulse_ed = sec_pulse_cntr == PULSE_PERIOD; // 1ms period
always_ff@(posedge adc.clk or negedge adc.resetn) begin
    if(adc.resetn == 1'b0) begin
        sec_pulse_cntr <= '0;
    end else begin
        if(sec_pulse_ed) begin
            sec_pulse_cntr <= '0;
        end else begin
            sec_pulse_cntr <= sec_pulse_cntr + 1'b1;;
        end
    end
end

localparam BASE_CALIB = BASEADDR + `HUBSIZE;
calibration #(
    .BASEADDR   (BASE_CALIB)
) CALIB (
    .bus            (bus_sl[0]),
    .adc            (adc),
    .sec_pulse_ed   (sec_pulse_ed)
);

endmodule
