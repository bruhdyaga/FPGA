`timescale 1ns/10ps
module test_interf_tb();

localparam NBUSES = 3;

logic clk = 1;

always #5 clk = ~clk;

axi3_interface axi3();
intbus_interf  bus();
intbus_interf bus_sl[NBUSES]();

assign axi3.aclk = clk;
assign bus.clk   = clk;

// axi3_to_inter axi3_to_inter_inst(
    // .axi3    (axi3),
    // .int_bus (bus)
// );

connectbus#(
    .BASEADDR   (0),
    .N_BUSES    (NBUSES),
    .OUTFF      ("n"),
    .MASTERFF   ("n")
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

typedef struct packed{
    logic [31:0] RW;
} TB_STRCT;

TB_STRCT PS1, PS2;

regs_file#(
    .BASEADDR (1),
    .ID       ('h1111),
    .DATATYPE (TB_STRCT),
    .OUTFF    ("n")
)RF_1 (
    .clk           (),
    .bus           (bus_sl[0]),
    .in            (),
    .out           (PS1),
    .pulse         (),
    .wr            (),
    .rd            ()
);

regs_file#(
    .BASEADDR (3),
    .ID       ('h2222),
    .DATATYPE (TB_STRCT),
    .OUTFF    ("n")
)RF_2 (
    .clk           (),
    .bus           (bus_sl[1]),
    .in            (),
    .out           (PS2),
    .pulse         (),
    .wr            (),
    .rd            ()
);

initial begin
    @(posedge clk) axi3.readReg(1*4,0,0);
    axi3.readReg(3*4,0,0);
end

initial begin
    bus.wr   <= '0;
    @(posedge clk)
    bus.rd   <= '1;
    bus.addr <= 'd1;
    @(posedge clk)
    bus.addr <= 'd3;
    @(posedge clk)
    bus.rd   <= '0;
    
    @(posedge clk)
    bus.wr <= '1;
    bus.addr <= 'd2;
    bus.wdata <= 'h12345678;
    @(posedge clk)
    bus.wr <= '0;
    
end

initial begin
    bus_sl[2].rdata  <= '0;
    bus_sl[2].rvalid <= '0;
    // #1000
    // @(posedge clk)
    // bus_sl[2].rvalid <= '1;
    // @(posedge clk)
    // bus_sl[2].rvalid <= '0;
    
end

endmodule