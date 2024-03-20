`include "null_former.svh"

module null_former
#(
    parameter  BASEADDR  = 0
)
(
    adc_interf.slave              data_in,
    intbus_interf.slave           bus,
    input                         ce,
    adc_interf.master             data_out,
    input                         coef_mirr,
    input [7:0]                   null_div
);

localparam NBUSES = `CRPA_NNF;
intbus_interf bus_sl[NBUSES]();

connectbus#(
    .BASEADDR   (BASEADDR),
    .N_BUSES    (NBUSES)
) connectbus_inst(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

adc_interf#(
    .PORTS (`CRPA_NCH),
    .R     (`CRPA_D_WIDTH)
)null_in [`CRPA_NNF]();

adc_interf#(
    .PORTS (1),
    .R     (`CRPA_D_WIDTH)
)null_out [`CRPA_NNF]();

for(genvar i=0; i < `CRPA_NNF; i ++) begin: NULL_i
    assign null_in[i].clk     = data_in.clk;
    assign null_in[i].valid   = data_in.valid;
    assign null_in[i].data    = data_in.data;
    
    null_former_ch#(
        .BASEADDR  (BASEADDR + `HUBSIZE + i*`NULL_FORMER_FULL_SIZE)
    )null_former_ch_inst (
        .data_in   (null_in[i]),
        .bus       (bus_sl[i]),
        .ce        (ce),
        .data_out  (null_out[i]),
        .coef_mirr (coef_mirr),
        .null_div  (null_div)
    );
    
    assign data_out.clk     = null_out[i].clk;
    assign data_out.valid   = null_out[i].valid;
    assign data_out.data[i] = null_out[i].data[0];
end

endmodule