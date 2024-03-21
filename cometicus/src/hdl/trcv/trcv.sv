`include "trcv.svh"
`include "global_param.v"

module trcv#(
    parameter BASEADDR        = 0,
    parameter ADC_PORTS       = 0
)
(
    intbus_interf.slave bus,
    adc_interf.slave    adc,
    imi_interf.master   imi,
    input               core_clk,
    output reg          fix_pulse,
    output              irq,
    input               pps_in,
    output              pps_out
);

localparam NBUSES = 3 + 
                    `ifdef FACQ        1 + `endif
                    `ifdef CALIBRATION 2 + `endif
                    `ifdef DATCOLL     1 + `endif
                    `ifdef IMITATOR    1 + `endif
                    `ifdef VITDEC      1 + `endif
                    `CORR_CHANNELS;

intbus_interf bus_sl[NBUSES]();

wire pps_pulse;
ed_det#(
    .TYPE      ("ris")
)
ED_DET_SEC(
    .clk   (adc.clk),
    .in    (pps_in),
    .out   (pps_pulse)
);

ed_det#(
    .TYPE      ("ris")
)ED_DET_IRQ_INST (
    .clk   (adc.clk),
    .in    (irq),
    .out   (irq_pulse)
);

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES),
    .OUTFF      ("y"),
    .MASTERFF   ("y")
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

// The generator data structure definition
TRCV_STRUCT PL;     // The registers from logic
TRCV_STRUCT PS;     // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 0}  // set_lock
};

localparam BASEREGFILE = BASEADDR + `HUBSIZE;
localparam BASEIRQ     = BASEREGFILE + `TRCV_SIZE + `RWREGSSIZE;
regs_file#(
    .BASEADDR (BASEREGFILE),
    .ID       (`TRCV_ID_CONST),
    .DATATYPE (TRCV_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (adc.clk),
    .bus    (bus_sl[0]),
    .in     (PL),
    .out    (PS),
    .pulse  (set_lock),
    .wr     (),
    .rd     ()
);

assign PL.CFG1.CORR_CH             = `CORR_CHANNELS;
assign PL.CFG1.N_INP               = N_INP;
assign PL.CFG1.DELAYS              = DELAYS;
assign PL.CFG1.DLY_LEN             = DLY_LEN;
assign PL.REV.R0                   = `REV_R0;
assign PL.REV.R1                   = `REV_R1;

always_ff@(posedge adc.clk) begin
    if(set_lock) begin
        PL.CFG1.LOCK <= '1;
    end
end

localparam BASETIME = BASEIRQ + `IRQ_CTRL_FULL_SIZE;
irq_ctrl#(
    .BASEADDR (BASEIRQ)
) IRQ(
    .bus    (bus_sl[1]),
    .clk    (adc.clk),
    .irq    (irq)
);

TIME_SCALE_COM_STRUCT TM;
wire facq_time_pulse;
localparam BASECORRCH = BASETIME + `TIME_SCALE_COM_FULL_SIZE;
wire pps_composite;
time_scale_com#(
    .BASEADDR     (BASETIME)
) TIME_SCALE_COM(
    .bus           (bus_sl[2]),
    .clk           (adc.clk),
    .trig_facq     (facq_time_pulse),
    .trig_pps      (`ifdef CALIBRATION pps_composite `else pps_pulse `endif),
    .epoch_pulse   (epoch_pulse),
    .sec_pulse     (sec_pulse),
    .fix_pulse     (fix_pulse),
    .pps_out       (pps_out),
    .time_out      (TM)
);

always_ff@(posedge adc.clk) begin
    fix_pulse <= epoch_pulse;
end

for(genvar ch=0; ch<`CORR_CHANNELS; ch++) begin: CORR_GEN
    corr_ch#(
        .BASEADDR   (BASECORRCH + ch * `CORR_CH_FULL_SIZE),
        .PRN_GEN    (1),
        .PRN_RAM    (1)
    ) CORR_CH(
        .bus           (bus_sl[3+ch]),
        .adc           (adc),
        .fix_pulse     (fix_pulse),
        .irq_pulse     (irq_pulse)
    );
end

localparam BASEFACQ = BASECORRCH + `CORR_CHANNELS * `CORR_CH_FULL_SIZE;
localparam BUS_FACQ = 3+`CORR_CHANNELS;

`ifdef FACQ
    acq_IP#(
        .BASEADDR   (BASEFACQ),
        .BRAM_DEPTH (`FACQ_MEM_SIZE),
        .CORE_SIZE  (`FACQ_SIZE)
    ) ACQ_IP(
        .adc             (adc),
        .bus_master      (bus_sl[BUS_FACQ]),
        .pps_in          (pps_pulse),
        .core_clk        (core_clk),
        .we_IQ           (1'b1),
        .epoch           (epoch_pulse),
        .facq_time_pulse (facq_time_pulse),
        .time_in         (TM)
    );
`else
    assign facq_time_pulse = '0;
`endif

localparam BUS_REFINTER = BUS_FACQ `ifdef FACQ + 1 `endif;

localparam BASEREFINT = BASEFACQ `ifdef FACQ + `ACQ_IP_FULL_SIZE `endif;
localparam BASECALIBR = BASEREFINT `ifdef CALIBRATION + `REFINTERP_FULL_SIZE `endif;

localparam BUS_CALIB = BUS_REFINTER `ifdef CALIBRATION + 1 `endif;

`ifdef CALIBRATION
    ref_in_interpretator #(
        .BASEADDR   (BASEREFINT),
        .NUM_ACCUM  (1)
    ) REFINTER (
        .bus            (bus_sl[BUS_REFINTER]),          // CPU bus (axi clk)
        .adc            (adc),          // ADC bus (pclk)
        .sec_pulse_ed   (pps_pulse),
        .intr_pulse     (),
        .debug          (),
        .out            (pps_composite)
    );
    
    calibration #(
        .BASEADDR   (BASECALIBR)
    ) CALIB (
        .bus            (bus_sl[BUS_CALIB]),
        .adc            (adc),
        .sec_pulse_ed   (sec_pulse)
    );
