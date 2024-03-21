module frequency_counter(
    resetn,  // глобальный ресет
    aclk,    // клоки шины
    ref_clk, // опорные клоки
    in_clk,  // измеряемые клоки
    rdata,
    rvalid,
    addr,
    rd
);

parameter FREQ_CNTR_BASE_ADDR = 0;// 4-byte
parameter ADDR_WIDTH          = 0;
parameter CHANNELS            = 0;// число измеряемых клоков
parameter FREQ_REF_HZ         = 0;// [Гц]; опорная частота

parameter PERIOD_MEAS = 24;
localparam DATA_WIDTH  = 32;

input  resetn;
input  aclk;
input  ref_clk;
input  [CHANNELS-1:0] in_clk;
output [31:0] rdata;
output rvalid;
input  [ADDR_WIDTH-1:0] addr;
input  rd;

reg  rvalid;
reg  [31:0] rdata;
reg  [31:0] rdata1;
reg  [31:0] rdata2 [CHANNELS-1:0];
reg  [31:0] rdata2_or [CHANNELS-1:0];
wire [31:0] rdata2_mux;
wire [CHANNELS-1:0] freq_rd;
wire id_rd;
wire chan_rd;
wire period_rd;
wire ref_rd;

reg  [DATA_WIDTH-1:0] cntr_chan [CHANNELS-1:0];
reg  [DATA_WIDTH-1:0] data_freq [CHANNELS-1:0];

`ifndef SYNTHESIS
    wire [63:0] freq_hz [CHANNELS-1:0];
`endif

reg  [PERIOD_MEAS-1:0] ref_cntr = 0; //дает референсный интервал времени, на нем считаем измеряемые клоки
wire [CHANNELS-1:0]  cntr_high_i;    //длинный сигнал в домене измеряемых клоков
wire [CHANNELS-1:0]  puls_ref;       //одноклоковый сигнал старт/стоп в домене измеряемых клоков


always@(posedge ref_clk)
if(ref_cntr == {PERIOD_MEAS{1'b1}})
    ref_cntr <= 0;
else
    ref_cntr <= ref_cntr + 1'b1;

genvar i;


generate
for(i=0;i<CHANNELS;i=i+1)
begin: loop_start_fl
    level_sync level_sync_cntr_high(
        .clk     (in_clk[i]),
        .reset_n (1'b1),
        .async   (ref_cntr[PERIOD_MEAS-1]),
        .sync    (cntr_high_i[i])
    );
    
    ed_det#(
        .TYPE      ("fal"),
        .RESET_POL ("NEG"),
        .FLIP_EN   (1)
    )
    ed_det_start_syn(
        .clk   (in_clk[i]),
        .reset (1'b1),
        .in    (cntr_high_i[i]),
        .out   (puls_ref[i])
    );
    
    always@(posedge in_clk[i])
    if(puls_ref[i])
        cntr_chan[i] <= 0;
    else
        cntr_chan[i] <= cntr_chan[i] + 1'b1;
    
    always@(posedge in_clk[i])
    if(puls_ref[i])
        data_freq[i] <= cntr_chan[i];
    
    assign id_rd      = (addr == FREQ_CNTR_BASE_ADDR + 0) & rd;
    assign chan_rd    = (addr == FREQ_CNTR_BASE_ADDR + 1) & rd;
    assign period_rd  = (addr == FREQ_CNTR_BASE_ADDR + 2) & rd;
    assign ref_rd     = (addr == FREQ_CNTR_BASE_ADDR + 3) & rd;
    assign freq_rd[i] = (addr == FREQ_CNTR_BASE_ADDR + 4 + i) & rd;
    
    `ifndef SYNTHESIS
        assign freq_hz[i] = FREQ_REF_HZ*data_freq[i]/(2**PERIOD_MEAS);
    `endif
end
endgenerate

generate
for(i=0;i<CHANNELS;i=i+1)
begin: loop_freq_rd
always@(*)
case(1'b1)
    freq_rd[i] : rdata2[i] <= data_freq[i];
    default    : rdata2[i] <= 0;
endcase
end
endgenerate

always@(*)
case(1'b1)
    id_rd     : rdata1 <= {((4 + CHANNELS) << 16) | 16'h1C40};
    chan_rd   : rdata1 <= CHANNELS;
    period_rd : rdata1 <= PERIOD_MEAS-1;
    ref_rd    : rdata1 <= FREQ_REF_HZ;
    default   : rdata1 <= 32'b0;
endcase

generate
for(i=0;i<CHANNELS-1;i=i+1)
begin: loop_rdata2_or
    always@(*)
        if(i==0)
            rdata2_or[0] = rdata2[0] | rdata2[1];
        else
            rdata2_or[i] = rdata2_or[i-1] | rdata2[i+1];
end
endgenerate

generate
if(CHANNELS==1)
    assign rdata2_mux = rdata2[0];
else
    assign rdata2_mux = rdata2_or[CHANNELS-2];
endgenerate

always@(posedge aclk or negedge resetn)
if(resetn == 0)
    rdata <= 0;
else
    rdata <= rdata1 | rdata2_mux;


always@(posedge aclk or negedge resetn)
if(resetn == 0)
    rvalid <= 0;
else
    rvalid <= id_rd | chan_rd | period_rd | ref_rd | (|freq_rd);

endmodule