`timescale 1ns/10ps

module level_sync#(
    parameter WIDTH = 1,        //(def=1)
    parameter INIT_STATE = 1'b0 // 1'b0 or 1'b1(def=1'b0)
)
(
    input  clk,
    input  [WIDTH-1:0] async,
    output [WIDTH-1:0] sync
);

(* ASYNC_REG="TRUE", SHIFT_EXTRACT="NO" *)
reg [WIDTH-1:0] sync1 = {WIDTH{INIT_STATE}};
(* ASYNC_REG="TRUE", SHIFT_EXTRACT="NO" *)
reg [WIDTH-1:0] sync2 = {WIDTH{INIT_STATE}};

always_ff@(posedge clk) begin
    sync1 <= async;
    sync2 <= sync1;
end

assign sync = sync2;

endmodule
