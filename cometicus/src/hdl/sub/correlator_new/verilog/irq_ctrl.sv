`include "irq_ctrl.svh"

module irq_ctrl
#(
    parameter BASEADDR = 0
)
(
    intbus_interf.slave bus, // CPU bus
    input clk,               // RF clk
    output reg irq           // irq pulse
);

// The generator data structure definition
IRQ_CTRL PS; // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 3} // release_pulse
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`IRQ_ID_CONST),
    .DATATYPE (IRQ_CTRL),
    .OUTFF    ("n"),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk     (clk),
    .bus     (bus),
    .in      ('0),
    .out     (PS),
    .pulse   (release_pulse),
    .wr     (),
    .rd     ()
);

logic [PERIODSIZE-1:0] CNT = '0; // Generator counter

always_ff@(posedge clk) begin
    if(CNT == (PS.PERIOD - 1)) begin // Generator counter logic
        CNT <= '0;
    end else begin
        CNT <= CNT + 1;
    end
end

always_ff@(posedge clk) begin
    if(PS.CFG.enable) begin //irq_out generation
        if(PS.CFG.sensitive) begin
            if(CNT == '0) begin
                irq <= PS.CFG.polarity ? 1'b0 : 1'b1;
            end else if(release_pulse) begin
                irq <= PS.CFG.polarity ? 1'b1 : 1'b0;
            end
        end else begin
            if(CNT < PS.DURATION) begin
                irq <= PS.CFG.polarity ? 1'b0 : 1'b1;
            end else begin
                irq <= PS.CFG.polarity ? 1'b1 : 1'b0;
            end
        end
    end else begin
        irq <= PS.CFG.polarity ? 1'b1 : 1'b0; // disable irq
    end
end

endmodule
