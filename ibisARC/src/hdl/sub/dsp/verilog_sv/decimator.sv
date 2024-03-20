`include "decimator.svh"

module decimator
#(
    parameter BASEADDR      = 0,
    parameter IN_WIDTH      = 0,
    parameter IN_SIGAMG     = 0,
    parameter OUT_SIGAMG    = 0,
    parameter WIDTH_COEF    = 0,
    parameter ORDER         = 0,
    parameter ACC_SUM_WIDTH = 0,
    parameter PLL           = 0,
    parameter PLL_PERIOD    = 0,
    parameter PLL_M         = 0,
    parameter PLL_D_UP      = 0,
    parameter PLL_D_DOWN    = 0
)
(
    intbus_interf.slave bus,
    adc_interf.slave    in,
    adc_interf.master   out,
    input               clk_up,
    input               clk_down
);

localparam DATA_IN_WIDTH = IN_SIGAMG ? 3          : IN_WIDTH;
localparam FIR_WIDTH     = IN_SIGAMG ? WIDTH_COEF : IN_WIDTH;

logic signed [DATA_IN_WIDTH-1:0] data_in;

localparam NBUSES = 2;
intbus_interf bus_sl[NBUSES]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES),
    .OUTFF      ("n"),
    .MASTERFF   ("n")
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

adc_interf#(
    .PORTS (1),
    .R     (DATA_IN_WIDTH)
)data_up ();
adc_interf#(
    .PORTS (1),
    .R     (FIR_WIDTH)
)data_fir ();
adc_interf#(
    .PORTS (1),
    .R     (FIR_WIDTH)
)data_fir_down ();

generate
    if(PLL == "INTERNAL") begin
        wire mmcm_locked;
        reg  mmcm_reset;
        wire CLKFBOUT_BUF;
        MMCME2_BASE #( // VCO 600...1200
            .BANDWIDTH          ("OPTIMIZED"), // Jitter programming (OPTIMIZED, HIGH, LOW)
            .CLKFBOUT_MULT_F    (PLL_M),       // Multiply value for all CLKOUT (2.000-64.000).
            .CLKFBOUT_PHASE     (0.0),         // Phase offset in degrees of CLKFB (-360.000-360.000).
            .CLKIN1_PERIOD      (PLL_PERIOD),  // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
            .CLKOUT1_DIVIDE     (PLL_D_DOWN),
            .CLKOUT2_DIVIDE     (1),
            .CLKOUT3_DIVIDE     (1),
            .CLKOUT4_DIVIDE     (1),
            .CLKOUT5_DIVIDE     (1),
            .CLKOUT6_DIVIDE     (1),
            .CLKOUT0_DIVIDE_F   (PLL_D_UP),    // Divide amount for CLKOUT0 (1.000-128.000).
            .CLKOUT0_DUTY_CYCLE (0.5),
            .CLKOUT1_DUTY_CYCLE (0.5),
            .CLKOUT2_DUTY_CYCLE (0.5),
            .CLKOUT3_DUTY_CYCLE (0.5),
            .CLKOUT4_DUTY_CYCLE (0.5),
            .CLKOUT5_DUTY_CYCLE (0.5),
            .CLKOUT6_DUTY_CYCLE (0.5),
            .CLKOUT0_PHASE      (0.0),
            .CLKOUT1_PHASE      (0.0),
            .CLKOUT2_PHASE      (0.0),
            .CLKOUT3_PHASE      (0.0),
            .CLKOUT4_PHASE      (0.0),
            .CLKOUT5_PHASE      (0.0),
            .CLKOUT6_PHASE      (0.0),
            .CLKOUT4_CASCADE    ("FALSE"),     // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
            .DIVCLK_DIVIDE      (1),           // Master division value (1-106)
            .REF_JITTER1        (0.0),         // Reference input jitter in UI (0.000-0.999).
            .STARTUP_WAIT       ("FALSE")      // Delays DONE until MMCM is locked (FALSE, TRUE)
        ) MMCME2_BASE_inst(
            .CLKOUT0   (PLL_OUT_UP),           // 1-bit output: CLKOUT0
            .CLKOUT0B  (),                     // 1-bit output: Inverted CLKOUT0
            .CLKOUT1   (PLL_OUT_DOWN),         // 1-bit output: CLKOUT1
            .CLKOUT1B  (),                     // 1-bit output: Inverted CLKOUT1
            .CLKOUT2   (),                     // 1-bit output: CLKOUT2
            .CLKOUT2B  (),                     // 1-bit output: Inverted CLKOUT2
            .CLKOUT3   (),                     // 1-bit output: CLKOUT3
            .CLKOUT3B  (),                     // 1-bit output: Inverted CLKOUT3
            .CLKOUT4   (),                     // 1-bit output: CLKOUT4
            .CLKOUT5   (),                     // 1-bit output: CLKOUT5
            .CLKOUT6   (),                     // 1-bit output: CLKOUT6
            .CLKFBOUT  (CLKFBOUT),             // 1-bit output: Feedback clock
            .CLKFBOUTB (),                     // 1-bit output: Inverted CLKFBOUT
            .LOCKED    (mmcm_locked),          // 1-bit output: LOCK
            .CLKIN1    (in.clk),               // 1-bit input: Clock
            .PWRDWN    ('0),                   // 1-bit input: Power-down
            .RST       (mmcm_reset),           // 1-bit input: Reset
            .CLKFBIN   (CLKFBOUT_BUF)          // 1-bit input: Feedback clock
        );
        
        BUFG BUFG_PLL_FB_inst (
            .O (CLKFBOUT_BUF),
            .I (CLKFBOUT)
        );
        
        BUFG BUFG_PLL_UP_inst (
            .O (PLL_OUT_UP_BUF),
            .I (PLL_OUT_UP)
        );
        
        BUFG BUFG_PLL_DOWN_inst (
            .O (PLL_OUT_DOWN_BUF),
            .I (PLL_OUT_DOWN)
        );
        
        // Городим схему ресета для MMCM
        reg [20:0] lock_counter = 0;  // считает 100 мс (при клоках 20 МГц) пока устаканится DCM
        always_ff@(posedge in.clk)
        begin
            lock_counter <= lock_counter + 1'b1;
        end
        
        reg [2:0] mmcm_reset_count = 0; // нужен чтобы держать reset несколько тактов как положено по даташиту
        always_ff@(posedge in.clk)
        if (lock_counter[20:0] == {21{1'b1}})
            mmcm_reset_count <= 0;
        else
            mmcm_reset_count <= mmcm_reset_count + 1'b1;
        
        always_ff@(posedge in.clk)
        if (lock_counter[20:0] == {21{1'b1}})
            if (!mmcm_locked)
                mmcm_reset <= 1'b1;
            else
                mmcm_reset <= 1'b0;
        else
            if (mmcm_reset_count[2:0] == {3{1'b1}})
                mmcm_reset <= 1'b0;
        
        assign data_up.clk       = PLL_OUT_UP_BUF;
        assign data_fir_down.clk = PLL_OUT_DOWN_BUF;
    end else begin
        assign data_up.clk       = clk_up;
        assign data_fir_down.clk = clk_down;
    end
endgenerate

DECIMATOR_STRUCT PS;

localparam BASEREG = BASEADDR + `HUBSIZE;
regs_file#(
    .BASEADDR (BASEREG),
    .ID       (`DECIMATOR_ID_CONST),
    .DATATYPE (DECIMATOR_STRUCT)
)RF (
    .clk    (),
    .bus    (bus_sl[0]),
    .in     ('0),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

if(IN_SIGAMG) begin
    always_ff@(posedge in.clk)
    case({in.data[0][1],in.data[0][0]}) // {sig,mag}
        2'b00: data_in <= $signed(1);
        2'b01: data_in <= $signed(3);
        2'b10: data_in <= $signed(-1);
        2'b11: data_in <= $signed(-3);
    endcase
end else begin
    always_ff@(posedge in.clk)
        data_in <= in.data[0];
end

level_sync#(
    .WIDTH   (DATA_IN_WIDTH)
) level_sync_data_in_data(
    .clk     (data_up.clk),
    .async   (data_in),
    .sync    (data_up.data[0])
);
level_sync level_sync_data_in_valid(
    .clk     (data_up.clk),
    .async   (in.valid),
    .sync    (data_up.valid)
);

localparam FIR_BASE_ADDR = BASEREG + `RWREGSSIZE + `DECIMATOR_SIZE;
fir#(
    .BASEADDR      (FIR_BASE_ADDR),
    .WIDTH_IN_DATA (DATA_IN_WIDTH),
    .WIDTH_COEF    (WIDTH_COEF),
    .ORDER         (ORDER),
    .NCH           (1),
    .ACC_SUM_WIDTH (ACC_SUM_WIDTH)
)FIR (
    .bus       (bus_sl[1]),
    .in        (data_up),
    .out       (data_fir),
    .coef_mirr ('0)
);

level_sync#(
    .WIDTH   (FIR_WIDTH)
) level_sync_data_fir_down(
    .clk     (data_fir_down.clk),
    .async   (data_fir.data[0]),
    .sync    (data_fir_down.data[0])
);
level_sync level_sync_data_fir_down_valid(
    .clk     (data_fir_down.clk),
    .async   (data_fir.valid),
    .sync    (data_fir_down.valid)
);

if(OUT_SIGAMG) begin
    sig_mag_v3#(
        .WIDTH (FIR_WIDTH)
    ) sig_mag_v3(
        .clk        (data_fir_down.clk),
        .data_in    (data_fir_down.data[0]),
        .we         (data_fir_down.valid),
        .clr        ('0),
        .sig        (sig),
        .mag        (mag),
        .valid      (out.valid),
        .por_out    (),
        .por_in     ('0),
        .por_manual ('0)
    );
    assign out.data[0][1] = PS.BYPASS ? in.data[0][1] : sig;
    assign out.data[0][0] = PS.BYPASS ? in.data[0][0] : mag;
end else begin
    assign out.valid  = data_fir_down.valid;
    assign out.data   = data_fir_down.data;
end
assign out.clk    = data_fir_down.clk;

endmodule
