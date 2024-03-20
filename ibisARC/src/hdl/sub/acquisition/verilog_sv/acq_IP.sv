`include "acq_ip.svh"
`include "global_param.v"

module acq_IP
#(
    parameter BASEADDR           = 0,
    parameter BRAM_DEPTH         = 0,
    parameter CORE_SIZE          = 0
)
(
    adc_interf.slave    adc,
    intbus_interf.slave bus_master,
    input               pps_in,
    input               core_clk,
    input               we_IQ,
    input               epoch,
    output              facq_time_pulse,
    input  wire         TIME_SCALE_COM_STRUCT time_in
);

assign core_resetn = '1;

localparam KG_WIDTH       = $clog2(10230*2*2/CORE_SIZE);
localparam NKG_WIDTH      = $clog2(128);
localparam CORE_OUT_WIDTH = 3 + $clog2(CORE_SIZE);// разрядность на входе ядра задана 3
localparam OUT_WIDTH_KG   = CORE_OUT_WIDTH + KG_WIDTH;
localparam QUAD_WIDTH     = OUT_WIDTH_KG*2;
localparam OUT_WIDTH_NKG  = QUAD_WIDTH + NKG_WIDTH;

localparam NBUSES = 7 `ifdef FACQ_DATCOLL + 1`endif;
intbus_interf  bus_sl[NBUSES]();

logic acq_global_resetn_core;// глобальный ресет поиска, домен core
logic timegen_wr;
logic fsm_wait;
logic fsm_reset;
logic fsm_reset_rf;

reset_sync#(
    .RESET_POL ("POS")
) reset_sync_fsm_reset_rf(
    .clk        (adc.clk),
    .resetn_in  (fsm_reset),
    .resetn_out (fsm_reset_rf)
);

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES),
    .OUTFF      ("y")
) connectbus_inst(
    .master_bus (bus_master),
    .slave_bus  (bus_sl)
);


ACQ_IP_STRUCT PS;

