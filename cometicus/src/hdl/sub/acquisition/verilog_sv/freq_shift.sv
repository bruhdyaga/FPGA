interface freq_shift_interface();

logic [31:0] code;
logic code_up;
logic valid;


modport master
(
    input  code,
    input  code_up,
    output valid
);

modport slave
(
    output code,
    output code_up,
    input  valid
);

endinterface

module freq_shift
(
    input                       clk,
    input                       resetn,
    input                       I_sig,
    input                       I_mag,
    input                       Q_sig,
    input                       Q_mag,
    input                       we,
    output logic signed [2:0]   I_out = '0,
    output logic signed [2:0]   Q_out = '0,
    freq_shift_interface.master freq_shift_interface
);

logic signed [2:0] sin;
logic signed [2:0] cos;
intbus_interf bus();// не используется
assign bus.clk    = '0;
// assign bus.addr   = '0;
// assign bus.wdata  = '0;
// assign bus.wr     = '0;
// assign bus.rd     = '0;

//синтезатор доплеровского смещения частоты
DDS_sin_cos
#(
    .BUS_EN     (0),
    .CODE_WIDTH (32)
)
DDS_sin_cos_inst(
    .clk       (clk),
    .syn_reset (1'b0),
    .sin       (sin),
    .cos       (cos),
    .en        (we),//разрешение на работу счетчика фазы
    .code_in   (freq_shift_interface.code),
    .bus       (bus)
);

always_ff@(posedge clk or negedge resetn)
if(resetn == '0) begin
    freq_shift_interface.valid <= '0;
end else begin
    freq_shift_interface.valid <= we;
end

logic signed [4:0] prod_I_I;
logic signed [4:0] prod_I_Q;
logic signed [4:0] prod_Q_I;
logic signed [4:0] prod_Q_Q;
logic signed [5:0] I_out_full;
logic signed [5:0] Q_out_full;
logic signed [2:0] inp_I;
logic signed [2:0] inp_Q;

always_comb
case({I_mag,I_sig})
    2'b00:
        inp_I <= $signed(1);
    2'b10:
        inp_I <= $signed(3);
    2'b01:
        inp_I <= $signed(-1);
    2'b11:
        inp_I <= $signed(-3);
endcase

always_comb
case({Q_mag,Q_sig})
    2'b00:
        inp_Q <= $signed(1);
    2'b10:
        inp_Q <= $signed(3);
    2'b01:
        inp_Q <= $signed(-1);
    2'b11:
        inp_Q <= $signed(-3);
endcase

assign prod_I_I = $signed(inp_I)*$signed(cos);
assign prod_I_Q = $signed(inp_I)*$signed(sin);
assign prod_Q_I = $signed(inp_Q)*$signed(cos);
assign prod_Q_Q = $signed(inp_Q)*$signed(sin);

always_comb
case(freq_shift_interface.code_up)
    1'b0: begin// doppler < 0
        I_out_full <= $signed(prod_I_I) - $signed(prod_Q_Q);
        Q_out_full <= $signed(prod_Q_I) + $signed(prod_I_Q);
    end
    1'b1: begin// doppler > 0
        I_out_full <= $signed(prod_I_I) + $signed(prod_Q_Q);
        Q_out_full <= $signed(prod_Q_I) - $signed(prod_I_Q);
    end
endcase

logic [5:0] I_out_full_unsigned;
logic [5:0] Q_out_full_unsigned;
assign I_out_full_unsigned = (I_out_full > 0) ? I_out_full : -$signed(I_out_full);
assign Q_out_full_unsigned = (Q_out_full > 0) ? Q_out_full : -$signed(Q_out_full);

logic [5:0] I_out_full_unsigned_compressed;
logic [5:0] Q_out_full_unsigned_compressed;
assign I_out_full_unsigned_compressed = (I_out_full_unsigned <= 6'd9) ? (I_out_full_unsigned + 3) : 6'd12;
assign Q_out_full_unsigned_compressed = (Q_out_full_unsigned <= 6'd9) ? (Q_out_full_unsigned + 3) : 6'd12;

logic signed [5:0] I_out_full_signed_compressed;
logic signed [5:0] Q_out_full_signed_compressed;
assign I_out_full_signed_compressed = (I_out_full > 0) ? I_out_full_unsigned_compressed : -$signed(I_out_full_unsigned_compressed);
assign Q_out_full_signed_compressed = (Q_out_full > 0) ? Q_out_full_unsigned_compressed : -$signed(Q_out_full_unsigned_compressed);

always_ff@(posedge clk or negedge resetn)
if(resetn == '0) begin
    I_out <= '0;
    Q_out <= '0;
end else begin
    I_out <= I_out_full_signed_compressed >> 2;
    Q_out <= Q_out_full_signed_compressed >> 2;
end

endmodule
