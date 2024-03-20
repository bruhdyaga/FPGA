`include "vitdec.svh"

module vitdec#(
    parameter BASEADDR = 0
)
(
    intbus_interf.slave bus,
    input clk
);

`define _MIN(a,b) ((a)>(b)?(b):(a))

localparam k = 7; // кодовое ограничение
localparam Nvert = 2**(k-1); // количество вершин решетки декодера
localparam G1 = 9'O133;
localparam G2 = 9'O171;
localparam G1_r = reverse_bit(G1,k); // маски, развернутые младшим битом справа
localparam G2_r = reverse_bit(G2,k); // маски, развернутые младшим битом справа
localparam H_SIZE = 8; // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// The generator data structure definition
VITDEC_STRUCT PL;     // The registers from logic
VITDEC_STRUCT PS;     // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 0}  // start
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`VITDEC_ID_CONST),
    .DATATYPE (VITDEC_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (start),
    .wr     (),
    .rd     ()
);

assign PL.CFG.RESERVED = '0;
assign PL.CFG.BIT2_USE = '0;
assign PL.CFG.MODE     = '0;
assign PL.CFG.DAT_BUF  = VIT_BUF_SIZE - 1;
assign PL.CFG.DAT_REGS = '0;
assign PL.CFG.START    = '0;
assign PL.ENC_DATA     = '0;

enum logic [3:0] {
    FSM_RESET        = 4'd0,
    FSM_READY        = 4'd1,
    FSM_VIRT         = 4'd2,
    FSM_H_MIRR       = 4'd3,
    FSM_NXT_DAT_ENC  = 4'd4,
    FSM_H_L_MIN      = 4'd5,
    FSM_H_END_MIN    = 4'd6,
    FSM_RST_WRD_CNTR = 4'd7,
    FSM_RD_WAY       = 4'd8,
    FSM_DATA_DEC     = 4'd9,
    FSM_NXT_DAT_DEC  = 4'd10,
    FSM_DONE         = 4'd11
} fsm_state;

assign FSM_STATE_RESET        = fsm_state == FSM_RESET;
assign FSM_STATE_READY        = fsm_state == FSM_READY;
assign FSM_STATE_VIRT         = fsm_state == FSM_VIRT;
assign FSM_STATE_H_MIRR       = fsm_state == FSM_H_MIRR;
assign FSM_STATE_NXT_DAT_ENC  = fsm_state == FSM_NXT_DAT_ENC;
assign FSM_STATE_H_L_MIN      = fsm_state == FSM_H_L_MIN;
assign FSM_STATE_H_END_MIN    = fsm_state == FSM_H_END_MIN;
assign FSM_STATE_RST_WRD_CNTR = fsm_state == FSM_RST_WRD_CNTR;
assign FSM_STATE_FSM_RD_WAY   = fsm_state == FSM_RD_WAY;
assign FSM_STATE_DATA_DEC     = fsm_state == FSM_DATA_DEC;
assign FSM_STATE_NXT_DAT_DEC  = fsm_state == FSM_NXT_DAT_DEC;
assign FSM_STATE_DONE         = fsm_state == FSM_DONE;

wire [k-2:0] nstate; // будущее состояние регистра
reg  [k-2:0] state;  // состояние сдвигового регистра без старшего бита
reg  inp_bit;        // входной бит на кодер

always_ff@(posedge clk)
if(FSM_STATE_READY) begin
    inp_bit <= '0;
end else begin
    if(FSM_STATE_VIRT) begin
        inp_bit <= inp_bit + 1'b1;
    end
end

assign inp_bit_last = inp_bit == '1;

always_ff@(posedge clk)
if(FSM_STATE_READY) begin
    state <= '0;
end else begin
    if((FSM_STATE_VIRT & inp_bit_last) | FSM_STATE_H_END_MIN) begin
        state <= state + 1'b1;
    end
end

assign state_last     = state == '1;
assign state_bit_last = state_last & inp_bit_last;
assign state_first    = state == '0;
assign state_hi_half  = state[$high(state)] == 1'b1; // вторая половина вершин

assign nstate = {state[k-3:0],inp_bit};
assign b1 = ^({state,inp_bit} & G1_r[k-1:0]);
assign b2 = ^({state,inp_bit} & G2_r[k-1:0]);

// перебор входных бит
localparam ENC_WORD_SIZE = $clog2(VIT_BUF_SIZE);    // для перебора регистров с данными
localparam ENC_PAIR_SIZE = $clog2(`AXI_GP_WIDTH)-1; // для перебора пар бит в регистрах
reg [ENC_WORD_SIZE-1:0] enc_word;
reg [ENC_PAIR_SIZE-1:0] enc_pair;

always_ff@(posedge clk)
if(FSM_STATE_READY) begin
    enc_word <= '0;
