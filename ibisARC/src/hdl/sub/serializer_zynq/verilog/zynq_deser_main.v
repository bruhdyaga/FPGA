`include "global_param.v"
module zynq_deser_main(
    refclk,
    reset_delay,
    CLK_LVDS_P,
    `ifndef SINGLE_CLK_DESER
    CLK_LVDS_N,
    `endif
    DAT_LVDS_P,
    DAT_LVDS_N,
    fpga_dat,
    clk_dat,
    gclk,
    dat_lock,
    mmcm_lock,
    debug
);

parameter N = 1;//number of channels
parameter D = 0;//number of data lines
parameter REF_FREQ = 0;
parameter BIT_RATE = 16'h739;//16'h573 == 573 Mbs
parameter CLKIN_PERIOD = 0;
parameter INTER_CLOCK = "BUF_R" ;      	// Parameter to set intermediate clock buffer type, BUFR, BUF_H, BUF_G
parameter SAMPL_CLOCK = "BUFIO" ;   	// Parameter to set sampling clock buffer type, BUFIO, BUF_H, BUF_G
parameter MMCM_MODE = 1;
parameter CLK_MULT = 1;//умножение входных клоков, если FR=ENC/2
parameter ENABLE_PHASE_DETECTOR = 1'b0;

parameter CLK_PATT_1 = 7'b1100001;
parameter CLK_PATT_2 = 7'b1100011;
parameter [D-1:0] RX_SWAP_MASK     = 16'h0000;
parameter         RX_CLK_SWAP_MASK = 1'b0;

input  refclk;
input  reset_delay;
input  [N-1:0] CLK_LVDS_P;
`ifndef SINGLE_CLK_DESER
input  [N-1:0] CLK_LVDS_N;
`endif
input  [N*D-1:0]   DAT_LVDS_P;
input  [N*D-1:0]   DAT_LVDS_N;
output [N*D*7-1:0] fpga_dat;
output [N*7-1:0]   clk_dat;
output gclk;
output dat_lock;
output mmcm_lock;
output [15:0] debug;

wire mmcm_lock;
wire [N-1:0] rx_mmcm_lckdpsbs;

assign enable_phase_detector = ENABLE_PHASE_DETECTOR;

reset_sync(
    .clk        (refclk),
    .resetn_in  (mmcm_lock & (!reset_delay)),
    .resetn_out (resetn_idelay)
);

IDELAYCTRL IDELAYCTRL_inst (
    .RDY    (idelay_rdy),    // 1-bit output: Ready output
    .REFCLK (refclk),        // 1-bit input: Reference clock input
    .RST    (!resetn_idelay) // 1-bit input: Active high reset input
);

n_x_serdes_1_to_7_mmcm_idelay_ddr#(
    .CLK_PATT_1             (CLK_PATT_1),
    .CLK_PATT_2             (CLK_PATT_2),
    .CLK_MULT               (CLK_MULT),
    .INTER_CLOCK            (INTER_CLOCK),
    .SAMPL_CLOCK            (SAMPL_CLOCK),
    .N                      (N),//number of data channels
    .D                      (D),//number of data lines
    .DIFF_TERM              ("TRUE"),
    .DATA_FORMAT            ("NONE!"),
    .REF_FREQ               (REF_FREQ),
    .MMCM_MODE              (MMCM_MODE),
    .CLKIN_PERIOD           (CLKIN_PERIOD),
    .RX_SWAP_MASK           (RX_SWAP_MASK),
    .RX_CLK_SWAP_MASK       (RX_CLK_SWAP_MASK)
)
n_x_serdes_1_to_7_mmcm_idelay_ddr_inst(
    .clkin_p              (CLK_LVDS_P),
    `ifndef SINGLE_CLK_DESER
    .clkin_n              (CLK_LVDS_N),
    `endif
    .datain_p             (DAT_LVDS_P),
    .datain_n             (DAT_LVDS_N),
    .enable_phase_detector(enable_phase_detector),
    .rxclk                (),// Global/BUFIO rx clock network
    .idelay_rdy           (idelay_rdy),
    .reset                (1'b0),
    .pixel_clk            (gclk),
    .refclk               (),//my
    .mmcm_locked          (mmcm_lock),
    .rx_mmcm_lckdps       (rx_mmcm_lckdps),
    .rx_mmcm_lckd         (rx_mmcm_lckd),
    .rx_mmcm_lckdpsbs     (rx_mmcm_lckdpsbs),
    .clk_data             (clk_dat),
    .rx_data              (fpga_dat),
    .status               (),
    .debug                (),
    .bit_rate_value       (BIT_RATE),
    .bit_time_value       ()
);


assign debug[0] = idelay_rdy;
assign debug[1] = mmcm_lock;
assign debug[2] = rx_mmcm_lckdps;
assign debug[3] = rx_mmcm_lckd;
assign debug[4] = &rx_mmcm_lckdpsbs;
assign dat_lock = rx_mmcm_lckdps & rx_mmcm_lckd & (&rx_mmcm_lckdpsbs);


endmodule