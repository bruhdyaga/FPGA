module bus_interface_apb_syn(
	aclk,
	resetn,
	apb_bridge_0_M_APB_PADDR,
	apb_bridge_0_M_APB_PSEL,
	apb_bridge_0_M_APB_PENABLE,
	apb_bridge_0_M_APB_PWRITE,
	apb_bridge_0_M_APB_PWDATA,
	apb_bridge_0_M_APB_PREADY,
	apb_bridge_0_M_APB_PSLVERR,
	out_wdata,
	out_addr,
	out_rd,
	out_wr
);

input  aclk;
input  resetn;
input  [31:0] apb_bridge_0_M_APB_PADDR;
input  apb_bridge_0_M_APB_PSEL;
input  apb_bridge_0_M_APB_PENABLE;
input  apb_bridge_0_M_APB_PWRITE;
input  [31:0] apb_bridge_0_M_APB_PWDATA;
output apb_bridge_0_M_APB_PREADY;
output apb_bridge_0_M_APB_PSLVERR;
output [31:0] out_wdata;
output [29:0] out_addr;
output out_rd;
output out_wr;


reg [31:0] out_wdata;
reg [29:0] out_addr;

ed_det#(
	.TYPE      ("ris"),
	.RESET_POL ("NEG"),
	.FLIP_EN   (1)
)
ed_det_out_rd_inst(
	.clk   (aclk),
	.reset (resetn),
	.in    (apb_bridge_0_M_APB_PSEL & apb_bridge_0_M_APB_PENABLE & (!apb_bridge_0_M_APB_PWRITE)),
	.out   (out_rd)//сигнал установки ответных сигналов для AXI
);

ed_det#(
	.TYPE      ("ris"),
	.RESET_POL ("NEG"),
	.FLIP_EN   (1)
)
ed_det_out_wr_inst(
	.clk   (aclk),
	.reset (resetn),
	.in    (apb_bridge_0_M_APB_PSEL & apb_bridge_0_M_APB_PENABLE & apb_bridge_0_M_APB_PWRITE),
	.out   (out_wr)//сигнал установки ответных сигналов для AXI
);

latency#(
	.length(1)
)
latency_pready_inst(
	.clk     (aclk),
	.reset   (!resetn),
	.in      (out_rd | out_wr),
	.out     (apb_bridge_0_M_APB_PREADY),
	.out_reg ()
);

always@(posedge aclk or negedge resetn)
if(resetn == 0) begin
	out_wdata <= 0;
	out_addr  <= 0;
end else begin
	out_wdata <= apb_bridge_0_M_APB_PWDATA;
	out_addr  <= apb_bridge_0_M_APB_PADDR[31:2];
end

assign apb_bridge_0_M_APB_PSLVERR = 0;

endmodule