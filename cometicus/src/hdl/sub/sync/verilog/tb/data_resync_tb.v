`timescale 1ns / 1ps


module data_resync_tb(
    );
    parameter WIDTH = 4;
    parameter DEPTH = 8;
    localparam delay = 33; // 7 or 33
    
    reg  wr_clk = 0;
    reg [WIDTH-1:0] wr_data = 0;
    reg rd_clk = 0;
    wire [WIDTH-1:0] rd_data;

always #20 wr_clk = !wr_clk;

always @( posedge wr_clk)
wr_data <= wr_data + 1;


initial begin
#delay;  
forever begin
#20 rd_clk = ~rd_clk;
end
end

data_resync#(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH)
)
data_resync_inst (
	.wr_clk   (wr_clk),
	.wr_data   (wr_data),
	.rd_clk   (rd_clk),
	.rd_data   (rd_data)
);



endmodule
