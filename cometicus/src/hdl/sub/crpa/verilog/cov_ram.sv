`include "cov_ram.svh"

module cov_ram#(
    parameter BASEADDR    = 0,
    parameter NCH         = 0,
    parameter WIDTH       = 0,
    parameter RAM_SIZE    = 0,
    parameter RAM_BLOCKS  = 0
)
(
    adc_interf.slave    data_in,
    adc_interf.master   data_out,
    intbus_interf.slave bus,
    input               we,
    input               ce,
    input               rd
);

localparam DEPTH = (2**RAM_SIZE)*RAM_BLOCKS;
localparam RAM_BLOCKS_AWIDTH = $clog2(RAM_BLOCKS);

// The generator data structure definition
COV_RAM_STRUCT PL;     // The registers from logic
COV_RAM_STRUCT PS;     // The registers from CPU

wire [`COV_RAM_SIZE-1:0] bus_wr;
wire [`COV_RAM_SIZE-1:0] bus_rd;

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 0} // start
};

localparam [`COV_RAM_SIZE-1:0] RVALID_FF = 'b100;

localparam logic [7 : 0] SYNCO [`COV_RAM_SIZE] = '{
    {"n"},  // CFG
    {"l"},  // CFG2
    {"n"}   // RAM
};

wire start;
regs_file#(
    .BASEADDR  (BASEADDR),
    .ID        (`COV_RAM_ID_CONST),
    .DATATYPE  (COV_RAM_STRUCT),
    .SYNCO     (SYNCO),
    .NPULSE    (NPULSE),
    .PULSE     (PULSE),
    .RVALID_FF (RVALID_FF)
)RF (
    .clk    (data_in.clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (start),
    .wr     (bus_wr),
    .rd     (bus_rd)
);

assign PL.CFG.RAM_BLOCKS = RAM_BLOCKS;
assign PL.CFG.RAM_SIZE   = RAM_SIZE;
assign PL.CFG.START_WR   = '0;
assign PL.CFG2           = '0;

assign data_out.clk    = data_in.clk;

reg  write;
wire wr_ram;
reg  [RAM_SIZE-1:0]          wr_addr_lo;
reg  [RAM_BLOCKS_AWIDTH-1:0] wr_addr_hi;
reg  [RAM_SIZE-1:0]          rd_addr_lo;
reg  [RAM_BLOCKS_AWIDTH-1:0] rd_addr_hi;

always_ff@(posedge data_in.clk)
if(ce) begin
    if(start) begin
        wr_addr_lo <= '0;
    end else begin
        if((PL.CFG.COMPLETE_WR == '0) & wr_ram) begin
            wr_addr_lo <= wr_addr_lo + 1'b1;
        end
    end
end

always_ff@(posedge data_in.clk)
if(ce) begin
    if(start) begin
        wr_addr_hi <= '0;
    end else begin
        if((PL.CFG.COMPLETE_WR == '0) & (wr_addr_lo == '1) & wr_ram) begin
            wr_addr_hi <= wr_addr_hi + 1'b1;
        end
    end
end

wire [RAM_BLOCKS_AWIDTH-1:0] W_BLOCKS; // ширина соответствует PS.CFG.W_BLOCKS

assign W_BLOCKS = PS.CFG.W_BLOCKS[RAM_BLOCKS_AWIDTH-1:0];
assign PL.CFG.COMPLETE_WR = (wr_addr_lo == '1) & (wr_addr_hi == W_BLOCKS);

assign PL.CFG.W_BLOCKS    = W_BLOCKS; // читаем фактическое количество записываемых блоков

always_ff@(posedge data_in.clk)
if(ce) begin
    if(start) begin
        write <= '1;
    end else begin
        if(PL.CFG.COMPLETE_WR == '1) begin
            write <= '0;
        end
    end
end

//--------------------------------------

signal_sync signal_sync_cpu_rd_ram(
    .sclk     (bus.clk),
    .dclk     (data_out.clk),
    .start    (bus_rd[2]),
    .ready    (cpu_rd_ram)
);

always_ff@(posedge data_out.clk)
if(ce) begin
    data_out.valid <= rd;
end

always_ff@(posedge data_out.clk)
if(ce) begin
    if(rd | cpu_rd_ram) begin
        rd_addr_lo <= rd_addr_lo + 1'b1;
    end else begin
        if(PS.CFG2.BLOCK_RD_ADDR == '0) begin
            rd_addr_lo <= '0;
        end
    end
end

always_ff@(posedge data_out.clk)
if(ce) begin
    if(rd | cpu_rd_ram) begin
        if(rd_addr_lo == '1) begin
            rd_addr_hi <= rd_addr_hi + 1'b1;
        end
    end else begin
        if(PS.CFG2.BLOCK_RD_ADDR == '0) begin
            rd_addr_hi <= '0;
        end
    end
end

assign wr_ram = we & write;
for(genvar i = 0; i < NCH; i ++) begin: CH_RAM
    bram_block_v2#(
        .OUT_REG ("EN"),
        .WIDTH   (WIDTH),
        .DEPTH   (DEPTH)
    )RAM (
        .wr_clk  (data_in.clk),
        .rd_clk  (data_out.clk),
        .we      (wr_ram),
        .re      ('1),
        .dat_in  (data_in.data[i]),
        .dat_out (data_out.data[i]),
        .wr_addr ({wr_addr_hi,wr_addr_lo}),
        .rd_addr ({rd_addr_hi,rd_addr_lo})
    );
end

assign PL.RAM = data_out.data[PS.CFG2.RAM_CH];

endmodule