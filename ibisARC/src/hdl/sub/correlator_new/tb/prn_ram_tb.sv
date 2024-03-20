`timescale 1ns/10ps

`define pclk 105.6  // MHz
`define aclk 100    // MHz

`include "global_param.v"
`include "time_scale_com.svh"

module prn_ram_tb();

localparam NBUSES = 3;

reg  pclk = 1;
reg  aclk = 1;
reg  aresetn = 1;

always #((1000/`pclk)/2) pclk <= !pclk;
always #((1000/`aclk)/2) aclk <= !aclk;


axi3_interface axi3();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus_sl[NBUSES]();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

connectbus#(
    .N_BUSES    (NBUSES),
    .OUTFF      ("y"),
    .MASTERFF   ("y")
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

reg fix_pulse;
localparam BASETIME = `HUBSIZE;
time_scale_com#(
    .BASEADDR     (BASETIME)
) TIME_SCALE_COM(
    .bus           (bus_sl[0]),
    .clk           (pclk),
    .trig_facq     ('0),
    .trig_pps      ('0),
    .epoch_pulse   (epoch_pulse),
    .sec_pulse     (),
    .fix_pulse     (fix_pulse),
    .pps_out       (),
    .time_out      ()
);

TIME_WORD time_out;
logic [2:0] phase_hi;
localparam BASETIME_CH = BASETIME + `TIME_SCALE_COM_FULL_SIZE;
time_scale_ch#(
    .BASEADDR   (BASETIME_CH)
)TIME_SCALE_CH (
    .bus           (bus_sl[1]), // последовательность обговорена
    .clk           (pclk),
    .chip_pulse    (chip_pulse),
    .epoch_pulse   (epoch_pulse),
    .sec_pulse     (),
    // .fix_pulse     (fix_pulse),
    .fix_pulse     ('0),
    .do_rqst       (do_rqst),
    .eph_apply     (eph_apply),
    .time_out      (time_out),
    .phase_hi      (phase_hi)
);

always_ff@(posedge pclk)
    fix_pulse <= epoch_pulse;

localparam BASEPRN = BASETIME_CH + `TIME_SCALE_CH_FULL_SIZE;
prn_ram#(
    .BASEADDR (BASEPRN),
    .RAM_SIZE (10230) // число бит = { 10230, 5115, 4092, 2046, 1023, 511 }
) PRN_RAM(
    .bus      (bus_sl[2]),
    .clk      (pclk),
    .phase_hi (phase_hi),
    .code_out (),
    .mask     (),
    .chip     (time_out.CHIP)
);

endmodule