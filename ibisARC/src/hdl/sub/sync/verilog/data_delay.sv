module data_delay#(
    parameter  WIDTH       = 0,
    parameter  MAX_DELAY   = 0,
    localparam DELAY_WIDTH = $clog2(MAX_DELAY+1) // ширина разрядности для задержки
)
(
    input  clk,
    input  [DELAY_WIDTH-1:0] delay,
    input  [WIDTH-1:0]       in,
    output [WIDTH-1:0]       out
);

reg  [WIDTH-1:0] data_dly_reg [MAX_DELAY:1];
wire [WIDTH-1:0] data_dly     [MAX_DELAY:0];

assign data_dly = {data_dly_reg,in};

always_ff@(posedge clk) begin
    data_dly_reg <= data_dly[MAX_DELAY-1:0];
end

assign out = data_dly[delay];

endmodule
