module main_deser_kit_045(
	GPIO
);

parameter S = 7;

inout [22:3] GPIO;

wire DAT_0_LVDS_P;
wire DAT_0_LVDS_N;
wire DAT_2_LVDS_P;
wire DAT_2_LVDS_N;
wire CLK_LVDS_P;
wire CLK_LVDS_N;
wire [S*2-1:0] fpga_dat;
wire [S-1:0] frm_dat;
wire dat_lock;
wire sig;
wire mag;

wire rx_mmcm_lckdps;
wire rx_mmcm_lckd;
wire rx_mmcm_lckdpsbs;
wire rx_pixel_clk;
wire refclk;

assign DAT_0_LVDS_P = GPIO[13];
assign DAT_0_LVDS_N = GPIO[11];
assign DAT_2_LVDS_P = GPIO[9];
assign DAT_2_LVDS_N = GPIO[7];
assign CLK_LVDS_P   = GPIO[21];
assign CLK_LVDS_N   = GPIO[19];
// assign sig = fpga_dat[0];
// assign mag = fpga_dat[S];

assign clk = rx_pixel_clk;


IDELAYCTRL IDELAYCTRL_inst (
	.RDY(idelay_rdy),       // 1-bit output: Ready output
	.REFCLK(refclk), // 1-bit input: Reference clock input
	.RST(1'b0)        // 1-bit input: Active high reset input
);

n_x_serdes_1_to_7_mmcm_idelay_ddr#(
	.N(1),//number of data channels
	.D(2),//number of data lines
	.DIFF_TERM("TRUE"),
	.DATA_FORMAT("NONE!"),
	.REF_FREQ(291.67)
)
n_x_serdes_1_to_7_mmcm_idelay_ddr_inst(
	.clkin_p              (CLK_LVDS_P),
	.clkin_n              (CLK_LVDS_N),
	.datain_p             ({DAT_2_LVDS_P,DAT_0_LVDS_P}),
	.datain_n             ({DAT_2_LVDS_N,DAT_0_LVDS_N}),
	.enable_phase_detector(1'b0),
	.rxclk                (),// Global/BUFIO rx clock network
	.idelay_rdy           (idelay_rdy),
	.reset                (1'b0),
	.pixel_clk            (rx_pixel_clk),
	.refclk               (refclk),//my
	.rx_mmcm_lckdps       (rx_mmcm_lckdps),
	.rx_mmcm_lckd         (rx_mmcm_lckd),
	.rx_mmcm_lckdpsbs     (rx_mmcm_lckdpsbs),
	.clk_data             (frm_dat),
	.rx_data              (fpga_dat),
	.status               (),
	.debug                (),
	.bit_rate_value       (16'h1050),
	.bit_time_value       ()
);


assign dat_lock = rx_mmcm_lckdps & rx_mmcm_lckd & rx_mmcm_lckdpsbs;

ODDR #(
	.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
	.INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
	.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
) ODDR_inst (
	.Q(GPIO[6]),// 1-bit DDR output
	.C(clk),    // 1-bit clock input
	.CE(1'b1),  // 1-bit clock enable input
	.D1(1'b1),  // 1-bit data input (positive edge)
	.D2(1'b0),  // 1-bit data input (negative edge)
	.R(1'b0),   // 1-bit reset
	.S(1'b0)    // 1-bit set
);

assign GPIO[8]  = fpga_dat[0];
assign GPIO[10] = fpga_dat[1];
assign GPIO[12] = fpga_dat[2];
assign GPIO[14] = fpga_dat[3];
assign GPIO[16] = fpga_dat[4];
assign GPIO[18] = fpga_dat[5];
assign GPIO[20] = fpga_dat[6];
assign GPIO[4]  = dat_lock;
assign GPIO[3]  = /* fpga_dat[15]^fpga_dat[14]^ */fpga_dat[13]^fpga_dat[12]^fpga_dat[11]^fpga_dat[10]^fpga_dat[9]^fpga_dat[8]^fpga_dat[7]^fpga_dat[6]^fpga_dat[5]^fpga_dat[4]^fpga_dat[3]^fpga_dat[2]^fpga_dat[1]^fpga_dat[0];
assign GPIO[5]  = frm_dat[6]^frm_dat[5]^frm_dat[4]^frm_dat[3]^frm_dat[2]^frm_dat[1]^frm_dat[0];
assign GPIO[15] = 0;
assign GPIO[17] = 0;
assign GPIO[22] = 0;



endmodule
