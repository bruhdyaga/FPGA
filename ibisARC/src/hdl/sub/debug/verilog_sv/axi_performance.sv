`include "axi_performance.svh"

module axi_performance
#(
    parameter BASEADDR = 0
)
(
    intbus_interf.slave bus
);

// The generator data structure definition
AXI_PERFORMANCE PL; // The registers from logic
AXI_PERFORMANCE PS; // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{1, 0} //tm_reset
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`AXI_PERFORMANCE_ID_CONST),
    .DATATYPE (AXI_PERFORMANCE),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk     (bus.clk),
    .bus     (bus),
    .in      (PL),
    .out     (PS),
    .pulse   (tm_reset),
    .wr      (),
    .rd      ()
);

assign PL.CFG.RESERVED = '0;
assign PL.CFG.RW_SIZE  = RW_SIZE;
assign PL.REG          = PS.REG;

always_ff@(posedge bus.clk)
if(tm_reset) begin
    PL.TIME <= '0;
end else begin
    PL.TIME <= PL.TIME + 1'b1;
end

endmodule