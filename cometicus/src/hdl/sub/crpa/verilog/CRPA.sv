`include "crpa.svh"
`include "global_param.v"

module crpa
#(
    parameter BASEADDR          = 0,
    parameter CRPA_CH           = 1  // количество компенсаторов
)
(
    adc_interf.slave     data_in[CRPA_CH],
    adc_interf.master    data_out[CRPA_CH],
    adc_interf.master    data_out_full[CRPA_CH],
    intbus_interf.slave  bus,
    input                ce    // используется только для глобального отключения логики
);

localparam WIDTH_COEF = `CRPA_D_WIDTH;
`include "fir.svh"

localparam NBUSES = 3 + CRPA_CH `ifdef CRPA_HETERODYNE + CRPA_CH `endif `ifdef CRPA_UP_HETERODYNE + CRPA_CH `endif `ifdef CRPA_DATCOLL + CRPA_CH `endif;
intbus_interf bus_sl[NBUSES]();

adc_interf#(
    .PORTS (`CRPA_NCH),
    .R     (`CRPA_D_WIDTH)
)data_heterodyne_out [CRPA_CH]();

adc_interf#(
    .PORTS (`CRPA_NCH),
    .R     (`CRPA_D_WIDTH)
)data_cvm_mux [1]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

// The generator data structure definition
CRPA_STRUCT PL;     // The registers from logic
CRPA_STRUCT PS;     // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 2;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 31},// release_pulse
    '{1, 31} // div_wr_pule
};

localparam BASEREG = BASEADDR + `HUBSIZE;
regs_file#(
    .BASEADDR (BASEREG),
    .ID       (`CRPA_ID_CONST),
    .DATATYPE (CRPA_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (data_in[0].clk),
    .bus    (bus_sl[0]),
    .in     (PL),
    .out    (PS),
    .pulse  ({null_div_wr, null_coef_mirr}),
    .wr     (),
    .rd     ()
);

assign PL.CFG.NULL_COEF_MIRR    = '0;
assign PL.CFG.HETERODYNE_ENABLE = `ifdef CRPA_HETERODYNE 1 `else 0 `endif;
assign PL.CFG.CRPA_D_WIDTH      = `CRPA_D_WIDTH;
assign PL.CFG.CRPA_C_WIDTH      = `CRPA_C_WIDTH;
assign PL.CFG.CRPA_NCH          = `CRPA_NCH;
assign PL.CFG.CRPA_NT           = `CRPA_NT;
assign PL.CFG.CRPA_NNF          = `CRPA_NNF;
assign PL.CFG.CRPA_ACCUM_WIDTH  = `CRPA_ACCUM_WIDTH;
assign PL.CFG2.NULL_DIV_WR      = '0;
assign PL.CFG2.NULL_DIV_ADDR    = '0;
assign PL.CFG2.RESERVED         = '0;
assign PL.CFG2.CRPA_NUMB        = CRPA_CH;
assign PL.CFG2.NULL_DIV         = '0;

localparam CRPA_INTERCONNECT_BASE_ADDR = BASEREG + `CRPA_SIZE + `RWREGSSIZE;
// на входе мультиплексора CRPA_CH-шин (`CRPA_NCH каналов) под каждый CRPA, на выходе
//   одна-шина (`CRPA_NCH каналов) для одной CVM
adc_interconnect#(
    .BASEADDR  (CRPA_INTERCONNECT_BASE_ADDR),
    .WIDTH     (`CRPA_D_WIDTH),
    .IN_SIZE   (`CRPA_NCH),
    .OUT_SIZE  (`CRPA_NCH),
    .IN_BUSES  (CRPA_CH),
    .OUT_BUSES (1),
    .OUT_FF    (1)
) CRPA_ADC_INTERCONNECT(
    .bus     (bus_sl[1]),
    .adc_in  (data_heterodyne_out),
    .adc_out (data_cvm_mux)
);

localparam BASECVM = CRPA_INTERCONNECT_BASE_ADDR + `ADC_INTERCONNECT_FULL_SIZE;
cov_matrix#(
    .BASEADDR    (BASECVM)
)CVM (
    .data_in (data_cvm_mux[0]),
    .bus     (bus_sl[2]),
    .ce      (ce)
);

