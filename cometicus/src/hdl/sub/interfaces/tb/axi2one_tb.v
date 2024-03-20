`timescale 1ns/1ns
`include "global_param.v" 
module axi2one_tb();

reg clk = 1;
reg resetn;

reg axi1_arvalid_start = 0;
reg axi1_awvalid_start = 0;
reg axi2_arvalid_start = 0;
reg axi2_awvalid_start = 0;

wire [31:0] axi1_araddr;
reg         axi1_arvalid;
wire [31:0] axi1_awaddr;
reg         axi1_awvalid;
wire [31:0] axi1_wdata;
wire        axi1_arready;
wire        axi1_awready;
wire [31:0] axi2_araddr;
reg         axi2_arvalid;
wire [31:0] axi2_awaddr;
reg         axi2_awvalid;
wire [31:0] axi2_wdata;
wire        axi2_arready;
wire        axi2_awready;

wire [31:0] axi_out_wdata;
wire [`ADDR_WIDTH - 1 : 0] axi_out_addr;
wire axi_out_wr_en;
wire axi_out_rd_en;

always #5 clk = !clk;

initial begin
resetn = 1'b1;
#50 resetn = 1'b0;
#50 resetn = 1'b1;

#30 axi1_arvalid_start = 1'b1;
#5  axi1_arvalid_start = 1'b0;

#105 axi1_awvalid_start = 1'b1;
#5   axi1_awvalid_start = 1'b0;

#105 axi2_arvalid_start = 1'b1;
#5   axi2_arvalid_start = 1'b0;

#105 axi2_awvalid_start = 1'b1;
#5   axi2_awvalid_start = 1'b0;
end

always@(posedge clk or negedge resetn)
if(resetn ==0)
	axi1_arvalid <= 0;
else
	if(axi1_arvalid_start)
		axi1_arvalid <= 1'b1;
	else
		if(axi1_arready)
			axi1_arvalid <= 0;

always@(posedge clk or negedge resetn)
if(resetn ==0)
	axi1_awvalid <= 0;
else
	if(axi1_awvalid_start)
		axi1_awvalid <= 1'b1;
	else
		if(axi1_awready)
			axi1_awvalid <= 0;

always@(posedge clk or negedge resetn)
if(resetn ==0)
	axi2_arvalid <= 0;
else
	if(axi2_arvalid_start)
		axi2_arvalid <= 1'b1;
	else
		if(axi2_arready)
			axi2_arvalid <= 0;

always@(posedge clk or negedge resetn)
if(resetn ==0)
	axi2_awvalid <= 0;
else
	if(axi2_awvalid_start)
		axi2_awvalid <= 1'b1;
	else
		if(axi2_awready)
			axi2_awvalid <= 0;


assign axi1_araddr = (axi1_arvalid) ? (`ACQ_BASE_ADDR+1)<<2 : 0;
assign axi1_awaddr = (axi1_awvalid) ? (`ACQ_BASE_ADDR+2)<<2 : 0;
assign axi2_araddr = (axi2_arvalid) ? (`ACQ_BASE_ADDR+3)<<2 : 0;
assign axi2_awaddr = (axi2_awvalid) ? (`ACQ_BASE_ADDR+4)<<2 : 0;
assign axi1_wdata  = (axi1_awvalid) ? 32'h11223344 : 0;
assign axi2_wdata  = (axi2_awvalid) ? 32'h55667788 : 0;


axi2one axi2one_inst(
	.clk           (clk),
	.resetn        (resetn),
	.axi1_araddr   (axi1_araddr),
	.axi1_arvalid  (axi1_arvalid),
	.axi1_awaddr   (axi1_awaddr),
	.axi1_awvalid  (axi1_awvalid),
	.axi1_wdata    (axi1_wdata),
	.axi1_arready  (axi1_arready),
	.axi1_awready  (axi1_awready),
	.axi1_wready   (),
	.axi1_rresp    (),
	.axi1_bresp    (),
	.axi1_rvalid   (),
	.axi1_bvalid   (),
	.axi2_araddr   (axi2_araddr),
	.axi2_arvalid  (axi2_arvalid),
	.axi2_awaddr   (axi2_awaddr),
	.axi2_awvalid  (axi2_awvalid),
	.axi2_wdata    (axi2_wdata),
	.axi2_arready  (axi2_arready),
	.axi2_awready  (axi2_awready),
	.axi2_wready   (),
	.axi2_rresp    (),
	.axi2_bresp    (),
	.axi2_rvalid   (),
	.axi2_bvalid   (),
	.axi_out_wdata (axi_out_wdata),
	.axi_out_addr  (axi_out_addr),
	.axi_out_wr_en (axi_out_wr_en),
	.axi_out_rd_en (axi_out_rd_en)
);

endmodule