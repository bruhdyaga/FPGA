module dac_interface(
	clk,
	en,//active high
	in,
	out
);

parameter WIDTH = 14;

input clk;
input en;
input  [WIDTH-1:0] in;
output [WIDTH-1:0] out;

wire [WIDTH-1:0] in_conv;

genvar i;


conv_reg#(
	.width(WIDTH),
	.length(1)
)
CONV_REG_DAC_DATA(
	.reset(1'b0),
	.clk(clk),
	.in(in),
	.out(in_conv)
);

//меняем данные по спаду клоков
//по en выставляем нули на линии данных
generate
for(i=0;i<WIDTH;i=i+1)
begin:loop_DAC_ODDR
ODDR2#(
	.DDR_ALIGNMENT ("NONE"), // Sets output alignment to "NONE", "C0" or "C1" 
	.INIT          (1'b0),   // Sets initial state of the Q output to 1'b0 or 1'b1
	.SRTYPE        ("ASYNC") // Specifies "SYNC" or "ASYNC" set/reset
)ODDR2_inst (
	.Q  (out[i]),     // 1-bit DDR output data
	.C0 (clk),        // 1-bit clock input
	.C1 (!clk),       // 1-bit clock input
	.CE (1'b1),       // 1-bit clock enable input
	.D0 (in_conv[i]), // 1-bit data in2 put (associated with C0)
	.D1 (in_conv[i]), // 1-bit data input (associated with C1)
	.R  (!en),        // 1-bit reset input
	.S  (1'b0)        // 1-bit set input
);
//---

end
endgenerate

endmodule
