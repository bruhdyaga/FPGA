
`include "ref_in_interpretator.svh"

module ref_in_interpretator 
    #(
        parameter BASEADDR  = 0,
        parameter NUM_ACCUM = 0     // from board_param
    )
    (
        intbus_interf.slave bus,    // CPU bus (axi clk)
        adc_interf.slave adc,       // ADC bus (pclk)
        input sec_pulse_ed,
        input intr_pulse,
        output debug,
        output reg out
    );

    wire clk;
    wire pclk;
    
    assign clk      = bus.clk;
    assign pclk     = adc.clk;

// The generator data structure definition
    REFINTERP PL;    // The registers from logic
    REFINTERP PS;    // The registers from CPU

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`REFINTERP_ID_CONST),
    .DATATYPE (REFINTERP)
) RFI_REGS (
    .clk    (clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

    assign PL.CFG.MODE      = PS.CFG.MODE;
    assign PL.CFG.RESERVED1 = '0;
    assign PL.CFG.SEL_IM    = PS.CFG.SEL_IM;
    assign PL.CFG.SEL_RE    = PS.CFG.SEL_RE;
    assign PL.CFG.RESERVED2 = '0;
    assign PL.MEAS.RESERVED = '0;


    wire [2*NUM_ACCUM - 1 : 0] sample_int_re;
    wire [2*NUM_ACCUM - 1 : 0] sample_int_im;
    
    wire input_sign;
    wire sin_sign_ed;
    wire cos_sign_ed;
    
    wire sign_ed;
    wire sec_sync;

    wire enable;

    reg  sec_hold_reg;              // Срабатывает по приходу sec_pulse_ed, сбрасывается по sin(cos)_sign_ed
    
    reg [23:0] GARM_COUNTER;        // Счетчик периодов гармоники 
    reg [15:0] LAG;                 // Счетчик клоков от входного импульса до выходного
    reg [ 5:0] MEAS_COUNTER;        // Счетчик на 64 секунды.
    
    reg [ 4:0] in_cos;

    assign enable       = PS.CFG.MODE[1];
    assign input_sign   = in_cos[3];
    assign debug        = in_cos[3];
    
    
    always_comb begin
        case (adc.data[PS.CFG.SEL_RE])
            2'b00: in_cos  = 5'b00001;      //  1
            2'b01: in_cos  = 5'b00010;      //  2
            2'b10: in_cos  = 5'b11111;      // -1
            2'b11: in_cos  = 5'b11110;      // -2
            default: in_cos = '0;
        endcase
    end
    
    
    ed_det#(
        .TYPE("fal")
        )
        REF_EDT_SIGN_SIN(
            .clk   (pclk),
            .in    (input_sign),
            .out   (sin_sign_ed)        //одноклоковый сигнал -\_ перепада
        );

    ed_det#(
            .TYPE("ris")
        )
        REF_EDT_SIGN_COS(
            .clk   (pclk),
            .in    (input_sign),
            .out   (cos_sign_ed)        //одноклоковый сигнал _/- перепада
        );

    assign sign_ed = PS.CFG.MODE[0] ? cos_sign_ed : sin_sign_ed;    // 0 - sin, 1 - cos;

    always_ff@(posedge pclk) begin
        if (sec_pulse_ed)
            sec_hold_reg <= 1;
        else
            if (sign_ed)
                sec_hold_reg <= 0;
        end

    assign sec_sync = sec_hold_reg & sign_ed;
    
    // Счетчик периодов GARM_COUNTER
    always_ff@(posedge pclk) begin
        if (enable) 
            begin
                if (sec_sync)
                    GARM_COUNTER <= 24'd0;
                else
                if (sec_pulse_ed) 
                    PL.MEAS.GARM_fix <= GARM_COUNTER;
                else
                if (sign_ed)
                    GARM_COUNTER <= GARM_COUNTER + 1'b1;
            end
        end
    
    // Счетчик клоков LAG
    always_ff@(posedge pclk) begin
        if (enable) begin
            if (sec_pulse_ed) begin
                PL.CFG.LAG_fix <= LAG;
                LAG <= 16'd0;
                end
            else
            if (sec_hold_reg)
                LAG <= LAG + 1'b1;
        end
    end
    
    // Счетчик секунд MEAS_COUNTER
    always_ff@(posedge pclk) begin
        if (enable) begin
            if (sec_pulse_ed) begin
                PL.MEAS.MEAS_fix <= MEAS_COUNTER;
                MEAS_COUNTER <= MEAS_COUNTER + 1'b1;
            end
        end
    end
    
    always_comb begin
        case (PS.CFG.MODE)
            2'b00: out = sec_pulse_ed;  // bypass
            2'b01: out = sec_pulse_ed;  // sec_ed_pulse
            2'b10: out = sec_sync;      // sin_sync
            2'b11: out = sec_sync;      // cos_sync
        endcase
    end
    
endmodule