`include "lim_cntr.svh"

module lim_cntr
#(
    parameter BASEADDR  = 0,
    parameter IN_WIDTH  = 0,
    parameter OUT_WIDTH = 0,
    parameter PERIOD_2N = 0
)
(
    input                clk,
    input                resetn,
    input                we,
    input [IN_WIDTH-1:0] in,
    intbus_interf.slave  bus
);

localparam CUT_DIG = IN_WIDTH - OUT_WIDTH;

LIM_CNTR_STRUCT PL;

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 31} // sync_pulse
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`LIM_CNTR_ID_CONST),
    .DATATYPE (LIM_CNTR_STRUCT),
    .OUTFF    ("n"),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk           (clk),
    .bus           (bus),
    .in            (PL),
    .out           (),
    .pulse         (sync),
    .wr            (),
    .rd            ()
);

assign PL.CFG.RESERVED  = '0;
assign PL.CFG.PERIOD_2N = PERIOD_2N;

logic [PERIOD_2N-1:0] cntr;      // счетчик интервала
logic [15:0]          cntr_ovfl; // счетчик превышений

always_ff@(posedge clk or negedge resetn)
if(resetn == '0) begin
    cntr <= '0;
end else begin
    if(we) begin
        cntr <= cntr + 1'b1;
    end
end

always_ff@(posedge clk)
if(sync) begin
    PL.CFG.CNTR <= cntr_ovfl;
end

always_ff@(posedge clk)
if(we) begin
    if(cntr == '1) begin
        cntr_ovfl <= '0;
    end else begin
        if(in[IN_WIDTH-1] == '0) begin //число положительное
            if(in[IN_WIDTH-2:IN_WIDTH-1-CUT_DIG] != '0) begin //число превышает предел
                cntr_ovfl <= cntr_ovfl + 1'b1;
            end
        end else begin //число отрицательное
            if(in[IN_WIDTH-2:IN_WIDTH-1-CUT_DIG] != '1) begin // число превышает предел
                cntr_ovfl <= cntr_ovfl + 1'b1;
            end
        end
    end
end

endmodule