 `timescale 1ns/10ps


`include "macro.svh"

`define aclk_freq     100    // MHz
`define pclk_freq     125    // MHz


typedef struct packed {
    logic [19:0]  RESERVED;
    logic [3:0]   RD_WR;
    logic [3:0]   RD_ONLY;
    logic [3:0]   WR_ONLY;
} REGSFILE_TEST_RDWR;

typedef struct packed {
    logic [29:0]  RESERVED;
    logic PULSE1;
    logic PULSE0;
} REGSFILE_TEST_PULSING;


typedef struct packed {
    logic [7:0]  PULSES_1;
    logic [7:0]  PULSES_0;
    logic [7:0]  READS;
    logic [7:0]  WRITES;
} REGSFILE_TEST_STATS;

typedef struct packed {
    REGSFILE_TEST_RDWR     RW;
    REGSFILE_TEST_PULSING  PULSING;
    REGSFILE_TEST_STATS    STATS;
} REGSFILE_TEST_STRUCT;

`define REGSFILE_TEST_ID_CONST  (16'hDADA)
`define REGSFILE_TEST_SIZE      (`size32(REGSFILE_TEST_STRUCT))

module regsfile_tb();
localparam BASEADDR  = 32'h0;

reg aclk  = 1;
reg pclk  = 1;
reg presetn;

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;
always #((1000/`pclk_freq)/2)     pclk     <= !pclk;

axi3_interface axi3();
intbus_interf bus();

initial begin
    @(posedge pclk);
    presetn = 0;
    @(posedge pclk);
    @(posedge pclk);
    @(posedge pclk);
    presetn = 1'b1;
end

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

REGSFILE_TEST_STRUCT PL;
REGSFILE_TEST_STRUCT PS;

wire [`REGSFILE_TEST_SIZE-1:0] bus_rd;
wire [`REGSFILE_TEST_SIZE-1:0] bus_wr;

//Define which bits will be pulsed
localparam NPULSE = 2;
localparam integer PULSE [NPULSE][2] = '{
    '{1,  0}, // PULSE 0 (reg 1 bit 0)
    '{1,  1}  // PULSE 1 (reg 1 bit 1)
};

regs_file#(
    .BASEADDR  (BASEADDR),
    .ID        (`REGSFILE_TEST_ID_CONST),
    .DATATYPE  (REGSFILE_TEST_STRUCT),
    .NPULSE    (NPULSE),
    .PULSE     (PULSE)
)RF (
    .clk    (pclk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  ({pulse_1, pulse_0}),
    .wr     (bus_wr),
    .rd     (bus_rd)
);


// to CPU
assign PL.RW.RD_ONLY  = 4'h7; // constantly
assign PL.RW.RESERVED = 0;
// use PS.RW.WR_ONLY and PS.RW.RD_WR into module directly

reg bus_wr_pl; // delay while bus data moves to PS register
always_ff@(posedge bus.clk) begin
    bus_wr_pl <= bus_wr[0];
end

always_ff@(posedge bus.clk)
    if (!presetn) begin
            PL.RW.RD_WR   <= 1; // init
            PL.RW.WR_ONLY <= 0;
    end
    else if (bus_wr_pl) begin
        PL.RW.RD_WR <= PS.RW.RD_WR; // move from PS to PL
    end


// stats and pulsing
always_ff@(posedge bus.clk) begin
    if (!presetn) begin
        PL.STATS.WRITES <= 0;
    end
    else if(bus_wr[0] | bus_wr[1]) begin
        PL.STATS.WRITES <= PL.STATS.WRITES  + 1;
    end 
    
    if (!presetn) begin
        PL.STATS.READS <= 0;
    end
    if(bus_rd[0] | bus_rd[1]) begin
        PL.STATS.READS <= PL.STATS.READS   + 1;
    end
end


always_ff@(posedge pclk) begin
    if (!presetn) begin
        PL.STATS.PULSES_0 <= 0;
    end
    else if(pulse_0) begin
        PL.STATS.PULSES_0 <= PL.STATS.PULSES_0 + 1;
        PL.PULSING.PULSE0 <= 0; // clear pulse bit
    end
end


always_ff@(posedge pclk) begin
    if (!presetn) begin
        PL.STATS.PULSES_1 <= 0;
    end
    else if(pulse_1) begin
        PL.STATS.PULSES_1 <= PL.STATS.PULSES_1 + 1;
        PL.PULSING.PULSE1 <= 0;
    end
end

endmodule
