/*  INST template

BRAM_array_top#(
	.BASE_ADDR		(`BRAM_BASE_ADDR),
	.portA_width	(14),
	.portA_channels (8),
	.portB_width 	(14),
	.portB_channels	(0)		
	)
BR_ARR (
	.aclk       (aclk),
	.aresetn    (!reset | aresetn),
	.araddr     (bram_araddr),
	.arprot     (bram_arprot),
	.arready    (bram_arready),
	.arvalid    (bram_arvalid),
	.awaddr     (bram_awaddr),
	.awprot     (bram_awprot),
	.awready    (bram_awready),
	.awvalid    (bram_awvalid),
	.bready     (bram_bready),
	.bresp      (bram_bresp),
	.bvalid     (bram_bvalid),
	.rdata      (bram_rdata),
	.rready     (bram_rready),
	.rresp      (bram_rresp),
	.rvalid     (bram_rvalid),
	.wdata      (bram_wdata),
	.wready     (bram_wready),
	.wstrb      (bram_wstrb),
	.wvalid     (bram_wvalid),
	
	.ext_adc_clk(clk_adc_ext),	
	.portA		(adc_conc),
	.portB		() 		
); 

*/

`include "BRAM_param.v"

module BRAM_array_top(

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
	
	// ADC
	ext_adc_clk,	// wr_clk for bram channes
	portA,			// ADC
	portB			// BF
	);
	
	parameter BASE_ADDR			= 0;
	parameter portA_width		= 14;
	parameter portA_channels	= 8;
	parameter portB_width 		= 32;
	parameter portB_channels	= 12;
	
	// AXI
	input aclk;
	input aresetn;
	input [31:0] araddr;
  	input [2:0] arprot;
  	output arready;
  	input arvalid;
  	input [31:0] awaddr;
  	input [2:0] awprot;
  	output awready;
  	input awvalid;
  	input bready;
  	output [1:0] bresp;
  	output bvalid;
  	input rready;
  	output [1:0] rresp;
  	output rvalid;
  	input [31:0] wdata;
  	output wready;
  	input [3:0] wstrb;
  	input wvalid;
	output [31:0] rdata;
	
	// ADC
	input ext_adc_clk;
	input [portA_width * portA_channels - 1 : 0] portA;
	input [portB_width * portB_channels - 1 : 0] portB;

  	wire [`BRAM_AXI_ADDR_WIDTH-1 : 0] addr_reg;
  	wire rd;
  	wire wr;
  	
  	assign arready = 1'b1;
  	assign awready = 1'b1;
  	assign wready = 1'b1;
  	assign rresp[1 : 0] = 2'b0;  	
  	assign bresp[1 : 0] = 2'b0;  	
  	
  	assign rvalid = arvalid;  	
  	assign bvalid = awvalid;  
  	
	assign addr_reg = awvalid ? awaddr[`BRAM_AXI_ADDR_WIDTH+1 : 2] : araddr[`BRAM_AXI_ADDR_WIDTH+1 : 2];	//BRAM_AXI_ADDR_WIDTH
	assign wr = awvalid;
	assign rd = arvalid;
  	
	wire [31:0] read_regs;

    wire [`BR_SELBIT-3:0] br_rd_addr;		
	wire [31:0] br_wr_addr;
	wire br_wr_ena;

	assign adr_sel 	  = addr_reg[`BR_SELBIT-2]; 						
    assign br_rd_addr = addr_reg[`BR_SELBIT-3 : 0];				
    
	reg	 [31:0] rdata;
	wire [31:0] BR_SELECT;
	wire [31:0] BR_CONTROL;
	wire [2:0]  CONTROL_sync;
	wire [31:0] STATUS;
		
	
	BRAM_regfile#(
		.BASE_ADDR(BASE_ADDR)	
	) 
	BRAM_regs (
		.clk            (aclk),
		.reset_n        (aresetn),
		.wr_en          (wr),
		.rd_en          (rd),
		.reg_addr       (addr_reg),
		.wdata          (wdata),
		.rdata          (read_regs),
	
		.BRAM_SELECT    (BR_SELECT),
		.BRAM_CONTROL   (BR_CONTROL),
		.BRAM_STATUS_IN (STATUS)

);
			
	level_sync#(
	    .INIT_STATE(1'b0),
		.WIDTH(2)
	)
	lsync_BR_CTRL(
	    .clk     (ext_adc_clk),
	    .reset_n (1'b1),
	    .async   (BR_CONTROL[2:0]),
	    .sync    (CONTROL_sync)
	);
	
	BRAM_filler#(
		.width(`BRAM_AWIDTH)
	) 
	BR_filler(
		.wclk  (ext_adc_clk),
		.cntrl (CONTROL_sync[0]),
		.reset (!aresetn),
		.status(STATUS[0]),
	    .waddr (br_wr_addr),
		.w_ena (br_wr_ena)
	 );

