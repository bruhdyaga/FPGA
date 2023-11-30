`timescale 1ns / 1ps

module IBUFDS(
     output reg O,
     input I,
     input IB);
     
always @*
begin
     if( (I == 1'b1)&( IB == 1'b0))
     assign O = 1'b1;
     else  if( (I == 1'b0)&( IB == 1'b1))
     assign O = 1'b0;
        
end
endmodule

module LVDS_capture(
    input [7:0] capture_data_p,
    input [7:0] capture_data_n,
    input clk_out_p,
    input clk_out_n,
    input rst,
    output reg [15:0] final_output
    );	
    wire          clk;
    wire  [7:0]   data;
	reg   [7:0]   out_reg;
 	
	genvar         i;
	
    IBUFDS   ibuf_ds_clk(
	          .O ( clk ),
			  .I ( clk_out_p ), 
			  .IB( clk_out_n)
    );
	
	generate
	for( i = 0; i < 8; i = i + 1) 
	begin
	IBUFDS ibuf_ds_data	(.O ( data[i] ),
	                     .I ( capture_data_p[i] ),
						 .IB( capture_data_n[i] )
					     );
	end				
	endgenerate
	
	
	//always @(negedge rst)begin
	//out_reg <=8 'b 00000000;
	//final_output <= 16'b 00000000_00000000;
	//end
	
    always @(negedge clk) begin
	out_reg[0] <= data[0];
	out_reg[1] <= data[1];
	out_reg[2] <= data[2];
	out_reg[3] <= data[3];
	out_reg[4] <= data[4];
	out_reg[5] <= data[5];
	out_reg[6] <= data[6];
	out_reg[7] <= data[7];
    end

	always @(posedge clk) begin	
	        final_output[0]  <= out_reg[0]; 
			final_output[1]  <= data[0]; 
			final_output[2]  <= out_reg[1]; 
			final_output[3]  <= data[1];
			final_output[4]  <= out_reg[2]; 
			final_output[5]  <= data[2];
	        final_output[6]  <= out_reg[3]; 
			final_output[7]  <= data[3]; 
	        final_output[8]  <= out_reg[4]; 
			final_output[9]  <= data[4]; 
	        final_output[10] <= out_reg[5]; 
			final_output[11] <= data[5]; 
	        final_output[12] <= out_reg[6]; 
			final_output[13] <= data[6]; 
	        final_output[14] <= out_reg[7]; 
			final_output[15] <= data[7]; 
    end		
endmodule
