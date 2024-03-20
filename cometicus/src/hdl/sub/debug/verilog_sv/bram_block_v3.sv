`include "macro.svh"

module bram_block_v3#(
    parameter  WIDTH       = 1,
    parameter  DEPTH       = 1,
    parameter  BLOCK_DEPTH = 32768, // глубина одного BRAM
    
    localparam BRAM_BLOCKS = `ceil_div(DEPTH,BLOCK_DEPTH),
    localparam AWIDTH      = $clog2(BLOCK_DEPTH*BRAM_BLOCKS)
)
(
    input  wr_clk,
    input  rd_clk,
    input  we,
    input  re,
    input        [WIDTH-1:0]  dat_in,
    output logic [WIDTH-1:0]  dat_out,
    input        [AWIDTH-1:0] wr_addr,
    input        [AWIDTH-1:0] rd_addr
);

localparam AWIDTH_LO   = $clog2(BLOCK_DEPTH); // адрессация внутри BRAM
localparam AWIDTH_HI   = AWIDTH - AWIDTH_LO;  // адрессация между BRAM

wire [AWIDTH_LO-1:0] rd_addr_lo;
wire [AWIDTH_HI-1:0] rd_addr_hi;
wire [AWIDTH_LO-1:0] wr_addr_lo;
wire [AWIDTH_HI-1:0] wr_addr_hi;

assign rd_addr_lo = rd_addr[AWIDTH_LO-1:0];
assign rd_addr_hi = rd_addr[AWIDTH-1:AWIDTH_LO];
assign wr_addr_lo = wr_addr[AWIDTH_LO-1:0];
assign wr_addr_hi = wr_addr[AWIDTH-1:AWIDTH_LO];

(* ram_style = "block" *)
reg [WIDTH-1:0] ram [DEPTH-1:0];

always_ff@(posedge wr_clk)
if(we)
    ram[wr_addr] <= dat_in;

wire [WIDTH-1:0] bram_rdata [BRAM_BLOCKS-1:0];
reg  [WIDTH-1:0] bram_rdata_reg [BRAM_BLOCKS-1:0];
for(genvar i = 0; i < BRAM_BLOCKS; i = i + 1) begin
    bram_block_v2#(
        .OUT_REG ("EN"),
        .WIDTH   (WIDTH),
        .DEPTH   (BLOCK_DEPTH)
    ) BRAM(
        .wr_clk  (wr_clk),
        .rd_clk  (rd_clk),
        .we      (we & (wr_addr_hi == i)),
        .re      (re),
        .dat_in  (dat_in),
        .dat_out (bram_rdata[i]),
        .wr_addr (wr_addr_lo),
        .rd_addr (rd_addr_lo)
    );
    
    always_ff@(posedge rd_clk) begin
        bram_rdata_reg[i] <= bram_rdata[i];
    end
end

conv_reg#(
    .width  (WIDTH),
    .length (2)
) conv_reg_inst(
    .clk    (rd_clk),
    .in     (bram_rdata_reg[rd_addr_hi]),
    .out    (dat_out)
);

// always_ff@(posedge rd_clk) begin
    // dat_out <= bram_rdata_reg[rd_addr_hi];
// end

endmodule