`endif

localparam BASEDATCOLL = BASECALIBR `ifdef CALIBRATION + `CALIBR_FULL_SIZE `endif;
localparam BUS_DATCOLL = BUS_CALIB `ifdef CALIBRATION + 1 `endif;

`ifdef DATCOLL
data_collector#(
    .BASEADDR   (BASEDATCOLL),
    .NUM_PORTS  (ADC_PORTS),
    .DATA_WIDTH (2),
    .DATA_DEPTH (1_000)
) DATA_COLLECTOR(
    .clk    (adc.clk),
    .we     ('1),
    .data   ({>>{adc.data}}),
    .bus    (bus_sl[BUS_DATCOLL])
);
`endif

localparam BASEIMI = BASEDATCOLL `ifdef DATCOLL + 13 `endif;
localparam BUS_IMI = BUS_DATCOLL `ifdef DATCOLL + 1  `endif;

`ifdef IMITATOR
    imitator#(
        .BASEADDR       (BASEIMI) // Начальный адрес (4-байтовая адресация)
    ) IMI(
        .clk           (adc.clk),
        .fix_pulse     (fix_pulse),
        .irq_pulse     (irq_pulse),
        .bus           (bus_sl[BUS_IMI]),
        .imi           (imi)
    );
`else
    assign imi.I  = '0;
    assign imi.Q  = '0;
    assign imi.In = '0;
    assign imi.Qn = '0;
`endif

localparam BASEVITDEC = BASEIMI `ifdef IMITATOR + `HUBSIZE + `RWREGSSIZE + `IMI_SIZE + `IMI_CHANNELS*`IMI_CHANNEL_FULL_SIZE + `LIM_CNTR_FULL_SIZE + `NORMALIZER_FULL_SIZE `endif;
localparam BUS_VITDEC = BUS_IMI `ifdef IMITATOR + 1  `endif;

`ifdef VITDEC
    vitdec#(
        .BASEADDR (BASEVITDEC)
    ) VITDEC(
        .bus    (bus_sl[BUS_VITDEC]),
        .clk    (bus_sl[BUS_VITDEC].clk)
    );
`endif

endmodule
