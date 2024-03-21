`include "calibration.svh"

module calibration#(
    parameter BASEADDR  = 0
)
(
    intbus_interf.slave bus,
    adc_interf.slave    adc,
    input               sec_pulse_ed
);

CALIBR PL; // The registers from logic
CALIBR PS; // The registers from CPU

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`CALIBR_ID_CONST),
    .DATATYPE (CALIBR)
) CALIBR_REGS (
    .clk    (),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

assign PL.CFG        = '0;
assign PL.PHASE_RATE = '0;

// Reference generator PHASE
wire [32:0] phase_next;
reg  [31:0] PHASE;
reg  [31:0] CAR_CYCLES;
assign phase_next = PHASE + PS.PHASE_RATE;

always_ff@(posedge adc.clk) begin
    if(sec_pulse_ed) begin
        PHASE <= '0;
    end else begin
        PHASE <= phase_next[31:0];
    end
end

always_ff@(posedge adc.clk) begin
    if(sec_pulse_ed) begin
        CAR_CYCLES <= '0;
    end else begin
        if(PS.PHASE_RATE[31]) begin
            if(phase_next[32] == '0) begin
                CAR_CYCLES <= CAR_CYCLES - 1'b1;
            end
        end else begin
            if(phase_next[32]) begin
                CAR_CYCLES <= CAR_CYCLES + 1'b1;
            end
        end
    end
end

always_ff@(posedge adc.clk) begin
    if(sec_pulse_ed) begin
        PL.PHASE <= PHASE;
        PL.CYCLE <= CAR_CYCLES;
    end
end

wire signed [4:0] cos_product;
wire signed [4:0] sin_product;
ch_mul CH_MUL(
    .adc_re (adc.data[PS.CFG.INPUT]),
    .adc_im (adc.data[PS.CFG.INPUT]),
    .phase  (PHASE[31:27]),
    .i_prod (cos_product),
    .q_prod (sin_product)
);

// Accumulators
reg signed [31:0] I;
reg signed [31:0] Q;

always_ff@(posedge adc.clk) begin
    if(sec_pulse_ed) begin
        PL.I <= $signed(I) + $signed(cos_product);
        PL.Q <= $signed(Q) + $signed(sin_product);
        I    <= '0;
        Q    <= '0;
    end else begin
        I <= $signed(I) + $signed(cos_product);
        Q <= $signed(Q) + $signed(sin_product);
    end
end

endmodule
