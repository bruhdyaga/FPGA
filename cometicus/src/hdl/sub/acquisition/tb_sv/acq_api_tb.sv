`timescale 1ns/10ps

`include "global_param.v"

`include "acq_api_tb.svh"
`include "acq_ip.svh"
`include "time_scale_com.svh"

module acq_api_tb();


localparam CORE_SIZE  = 256;
localparam BRAM_DEPTH = 4*204800;
localparam BASEADDR   = 0;

`define aclk_freq     100  // MHz
`define rf_clk_freq   100  // MHz
`define core_clk_freq 100  // MHz

reg aclk     = 1;
reg rf_clk   = 1;
reg core_clk = 1;
reg record_en = 0; // разрешение на чтение выборки

localparam N_record = 30000;// количество отсчетов в тестовой записи (размер файла разделить на 2)
reg sig_I [N_record-1:0];
reg mag_I [N_record-1:0];
reg sig_Q [N_record-1:0];
reg mag_Q [N_record-1:0];

initial begin
$readmemb ("../matlab/acq_test_signal/sig_I.txt", sig_I);
$readmemb ("../matlab/acq_test_signal/mag_I.txt", mag_I);
$readmemb ("../matlab/acq_test_signal/sig_Q.txt", sig_Q);
$readmemb ("../matlab/acq_test_signal/mag_Q.txt", mag_Q);

// $readmemb ("../matlab/acq_test_signal/sig_I_LCT_L2O.txt", sig_I);
// $readmemb ("../matlab/acq_test_signal/mag_I_LCT_L2O.txt", mag_I);
// $readmemb ("../matlab/acq_test_signal/sig_Q_LCT_L2O.txt", sig_Q);
// $readmemb ("../matlab/acq_test_signal/mag_Q_LCT_L2O.txt", mag_Q);

$readmemb ("../matlab/acq_test_signal/sig_I_GLN_L1_OF_slot1.txt", sig_I);
$readmemb ("../matlab/acq_test_signal/mag_I_GLN_L1_OF_slot1.txt", mag_I);
$readmemb ("../matlab/acq_test_signal/sig_Q_GLN_L1_OF_slot1.txt", sig_Q);
$readmemb ("../matlab/acq_test_signal/mag_Q_GLN_L1_OF_slot1.txt", mag_Q);

// $readmemb ("../matlab/acq_test_signal/sig_I_fd0_tau0.txt", sig_I);
// $readmemb ("../matlab/acq_test_signal/mag_I_fd0_tau0.txt", mag_I);
// $readmemb ("../matlab/acq_test_signal/sig_Q_fd0_tau0.txt", sig_Q);
// $readmemb ("../matlab/acq_test_signal/mag_Q_fd0_tau0.txt", mag_Q);
end

localparam NBUSES = 2;
axi3_interface  axi3();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus();
intbus_interf bus_sl[NBUSES]();

// ADC interface
adc_interf#(
    .PORTS (3),
    .R     (2)
)adc ();

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;
always #((1000/`rf_clk_freq)/2)   rf_clk   <= !rf_clk;
always #((1000/`core_clk_freq)/2) core_clk <= !core_clk;

real tb_time = 0;
initial begin
    fork
        $display("%t", $stime);
        #100 begin $display("%t", $stime); tb_time = 100; end
        #1000 begin $display("%t", $stime); tb_time = 1000; end
        #1010.5 begin $display("%t", $stime); tb_time = 1010.5; end
    join
end

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

connectbus#(
    .BASEADDR   (BASEADDR/4),
    .N_BUSES    (NBUSES),
    .TOP_LEVEL  (1)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

initial begin
        record_en = 0;
// #50000  record_en = 1;
        record_en = 1;
end

ACQ_IP_TB_STRUCT PL;
ACQ_IP_TB_STRUCT PS;

