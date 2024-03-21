module ed_det(
	//TYPE "ed"-default,"ris","fal"
	//RESET_TYPE "SYN" or "ASY"(def="ASY")
	//IN_RESET_VALUE 0(def) or 1'b1//значение на входе во время reset
	clk,
	reset,
	in,
	out//одноклоковый сигнал перепада
);

parameter TYPE = "ed";
parameter RESET_TYPE = "ASY";
parameter IN_RESET_VALUE = 0;

input clk;
input reset;
input in;
output out;

reg lat;//звено задержки вх. сигнала на такт
reg out;

generate
//SYN RESET
if(RESET_TYPE == "SYN")
begin
	if(TYPE == "ed")
		always@(posedge clk)
		if(reset)
			lat <= IN_RESET_VALUE;
		else
			lat <= in;
		
	if(TYPE == "ris")
		always@(posedge clk)
		if(reset)
			lat <= IN_RESET_VALUE;
		else
			lat <= in;
		
	if(TYPE == "fal")
		always@(posedge clk)
		if(reset)
			lat <= IN_RESET_VALUE;
		else
			lat <= in;
	//-----
	if(TYPE == "ed")
		always@(*)
			out <= ((lat == 1'b0) & (in == 1'b1) | (lat == 1'b1) & (in == 1'b0));
		
	if(TYPE == "ris")
		always@(*)
			out <= ((lat == 1'b0) & (in == 1'b1));
			
	if(TYPE == "fal")
		always@(*)
			out <= ((lat == 1'b1) & (in == 1'b0));
//-----------------------------
//ASY RESET
end else begin
	if(TYPE == "ed")
		always@(posedge clk or posedge reset)
		if(reset)
			lat <= IN_RESET_VALUE;
		else
			lat <= in;
		
	if(TYPE == "ris")
		always@(posedge clk or posedge reset)
		if(reset)
			lat <= IN_RESET_VALUE;
		else
			lat <= in;
		
	if(TYPE == "fal")
		always@(posedge clk or posedge reset)
		if(reset)
			lat <= IN_RESET_VALUE;
		else
			lat <= in;
	//-----
	if(TYPE == "ed")
		always@(*)
			out <= ((lat == 1'b0) & (in == 1'b1) | (lat == 1'b1) & (in == 1'b0));
		
	if(TYPE == "ris")
		always@(*)
			out <= ((lat == 1'b0) & (in == 1'b1));
			
	if(TYPE == "fal")
		always@(*)
			out <= ((lat == 1'b1) & (in == 1'b0));
end
endgenerate


endmodule
