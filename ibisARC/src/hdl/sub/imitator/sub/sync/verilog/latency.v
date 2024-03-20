//задерживает однобитовый сигнал на заданное количество тактов
module latency(
	//parameter length (def = 1)
	//RESET_TYPE "SYN" or "ASY"(def="ASY")
	clk,
	reset,
	in,
	out,
	out_reg//весь сдвиговый регистр для промежуточных задержек
);

parameter length = 1;
parameter RESET_TYPE = "ASY";

input clk;
input reset;
input in;
output out;
output [length-1:0] out_reg;

reg [length-1:0] lat;//звено задержки вх. сигнала
wire [length-1:0] out_reg;


generate
//SYN RESET
if(RESET_TYPE == "SYN")
	if(length == 1)
		begin
			always@(posedge clk)
			if(reset)
				lat <= 0;
			else
				lat[0] <= in;
		end
	else
		begin
			always@(posedge clk)
			if(reset)
				lat <= 0;
			else
				lat[length-1:0] <= {lat[length-2:0],in};
		end
//-----------------------------
//ASY RESET
else
	if(length == 1)
		begin
			always@(posedge clk or posedge reset)
			if(reset)
				lat <= 0;
			else
				lat[0] <= in;
		end
	else
		begin
			always@(posedge clk or posedge reset)
			if(reset)
				lat <= 0;
			else
				lat[length-1:0] <= {lat[length-2:0],in};
		end

endgenerate

assign out = lat[length-1];
assign out_reg = lat;

endmodule
