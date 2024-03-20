`include "fsm_controller.svh"

module fsm_controller
#(
    parameter BASEADDR       = 0,
    parameter CORE_SIZE      = 0,
    parameter DEPTH          = 0,
    parameter ADDR_WORD_BITS = 0
)
(
    input                             rf_clk,
    input                             core_clk,
    output                            fsm_wait,
    output reg                        fsm_reset,
    output                            acq_global_resetn_core,
    bram_controller_interface.slave   bram_controller_interface,
    freq_shift_interface.slave        freq_shift_interface,
    psp_gen_interface.slave           psp_gen_interface,
    core_interface.slave              core_interface,
    arr_accum_interface.master        arr_accum_interface,
    max_args_interface.slave          max_args_interface,
    intbus_interf.slave               bus,
    input        [ADDR_WORD_BITS-1:0] rd_cntr,
    output logic [ADDR_WORD_BITS-1:0] rd_cntr_init
);

FSM_CONTROLLER_STRUCT PL;
FSM_CONTROLLER_STRUCT PS;

//Define which bits will be pulsed
localparam NPULSE = 4;
localparam integer PULSE [NPULSE][2] = '{
    '{3, 0}, // do_init
    '{3, 1}, // acq_start
    '{3, 3}, // acq_global_resetp
    '{3, 31} // reset_fsm
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`FSM_CONTROLLER_ID_CONST),
    .DATATYPE (FSM_CONTROLLER_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
) regs_file_fsm_controller_inst(
    .clk    (core_clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  ({reset_fsm,acq_global_resetp,acq_start,cpu_do_init}),
    .wr     (),
    .rd     ()
);

signal_sync acq_global_resetp_core_inst
(
    .sclk     (core_clk),
    .dclk     (core_clk),
    .start    (acq_global_resetp),
    .ready    (acq_global_resetp_core)
);

assign acq_global_resetn_core = !acq_global_resetp_core;

assign PL.CORE_SIZE            = CORE_SIZE;
assign PL.KG                   = '0;
assign PL.NKG                  = '0;
assign PL.N_TAU_ZONE           = '0;
assign PL.N_F                  = '0;
assign PL.BRAM_RD_DEPTH        = '0;
assign PL.FREQ_SHIFT_CODE_INIT = '0;
assign PL.FREQ_SHIFT_CODE_STEP = '0;

assign PL.PSP                  = '0;

assign PL.RESERVED                   = '0;
assign PL.CONTROL.DO_INIT            = '0;
assign PL.CONTROL.ACQ_START          = '0;
assign PL.CONTROL.ACQ_GLOBAL_RESETN  = '0;
assign PL.CONTROL.RESERVED_FOR_STATE = '0;
assign PL.CONTROL.RESERVED           = '0;

assign arr_accum_interface.kg              = PS.KG;
assign arr_accum_interface.nkg             = PS.NKG;
assign bram_controller_interface.rd_depth  = PS.BRAM_RD_DEPTH;
assign max_args_interface.Ntau             = PS.N_TAU_ZONE;
assign max_args_interface.Nf               = PS.N_F;
assign arr_accum_interface.time_separation = PS.TIME_SEPARATION;
wire   time_separation = PS.TIME_SEPARATION;
//
wire end_kg;
wire end_nkg;
assign arr_accum_interface.end_kg         = end_kg;
assign arr_accum_interface.end_nkg        = end_nkg;



// --- BRAM FSM ---
logic [$clog2(CORE_SIZE)-1:0] core_cntr = '0;// счетчик адресов в пределах одного ядра
logic [15:0] cores_cntr                 = '0;// счетчик ядер внутри tau_zone
logic [15:0] fsm_bram_n_tau_zone_cntr   = '0;
logic [15:0] fsm_bram_n_f_cntr          = '0;
logic [15:0] fsm_bram_kg_cntr           = '0;
logic [15:0] fsm_bram_nkg_cntr          = '0;

assign end_core  = core_cntr == CORE_SIZE - 1;
assign end_kg    = end_core  & (fsm_bram_kg_cntr         == arr_accum_interface.kg  - 1);
assign end_nkg   = end_kg    & (fsm_bram_nkg_cntr        == arr_accum_interface.nkg - 1);
assign end_n_tau = end_nkg   & (fsm_bram_n_tau_zone_cntr == PS.N_TAU_ZONE - 1);
assign end_n_f   = end_n_tau & (fsm_bram_n_f_cntr        == PS.N_F - 1);
logic end_last_psp;

logic [2:0] state;
enum logic [2:0] {
    FSM_RESET       = 3'd0,
    FSM_WAIT_START  = 3'd1,
    FSM_INIT        = 3'd2,
    FSM_N_TAU_ZONE  = 3'd3,// стадия непрерывного вычитывания из памяти
    FSM_LAST_PSP    = 3'd4,// стадия завершения свертки
    FSM_WAIT_MAX    = 3'd5 // ожидание окончания поиска
} fsm_state_enum;

assign STATE_RESET      = state == FSM_RESET;
assign STATE_WAIT_START = state == FSM_WAIT_START;
assign STATE_INIT       = state == FSM_INIT;
assign STATE_N_TAU_ZONE = state == FSM_N_TAU_ZONE;
assign STATE_LAST_PSP   = state == FSM_LAST_PSP;
assign STATE_WAIT_MAX   = state == FSM_WAIT_MAX;

always_ff@(posedge core_clk)
if(reset_fsm) begin
    state <= FSM_RESET;
end else
case (state)
    FSM_RESET : begin
        state <= PS.TARGET.STATE[0]; // FSM_WAIT_START = 1
    end
    FSM_WAIT_START : begin
        if(acq_start)
            state <= PS.TARGET.STATE[1]; // FSM_INIT = 2
    end
    FSM_INIT : begin
        state <= PS.TARGET.STATE[2]; // FSM_N_TAU_ZONE = 3
    end
    FSM_N_TAU_ZONE : begin
        if(end_nkg) begin
            if(end_n_tau)
                state <= PS.TARGET.STATE[3]; // FSM_LAST_PSP = 4
            else
                state <= PS.TARGET.STATE[4]; // FSM_INIT = 2
        end
    end
    FSM_LAST_PSP : begin
        if(end_last_psp)
        begin
            if(fsm_bram_n_f_cntr == PS.N_F)
                state <= PS.TARGET.STATE[5]; // FSM_WAIT_MAX = 5
            else
                state <= PS.TARGET.STATE[6]; // FSM_INIT = 2
        end
    end
    FSM_WAIT_MAX : begin
        if(max_args_interface.done_max)
            state <= PS.TARGET.STATE[7]; // FSM_WAIT_START = 1
    end
    default: begin
        state <= FSM_RESET;
    end
endcase

// ila_0 ila_state_i (
  // .clk   (core_clk),
  // .probe0({0
    // ,state
  // })
// );

always_ff@(posedge core_clk)// счетчик отсчетов внутри каждого ядра
if(STATE_RESET)
    core_cntr <= '0;
else
    if(STATE_N_TAU_ZONE) begin
        if(end_core)
            core_cntr <= '0;
        else
            if(bram_controller_interface.valid)
                core_cntr <= core_cntr + 1'b1; end
    else
        core_cntr <= '0;

always_ff@(posedge core_clk)// счетчик отсчетов внутри каждого ядра
if(STATE_RESET)
    cores_cntr <= '0;
else
    if(end_core) begin
        if(end_nkg)
            cores_cntr <= '0;
        else
            cores_cntr <= cores_cntr + 1'b1;
    end

always_ff@(posedge core_clk)// счетчик когерентного накопления
if(STATE_RESET)
    fsm_bram_kg_cntr <= '0;
else
    if(STATE_N_TAU_ZONE) begin
        if(end_core)
            if(end_kg)
                fsm_bram_kg_cntr <= '0;
            else
                fsm_bram_kg_cntr <= fsm_bram_kg_cntr + 1'b1; end
    else
        fsm_bram_kg_cntr <= '0;

always_ff@(posedge core_clk)// счетчик некогерентного накопления
if(STATE_RESET)
    fsm_bram_nkg_cntr <= '0;
else
    if(STATE_N_TAU_ZONE) begin
        if(end_kg)
            if(end_nkg)
                fsm_bram_nkg_cntr <= '0;
            else
                fsm_bram_nkg_cntr <= fsm_bram_nkg_cntr + 1'b1; end
    else
        fsm_bram_nkg_cntr <= '0;

// ---
localparam AWIDTH = $clog2(DEPTH)+1; // разрядность расширена для возможности хранения адреса=DEPTH
reg [AWIDTH-1:0] sRdAddrStart;
reg [15:0]       sPRBSpermutaionCnt;
wire             sTimeSlotOver = (sPRBSpermutaionCnt == arr_accum_interface.kg  - 1);

always_ff@(posedge core_clk)
begin
  if (time_separation) begin
    if (STATE_WAIT_START || STATE_LAST_PSP) begin
      sRdAddrStart       = '0;
      sPRBSpermutaionCnt = '0;
    // end else if (STATE_INIT) begin
    end else if (end_nkg) begin
        sPRBSpermutaionCnt <= '0;
        sRdAddrStart       <= sRdAddrStart + CORE_SIZE; // shift data pointer to the core size
    end
  end else begin
    sRdAddrStart       = '0;
    sPRBSpermutaionCnt = '0;
  end
end

assign bram_controller_interface.rd_start_addr = {'0, sRdAddrStart};
assign bram_controller_interface.rd_start      = STATE_INIT;
// ---

always_ff@(posedge core_clk)// счетчик зон поиска по задрежке(каждая в размер ядра)
if(STATE_RESET)
    fsm_bram_n_tau_zone_cntr <= '0;
else
    case(state)
        FSM_N_TAU_ZONE: begin
            if(end_nkg) begin
                if(end_n_tau)
                    fsm_bram_n_tau_zone_cntr <= '0;
                else
                    fsm_bram_n_tau_zone_cntr <= fsm_bram_n_tau_zone_cntr + 1'b1;
            end
        end
        FSM_INIT: begin
            fsm_bram_n_tau_zone_cntr <= fsm_bram_n_tau_zone_cntr;
        end
        default: begin
            fsm_bram_n_tau_zone_cntr <= '0;
        end
    endcase

always_ff@(posedge core_clk)// счетчик каналов поиска по частоте
if(STATE_RESET)
    fsm_bram_n_f_cntr <= '0;
else
    case(state)
        FSM_N_TAU_ZONE: begin
            if(end_n_tau)
                fsm_bram_n_f_cntr <= fsm_bram_n_f_cntr + 1'b1;
        end
        FSM_WAIT_START: begin
            fsm_bram_n_f_cntr <= '0;
        end
        default: begin
            fsm_bram_n_f_cntr <= fsm_bram_n_f_cntr;
        end
    endcase
// --- BRAM FSM END ---

// --- FREQ_SHIFT ---
//freq_shift is combinatorical and non-latency
logic [31:0] code_dds_freq_shift    = '0;
logic        code_dds_freq_shift_up = '0;//0 - doppler<0; 1 - doppler>0

always_ff@(posedge core_clk)// расчет кода частоты блока freq_shifter
if(STATE_RESET)
    code_dds_freq_shift_up <= '0;
else
    case(state)
        FSM_WAIT_START: begin
            code_dds_freq_shift_up <= '0;
        end
        FSM_N_TAU_ZONE: begin
            if(end_n_tau)
                if(fsm_bram_n_f_cntr == (PS.N_F - 1)/2 - 1)
                    code_dds_freq_shift_up <= 1'b1;
        end
        default: begin
            code_dds_freq_shift_up <= code_dds_freq_shift_up;
        end
    endcase

always_ff@(posedge core_clk)// расчет кода частоты блока freq_shifter
if(STATE_RESET)
    code_dds_freq_shift <= '0;
else
    case(state)
        FSM_WAIT_START: begin
            code_dds_freq_shift <= PS.FREQ_SHIFT_CODE_INIT;
        end
        FSM_N_TAU_ZONE: begin
            if(end_n_tau)
            begin
                if(code_dds_freq_shift_up)// doppler>0
                    code_dds_freq_shift <= code_dds_freq_shift + PS.FREQ_SHIFT_CODE_STEP;
                else
                    code_dds_freq_shift <= code_dds_freq_shift - PS.FREQ_SHIFT_CODE_STEP;
            end
        end
        default: begin
            code_dds_freq_shift <= code_dds_freq_shift;
        end
    endcase

assign freq_shift_interface.code    = code_dds_freq_shift;
assign freq_shift_interface.code_up = code_dds_freq_shift_up;
// --- FREQ_SHIFT END ---

// --- PSP GEN ---
logic [FACQ_PRNSIZE-1:0]   sr1_reg         = '0;// запоминают состояние сдвиговых регистров
logic [FACQ_PRNSIZE-1:0]   sr2_reg         = '0;// запоминают состояние сдвиговых регистров
logic [FACQ_CNTRSIZE-1:0]  prn_counter_reg = '0;
logic [4:0]                ovl_counter_reg = '0;
logic [ADDR_WORD_BITS-1:0] rd_cntr_reg     = '0;

assign fsm_do_init = core_interface.code_load | ((STATE_INIT) & (fsm_bram_n_tau_zone_cntr == '0));
assign psp_gen_interface.do_init = cpu_do_init | fsm_do_init;

always_ff@(posedge core_clk)
if(STATE_RESET) begin
    sr1_reg          <= '0;
    sr2_reg          <= '0;
    prn_counter_reg  <= '0;
    ovl_counter_reg  <= '0;
    rd_cntr_reg      <= '0;
end else
    case(state)
        FSM_N_TAU_ZONE: begin
            if(core_interface.wr_buf)
            begin// запомнили состояние генератора псп
                sr1_reg          <= psp_gen_interface.sr1;
                sr2_reg          <= psp_gen_interface.sr2;
                prn_counter_reg  <= psp_gen_interface.prn_counter;
                ovl_counter_reg  <= psp_gen_interface.ovl_cntr;
                rd_cntr_reg      <= rd_cntr;
            end
        end
    endcase

always_ff@(posedge core_clk)
if(STATE_RESET) begin
    psp_gen_interface.code_state1 <= '0;
    psp_gen_interface.code_state2 <= '0;
    psp_gen_interface.prn_init    <= '0;
    psp_gen_interface.ovl_init    <= '0;
    rd_cntr_init                  <= '0;
end else
    case(state)
        FSM_WAIT_START: begin// начальная инициализация процессором
              psp_gen_interface.code_state1 <= PS.PSP.CODE_STATE1;
              psp_gen_interface.code_state2 <= PS.PSP.CODE_STATE2;
              psp_gen_interface.prn_init    <= PS.PSP.PRN_INIT;
              psp_gen_interface.ovl_init    <= '0;
              rd_cntr_init                  <= '0;
        end
        FSM_N_TAU_ZONE: begin
            if(!time_separation && end_nkg) begin// инициализация состоянием из кэша
              psp_gen_interface.code_state1 <= sr1_reg;
              psp_gen_interface.code_state2 <= sr2_reg;
              psp_gen_interface.prn_init    <= prn_counter_reg;
              psp_gen_interface.ovl_init    <= ovl_counter_reg;
              rd_cntr_init                  <= rd_cntr_reg;
            end
        end
        FSM_LAST_PSP: begin
            if(end_last_psp) begin// восстанавливаем исходное состояние генератора ПСП// начальная инициализация данными из процессора
                psp_gen_interface.code_state1 <= PS.PSP.CODE_STATE1;
                psp_gen_interface.code_state2 <= PS.PSP.CODE_STATE2;
                psp_gen_interface.prn_init    <= PS.PSP.PRN_INIT;
                psp_gen_interface.ovl_init    <= '0;
                rd_cntr_init                  <= '0;
            end
        end
    endcase

always_ff@(posedge core_clk)
if(STATE_RESET) begin
    psp_gen_interface.freq_div          <= '0;
    psp_gen_interface.code_reset_state1 <= '0;
    psp_gen_interface.code_bitmask1     <= '0;
    psp_gen_interface.code_out_bitmask1 <= '0;
    psp_gen_interface.code_reset_state2 <= '0;
    psp_gen_interface.code_bitmask2     <= '0;
    psp_gen_interface.code_out_bitmask2 <= '0;
    psp_gen_interface.prn_length        <= '0;
    psp_gen_interface.gps_l5_reset_en   <= '0;
    psp_gen_interface.single_sr         <= '0;
    psp_gen_interface.ovl               <= '0;
    psp_gen_interface.ovl_length        <= '0;
end else
    case(state)
        FSM_WAIT_START: begin// начальная инициализация данными из процессора
            psp_gen_interface.freq_div          <= PS.PSP.FREQ_DIV;
            psp_gen_interface.code_reset_state1 <= PS.PSP.CODE_RESET_STATE1;
            psp_gen_interface.code_bitmask1     <= PS.PSP.CODE_BITMASK1;
            psp_gen_interface.code_out_bitmask1 <= PS.PSP.CODE_OUT_BITMASK1;
            psp_gen_interface.code_reset_state2 <= PS.PSP.CODE_RESET_STATE2;
            psp_gen_interface.code_bitmask2     <= PS.PSP.CODE_BITMASK2;
            psp_gen_interface.code_out_bitmask2 <= PS.PSP.CODE_OUT_BITMASK2;
            psp_gen_interface.prn_length        <= PS.PSP.PRN_LENGTH;
            psp_gen_interface.gps_l5_reset_en   <= PS.PSP.GPS_L5_RESET_EN;
            psp_gen_interface.single_sr         <= PS.PSP.SINGLE_SR;
            psp_gen_interface.ovl               <= PS.PSP.OVL;
            psp_gen_interface.ovl_length        <= PS.PSP.OVL_LENGTH;
        end
    endcase

always_ff@(posedge core_clk)
if(STATE_RESET) begin
    psp_gen_interface.psp_back_valid <= '0;
end else begin
    psp_gen_interface.psp_back_valid <= STATE_LAST_PSP;
end

logic [$clog2(CORE_SIZE)-1:0] last_psp_cntr = '0;
always_ff@(posedge core_clk)// счетчик для завершения свертки в конце зоны поиска по задержке
if(STATE_RESET)
    last_psp_cntr <= '0;
else
    case(state)
        FSM_LAST_PSP: begin
            last_psp_cntr <= last_psp_cntr + 1'b1;
        end
        default: begin
            last_psp_cntr <= '0;
        end
    endcase

assign end_last_psp = last_psp_cntr == CORE_SIZE - 1;
// --- PSP GEN END ---

reg end_nkg_dly;
always_ff@(posedge core_clk) end_nkg_dly <= end_nkg;

assign core_resetp_fsm_rqst         = end_n_tau;
// assign core_interface.code_load     = end_core & (cores_cntr == '0) & (fsm_bram_n_tau_zone_cntr != '0);
// assign core_interface.wr_buf        = end_core & (cores_cntr == 16'd1);

assign core_interface.code_load     = end_nkg_dly;
assign core_interface.wr_buf        = (time_separation && sTimeSlotOver) ? end_core & (cores_cntr == 16'd0) : (cores_cntr == 16'd1) & (core_cntr == 16'd1); // end_core & (cores_cntr == 16'd0);

assign max_args_interface.reset_max = STATE_WAIT_START;

assign PL.CONTROL.ACQ_DONE = STATE_WAIT_START;
assign PL.CONTROL.STATE    = state;
assign PL.KG_CNTR          = fsm_bram_kg_cntr;
assign PL.NKG_CNTR         = fsm_bram_nkg_cntr;
assign PL.NF_CNTR          = fsm_bram_n_f_cntr;
assign PL.NTAU_CNTR        = fsm_bram_n_tau_zone_cntr;

//============================================
//============================================
//============================================
//============================================
logic core_resetp_fsm_late;

assign core_resetp_fsm = (core_resetp_fsm_rqst & !core_interface.we) ? 1'b1 : core_resetp_fsm_late;

logic core_resetp_fsm_allow = '0;

always_ff@(posedge core_clk)
if(STATE_RESET)
    core_resetp_fsm_allow <= 0;
else
    if(core_resetp_fsm_rqst & core_interface.we)
        core_resetp_fsm_allow <= 1'b1;
    else
        if(core_resetp_fsm_late)
            core_resetp_fsm_allow <= 0;

ed_det#(
    .TYPE  ("fal")
) ed_det_core_resetp_fsm_late(
    .clk   (core_clk),
    .in    (core_interface.we & core_resetp_fsm_allow),
    .out   (core_resetp_fsm_late)
);

//----------------------------------------------------------------------

logic [$clog2(CORE_SIZE)-1:0] wr_cntr;
assign core_interface.data_latch = wr_cntr == (CORE_SIZE-1);// защелкивание данных в регистре памяти данных
assign core_interface.we         = freq_shift_interface.valid | psp_gen_interface.psp_back_valid;

always_ff@(posedge core_clk)
if((core_interface.we == 0) | core_interface.data_latch) begin
    wr_cntr <= 0;
end else begin
    wr_cntr <= wr_cntr + 1'b1;
end

logic adder_allow = '0;

always_ff@(posedge core_clk)
if(STATE_RESET)
    adder_allow <= 0;
else
    if(core_resetp_fsm)
        adder_allow <= 0;
    else if(core_interface.data_latch) // можно начинать писать псп в кеш
        adder_allow <= 1'b1;

assign core_interface.we_adder = core_interface.we & adder_allow;

assign                       fsm_wait  = STATE_WAIT_START;
always_ff@(posedge core_clk) fsm_reset = STATE_RESET;

endmodule