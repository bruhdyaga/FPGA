`include "global_param.v"
`include "facq_prn_ram.svh"

module facq_prn_ram
#(
    parameter BASEADDR  = 0,
    parameter RAM_SIZE  = 0,
    localparam RAM_DEPTH      = (RAM_SIZE - 1)/`AXI_GP_WIDTH + 1, // глубина памяти в словах
    localparam ADDR_BITS      = $clog2(RAM_SIZE),
    localparam ADDR_WORD_BITS = $clog2(RAM_DEPTH)
)
(
    intbus_interf.slave               bus,
    input                             clk,
    input [2:0]                       freq_div,
    input                             shift,
    input                             clr,
    output logic                      prn,
    output logic                      valid,
    output logic                      en,
    input                             do_init,
    output logic [ADDR_WORD_BITS-1:0] rd_cntr,
    input        [ADDR_WORD_BITS-1:0] rd_cntr_init
);



logic [`AXI_GP_WIDTH-1:0] ram_out;

logic [`AXI_GP_WIDTH-1:0] sr_out; // out shift reg

logic [ADDR_BITS-1:0]             prn_cntr; // счетчик вычитываемых битов ПСП
logic [ADDR_WORD_BITS-1:0]        wr_addr;
logic [ADDR_WORD_BITS-1:0]        rd_addr;
logic [$clog2(`AXI_GP_WIDTH)-1:0] bit_cntr;
logic [1:0]                       rep_cntr; // счетчик растягивания ПСП на чипе
logic sr_load;

// The generator data structure definition
FACQ_PRN_RAM_STRUCT PS;     // The registers from CPU

wire [(($bits(FACQ_PRN_RAM_STRUCT) + 1)/`AXI_GP_WIDTH) - 1 : 0] int_wr_arr;
regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`FACQ_PRN_RAM_ID_CONST),
    .DATATYPE (FACQ_PRN_RAM_STRUCT),
    .OUTFF    ("n")
)RF (
    .clk    ('0),
    .bus    (bus),
    .in     ('0),
    .out    (PS),
    .pulse  (),
    .wr     (int_wr_arr),
    .rd     ()
);

// // //
// Write interface
// // //
logic wr_ram;
always_ff@(posedge bus.clk) begin
    wr_ram <= int_wr_arr[1];
end

always_ff@(posedge bus.clk) begin
if(int_wr_arr[0]) begin
    wr_addr <= '0;
end else
    if(wr_ram) begin
        wr_addr <= wr_addr + 1'b1;
    end
end

// // //
// Counters
// // //
wire next_bit;
wire next_word;
wire reset_cntr;

// 0.5 symbol counter
always_ff@(posedge clk)
if(shift) begin
    if(rep_cntr == (freq_div-1)) begin
        rep_cntr <= '0;
    end else begin
        rep_cntr <= rep_cntr + 1'b1;
    end
end else begin
    rep_cntr <= '0;
end

// 32-bit word counter
always_ff@(posedge clk)
if(do_init) begin
    rd_cntr <= rd_cntr_init;
end else if(clr | reset_cntr) begin
    rd_cntr <= '0;
end else if(next_word) begin
    rd_cntr <= rd_cntr + 1'b1;
end

// bit counter
always_ff@(posedge clk)
if(next_word | clr | reset_cntr | do_init) begin
    bit_cntr <= '0;
end else begin
    if(next_bit) begin
        bit_cntr <= bit_cntr + 1'b1;
    end
end

// flags
assign prn_cntr   = (rd_cntr << $clog2(`AXI_GP_WIDTH)) + bit_cntr;
assign next_bit   = shift    & (rep_cntr == (freq_div-1));
assign next_word  = next_bit & (bit_cntr == (2**$clog2(`AXI_GP_WIDTH) - 1));
assign reset_cntr = wr_addr |  next_bit & (prn_cntr == PS.CFG.RAM_LENGTH);

// // //
// Read interface
// // //
assign switch_bit = shift & (rep_cntr == (freq_div-2));
assign init_ram   = wr_addr | (switch_bit & (prn_cntr == PS.CFG.RAM_LENGTH));
assign rd_next    =            switch_bit & (bit_cntr == (2**$clog2(`AXI_GP_WIDTH) - 1));
//
assign rd_ram     =  do_init | init_ram | rd_next;
assign rd_addr    = (do_init) ? rd_cntr_init : ( (init_ram) ? '0 : rd_cntr + 1 );

always_ff@(posedge clk)
sr_load <= rd_ram;

bram_block_v2#(
    .OUT_REG ("EN"),
    .WIDTH   (`AXI_GP_WIDTH),
    .DEPTH   (RAM_DEPTH)
) bram_block_v2_inst(
    .wr_clk  (bus.clk),
    .rd_clk  (clk),
    .we      (wr_ram),
    .re      (rd_ram),
    .dat_in  (PS.DATA),
    .dat_out (ram_out),
    .wr_addr (wr_addr),
    .rd_addr (rd_addr)
);

always_ff@(posedge clk)
// if(next_word | reset_cntr) begin
if(sr_load) begin
    sr_out <= ram_out;
end else if(next_bit) begin
    if(PS.CFG.REVERSE) begin
        sr_out <= sr_out << 1;
    end else begin
        sr_out <= sr_out >> 1;
    end
end

assign prn = PS.CFG.REVERSE ? sr_out[31] : sr_out[0];
assign valid = shift;

assign en = PS.CFG.PRN_RAM_EN;

endmodule