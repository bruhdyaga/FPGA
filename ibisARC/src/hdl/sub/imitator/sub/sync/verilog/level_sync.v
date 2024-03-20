`timescale 1ns/10ps

module level_sync(
	//INIT_STATE 1'b0 or 1'b1(def=1'b0)
	//WIDTH (def=1)
	//RESET_TYPE "SYN" or "ASY"(def="ASY")
	clk,
	reset_n,
	async,
	sync
);

parameter WIDTH = 1;
parameter INIT_STATE = 1'b0;
parameter RESET_TYPE = "ASY";

input clk;
input reset_n;
input [WIDTH - 1 : 0] async;
output [WIDTH - 1 : 0] sync;  


(* ASYNC_REG="TRUE", SHIFT_EXTRACT="NO" *)
reg [WIDTH - 1 : 0] sync1 = {WIDTH{INIT_STATE}};
(* ASYNC_REG="TRUE", SHIFT_EXTRACT="NO" *)
reg [WIDTH - 1 : 0] sync2 = {WIDTH{INIT_STATE}};

generate
if(RESET_TYPE == "SYN")
	always @ (posedge clk) begin
	if (reset_n == 1'b0) begin
		sync1 <= {WIDTH{INIT_STATE}};
		sync2 <= {WIDTH{INIT_STATE}};
	end
	else begin
		sync1 <= async;
		sync2 <= sync1;
	end
	end
else
	always @ (posedge clk or negedge reset_n) begin
	if (reset_n == 1'b0) begin
		sync1 <= {WIDTH{INIT_STATE}};
		sync2 <= {WIDTH{INIT_STATE}};
	end
	else begin
		sync1 <= async;
		sync2 <= sync1;
	end
	end
endgenerate

assign sync = sync2;

endmodule
