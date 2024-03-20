module dac_clk_interface(
	clk,
	en,
	clk_out_p,
	clk_out_n
);

parameter INV_CLK = 0;//1 - инвертирует клоки

input  clk;
input  en;
output clk_out_p;
output clk_out_n;

wire D0;
wire D1;


assign D0 = INV_CLK ? 1'b0 : 1'b1;
assign D1 = !D0;

ODDR2#(
	.DDR_ALIGNMENT ("NONE"), // Sets output alignment to "NONE", "C0" or "C1" 
	.INIT          (1'b0),   // Sets initial state of the Q output to 1'b0 or 1'b1
	.SRTYPE        ("ASYNC") // Specifies "SYNC" or "ASYNC" set/reset
)ODDR2_inst_clk_out_n (
	.Q  (clk_out_n), // 1-bit DDR output data
	.C0 (!clk),      // 1-bit clock input
	.C1 (clk),       // 1-bit clock input
	.CE (1'b1),      // 1-bit clock enable input
	.D0 (D0),        // 1-bit data input (associated with C0)
	.D1 (D1),        // 1-bit data input (associated with C1)
	.R  (!en),       // 1-bit reset input
	.S  (1'b0)       // 1-bit set input
);

ODDR2 #(
	.DDR_ALIGNMENT ("NONE"), // Sets output alignment to "NONE", "C0" or "C1" 
	.INIT          (1'b0),   // Sets initial state of the Q output to 1'b0 or 1'b1
	.SRTYPE        ("SYNC")  // Specifies "SYNC" or "ASYNC" set/reset
) ODDR2_inst_clk_out_p (
	.Q  (clk_out_p), // 1-bit DDR output data
	.C0 (clk),       // 1-bit clock input
	.C1 (!clk),      // 1-bit clock input
	.CE (1'b1),      // 1-bit clock enable input
	.D0 (D0),      // 1-bit data input (associated with C0)
	.D1 (D1),      // 1-bit data input (associated with C1)
	.R  (!en),       // 1-bit reset input
	.S  (1'b0)       // 1-bit set input
);

endmodule