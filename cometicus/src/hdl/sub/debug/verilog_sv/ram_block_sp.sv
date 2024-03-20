module ram_block_sp
#(
    parameter  WIDTH   = 1,
    parameter  DEPTH   = 1,
    localparam AWIDTH  = $clog2(DEPTH)
)
(
    input                     clk,
    input                     we,
    input        [WIDTH-1:0]  dat_in,
    output logic [WIDTH-1:0]  dat_out,
    input        [AWIDTH-1:0] addr
);

reg [WIDTH-1:0] ram [DEPTH-1:0];

always_ff@(posedge clk)
if(we) begin
    ram[addr] <= dat_in;
end else begin
    dat_out <= ram[addr];
end

endmodule