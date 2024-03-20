`include "prestore.svh"
`include "global_param.v"

module prestore
#(
    parameter BASEADDR = 0
)
(
    input  clk,
    input  clr,
    input  adapt_bypass,
    input  ms_epoch,
    input  sig_I,
    input  mag_I,
    input  sig_Q,
    input  mag_Q,
    input  time_pulse_in,
    output time_pulse_out,
    input  we,
    output I_sum_sig,
    output I_sum_mag,
    output Q_sum_sig,
    output Q_sum_mag,
    output valid,
    intbus_interf.slave bus
);

localparam NBUSES = 3;
intbus_interf bus_sl[NBUSES]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{1, 2} // reset_sigmag
};

localparam BASEREGFILE   = BASEADDR + `HUBSIZE;
localparam BASEDDSSINCOS = BASEREGFILE + `PRESTORE_SIZE + `RWREGSSIZE;
regs_file#(
    .BASEADDR (BASEREGFILE),
    .ID       (`PRESTORE_ID_CONST),
    .DATATYPE (PRESTORE_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
) regs_file_prestore_inst(
    .clk    (clk),
    .bus    (bus_sl[0]),
    .in     ('0),
    .out    (),
    .pulse  (reset_sigmag),
    .wr     (),
    .rd     ()
);

logic valid_ed;
logic valid_IQ_mul = '0;
logic valid_IQ     = '0;
logic signed [2:0] data_rf_I;
logic signed [2:0] data_rf_Q;

always_comb
case({mag_I,sig_I})
    2'b00:
        data_rf_I <= $signed(1);
    2'b10:
        data_rf_I <= $signed(3);
    2'b01:
        data_rf_I <= $signed(-1);
    2'b11:
        data_rf_I <= $signed(-3);
endcase

always_comb
case({mag_Q,sig_Q})
    2'b00:
        data_rf_Q <= $signed(1);
    2'b10:
        data_rf_Q <= $signed(3);
    2'b01:
        data_rf_Q <= $signed(-1);
    2'b11:
        data_rf_Q <= $signed(-3);
endcase

logic signed [2:0] sin;
logic signed [2:0] cos;

//синтез опорных sin и cos
localparam BASEDDSBIN = BASEDDSSINCOS + `DDS_SIN_COS_FULL_SIZE;
DDS_sin_cos#(
    .BASEADDR   (BASEDDSSINCOS),
    .BUS_EN     (1),
    .CODE_WIDTH (32)
) DDS_sin_cos_inst(
    .clk       (clk),
    .syn_reset (!we),
    .sin       (sin),
    .cos       (cos),
    .en        (1'b1),//разрешение на работу счетчика фазы
    .code_in   (0),
    .bus       (bus_sl[1])
);

localparam BASEDDSBINEND = BASEDDSBIN + `DDS_BIN_FULL_SIZE;
//синтез периода предварительного накопления
DDS_bin#(
    .BASEADDR (BASEDDSBIN)
) DDS_bin_inst(
    .clk       (clk),
    .syn_reset (!valid_IQ),
    .out       (sum_mux),
    .en        (1'b1),//разрешение на работу счетчика фазы
    .bus       (bus_sl[2])
);
//-----------------------------------------------

logic signed [4:0] I_Cos          = '0;
logic signed [4:0] Q_Sin          = '0;
logic signed [4:0] jQ_Cos         = '0;
logic signed [4:0] jI_Sin         = '0;
logic              time_pulse_mul = '0;
logic signed [5:0] I              = '0;
logic signed [5:0] Q              = '0;
logic              time_pulse_IQ  = '0;

always_ff@(posedge clk) begin
if(we) begin
    I_Cos          <= $signed(data_rf_I)*$signed(cos);
    Q_Sin          <= $signed(data_rf_Q)*$signed(sin);
    jQ_Cos         <= $signed(data_rf_Q)*$signed(cos);
    jI_Sin         <= $signed(data_rf_I)*$signed(sin);
    time_pulse_mul <= time_pulse_in;
    valid_IQ_mul   <= 1'b1;
end else
    valid_IQ_mul   <= '0;
end

always_ff@(posedge clk) begin
if(valid_IQ_mul) begin
    I             <=  I_Cos  + Q_Sin;
    Q             <= jQ_Cos - jI_Sin;
    valid_IQ      <= 1'b1;
    time_pulse_IQ <= time_pulse_mul;
end else
    valid_IQ <= 0;
end

logic signed [N_dig_sum_I_Q-1:0] I_sum_1;
logic signed [N_dig_sum_I_Q-1:0] I_sum_2;
logic signed [N_dig_sum_I_Q-1:0] Q_sum_1;
logic signed [N_dig_sum_I_Q-1:0] Q_sum_2;
logic signed [N_dig_sum_I_Q-1:0] I_sum;
logic signed [N_dig_sum_I_Q-1:0] Q_sum;
logic                            time_pulse_sum;

always_ff@(posedge clk)
if(clr) begin
    I_sum_1        <= '0;
    Q_sum_1        <= '0;
    I_sum_2        <= '0;
    Q_sum_2        <= '0;
end else begin
    if(valid_IQ) begin
        if(sum_mux) begin
            I_sum_1 <= $signed(I_sum_1) + $signed(I);
            Q_sum_1 <= $signed(Q_sum_1) + $signed(Q);
            I_sum_2 <= '0;
            Q_sum_2 <= '0;
        end else begin
            I_sum_2 <= $signed(I_sum_2) + $signed(I);
            Q_sum_2 <= $signed(Q_sum_2) + $signed(Q);
            I_sum_1 <= '0;
            Q_sum_1 <= '0;
        end
        time_pulse_sum <= time_pulse_IQ;
    end else begin
        I_sum_1 <= 0;
        Q_sum_1 <= 0;
        I_sum_2 <= 0;
        Q_sum_2 <= 0;
    end
end

assign I_sum = (sum_mux) ? I_sum_2 : I_sum_1;
assign Q_sum = (sum_mux) ? Q_sum_2 : Q_sum_1;


ed_det valid_ed_inst(
    .clk   (clk),
    .in    (sum_mux),
    .out   (valid_ed)
);

// for debugging
`ifdef SIMULATE
    logic signed [N_dig_sum_I_Q-1:0] I_sum_tmp = '0;
    logic signed [N_dig_sum_I_Q-1:0] Q_sum_tmp = '0;
    logic I_sum_sig_tmp = '0;
    logic Q_sum_sig_tmp = '0;

    always_ff@(posedge clk)
    if(clr) begin
        I_sum_tmp <= 0;
        Q_sum_tmp <= 0;
    end else
        if(valid_ed) begin
            I_sum_tmp <= I_sum;
            Q_sum_tmp <= Q_sum;
        end

    always_ff@(posedge clk)
    if(clr) begin
        I_sum_sig_tmp <= 0;
        Q_sum_sig_tmp <= 0;
    end else
        if(valid) begin
            I_sum_sig_tmp <= I_sum_sig;
            Q_sum_sig_tmp <= Q_sum_sig;
        end
`endif

sig_mag_v3#(
    .WIDTH (N_dig_sum_I_Q),
    .N_CH  (2)
) sig_mag_v3_I(
    .clk        (clk),
    .data_in    ({Q_sum, I_sum}),//signed
    .we         (valid_ed),
    .clr        ('0),
    .sig        ({Q_sum_sig, I_sum_sig}),
    .mag        ({Q_sum_mag, I_sum_mag}),
    .valid      (valid),
    .adpt_ready (),
    .por_out    (),
    .por_in     ('0),
    .por_manual (adapt_bypass)
);

conv_reg#(
    .width  (1),
    .length (2)
) conv_reg_time_inst(
    .clk    (clk),
    .in     (time_pulse_sum),
    .out    (time_pulse_out)
);

endmodule
