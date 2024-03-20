
`include "ATT_param.v"

module ATT_regfile(
	clk,
	reset_n,
	wr_en,
    rd_en,
    reg_addr,
    wdata,
	rdata,
		
	ATT_DATA,
	ATT_CSMASK,
	ATT_RESET
	);
	
	parameter BASE_ADDR = 0; 
		
	input clk;
    input reset_n;
    input wr_en;
    input rd_en;  
    input [`ATT_ADDR_WIDTH-1 : 0] reg_addr;
    input [31 : 0] wdata;
	
	output [31 : 0] rdata;
	reg [31 : 0] rdata;

	output [31:0] ATT_DATA;
	output [31:0] ATT_CSMASK;
	output [31:0] ATT_RESET;

	reg [31:0] ATT_ID;
	reg [31:0] ATT_DATA;
	reg [31:0] ATT_CSMASK;
	reg [31:0] ATT_RESET;
		

	assign ATT_DATA_wr 		  = (reg_addr == `ATT_DATA_OFFSET) 		& wr_en;
	assign ATT_CSMASK_wr 	  = (reg_addr == `ATT_CSMASK_OFFSET) 	& wr_en;
	assign ATT_RESET_wr 	  = (reg_addr == `ATT_RESET_OFFSET) 	& wr_en;
	
// READ Signals
	assign ATT_ID_rd 		  = (reg_addr == `ATT_ID_OFFSET) 		& rd_en;
	assign ATT_DATA_rd 		  = (reg_addr == `ATT_DATA_OFFSET) 		& rd_en;
	assign ATT_CSMASK_rd 	  = (reg_addr == `ATT_CSMASK_OFFSET) 	& rd_en;
	assign ATT_RESET_rd 	  = (reg_addr == `ATT_RESET_OFFSET) 	& rd_en;	

		always @(posedge clk or negedge reset_n)
		if (!reset_n) begin
			ATT_ID 	<= 0;
			end
		else
			begin
			ATT_ID 	<= 32'hA1B1C1D1;
			end
	
	
// ATT
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            ATT_DATA <= 32'b0;
        end
        else begin
            if (ATT_DATA_wr) begin
                ATT_DATA <= wdata;
            end      
        end
    end

    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            ATT_CSMASK <= 32'b0;
        end
        else begin
            if (ATT_CSMASK_wr) begin
                ATT_CSMASK <= wdata;
            end      
        end
    end

    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            ATT_RESET <= 32'b0;
        end
        else begin
            if (ATT_RESET_wr) begin
                ATT_RESET <= wdata;
            end      
        end
    end

		
// Static cross-module wires(regs) READ-ONLY
           
// Read from regs
    always @ (*) begin
        rdata = {32{1'b0}};
        case (1'b1)	
			ATT_ID_rd			  : rdata = ATT_ID;
			ATT_DATA_rd			  : rdata = ATT_DATA;
			ATT_CSMASK_rd		  : rdata = ATT_CSMASK;
			ATT_RESET_rd		  : rdata = ATT_RESET;
			
        endcase
    end
    
    
    
	
endmodule