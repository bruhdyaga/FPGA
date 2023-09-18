`timescale 1ns / 1ps

module _1ms(
    input clk, KEY2,
    input key0,
    output time_1ms
    );
	 
	 reg [25:0] ctr_reg ; // 26 bits to cover 25,000,000
    reg clk_out_reg;
		
always_ff @(posedge clk or negedge KEY2) 
	  if (!KEY2) begin 
		ctr_reg = 0;
      clk_out_reg = 0;
    end 
	 else begin
	  if (key0) begin 
		ctr_reg = 0;
      clk_out_reg = 0;
    end
        else
            if(ctr_reg == 24_999) begin  // тысячная
                ctr_reg <= 0;
                clk_out_reg <= ~clk_out_reg;
            end
            else
                ctr_reg <= ctr_reg + 1;
					 end
					
    assign time_1ms = clk_out_reg;

endmodule
