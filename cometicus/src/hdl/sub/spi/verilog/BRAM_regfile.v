
`include "BRAM_param.v"


module BRAM_regfile(
	clk,
	reset_n,
	wr_en,
    rd_en,
    reg_addr,
    wdata,
	rdata,
	
	BRAM_CONTROL,
	BRAM_STATUS_IN,
	BRAM_SELECT
	);
	
	parameter BASE_ADDR = 0; 
	
	input clk;
    input reset_n;
    input wr_en;
    input rd_en;  
    input [`BRAM_AXI_ADDR_WIDTH-1 : 0] reg_addr;
    input [31:0] wdata;
	input [31:0] BRAM_STATUS_IN;
	
	output [31:0] rdata;
	reg    [31:0] rdata;

	output [31:0] BRAM_CONTROL;
	output [31:0] BRAM_SELECT;

// Common Slave regs
	reg [31:0] BRAM_CONTROL;
	reg [31:0] BRAM_ID;
	reg [31:0] BRAM_PARAM;
	reg [31:0] BRAM_SELECT;
	reg [31:0] BRAM_STATUS;

	
		always @(posedge clk or negedge reset_n)
		if (!reset_n) begin
			BRAM_STATUS <= 0;
			BRAM_PARAM  <= 0;
			BRAM_ID 	<= 0;
			end
		else
			begin
			BRAM_ID 	<= 32'hABCD1234;
			BRAM_STATUS <= BRAM_STATUS_IN;
			BRAM_PARAM  <= (1 << 24) 
						 | (2 << 16) 
						 | (3 << 8) 
						 | (4);
			end
	
	
// WRITE Signals
	assign BRAM_CONTROL_wr 	  = (reg_addr == `BRAM_CONTROL_OFFSET) & wr_en;
	assign BRAM_SELECT_wr 	  = (reg_addr == `BRAM_SELECT_OFFSET)  & wr_en;
	
// READ Signals
	assign BRAM_CONTROL_rd 	  = (reg_addr == `BRAM_CONTROL_OFFSET) & rd_en; 
	assign BRAM_SELECT_rd     = (reg_addr == `BRAM_SELECT_OFFSET)  & rd_en; 
	assign BRAM_STATUS_rd 	  = (reg_addr == `BRAM_STATUS_OFFSET)  & rd_en; 
	assign BRAM_PARAM_rd  	  = (reg_addr == `BRAM_PARAM_OFFSET)   & rd_en;	
	assign BRAM_ID_rd  	  	  = (reg_addr == `BRAM_ID_OFFSET)      & rd_en;	

//Write to regs
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            BRAM_CONTROL <= 32'b0;
        end
        else begin
            if (BRAM_CONTROL_wr) begin
                BRAM_CONTROL <= wdata;
            end      
        end
    end
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            BRAM_SELECT <= 32'b0;
        end
        else begin
            if (BRAM_SELECT_wr) begin
                BRAM_SELECT <= wdata;
            end      
        end
    end

// Static cross-module wires(regs) READ-ONLY
           
// Read from regs
    always @ (*) begin
        rdata = {32{1'b0}};
        case (1'b1)	
            BRAM_STATUS_rd         	: rdata = BRAM_STATUS;
            BRAM_CONTROL_rd        	: rdata = BRAM_CONTROL;            
            BRAM_SELECT_rd	  	   	: rdata = BRAM_SELECT;
			BRAM_PARAM_rd		  	: rdata = BRAM_PARAM;
			BRAM_ID_rd			  	: rdata = BRAM_ID;

        endcase
    end
    
    
    
	
endmodule