adc_interf#(
    .PORTS (`CRPA_NNF),
    .R     (`CRPA_D_WIDTH)
)null_out [CRPA_CH]();

localparam BASENULL = BASECVM + `COV_MATRIX_FULL_SIZE;
localparam NULL_BUS_NUM = 3;

`ifdef CRPA_UP_HETERODYNE
    adc_interf#(
        .PORTS (2),
        .R     (`CRPA_D_WIDTH)
    )data_heterodyne_up_out [CRPA_CH]();
    
    localparam HETERODYNE_UP_BASE_ADDR  = BASENULL + CRPA_CH*(`HUBSIZE + `CRPA_NNF*`NULL_FORMER_FULL_SIZE);
    localparam HETERODYNE_BASE_ADDR  = HETERODYNE_UP_BASE_ADDR + CRPA_CH*`HETERODYNE_FULL_SIZE;
    
    localparam HETERODYNE_UP_BUS_NUM = NULL_BUS_NUM + CRPA_CH;
    localparam HETERODYNE_BUS_NUM = HETERODYNE_UP_BUS_NUM + CRPA_CH;
`else
    localparam HETERODYNE_BASE_ADDR  = BASENULL + CRPA_CH*(`HUBSIZE + `CRPA_NNF*`NULL_FORMER_FULL_SIZE);
    localparam HETERODYNE_BUS_NUM = NULL_BUS_NUM + CRPA_CH;
`endif

reg [7:0] null_div [CRPA_CH-1:0];
for(genvar CRPA_NULL_CH=0; CRPA_NULL_CH < CRPA_CH; CRPA_NULL_CH ++) begin: CRPA_NULL_CH_i
    always_ff@(posedge data_in[0].clk)
    if(null_div_wr & (PS.CFG2.NULL_DIV_ADDR == CRPA_NULL_CH)) begin
        null_div[CRPA_NULL_CH] <= PS.CFG2.NULL_DIV;
    end
    
    null_former#(
        .BASEADDR  (BASENULL + CRPA_NULL_CH*(`HUBSIZE + `CRPA_NNF*`NULL_FORMER_FULL_SIZE))
    )null_former (
        .data_in   (data_heterodyne_out[CRPA_NULL_CH]),
        .bus       (bus_sl[NULL_BUS_NUM + CRPA_NULL_CH]),
        .ce        (ce),
        .data_out  (null_out[CRPA_NULL_CH]),
        .coef_mirr (null_coef_mirr),
        .null_div  (null_div[CRPA_NULL_CH])
    );
    
    `ifdef CRPA_UP_HETERODYNE
        heterodyne#(
            .BASEADDR    (HETERODYNE_UP_BASE_ADDR + CRPA_NULL_CH*`HETERODYNE_FULL_SIZE),
            .WIDTH_DATA  (`CRPA_D_WIDTH),
            .WIDTH_COEF  (WIDTH_COEF),
            .IQ_WIDTH    (IQ_WIDTH),
            .PHASE_WIDTH (PHASE_WIDTH),
            .ORDER_IN    (`HETERODYNE_UP_FIR_IN_ORDER),
            .ORDER_OUT   (`HETERODYNE_UP_FIR_OUT_ORDER),
            .NCH         (1) // входных каналов
        )HETERODYNE_UP (
            .bus (bus_sl[HETERODYNE_UP_BUS_NUM + CRPA_NULL_CH]),
            .in  (null_out[CRPA_NULL_CH]),
            .out (data_heterodyne_up_out[CRPA_NULL_CH])
        );
        assign data_out_full[CRPA_NULL_CH].clk     = data_heterodyne_up_out[CRPA_NULL_CH].clk;
        assign data_out_full[CRPA_NULL_CH].valid   = data_heterodyne_up_out[CRPA_NULL_CH].valid;
        assign data_out_full[CRPA_NULL_CH].data[0] = data_heterodyne_up_out[CRPA_NULL_CH].data[0];
    `else
        assign data_out_full[CRPA_NULL_CH].clk     = null_out[CRPA_NULL_CH].clk;
        assign data_out_full[CRPA_NULL_CH].valid   = null_out[CRPA_NULL_CH].valid;
        assign data_out_full[CRPA_NULL_CH].data[0] = null_out[CRPA_NULL_CH].data[0];
    `endif
    
    sig_mag_v3#(
        .WIDTH (`CRPA_D_WIDTH)
    ) sig_mag_v3_inst(
        .clk        (data_out_full[CRPA_NULL_CH*`CRPA_NNF].clk),
        .data_in    (data_out_full[CRPA_NULL_CH*`CRPA_NNF].data[0]),
        .we         (data_out_full[CRPA_NULL_CH*`CRPA_NNF].valid),
        .clr        ('0),
        .sig        (data_out[CRPA_NULL_CH].data[0][1]),
        .mag        (data_out[CRPA_NULL_CH].data[0][0]),
        .valid      (data_out[CRPA_NULL_CH].valid),
        .por_out    (),
        .por_in     ('0),
        .por_manual ('0)
    );
    
    assign data_out[CRPA_NULL_CH].clk    = null_out[0].clk;
end

`ifdef CRPA_HETERODYNE
localparam IQ_WIDTH       = 9;
localparam PHASE_WIDTH    = 10;

for(genvar HETERODYNE_CH=0; HETERODYNE_CH < CRPA_CH; HETERODYNE_CH ++) begin: HETERODYNE_i
    heterodyne#(
        .BASEADDR    (HETERODYNE_BASE_ADDR + HETERODYNE_CH*`HETERODYNE_FULL_SIZE),
        .WIDTH_DATA  (`CRPA_D_WIDTH),
        .WIDTH_COEF  (WIDTH_COEF),
        .IQ_WIDTH    (IQ_WIDTH),
        .PHASE_WIDTH (PHASE_WIDTH),
        .ORDER_IN    (`HETERODYNE_FIR_IN_ORDER),
        .ORDER_OUT   (`HETERODYNE_FIR_OUT_ORDER),
        .NCH         (`CRPA_ANT) // входных каналов
    )HETERODYNE (
        .bus (bus_sl[HETERODYNE_BUS_NUM + HETERODYNE_CH]),
        .in  (data_in[HETERODYNE_CH]),
        .out (data_heterodyne_out[HETERODYNE_CH])
    );
end

localparam DATCOL_CRPA_BASE_ADDR = HETERODYNE_BASE_ADDR + CRPA_CH*`HETERODYNE_FULL_SIZE;
localparam CRPA_DATCOLL_BUS_NUM  = HETERODYNE_BUS_NUM + CRPA_CH;
`else
localparam DATCOL_CRPA_BASE_ADDR = HETERODYNE_BASE_ADDR;
localparam CRPA_DATCOLL_BUS_NUM  = HETERODYNE_BUS_NUM;

adc_interconnect_bypass#(
    .NCH (CRPA_CH)
) adc_interconnect_bypass_inst(
    .adc_in  (data_in            ),
    .adc_out (data_heterodyne_out)
);
`endif

`ifdef CRPA_DATCOLL
for(genvar CRPA_DATCOLL_CH=0; CRPA_DATCOLL_CH < CRPA_CH; CRPA_DATCOLL_CH ++) begin: CRPA_DATCOLL_i
    data_collector#(
        .BASEADDR   (DATCOL_CRPA_BASE_ADDR + CRPA_DATCOLL_CH*`DATA_COLLECTOR_FULL_SIZE),
        .NUM_PORTS  (2),
        .DATA_WIDTH (`CRPA_D_WIDTH),
        .DATA_DEPTH (1_000)
    ) DATA_COLLECTOR_CRPA(
        .clk    (null_out[CRPA_DATCOLL_CH].clk),
        .we     (null_out[CRPA_DATCOLL_CH].valid),
        .data   ({null_out[CRPA_DATCOLL_CH].data[0], data_heterodyne_out[CRPA_DATCOLL_CH].data[0]}),
        .bus    (bus_sl[CRPA_DATCOLL_BUS_NUM + CRPA_DATCOLL_CH])
    );
end
`endif

endmodule
