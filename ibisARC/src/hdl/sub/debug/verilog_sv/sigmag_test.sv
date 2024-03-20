`include "sigmag_test.svh"

module sigmag_test
#(
    parameter BASEADDR = 0
)
(
    adc_interf.slave adc,
    intbus_interf.slave bus
);

// The generator data structure definition
SIGMAG_TEST PL;     // The registers from logic
SIGMAG_TEST PS;     // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 1} // RESETP
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`SIGMAG_TEST_ID_CONST),
    .DATATYPE (SIGMAG_TEST),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (adc.clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (resetp)
);

assign PL.CFG.RESETP      = '0;
assign PL.CFG.HIST_INP    = '0;
assign PL.CFG.LENGTH      = CNTR_LENGTH;
assign PL.CFG.RESERVED    = '0;
assign PL.RESULT.RESERVED = '0;

reg  [CNTR_LENGTH-1:0] cntr;

always_ff@(posedge adc.clk)
if(resetp == 1'b1) begin
    cntr <= '0;
end else begin
    if(cntr != '1) begin
        cntr <= cntr + 1'b1;
    end
end

always_ff@(posedge adc.clk)
if(resetp == '1) begin
    PL.CFG.DONE <= '0;
end else begin
    if(cntr == '1) begin
        PL.CFG.DONE <= '1;
    end
end

always_ff@(posedge adc.clk)
    if(resetp == '1) begin
        PL.RESULT.SIG <= '0;
    end else if(adc.data[PS.CFG.HIST_INP][1]) begin
        if(cntr != '1) begin
            PL.RESULT.SIG <= PL.RESULT.SIG + 1'b1;
        end
    end

always_ff@(posedge adc.clk)
if(resetp == '1) begin
    PL.RESULT.MAG <= '0;
end else if(adc.data[PS.CFG.HIST_INP][0]) begin
    if(cntr != '1) begin
        PL.RESULT.MAG <= PL.RESULT.MAG + 1'b1;
    end
end

endmodule