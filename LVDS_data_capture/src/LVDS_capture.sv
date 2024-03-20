`timescale 1ns / 1ps
module LVDS_capture(
    input       [7:0] capture_data_p,
    input       [7:0] capture_data_n,
    input             clk_out_p,
    input             clk_out_n,
    input             rst,
    output reg [15:0] ADC_data
    );	
    
    logic          clk_en, IDDR_set, IDDR_rst;
    wire           clk;
    wire  [7:0]    data;
    reg   [7:0]    iddr_data_even;
    reg   [7:0]    iddr_data_odd;
    genvar         i;
 	

    IBUFDS   ibuf_ds_clk(
	.O ( clk ),
    .I ( clk_out_p ), 
    .IB( clk_out_n)
    );
	
	generate
	for( i = 0; i < 8; i = i + 1) 
	begin
	IBUFDS ibuf_ds_data	(
	 .O ( data[i] ),
	 .I ( capture_data_p[i] ),
     .IB( capture_data_n[i] )
     );

	IDDR #(
   .DDR_CLK_EDGE("OPPOSITE_EDGE"),
   .INIT_Q1(1'b0),
   .INIT_Q2(1'b0), 
   .SRTYPE("SYNC") 
    )
    IDDR_inst (
   .Q1(iddr_data_even[i]),  // 1-bit output for positive edge of clock
   .Q2(iddr_data_odd[i]),   // 1-bit output for negative edge of clock
   .C(clk),                 // 1-bit clock input
   .CE(1'b1),               // 1-bit clock enable input
   .D(data[i]),             // 1-bit DDR data input
   .R(1'b0),                // 1-bit reset
   .S(rst)                  // 1-bit set
    );
    				     
	end				
	endgenerate
	
	
    always @(posedge clk or posedge rst) begin
    
    if (rst) 
    begin
    ADC_data <=0;
    end
    
    else begin
	ADC_data[0]  <= iddr_data_odd  [0];
	ADC_data[1]  <= iddr_data_even [0];
	ADC_data[2]  <= iddr_data_odd  [1];
	ADC_data[3]  <= iddr_data_even [1];
	ADC_data[4]  <= iddr_data_odd  [2];
	ADC_data[5]  <= iddr_data_even [2];
	ADC_data[6]  <= iddr_data_odd  [3];
	ADC_data[7]  <= iddr_data_even [3];
	ADC_data[8]  <= iddr_data_odd  [4];
	ADC_data[9]  <= iddr_data_even [4];
	ADC_data[10] <= iddr_data_odd  [5];
	ADC_data[11] <= iddr_data_even [5];
	ADC_data[12] <= iddr_data_odd  [6];
	ADC_data[13] <= iddr_data_even [6];
	ADC_data[14] <= iddr_data_odd  [7];
	ADC_data[15] <= iddr_data_even [7];
	end
    end
	
endmodule
