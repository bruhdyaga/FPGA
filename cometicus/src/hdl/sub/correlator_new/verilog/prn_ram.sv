`include "prn_ram.svh"
`include "global_param.v"

module prn_ram
#(
    parameter BASEADDR  = 0,
    parameter RAM_SIZE  = 0 // число бит = { 10230, 5115, 4092, 2046, 1023, 511 }
)
(
    intbus_interf.slave bus,
    input               clk,
    input  [2:0]        phase_hi,
    input               update,
    output logic        code_out,
    output logic        mask,
    input  [9:0]        chip,
    input               chip_pulse,
    input               epoch_pulse
);

localparam ADDR_BITS = $clog2(RAM_SIZE);

logic ram_out;
logic [3:0]  hi_chip_cntr = '0;
wire  [13:0] full_chip;

assign full_chip = {hi_chip_cntr,chip};

// The generator data structure definition
PRN_RAM_STRUCT PL;     // The registers from logic
PRN_RAM_STRUCT PS;     // The registers from CPU

wire [(($bits(PRN_RAM_STRUCT) + 1)/`AXI_GP_WIDTH) - 1 : 0] int_wr_arr;
regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`PRN_RAM_ID_CONST),
    .DATATYPE (PRN_RAM_STRUCT),
    .OUTFF    ("n")
)RF (
    .clk    (clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (int_wr_arr),
    .rd     ()
);

assign PL.CFG.RAM_LENGTH = ADDR_BITS; // передаем $clog2(RAM_SIZE)
assign PL.CFG.WR_ADDR    = '0;
assign PL.CFG.BOC_MODE   = '0;
assign PL.CFG.TDMA_MODE  = '0;
assign PL.CFG.WR_DATA    = '0;
assign PL.CFG.RESERVED   = '0;

always_ff@(posedge clk)
if(update | ((hi_chip_cntr == PS.CFG.RAM_LENGTH) & epoch_pulse)) begin
    hi_chip_cntr <= '0;
end else if(epoch_pulse | ((chip == '1) & chip_pulse)) begin
    hi_chip_cntr <= hi_chip_cntr + 1'b1;
end

logic wr_ram;
always_ff@(posedge bus.clk) begin
    wr_ram <= int_wr_arr[0];
end

bram_block_v2#(
    .OUT_REG ("EN"),
    .WIDTH   (1),
    .DEPTH   (RAM_SIZE)
) bram_block_v2_inst(
    .wr_clk  (bus.clk),
    .rd_clk  (clk),
    .we      (wr_ram),
    .re      ('1),
    .dat_in  (PS.CFG.WR_DATA),
    .dat_out (ram_out),
    .wr_addr (PS.CFG.WR_ADDR[ADDR_BITS-1:0]),
    .rd_addr (full_chip[ADDR_BITS-1:0])
);

logic [2:0] phase_hi_reg;
logic boc_mod;
always_ff@(posedge clk)
case(PS.CFG.BOC_MODE)
    2'd1     : boc_mod <= !phase_hi_reg[2];
    2'd2     : boc_mod <= !phase_hi_reg[1];
    2'd3     : boc_mod <= !phase_hi_reg[0];
    default  : boc_mod <= '1;
endcase

assign code_out = boc_mod ? ram_out : !ram_out;

always_ff@(posedge clk) begin
    phase_hi_reg <= phase_hi;
end

always_ff@(posedge clk)
case(PS.CFG.TDMA_MODE)
    'd1     : mask <= !phase_hi_reg[2];
    'd2     : mask <=  phase_hi_reg[2];
    default : mask <= '0;
endcase

endmodule
