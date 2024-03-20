`include "global_param.v"
`include "time_scale_com.svh"

module acq_ip_top
#(
    localparam ADC_PORTS  = 4
)
(
    input                          bus_clk,
    input  [`AXI_GP_WIDTH - 1 : 0] bus_addr,
    input  [`AXI_GP_WIDTH - 1 : 0] bus_wdata,
    output [`AXI_GP_WIDTH - 1 : 0] bus_rdata,
    output                         bus_rvalid,
    input                          bus_wr,
    input                          bus_rd,
    
    input  [2*ADC_PORTS - 1 : 0 ]  adc_data,
    input                          adc_clk,
    input                          adc_valid,
    
    input                          core_clk,
    output                         facq_time_pulse,
    input                          epoch_pulse,
    input                          we_IQ,
    input  TIME_SCALE_COM_STRUCT   time_in
);

TIME_SCALE_COM_STRUCT TM;

intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
) bus();

adc_interf#(
    .PORTS (ADC_PORTS),
    .R     (2)
)adc ();

assign bus.clk    = bus_clk;
assign bus.addr   = bus_addr;
assign bus.wdata  = bus_wdata;
assign bus.wr     = bus_wr;
assign bus.rd     = bus_rd;
assign bus_rdata  = bus.rdata;
assign bus_rvalid = bus.rvalid;

assign {>>{adc.data}}  = adc_data;
assign adc.clk         = adc_clk;
assign adc.valid       = adc_valid;

acq_IP#(
    .BASEADDR   (0),
    .BRAM_DEPTH (204600*2),
    .CORE_SIZE  (256)
) acq_IP_inst(
    .adc             (adc),
    .bus_master      (bus),
    .core_clk        (core_clk),
    .we_IQ           (we_IQ),
    .epoch           (epoch_pulse),
    .facq_time_pulse (facq_time_pulse),
    .time_in         (time_in)
);


endmodule