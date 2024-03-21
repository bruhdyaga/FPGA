`include "adc_interconnect.svh"

module adc_interconnect
#(
    parameter BASEADDR  = 0,
    parameter WIDTH     = 0,
    parameter IN_SIZE   = 1,
    parameter OUT_SIZE  = 1,
    parameter IN_BUSES  = 1,
    parameter OUT_BUSES = 1,
    parameter OUT_FF    = 0
)
(
    intbus_interf.slave bus,
    adc_interf.slave    adc_in[IN_BUSES],
    adc_interf.master   adc_out[OUT_BUSES]
);

adc_interf#(
    .PORTS (IN_SIZE*IN_BUSES),
    .R     (WIDTH)
)in_flat ();

adc_interf#(
    .PORTS (OUT_SIZE*OUT_BUSES),
    .R     (WIDTH)
)out_flat ();

// The generator data structure definition
ADC_INTERCONNECT_STRUCT PL;     // The registers from logic
ADC_INTERCONNECT_STRUCT PS;     // The registers from CPU

wire [`ADC_INTERCONNECT_SIZE-1:0] bus_wr;

regs_file#(
    .BASEADDR  (BASEADDR),
    .ID        (`ADC_INTERCONNECT_ID_CONST),
    .DATATYPE  (ADC_INTERCONNECT_STRUCT)
)RF (
    .clk    (),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (),
    .wr     (bus_wr),
    .rd     ()
);

assign PL.CFG.MUX        = '0;
assign PL.CFG.ADDR       = '0;
assign PL.CFG.IN_SIZE    = IN_SIZE*IN_BUSES;
assign PL.CFG.OUT_SIZE   = OUT_SIZE*OUT_BUSES;

assign in_flat.clk    = adc_in[0].clk;
assign in_flat.valid  = adc_in[0].valid;
for(genvar i = 0; i < IN_BUSES; i = i + 1) begin
    for(genvar j = 0; j < IN_SIZE; j= j + 1) begin
        assign in_flat.data[i*IN_SIZE + j] = adc_in[i].data[j]; // склеиваем набор входных шин в плоский массив
    end
end

assign out_flat.clk    = in_flat.clk;

for(genvar i = 0; i < OUT_BUSES; i = i + 1) begin
    assign adc_out[i].clk    = out_flat.clk;
    assign adc_out[i].valid  = out_flat.valid;
    for(genvar j = 0; j < OUT_SIZE; j= j + 1) begin
        assign adc_out[i].data[j] = out_flat.data[i*OUT_SIZE + j]; // разворачиваем набор выходных шин
    end
end


reg [7:0] mux_reg [OUT_SIZE*OUT_BUSES-1:0];
reg bus_wr_pl;

always_ff@(posedge bus.clk) begin
    bus_wr_pl <= bus_wr[0];
end

generate
    if(OUT_FF) begin
    always_ff@(posedge in_flat.clk) begin
            out_flat.valid   <= in_flat.valid;
        end
    end else begin
        always_comb begin
            out_flat.valid   <= in_flat.valid;
        end
    end
    
    for(genvar i = 0; i < OUT_SIZE*OUT_BUSES; i = i + 1) begin
        if(OUT_FF) begin
            always_ff@(posedge in_flat.clk) begin
                out_flat.data[i] <= in_flat.data[mux_reg[i]];
            end
        end else begin
            always_comb begin
                out_flat.data[i] <= in_flat.data[mux_reg[i]];
            end
        end
        
        always_ff@(posedge bus.clk)
        if(bus_wr_pl & (PS.CFG.ADDR == i)) begin
            mux_reg[i] <= PS.CFG.MUX;
        end
    end
endgenerate

endmodule