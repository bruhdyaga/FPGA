`timescale 1ns/10ps

module ch_mul_tb ();
localparam FREQ_CNTR_BASE_ADDR   = 32'h40110000;

`define pclk 81  // MHz

reg pclk = 1;

always #((1000/`pclk)/2) pclk <= !pclk;

reg [4:0] PHASE = 0;

always@(posedge pclk)
PHASE <= PHASE + 1'b1;

ch_mul CH_MUL(
    .adc_re ('0), // ограничить разрядность INPUT -- !!!!!!!!!!!!!!!!!!!!
    .adc_im ('0),
    .phase  (PHASE),
    .i_prod (),
    .q_prod ()
);

endmodule