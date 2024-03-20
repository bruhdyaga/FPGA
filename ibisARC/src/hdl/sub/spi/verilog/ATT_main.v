//////// INST template ///////////////////*
/*

ATT_main#(
	.ATT_BASE_ADDR(`ATT_BASE_ADDR)
	)
ATT (
	.aclk   (aclk),
	.aresetn(!reset | aresetn),
	.araddr (att_araddr),
	.arprot (att_arprot),
	.arready(att_arready),
	.arvalid(att_arvalid),
	.awaddr (att_awaddr),
	.awprot (att_awprot),
	.awready(att_awready),
	.awvalid(att_awvalid),
	.bready (att_bready),
	.bresp  (att_bresp),
	.bvalid (att_bvalid),
	.rdata  (att_rdata),
	.rready (att_rready),
	.rresp  (att_rresp),
	.rvalid (att_rvalid),
	.wdata  (att_wdata),
	.wready (att_wready),
	.wstrb  (att_wstrb),
	.wvalid (att_wvalid),

	.clk_200(clk_200),
	.ATT_SCK(ATT_SCK),
	.ATT_SDI(ATT_SDI),
	.LE		(LE)
	);
	
*////////////////////////////////////////

`include "ATT_param.v"

module ATT_main(

	// AXI
	aclk,
	aresetn,
	araddr,
	arprot,
	arready,
	arvalid,
	awaddr,
	awprot,
	awready,
	awvalid,
	bready,
	bresp,
	bvalid,
	rdata,
	rready,
	rresp,
	rvalid,
	wdata,
	wready,
	wstrb,
	wvalid,
	

	// ATT
	clk_200,
	ATT_SCK,
	ATT_SDI,
	LE
	);
	
	parameter ATT_BASE_ADDR = 0;
	
	
	// AXI
	input 			aclk;
	input 			aresetn;
	input [31:0] 	araddr;
  	input [2:0] 	arprot;
  	output 			arready;
  	input 			arvalid;
  	input [31:0] 	awaddr;
  	input [2:0] 	awprot;
  	output 			awready;
  	input 			awvalid;
  	input 			bready;
  	output [1:0] 	bresp;
  	output 			bvalid;
  	input 			rready;
  	output [1:0] 	rresp;
  	output 			rvalid;
  	input [31:0] 	wdata;
  	output 			wready;
  	input [3:0] 	wstrb;
  	input 			wvalid;
	output [31:0] 	rdata;
	
	// ATT
	input 			clk_200;
	output [16:1] 	LE;
	output 			ATT_SCK;
	output 			ATT_SDI;
	
	wire [31:0] ATT_DATA;
	wire [31:0] ATT_CSMASK;
	wire [31:0] ATT_RESET;
			
  	wire [`ATT_ADDR_WIDTH-1 : 0] addr_reg;
  	wire rd;
  	wire wr;
  	
  	assign arready = 1'b1;
  	assign awready = 1'b1;
  	assign wready = 1'b1;
  	assign rresp[1 : 0] = 2'b0;  	
  	assign bresp[1 : 0] = 2'b0;  	
  	
  	assign rvalid = arvalid;  	
  	assign bvalid = awvalid;
  	
	assign addr_reg = awvalid ? awaddr[`ATT_ADDR_WIDTH+1 : 2] : araddr[`ATT_ADDR_WIDTH+1 : 2];	
	assign wr = awvalid;
	assign rd = arvalid;
  	
	wire [31:0] read_regs;
	wire [31:0] br_wr_addr;
	wire [15:0] at_nCS;
        		
	ATT_regfile#(
			.BASE_ADDR(ATT_BASE_ADDR)
		) 
		ATT_REGS (
			.clk            (aclk),
			.reset_n        (aresetn),
			.wr_en          (wr),
			.rd_en          (rd),
			.reg_addr       (addr_reg),
			.wdata          (wdata),
			.rdata          (rdata),
				
			.ATT_DATA       (ATT_DATA),
			.ATT_CSMASK     (ATT_CSMASK),
			.ATT_RESET      (ATT_RESET)
		);
	
// ATT setup from regs
    level_sync#(
			.INIT_STATE(1'b1)
		)
		level_sync_attreset(
			.clk     (clk_200),
			.reset_n (1'b1),
			.async   (ATT_RESET[0]),
			.sync    (s_reset)
		);
	
	spi_att_ctrl#(
			.CLK_DIV   (200),
			.N_BITS    (6),  
			.N_PACKETS (1),
			.N_CS	   (16)
			)
		ATT_ctrl(
			.clk	 (clk_200),
			.reset	 (s_reset),
			.spi_clk (ATT_SCK),
			.spi_nncs(at_nCS),
			.spi_mosi(ATT_SDI),
			.DATA	 (ATT_DATA[5:0])
		);
	
	genvar i;
	generate
		for(i=1;i<=16;i=i+1)
		begin: loop_att_cs
			assign LE[i] = !at_nCS[i-1] & ATT_CSMASK[i-1];
		end
	endgenerate
			 
endmodule