localparam BASEREGFILE  = BASEADDR + `HUBSIZE;
regs_file#(
    .BASEADDR (BASEREGFILE),
    .ID       (`ACQ_IP_ID_CONST),
    .DATATYPE (ACQ_IP_STRUCT)
) regs_file_acq_ip_inst(
    .clk    (core_clk),
    .bus    (bus_sl[0]),
    .in     ('0),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

//----------------------------------------------------------------
`ifdef SIMULATE
  logic adapt_bypass = 1'b1;
`else
  logic adapt_bypass = 1'b0;
`endif

localparam BASEPRESTORE = BASEREGFILE + `ACQ_IP_SIZE + `RWREGSSIZE;
prestore#(
    .BASEADDR (BASEPRESTORE)
)
prestore_inst(
    .clk            (adc.clk),//с фронтенда
    .clr            (fsm_reset_rf),
    .adapt_bypass   (adapt_bypass),
    .ms_epoch       (epoch), // not used
    .sig_I          (adc.data[PS.CFG.RE_INP][1]),
    .mag_I          (adc.data[PS.CFG.RE_INP][0]),
    .sig_Q          (adc.data[PS.CFG.IM_INP][1]),
    .mag_Q          (adc.data[PS.CFG.IM_INP][0]),
    .time_pulse_in  (timegen_wr), // just out in several cycles 
    .time_pulse_out (facq_time_pulse),
    .we             (we_IQ),  // 230116: always '1' in trcv.sv
    .I_sum_sig      (I_sum_sig),
    .I_sum_mag      (I_sum_mag),
    .Q_sum_sig      (Q_sum_sig),
    .Q_sum_mag      (Q_sum_mag),
    .valid          (prestore_valid),//строб по накопленной величине
    .bus            (bus_sl[1])
);

bram_controller_interface bram_controller_interface();
freq_shift_interface      freq_shift_interface();
psp_gen_interface         psp_gen_interface();
core_interface            core_interface();
arr_accum_interface#(
    .KG_WIDTH  (KG_WIDTH),
    .NKG_WIDTH (NKG_WIDTH)
) arr_accum_interface();
max_args_interface        max_args_interface();

wire  [31:0]              sAmpMax;
wire  [31:0]              sTauMax;
wire                      sTauEnd;
logic [OUT_WIDTH_NKG-1:0] R_quad_nkg;

localparam BASEBRAMCONTROLLER = BASEPRESTORE + `PRESTORE_FULL_SIZE;
bram_controller#(
    .BASEADDR         (BASEBRAMCONTROLLER),
    .DEPTH            (BRAM_DEPTH),
    .OUT_WIDTH_NKG    (OUT_WIDTH_NKG)
) bram_controller_inst(
    // debug
    .R                         (R_quad_nkg),
    .tau                       (sTauMax),
    .tauEnd                    (sTauEnd),
    .pps                       (pps_in),
    //
    .rf_clk                    (adc.clk),
    .core_clk                  (core_clk),
    .wr_clr                    (fsm_reset_rf),
    .rd_clr                    (fsm_wait),
    .I_sum_sig                 (I_sum_sig),
    .I_sum_mag                 (I_sum_mag),
    .Q_sum_sig                 (Q_sum_sig),
    .Q_sum_mag                 (Q_sum_mag),
    .we_sum                    (prestore_valid),
    .I_mem_sig                 (I_mem_sig),
    .I_mem_mag                 (I_mem_mag),
    .Q_mem_sig                 (Q_mem_sig),
    .Q_mem_mag                 (Q_mem_mag),
    .timegen_wr                (timegen_wr),
    .bram_controller_interface (bram_controller_interface),
    .bus                       (bus_sl[2]),
    .time_in                   (time_in)
);

logic signed [2:0] I_freq_shift;
logic signed [2:0] Q_freq_shift;

freq_shift freq_shift_inst(
    .clk                  (core_clk),
    .resetn               (core_resetn & acq_global_resetn_core),
    .I_sig                (I_mem_sig),
    .I_mag                (I_mem_mag),
    .Q_sig                (Q_mem_sig),
    .Q_mag                (Q_mem_mag),
    .we                   (bram_controller_interface.valid),
    .I_out                (I_freq_shift),
    .Q_out                (Q_freq_shift),
    .freq_shift_interface (freq_shift_interface)
);

facq_prn_gen facq_prn_gen_inst(
    .clk               (core_clk),
    .resetn            (core_resetn & acq_global_resetn_core),
    .we                (freq_shift_interface.valid | psp_gen_interface.psp_back_valid),
    .psp_out_shift_reg (psp_out_shift_reg),
    .psp_gen_interface (psp_gen_interface)
);

// ++++++++++++++++++++++++++
localparam RAM_SIZE       = 10230;
localparam RAM_DEPTH      = (RAM_SIZE - 1)/`AXI_GP_WIDTH + 1; // глубина памяти в словах
localparam ADDR_WORD_BITS = $clog2(RAM_DEPTH);
logic [ADDR_WORD_BITS-1:0] rd_cntr;
logic [ADDR_WORD_BITS-1:0] rd_cntr_init;
// ++++++++++++++++++++++++++

localparam BASEPRNRAM = BASEBRAMCONTROLLER + `BRAM_CONTROLLER_FULL_SIZE;
facq_prn_ram#(
    .BASEADDR (BASEPRNRAM),
    .RAM_SIZE (RAM_SIZE)
) facq_prn_ram_inst(
    .bus          (bus_sl[3]),
    .clk          (core_clk),
    .freq_div     (psp_gen_interface.freq_div[2:0]),
    .shift        (freq_shift_interface.valid | psp_gen_interface.psp_back_valid),
    .clr          (!(core_resetn & acq_global_resetn_core)),
    .prn          (prn_ram_prn),
    .valid        (),
    .en           (prn_ram_en),
    .do_init      (psp_gen_interface.do_init),
    .rd_cntr      (rd_cntr),
    .rd_cntr_init (rd_cntr_init)
);

logic signed [CORE_OUT_WIDTH-1:0] I_core;
logic signed [CORE_OUT_WIDTH-1:0] Q_core;

core#(
    .CORE_SIZE  (CORE_SIZE)
) core_inst(
    .clk                  (core_clk),
    .time_separation      (arr_accum_interface.time_separation),
    .I_in                 (I_freq_shift),
    .Q_in                 (Q_freq_shift),
    .psp_in               (prn_ram_en ? prn_ram_prn : psp_out_shift_reg),
    .I                    (I_core),
    .Q                    (Q_core),
    .core_interface       (core_interface)
);

wire prn_xor = (freq_shift_interface.valid | psp_gen_interface.psp_back_valid) ? (prn_ram_prn ^ psp_out_shift_reg) : 1'b0;

logic signed [OUT_WIDTH_KG-1:0] I_kg_accum;
logic signed [OUT_WIDTH_KG-1:0] Q_kg_accum;

arr_accum#(
    .IN_WIDTH  (CORE_OUT_WIDTH),
    .OUT_WIDTH (OUT_WIDTH_KG),
    .N_args    (CORE_SIZE),
    .KG_MODE   (1)
) arr_accum_I_kg_inst(
    .clk                 (core_clk),
    .clr                 (fsm_wait),
    .R_in                (I_core),
    .R_out               (I_kg_accum),
    .we                  (core_interface.valid),
    .valid               (valid_kg),
    .arr_accum_interface (arr_accum_interface)
);

