`include "null_former.svh"

module null_former_ch
#(
    parameter  BASEADDR  = 0,
    localparam FIR_WIDTH = `CRPA_C_WIDTH + `CRPA_D_WIDTH - 1 + $clog2(`CRPA_NT)
)
(
    adc_interf.slave              data_in,
    intbus_interf.slave           bus,
    input                         ce,
    adc_interf.master             data_out,
    input                         coef_mirr,
    input [7:0]                   null_div
);

localparam WIDTH_COEF = `CRPA_C_WIDTH;
`include "fir.svh"

localparam NBUSES = `CRPA_NCH;
intbus_interf bus_sl[NBUSES]();

// array of interfaces to each FIR
adc_interf#(
    .PORTS (1),
    .R     (`CRPA_D_WIDTH)
)data_to_fir[`CRPA_NCH-1:0]();

adc_interf#(
    .PORTS (1),
    .R     (FIR_WIDTH)
)fir_out[`CRPA_NCH-1:0]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

wire [FIR_WIDTH-1:0] fir_data [`CRPA_NCH-1:0];

localparam FIR_BASE_ADDR = BASEADDR + `HUBSIZE;
for(genvar ch = 0; ch < `CRPA_NCH; ch ++) begin: CH
    assign data_to_fir[ch].clk     = data_in.clk;
    assign data_to_fir[ch].data[0] = data_in.data[ch];
    assign data_to_fir[ch].valid   = data_in.valid;
    
    fir#( // FIR из DSP
        .BASEADDR      (FIR_BASE_ADDR + `FIR_FULL_SIZE*ch),
        .WIDTH_IN_DATA (`CRPA_D_WIDTH),
        .WIDTH_COEF    (WIDTH_COEF),
        .ORDER         (`CRPA_NT-1),
        .NCH           (1),
        .SYN_COEF      (1)
    )FIR (
        .bus       (bus_sl[ch]),
        .in        (data_to_fir[ch]),
        .out       (fir_out[ch]),
        .coef_mirr (coef_mirr)
    );
    assign fir_data[ch] = fir_out[ch].data[0];
end

localparam SUM_OUT_WIDTH     = FIR_WIDTH + $clog2(`CRPA_NCH);
localparam SUM_OUT_CUT_WIDTH = SUM_OUT_WIDTH - (`CRPA_C_WIDTH - 1 + $clog2(`CRPA_NT));
wire signed [SUM_OUT_WIDTH-1:0]     sum_out;
wire signed [SUM_OUT_CUT_WIDTH-1:0] sum_out_cut;
piped_adder #( // ПОТОМ ЗАМЕНИТЬ НА DSP!!!!!
    .N_args    (`CRPA_NCH),
    .arg_width (FIR_WIDTH)
)FIR_summ (
    .clk       (data_in.clk),
    .args_in   ({>>{fir_data}}),
    .sum_out   (sum_out),
    .we        (ce & fir_out[0].valid),
    .valid     (fir_sum_valid)
);

assign sum_out_cut = sum_out >>> null_div;

lim_qnt#(
    .in_width  (SUM_OUT_CUT_WIDTH),
    .out_width (`CRPA_D_WIDTH)
)LIM_QNT (
    .clk   (data_in.clk),
    .WE    (fir_sum_valid),
    .valid (lim_valid),
    .in    (sum_out_cut),
    .out   (data_out.data[0])
);

assign data_out.clk    = data_in.clk;
assign data_out.valid  = lim_valid;

endmodule