end else begin
    if(FSM_STATE_NXT_DAT_ENC) begin
        enc_word <= enc_word + 1'b1;
    end else begin
        if(FSM_STATE_RST_WRD_CNTR) begin
            enc_word <= PS.CFG.DAT_REGS;
        end else begin
            if(FSM_STATE_NXT_DAT_DEC) begin
                enc_word <= enc_word - 1'b1;
            end
        end
    end
end

assign enc_word_last  = enc_word == PS.CFG.DAT_REGS;
assign enc_word_first = enc_word == '0;

always_ff@(posedge clk)
if(FSM_STATE_READY) begin
    enc_pair <= '0; // инициализация перед рассчетом метрик
end else begin
    if(FSM_STATE_H_MIRR) begin
        enc_pair <= enc_pair + 1'b1;
    end else begin
        if(FSM_STATE_RST_WRD_CNTR) begin
            enc_pair <= PS.CFG.BIT2_USE; // инициализация перед восстановлением данных
        end else begin
            if(FSM_STATE_NXT_DAT_DEC) begin
                enc_pair <= '1; // инициализация перед восстановлением данных
            end else begin
                if(FSM_STATE_DATA_DEC) begin
                    enc_pair <= enc_pair - 1'b1;
                end
            end
        end
    end
end

assign enc_pair_last  = enc_word_last ? (enc_pair == PS.CFG.BIT2_USE) : (enc_pair == '1);
assign enc_pair_first = enc_pair == '0;
assign level_first = FSM_STATE_VIRT & enc_word_first & enc_pair_first; // первый уровень декодирования

// расчет двух метрик данного перехода для входных бит 0 и 1
wire [1:0] Ri;      // пара входных кодированных бит
wire [1:0] Ri_mode; // пара входных кодированных бит в порядке (171,133) или (133,171)
assign Ri = FSM_STATE_VIRT ? PS.ENC_DATA[enc_word][enc_pair] : '0;
assign Ri_mode = (PS.CFG.MODE == 2'd1) ? {Ri[0],Ri[1]} : Ri; // если GLN - разворачиваем биты

wire [1:0] H_bb; // текущая метрика
assign H_bb = (^{b2,Ri_mode[0]}) + (^{((PS.CFG.MODE == 2'd2) ^ b1),Ri_mode[1]});

reg [H_SIZE-1:0] H   [Nvert-1:0][1:0];
reg [H_SIZE-1:0] H_L [Nvert-1:0][1:0];
reg [H_SIZE-1:0] H_bb_min;
// выбор меньшей метрики с предыдущего уровня
always_comb
if(level_first) begin // 1-й уровень пропускаем
    H_bb_min <= '0;
end else begin
    if(H_L[state][1] > H_L[state][0]) begin // выбираем обратный путь обратно ВВЕРХ
        H_bb_min <= H_L[state][0]; // меньшая из пар метрик
    end else begin// выбираем обратный путь обратно ВНИЗ
        H_bb_min <= H_L[state][1]; // меньшая из пар метрик
    end
end

// расчет
wire [H_SIZE:0]   H_nstate_hd; // не ограниченные компрессором
wire [H_SIZE-1:0] H_nstate;    // защищены от переполнения
assign H_nstate_hd = H_bb_min + H_bb;
assign H_nstate    = (H_nstate_hd) > 2**H_SIZE-1 ? 2*H_SIZE-1 : H_nstate_hd;

always_ff@(posedge clk)
if(FSM_STATE_VIRT) begin
    if(state_hi_half == '0) begin
        H[nstate][0] <= H_nstate;
    end else begin
        H[nstate][1] <= H_nstate;
    end
end

always_ff@(posedge clk)
if(FSM_STATE_H_MIRR) begin
    H_L <= H;
end

//----
reg [k-2:0] state_dec; // состояние декодера при возврате по way
localparam PAIR_SIZE = 2**ENC_PAIR_SIZE;
localparam RAM_SIZE  = Nvert*VIT_BUF_SIZE*PAIR_SIZE;
localparam ADDR_SIZE = $clog2(RAM_SIZE);

reg  way [RAM_SIZE-1:0];
wire [ADDR_SIZE-1:0] way_addr_wr;
reg  [ADDR_SIZE-1:0] way_addr_wr_d; // задержанный на клок;
wire [ADDR_SIZE-1:0] way_addr_rd;
reg  state_hi_half_d;
reg  way_wr_d;

// assign way_addr_wr = {state,enc_word,enc_pair};
assign way_addr_wr = {enc_word,enc_pair,nstate};
assign way_addr_rd = {enc_word,enc_pair,state_dec};

logic way_data;

assign way_wr = (!level_first) & (FSM_STATE_VIRT) & state_hi_half;
always_ff@(posedge clk) begin
    state_hi_half_d <= state_hi_half;
    way_wr_d        <= way_wr;
end

always_ff@(posedge clk)
if(way_wr) begin
    way_addr_wr_d <= way_addr_wr;
end

// always_ff@(posedge clk)
// if(way_wr_d) begin
    // way[way_addr_wr_d] <= H[nstate-1'b1][0] >= H[nstate-1'b1][1];
// end
// else begin
    // way_data <= way[way_addr_rd];
// end

ram_block_sp#(
    .WIDTH (1),
    .DEPTH (RAM_SIZE)
) RAM(
    .clk     (clk),
    .we      (way_wr_d),
    .dat_in  (H[nstate-1'b1][0] >= H[nstate-1'b1][1]),
    .dat_out (way_data),
    .addr    (way_wr_d ? way_addr_wr_d : way_addr_rd)
);
//----

//****
reg [H_SIZE-1:0] H_min;
reg [H_SIZE-1:0] Hmin_end;
reg [k-2:0]      Hmin_num;

always_ff@(posedge clk)
if(FSM_STATE_H_L_MIN | FSM_STATE_H_END_MIN) begin
    H_min <= `_MIN(H_L[state][0],H_L[state][1]);
end else begin
    H_min <= '0;
end

always_ff@(posedge clk)
if(FSM_STATE_H_END_MIN) begin
    if(state_first) begin
        Hmin_end <= H_min;
        Hmin_num <= state;
    end else begin
        if(H_min < Hmin_end) begin
            Hmin_end <= H_min;
            Hmin_num <= state;
        end
    end
end
//****

always_ff@(posedge clk)
if(FSM_STATE_RST_WRD_CNTR) begin
    state_dec <= Hmin_num; // инициализация номером победившей ветви
end else begin
    if(FSM_STATE_DATA_DEC) begin
        state_dec <= {way_data,state_dec[k-2:1]};
    end
end

reg [31:0] dec_data_sr;
always_ff@(posedge clk)
if(FSM_STATE_DATA_DEC) begin
    dec_data_sr <= {dec_data_sr[30:0],state_dec[0]};
end

always_ff@(posedge clk)
if(FSM_STATE_NXT_DAT_DEC) begin
    PL.DEC_DATA[enc_word >> 1] <= dec_data_sr;
end

always_ff@(posedge clk)
if(FSM_STATE_RESET) begin // Fault Recovery
    PL.CFG.DONE <= '1;
end else begin
    if(FSM_STATE_VIRT) begin
        PL.CFG.DONE <= '0;
    end else begin
        if(FSM_STATE_DONE) begin
            PL.CFG.DONE <= '1;
        end
    end
end

always_ff@(posedge clk)
case(fsm_state)
    FSM_RESET : begin
        fsm_state <= FSM_READY;
    end
    FSM_READY : begin
        if(start) begin
            fsm_state <= FSM_VIRT; // начинаем перебор вершин
        end
    end
    FSM_VIRT : begin
        if(state_bit_last) begin
            fsm_state <= FSM_H_MIRR; // прошли все вершины, зеркалируем H
        end
    end
    FSM_H_MIRR : begin
        if(enc_pair_last) begin
            if(enc_word_last) begin // перебрали все входные данные
                fsm_state <= FSM_H_L_MIN; // поиск минимальной метрики
            end else begin
                fsm_state <= FSM_NXT_DAT_ENC; // читаем новый регистр входных данных
            end
        end else begin
            fsm_state <= FSM_VIRT; // читаем новый регистр входных данных
        end
    end
    FSM_NXT_DAT_ENC : begin
        fsm_state <= FSM_VIRT; // переходим на следующий уровень
    end
    FSM_H_L_MIN : begin
        fsm_state <= FSM_H_END_MIN; // сброс счетчика слов
    end
    FSM_H_END_MIN : begin
        if(state_last) begin
            fsm_state <= FSM_RST_WRD_CNTR; // сброс счетчика слов
        end else begin
            fsm_state <= FSM_H_L_MIN;
        end
    end
    FSM_RST_WRD_CNTR : begin
        fsm_state <= FSM_RD_WAY; // переход к восстановлению данных из way (вычитывае way)
    end
    FSM_RD_WAY : begin
        fsm_state <= FSM_DATA_DEC; // way прочтен
    end
    FSM_DATA_DEC : begin
        if(enc_pair_first) begin
            fsm_state <= FSM_NXT_DAT_DEC; // данные получены
        end else begin
            fsm_state <= FSM_RD_WAY; // переход к восстановлению данных из way (вычитывае way)
        end
    end
    FSM_NXT_DAT_DEC : begin
        if(enc_word_first) begin
            fsm_state <= FSM_DONE; // данные получены
        end else begin
            fsm_state <= FSM_RD_WAY; // продолжаем декодировать
        end
    end
    FSM_DONE : begin
        fsm_state <= FSM_READY;
    end
    default : begin // Fault Recovery
        fsm_state <= FSM_RESET;
    end
endcase

// разворот константы битами в обратную сторону
function integer reverse_bit;
input integer mask, size;
integer i;
begin
    reverse_bit = 0;
    for(i = 0; i < size; i = i + 1)
        reverse_bit[i] = mask[6-i];
end
endfunction

endmodule