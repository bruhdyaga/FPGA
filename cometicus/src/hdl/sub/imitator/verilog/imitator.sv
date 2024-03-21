`include "lim_cntr.svh"
`include "imitator.svh"
`include "global_param.v"

module imitator#(
    parameter BASEADDR = 0
)
(
    input                clk,
    input                fix_pulse,
    input                irq_pulse,
    intbus_interf.slave  bus,
    imi_interf.master    imi
);

`define _MAX(a,b) ((a)>(b)?(a):(b))

localparam MSUM_WIDTH = IMI_CHNL_OUT_WIDTH + $clog2(`IMI_CHANNELS);   // Разрядность суммы полезных сигналов всех каналов
localparam AWGN_RAW_WIDTH = 10;     // Разрядность на выходе randn, соответствующая +-3 сигма
localparam AWGN_SHIFT = AMULT_WIDTH - 1; // Масштабирование АБГШ под разрядность полезных сигналов
localparam AWGN_WIDTH = AWGN_RAW_WIDTH + AWGN_SHIFT;    // Разрядность АБГШ после масштабирования
localparam NOISED_FULL_WIDTH = `_MAX(AWGN_WIDTH, MSUM_WIDTH) + 1; // Полная разрядность суммы сигналов и шума

localparam NBUSES = `IMI_CHANNELS + 3;

intbus_interf  bus_sl[NBUSES]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

// The generator data structure definition
IMI_STRUCT PL;
IMI_STRUCT PS;     // The registers from CPU

localparam BASEREGFILE = BASEADDR + `HUBSIZE;
regs_file#(
    .BASEADDR (BASEREGFILE),
    .ID       (`IMI_ID_CONST),
    .DATATYPE (IMI_STRUCT)
)RF (
    .clk    (clk),
    .bus    (bus_sl[0]),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

assign PL.CFG.RESERVED    = '0;
assign PL.CFG.OUT_SHIFT   = '0;
assign PL.CFG.ADIV_WIDTH  = ADIV_WIDTH;
assign PL.CFG.AMULT_WIDTH = AMULT_WIDTH;

level_sync#(
    .WIDTH      (1),
    .INIT_STATE ('1)
) SET_INST    (
    .clk   (clk),
    .async ('0),
    .sync  (set)
);

// Шумы до масштабирования
wire signed [AWGN_RAW_WIDTH-1:0] awgnIraw;
wire signed [AWGN_RAW_WIDTH-1:0] awgnQraw;
// Additive white gaussian noise, STD = 147.8
randn#(
    .number(0)
) AWGN_I(
    .clk     (clk),
    .set     (set),
    .out     (awgnIraw)
);

randn#(
    .number(1)
) AWGN_Q(
    .clk     (clk),
    .set     (set),
    .out     (awgnQraw)
);

wire signed [IMI_CHNL_OUT_WIDTH-1:0] Ich [`IMI_CHANNELS-1:0];
wire signed [IMI_CHNL_OUT_WIDTH-1:0] Qch [`IMI_CHANNELS-1:0];
for(genvar i = 0; i < `IMI_CHANNELS; i ++) begin: CH
    imitator_channel#(
        .BASEADDR  (BASEREGFILE + `RWREGSSIZE + `IMI_SIZE + i*`IMI_CHANNEL_FULL_SIZE),
        .OUT_WIDTH (IMI_CHNL_OUT_WIDTH),
        .PRN_GEN   (1),
        .PRN_RAM   (1)
    ) IMI_CH(
        .bus           (bus_sl[i + 1]),
        .clk           (clk),
        .fix_pulse     (fix_pulse),
        .irq_pulse     (irq_pulse),
        .I             (Ich[i]),
        .Q             (Qch[i])
    );
end

// Сумма полезных сигналов и соответствующие флаги от сумматора
wire signed [MSUM_WIDTH-1:0] mI;
wire signed [MSUM_WIDTH-1:0] mQ;
piped_adder#(
    .N_args    (`IMI_CHANNELS),     // Number of arguments for adding
    .arg_width (IMI_CHNL_OUT_WIDTH) // Bits per each argument
) CHNLSUM_I(
    .clk     (clk),
    .args_in ({>>{Ich}}),
    .sum_out (mI),
    .we      ('0), // for valid use
    .valid   ()
);

piped_adder#(
    .N_args    (`IMI_CHANNELS),     // Number of arguments for adding
    .arg_width (IMI_CHNL_OUT_WIDTH) // Bits per each argument
) CHNLSUM_Q(
    .clk     (clk),
    .args_in ({>>{Qch}}),
    .sum_out (mQ),
    .we      ('0), // for valid use
    .valid   ()
);

reg signed [AWGN_WIDTH-1:0] awgnI;
reg signed [AWGN_WIDTH-1:0] awgnQ;
// Noise scaling
always_ff@(posedge clk) begin
    awgnI <= $signed(awgnIraw <<< AWGN_SHIFT);
    awgnQ <= $signed(awgnQraw <<< AWGN_SHIFT);
end

// Смесь сигналов и шума до масштабирования под требуемую выходную разрядность
reg signed [NOISED_FULL_WIDTH-1:0] Inoised_full;
reg signed [NOISED_FULL_WIDTH-1:0] Qnoised_full;
// Signals + Noise
always_ff@(posedge clk) begin
    Inoised_full <= $signed(mI) + $signed(awgnI);
    Qnoised_full <= $signed(mQ) + $signed(awgnQ);
end

// Module output signals
reg signed [MSUM_WIDTH-1:0] mI_shift;
reg signed [MSUM_WIDTH-1:0] mQ_shift;
always_ff@(posedge clk) begin // сделано округление по модулю вниз
        mI_shift <= $signed(mI >>> PS.CFG.OUT_SHIFT) + ((mI[MSUM_WIDTH-1] & |(mI & (2**PS.CFG.OUT_SHIFT - 1))) ? 1 : 0);
        mQ_shift <= $signed(mQ >>> PS.CFG.OUT_SHIFT) + ((mQ[MSUM_WIDTH-1] & |(mQ & (2**PS.CFG.OUT_SHIFT - 1))) ? 1 : 0);
end

localparam BASE_LIMCNTR = BASEREGFILE + `RWREGSSIZE + `IMI_SIZE + `IMI_CHANNELS*`IMI_CHANNEL_FULL_SIZE;
lim_cntr#(
    .BASEADDR  (BASE_LIMCNTR),
    .IN_WIDTH  (MSUM_WIDTH),
    .OUT_WIDTH (`IMI_OUTWIDTH),
    .PERIOD_2N (15)
) lim_cntr_inst(
    .clk    (clk),
    .resetn ('1),
    .we     ('1),
    .in     (mI_shift),
    .bus    (bus_sl[`IMI_CHANNELS + 1])
);

logic signed [`IMI_OUTWIDTH-1:0] I_lim;
logic signed [`IMI_OUTWIDTH-1:0] Q_lim;
// limit mI, mQ
lim_qnt#(
    .in_width  (MSUM_WIDTH),
    .out_width (`IMI_OUTWIDTH)
)LIM_QNT_I (
    .clk   (clk),
    .WE    ('1),
    .valid (valid_lim),
    .in    (mI_shift),
    .out   (I_lim)
);
lim_qnt#(
    .in_width  (MSUM_WIDTH),
    .out_width (`IMI_OUTWIDTH)
)LIM_QNT_Q (
    .clk   (clk),
    .WE    ('1),
    .valid (),
    .in    (mQ_shift),
    .out   (Q_lim)
);

localparam BASE_NORMALIZER = BASE_LIMCNTR + `LIM_CNTR_FULL_SIZE;
normalizer#(
    .BASEADDR (BASE_NORMALIZER),
    .WIDTH    (`IMI_OUTWIDTH),
    .TWIDTH   (`NORMALIZER_T_W)
) normalizer_ins(
    .bus   (bus_sl[`IMI_CHANNELS + 2]),
    .clk   (clk),
    .i_in  (I_lim),
    .q_in  (Q_lim),
    .i_out (imi.I),
    .q_out (imi.Q),
    .we    (valid_lim),
    .valid ()
);

assign imi.In = ($signed(Inoised_full) > 0) ? $signed(1) : $signed(-1);
assign imi.Qn = ($signed(Qnoised_full) > 0) ? $signed(1) : $signed(-1);

`undef _MAX

endmodule