arr_accum#(
    .IN_WIDTH  (CORE_OUT_WIDTH),
    .OUT_WIDTH (OUT_WIDTH_KG),
    .N_args    (CORE_SIZE),
    .KG_MODE   (1)
) arr_accum_Q_kg_inst(
    .clk                 (core_clk),
    .clr                 (fsm_wait),
    .R_in                (Q_core),
    .R_out               (Q_kg_accum),
    .we                  (core_interface.valid),
    .valid               (),
    .arr_accum_interface (arr_accum_interface)
);

//quadrature-------
logic [QUAD_WIDTH-1:0] R_quad;

quad#(
    .IN_WIDTH (OUT_WIDTH_KG)
) quad_inst(
    .clk     (core_clk),
    .resetn  (core_resetn & acq_global_resetn_core),
    .I_in    (I_kg_accum),
    .Q_in    (Q_kg_accum),
    .R       (R_quad),
    .we      (valid_kg),
    .valid   (valid_quad)
);

//nonkoherent-------


arr_accum#(
    .IN_WIDTH  (QUAD_WIDTH),
    .OUT_WIDTH (OUT_WIDTH_NKG),
    .N_args    (CORE_SIZE),
    .KG_MODE   (0)
) arr_accum_quad_nkg_inst(
    .clk                 (core_clk),
    .clr                 (fsm_wait),
    .R_in                (R_quad),
    .R_out               (R_quad_nkg),
    .we                  (valid_quad),
    .valid               (valid_nkg),
    .arr_accum_interface (arr_accum_interface)
);

localparam BASEMAXARGS = BASEPRNRAM + `FACQ_PRN_RAM_FULL_SIZE;
max_args#(
    .BASEADDR (BASEMAXARGS),
    .IN_WIDTH (OUT_WIDTH_NKG),
    .N_args   (CORE_SIZE)
) max_args(
  // debug
    .oAmpMax            (sAmpMax),
    .oTauMax            (sTauMax),
    .oTauEnd            (sTauEnd),
  //
    .clk                (core_clk),
    .R                  (R_quad_nkg),
    .we                 (valid_nkg),
    .max_args_interface (max_args_interface),
    .bus                (bus_sl[4])
);

localparam BASEFSM = BASEMAXARGS + `MAX_ARGS_FULL_SIZE;
fsm_controller#(
    .BASEADDR       (BASEFSM),
    .CORE_SIZE      (CORE_SIZE),
    .DEPTH          (BRAM_DEPTH),
    .ADDR_WORD_BITS (ADDR_WORD_BITS)
) fsm_controller_inst(
    .rf_clk                    (adc.clk),
    .core_clk                  (core_clk),
    .fsm_wait                  (fsm_wait),
    .fsm_reset                 (fsm_reset),
    .acq_global_resetn_core    (acq_global_resetn_core),
    .bram_controller_interface (bram_controller_interface),
    .freq_shift_interface      (freq_shift_interface),
    .psp_gen_interface         (psp_gen_interface),
    .core_interface            (core_interface),
    .arr_accum_interface       (arr_accum_interface),
    .max_args_interface        (max_args_interface),
    .bus                       (bus_sl[5]),
    .rd_cntr                   (rd_cntr),
    .rd_cntr_init              (rd_cntr_init)
);

localparam BASENOISECOLL = BASEFSM + `FSM_CONTROLLER_FULL_SIZE;
wire sNoiseWrEn = ~(|R_quad_nkg[OUT_WIDTH_NKG-1:32]) // don't collect if noise sample is too high
                  & valid_nkg;
data_collector#(
    .BASEADDR   (BASENOISECOLL),
    .NUM_PORTS  (1),
    .DATA_WIDTH (32),
    .DATA_DEPTH (1_024)
) DATA_COLLECTOR_NOISE(
    .clk    (core_clk),
    .we     (sNoiseWrEn),
    .data   (R_quad_nkg[31:0]),
    .bus    (bus_sl[6])
);

localparam BASEDATCOLL = BASENOISECOLL + `DATA_COLLECTOR_FULL_SIZE;
`ifdef FACQ_DATCOLL
data_collector#(
    .BASEADDR   (BASEDATCOLL),
    .NUM_PORTS  (2),
    .DATA_WIDTH (2),
    .DATA_DEPTH (2_048)
) DATA_COLLECTOR(
    .clk    (adc.clk),
    .we     (prestore_valid),
    .data   ({Q_sum_sig,Q_sum_mag,I_sum_sig,I_sum_mag}),
    .bus    (bus_sl[7])
);
`endif

endmodule