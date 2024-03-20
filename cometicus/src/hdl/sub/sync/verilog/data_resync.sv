module data_resync
#(
    parameter WIDTH = 0,
    parameter DEPTH = 4
)
(
    input                  wr_clk,
    input  [WIDTH-1:0]     wr_data,
    input                  rd_clk,
    output reg [WIDTH-1:0] rd_data
);

localparam ADDR_SIZE    = $clog2(DEPTH);
localparam RD_ADDR_INIT = (DEPTH >> 1) - 1;

reg [ADDR_SIZE-1:0] wraddr = RD_ADDR_INIT;
reg [ADDR_SIZE-1:0] rdaddr = '0;

(* ram_style="block" *)
reg [WIDTH-1:0] ram [DEPTH-1:0];

always_ff@(posedge wr_clk) begin
    if(wraddr == DEPTH-1) begin
        wraddr <= '0;
    end else begin
        wraddr <= wraddr + 1'b1;
    end
end

always_ff@(posedge rd_clk) begin
    if(rdaddr == DEPTH-1) begin
        rdaddr <= '0;
    end else begin
        rdaddr <= rdaddr + 1'b1;
    end
end

always_ff@(posedge wr_clk) begin
    ram[wraddr] <= wr_data;
end

always_ff@(posedge rd_clk) begin
    rd_data <= ram[rdaddr];
end

endmodule