// Блок записи выборок
 	wire [31:0] read_data_A [portA_channels-1:0];	
 	wire [31:0] read_data_B [portB_channels-1:0];	

	    always @(*)	begin
	    rdata = {32{1'b0}};
        if (rd & (adr_sel == 0)) 
                rdata = read_regs;
        else if (rd & (adr_sel == 1)) 
			begin
				case (BR_SELECT)
					8'h00: rdata = read_data_A[0];
					8'h01: rdata = read_data_A[1];
					8'h02: rdata = read_data_A[2];
					8'h03: rdata = read_data_A[3];
					8'h04: rdata = read_data_A[4];
					8'h05: rdata = read_data_A[5];
					8'h06: rdata = read_data_A[6];
					8'h07: rdata = read_data_A[7];
					8'h08: rdata = read_data_A[8];
					8'h09: rdata = read_data_A[9];
					8'h0A: rdata = read_data_A[10];
					8'h0B: rdata = read_data_A[11];
					8'h0C: rdata = read_data_A[12];
					8'h0D: rdata = read_data_A[13];
					8'h0E: rdata = read_data_A[14];
					8'h0F: rdata = read_data_A[15];
					
					8'hf0: rdata = read_data_B[0];
					8'hf1: rdata = read_data_B[1];
					8'hf2: rdata = read_data_B[2];
					8'hf3: rdata = read_data_B[3];
					8'hf4: rdata = read_data_B[4];
					8'hf5: rdata = read_data_B[5];
					8'hf6: rdata = read_data_B[6];
					8'hf7: rdata = read_data_B[7];
					8'hf8: rdata = read_data_B[8];	
					8'hf9: rdata = read_data_B[9];	
					8'hfA: rdata = read_data_B[10];	
					8'hfB: rdata = read_data_B[11];	
					8'hfC: rdata = read_data_B[12];	
					8'hfD: rdata = read_data_B[13];	
					8'hfE: rdata = read_data_B[14];	
					8'hfF: rdata = read_data_B[15];	
			   	endcase
            end   
		end

genvar i;	
generate
	
	for (i=0; i< portA_channels; i = i+1)			// Повесил BRAM только на нулевые отводы.
		begin : ADC_BR_array
		bram_block#(
			.WIDTH   (portA_width),
			.AWIDTH  (`BRAM_AWIDTH)
		)
		ADC_br(
			.wr_clk  (ext_adc_clk),
			.rd_clk  (aclk),
			.we      (br_wr_ena),
			.re      (1'b1),
			.dat_in  (portA[(i+1) * portA_width-1 : i * portA_width]),
			.dat_out (read_data_A[i]),		// Первые NCH блоков BRAM
			.wr_addr (br_wr_addr),
			.rd_addr (br_rd_addr)
		);
		end
	
	for (i = 0; i< portB_channels; i = i+1) 
		begin : BF_BR_array
		bram_block#(
			.WIDTH   (portB_width),
			.AWIDTH  (`BRAM_AWIDTH)
		)
		BF_br(
			.wr_clk  (ext_adc_clk),
			.rd_clk  (aclk),
			.we      (br_wr_ena),
			.re      (1'b1),
			.dat_in  (portB[(i+1) * portB_width-1 : i * portB_width]),
			.dat_out (read_data_B[i]),		// Первые NCH блоков BRAM
			.wr_addr (br_wr_addr),
			.rd_addr (br_rd_addr)
		);
	end

endgenerate
	 
endmodule












