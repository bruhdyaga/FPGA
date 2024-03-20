`include "global_param.v"
`include "heterodyne.svh"

module heterodyne#(
    parameter BASEADDR    = 0,
    parameter WIDTH_DATA  = 0,
    parameter WIDTH_COEF  = 0,
    parameter IQ_WIDTH    = 0,
    parameter PHASE_WIDTH = 0,
    parameter ORDER_IN    = 0,
    parameter ORDER_OUT   = 0,
    parameter NCH         = 0
)
(
    intbus_interf.slave bus,
    adc_interf.slave    in,
    adc_interf.master   out
);

localparam FIR_CH       = NCH*2;
localparam FIR_IN_WIDTH = WIDTH_DATA + IQ_WIDTH - 1;

localparam NBUSES = 3 `ifdef HETERODYNE_DATCOLL  + 1 `endif `ifdef HETERODYNE_RECORDER + 1 `endif;
intbus_interf bus_sl[NBUSES]();
adc_interf#(
    .PORTS (NCH),
    .R     (WIDTH_DATA)
)input_fir();

adc_interf#(
    .PORTS (FIR_CH),
    .R     (FIR_IN_WIDTH)
)fir_in_IQ ();

adc_interf#(
    .PORTS (FIR_CH),
    .R     (FIR_IN_WIDTH)
)in_mux ();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

HETERODYNE_STRUCT PS;
HETERODYNE_STRUCT PL;

localparam BASE_REGFILE = BASEADDR + `HUBSIZE;
regs_file#(
    .BASEADDR (BASE_REGFILE),
    .ID       (`HETERODYNE_ID_CONST),
    .DATATYPE (HETERODYNE_STRUCT)
)RF (
    .clk           (),
    .bus           (bus_sl[0]),
    .in            (PL),
    .out           (PS),
    .pulse         (),
    .wr            (),
    .rd            ()
);

assign PL.CFG.RESERVED    = '0;
assign PL.CFG.RECORDER_EN = '0;
assign PL.CFG.PHASE_WIDTH = PHASE_WIDTH;
assign PL.CFG.IQ_WIDTH    = IQ_WIDTH;
assign PL.CODE            = '0;

assign in_mux.clk    = in.clk;

wire signed [IQ_WIDTH-1:0] sin;
wire signed [IQ_WIDTH-1:0] cos;
dds_iq_hd#(
    .IQ_WIDTH    (IQ_WIDTH),
    .PHASE_WIDTH (PHASE_WIDTH),
    .TABLE_NAME  ("dds_iq_hd_ph10_iq_9.txt")
)DDS_IQ_HD (
    .clk        (in.clk),
    .sin        (sin),
    .cos        (cos),
    .code       (PS.CODE),
    .phase_cntr ()
);

for(genvar i = 0; i < NCH; i ++) begin: GET_MUL
    always_ff@(posedge in.clk) begin
        fir_in_IQ.data[i]     <=  cos * $signed(input_fir.data[i]);
        fir_in_IQ.data[i+NCH] <= -sin * $signed(input_fir.data[i]);
    end
end
assign fir_in_IQ.clk    = in.clk;

always_ff@(posedge in.clk) begin
    fir_in_IQ.valid <= in.valid;
end

localparam FIR_IN_BASE_ADDR = BASE_REGFILE + `HETERODYNE_SIZE + `RWREGSSIZE;
fir#(
    .BASEADDR      (FIR_IN_BASE_ADDR),
    .WIDTH_IN_DATA (WIDTH_DATA),
    .WIDTH_COEF    (WIDTH_COEF),
    .ORDER         (ORDER_IN),
    .NCH           (NCH)
)FIR_IN (
    .bus       (bus_sl[1]),
    .in        (in),
    .out       (input_fir),
    .coef_mirr ('0)
);

localparam FIR_OUT_BASE_ADDR = FIR_IN_BASE_ADDR + `FIR_FULL_SIZE;
fir#(
    .BASEADDR      (FIR_OUT_BASE_ADDR),
    .WIDTH_IN_DATA (FIR_IN_WIDTH),
    .WIDTH_COEF    (WIDTH_COEF),
    .ORDER         (ORDER_OUT),
    .NCH           (FIR_CH)
)FIR_OUT (
    .bus       (bus_sl[2]),
    .in        (in_mux),
    .out       (out),
    .coef_mirr ('0)
);

`ifdef HETERODYNE_RECORDER
adc_interf#(
    .PORTS (FIR_CH),
    .R     (FIR_IN_WIDTH)
)recorder_data (); // рекордер

wire [FIR_CH*FIR_IN_WIDTH-1:0] recorder_data_flat;

assign in_mux.data  = PS.CFG.RECORDER_EN ? recorder_data.data  : fir_in_IQ.data;
assign in_mux.valid = PS.CFG.RECORDER_EN ? recorder_data.valid : fir_in_IQ.valid;

localparam RECORDER_BASE_ADDR = FIR_OUT_BASE_ADDR + `FIR_FULL_SIZE;
localparam DATA_COLL_BASE_ADDR = RECORDER_BASE_ADDR + `DATA_RECORDER_FULL_SIZE;
localparam DATACOLL_BUS_NUM = 4;
data_recorder#(
    .BASEADDR   (RECORDER_BASE_ADDR),
    .NUM_PORTS  (FIR_CH),
    .DATA_WIDTH (FIR_IN_WIDTH),
    .DATA_DEPTH (10_000),
    .RAM_TYPE   ("BLOCK") //"BLOCK" or "LUT"
)DATA_RECORDER (
    .clk    (in_mux.clk),
    .valid  (recorder_data.valid),
    .data   (recorder_data_flat),
    .bus    (bus_sl[3])
);

assign {>>{recorder_data.data}} = recorder_data_flat;
`else
assign in_mux.data  = fir_in_IQ.data;
assign in_mux.valid = fir_in_IQ.valid;

localparam DATA_COLL_BASE_ADDR = FIR_OUT_BASE_ADDR + `FIR_FULL_SIZE;
localparam DATACOLL_BUS_NUM = 3;
`endif

`ifdef HETERODYNE_DATCOLL
wire [NCH*WIDTH_DATA-1:0]    in_flat;
wire [FIR_CH*WIDTH_DATA-1:0] fir_IQ_out_flat;
assign in_flat         = {>>{input_fir.data}};
assign fir_IQ_out_flat = {>>{out.data}};

localparam DATCOLL_CH = FIR_CH + NCH;
data_collector#(
    .BASEADDR   (DATA_COLL_BASE_ADDR),
    .NUM_PORTS  (DATCOLL_CH),
    .DATA_WIDTH (WIDTH_DATA),
    .DATA_DEPTH (1_000)
) data_collector_inst(
    .clk    (out.clk),
    .we     (out.valid),
    .data   ({ fir_IQ_out_flat , in_flat }),
    .bus    (bus_sl[DATACOLL_BUS_NUM])
);
`endif

endmodule