localparam logic [7 : 0] SYNCO [`ACQ_IP_TB_SIZE] = '{
    {"n"}, // N_RECORD
    {"l"}  // CONTROL
};

localparam BASEREGFILE = BASEADDR/4 + `HUBSIZE;
localparam BASEFACQ    = BASEREGFILE + `ACQ_IP_TB_FULL_SIZE;
regs_file#(
    .BASEADDR (BASEREGFILE),
    .ID       (`ACQ_IP_TB_ID_CONST),
    .DATATYPE (ACQ_IP_TB_STRUCT),
    .SYNCO    (SYNCO)
) regs_file_acq_ip_tb_inst(
    .clk    (adc.clk),
    .bus    (bus_sl[0]),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

assign PL.N_RECORD = N_record;
assign PL.CONTROL.RECORD_START = PS.CONTROL.RECORD_START;

/* reverse */
// 1023 * 3 = 3069

// tau = 3063 (1464116)
// reg [31:0] record_cntr_offset = 32'd0 * 32'd18;

// tau = 2828 (1399505), waveform: 2560 rd.addr. + 2.84us to start = 2844
// reg [31:0] record_cntr_offset = 32'd128 * 32'd18;

// tau = 2592 (2208212), waveform: 2304 rd.addr. + 3.05us to start = 2609
// reg [31:0] record_cntr_offset = 32'd256 * 32'd18;

// tau = 2357 (1857785), waveform: 2304 rd.addr. + 0.7us to start = 2374
// reg [31:0] record_cntr_offset = 32'd384 * 32'd18;

// tau = 2279 (1522772), waveform: 2048 rd.addr. + 2.48us to start = 2296
// reg [31:0] record_cntr_offset = 32'd426 * 32'd18;

// tau = 2 (2334800), 190 ticks (0.19us) from start (transaction 1->0)
// reg [31:0] record_cntr_offset = 32'd1664 * 32'd18;

// tau = 0 (2353172), 170 ticks (0.17us) from start (transaction 1->0)
// reg [31:0] record_cntr_offset = 32'd1665 * 32'd18;

// tau = 3064 (1464116)
reg [31:0] record_cntr_offset = 32'd1666 * 32'd18;

/* classic */
// // core = 256
// // tau = 1258
// // tau = 2282 (-1024 = 1258)
// reg [31:0] record_cntr_offset = 32'd680 * 32'd18;

// reg [31:0] record_cntr_offset = 32'd0 * 32'd18; // tau = 1  (2353172 - in 4 cores total)

// // // tau = 0    (2353172 - in 4 cores total)
// reg [31:0] record_cntr_offset = 32'd1666 * 32'd18;

// // // tau = 510  (1350260 - in 3 cores total)
// // // tau = 3076 (2353172 - in 4 cores total), (-3072 = 4)
// reg [31:0] record_cntr_offset = 32'd1665 * 32'd18;

// reg [31:0] record_cntr_offset = 32'd50 * 32'd18;

reg [31:0] record_cntr;
always@(posedge adc.clk) begin
    if(PS.CONTROL.RECORD_START)
    // if(record_en)
    begin
        if(record_cntr == N_record-1)
            record_cntr <= 0;
        else
            record_cntr <= record_cntr + 1'b1;
    end
    else
        // record_cntr <= $urandom%N_record;
        record_cntr <= 0;
end

assign adc.clk     = rf_clk;
wire [31:0] indx = (record_cntr_offset + record_cntr) % N_record;
assign adc.data[0] = {sig_I[indx],mag_I[indx]};
assign adc.data[1] = {sig_Q[indx],mag_Q[indx]};
assign adc.data[2] = '0;


TIME_SCALE_COM_STRUCT T = '0;
assign epoch_pulse = T.TM_CH.CHIP_EPOCH.CHIP == (`rf_clk_freq*1000 - 1);

always@(posedge adc.clk)
if(epoch_pulse | !PS.CONTROL.RECORD_START) begin
    T.TM_CH.CHIP_EPOCH.CHIP <= '0;
end else begin
    T.TM_CH.CHIP_EPOCH.CHIP <= T.TM_CH.CHIP_EPOCH.CHIP + 1;
end


always@(posedge adc.clk)
if(epoch_pulse) begin
    T.TM_CH.CHIP_EPOCH.EPOCH <= T.TM_CH.CHIP_EPOCH.EPOCH + 1'b1;
end

//
// acq_IP module below has the same functionality
//
// acq_ip_top#(
    // .BASEADDR   (0),
    // .BRAM_DEPTH (BRAM_DEPTH),
    // .CORE_SIZE  (CORE_SIZE)
// ) acq_ip_top_wrapper_inst(
    // .bus_clk         (bus_sl[1].clk),
    // .bus_addr        (bus_sl[1].addr),
    // .bus_wdata       (bus_sl[1].wdata),
    // .bus_rdata       (bus_sl[1].rdata),
    // .bus_rvalid      (bus_sl[1].rvalid),
    // .bus_wr          (bus_sl[1].wr),
    // .bus_rd          (bus_sl[1].rd),
    // .adc_data        (adc.data),
    // .adc_clk         (adc.clk),
    // .adc_valid       (adc.valid),
    // .core_clk        (core_clk),
    // .facq_time_pulse (),
    // .epoch_pulse     (epoch_pulse),
    // .we_IQ           (PS.CONTROL.RECORD_START),
    // .time_in         (T)
// );

// localparam FACQSIZE = `ACQ_IP_FULL_SIZE;
acq_IP#(
    .BASEADDR   (BASEFACQ),
    .BRAM_DEPTH (BRAM_DEPTH),
    .CORE_SIZE  (CORE_SIZE)
) acq_IP_inst(
    .adc             (adc),
    .bus_master      (bus_sl[1]),
    .core_clk        (core_clk),
    .we_IQ           (PS.CONTROL.RECORD_START),
    // .we_IQ           (record_en),
    .epoch           (epoch_pulse),
    .facq_time_pulse (),
    .time_in         (T)
);

endmodule