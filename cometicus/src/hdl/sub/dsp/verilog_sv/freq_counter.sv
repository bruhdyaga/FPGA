module freq_counter
#(
    parameter                BASEADDR           = 0,  // 4-byte
    parameter                CHANNELS           = 0,  // число измеряемых клоков
    parameter                FREQ_REF_HZ        = 0,  // [Гц]; опорная частота
    parameter                MAX_FREQ           = 0,  // [Гц]; максимальная входная частота
    parameter                PERIOD_MS          = 10, // период измерения в [мс]
    parameter [7 : 0]        FREQ_ID [CHANNELS] = '{CHANNELS{0}},
    parameter [CHANNELS-1:0] PULSE_MODE         = 0
)
(
    intbus_interf.slave        bus,
    input logic                ref_clk, // опорные клоки
    input logic [CHANNELS-1:0] in_clk   // измеряемые клоки
);

localparam integer PERIOD_MEAS_ND = PERIOD_MS*FREQ_REF_HZ/1000 + 1;
localparam [15:0]  PERIOD_MEAS    = $clog2(PERIOD_MEAS_ND); // округление вверх
localparam [15:0]  DATA_WIDTH     = $clog2((2**PERIOD_MEAS)*(MAX_FREQ/FREQ_REF_HZ) + 1) + 1; // округление вверх

logic [31:0] rdata1;
logic [31:0] rdata2    [CHANNELS-1:0];
logic [31:0] rdata2_or [CHANNELS-1:0];
logic [CHANNELS-1:0] freq_rd;
logic id_rd;
logic chan_rd;
logic period_rd;
logic ref_rd;

logic [DATA_WIDTH-1:0] cntr_chan    [CHANNELS-1:0] = '{default:0};
logic [DATA_WIDTH-1:0] data_freq    [CHANNELS-1:0] = '{default:0};
logic [23:0]           data_freq_24 [CHANNELS-1:0];

`ifndef SYNTHESIS
    logic [63:0] freq_hz [CHANNELS-1:0];
`endif

logic [PERIOD_MEAS-1:0] ref_cntr     = '0; //дает референсный интервал времени, на нем считаем измеряемые клоки
logic                   ref_cntr_MSB_cdc;  // CDC for ref_cntr
logic [CHANNELS-1:0]    cntr_high_i;   //длинный сигнал в домене измеряемых клоков
logic [CHANNELS-1:0]    puls_ref;      //одноклоковый сигнал старт/стоп в домене измеряемых клоков
logic [CHANNELS-1:0]    puls_sync;     // измеряемый пульс в домене ref
logic [CHANNELS-1:0]    puls_sync_ed;


always_ff@(posedge ref_clk) begin
  ref_cntr         <= ref_cntr + 1'b1;
  ref_cntr_MSB_cdc <= ref_cntr[PERIOD_MEAS-1];
end

for(genvar i=0; i < CHANNELS; i ++)
begin: FREQ_CH
    if(~PULSE_MODE[i]) begin: CLK_MODE
        level_sync level_sync_cntr_high(
            .clk     (in_clk[i]),
            .async   (ref_cntr_MSB_cdc),
            .sync    (cntr_high_i[i])
        );
        
        ed_det#(
            .TYPE      ("fal"),
            .FLIP_EN   (1)
        )
        ed_det_start_syn(
            .clk   (in_clk[i]),
            .in    (cntr_high_i[i]),
            .out   (puls_ref[i])
        );
        
        always_ff@(posedge in_clk[i])
        if(puls_ref[i])
            cntr_chan[i] <= '0;
        else if(cntr_chan[i][DATA_WIDTH-1] != '1)
            cntr_chan[i] <= cntr_chan[i] + 1'b1;
        
        always_ff@(posedge in_clk[i])
        if(puls_ref[i])
            data_freq[i] <= cntr_chan[i];
    end else begin: PULSE_MODE
        ed_det#(
            .TYPE      ("fal"),
            .FLIP_EN   (1)
        )
        ed_det_start_syn_p(
            .clk   (ref_clk),
            .in    (ref_cntr[PERIOD_MEAS-1]),
            .out   (puls_ref[i])
        );
        
        reset_sync#(
            .RESET_POL ("POS")
        ) puls_sync_inst(
            .clk        (ref_clk),
            .resetn_in  (in_clk[i]),
            .resetn_out (puls_sync[i])
        );
        
        ed_det#(
            .TYPE      ("ris"),
            .FLIP_EN   (1)
        ) puls_sync_ed_inst(
            .clk   (ref_clk),
            .in    (puls_sync[i]),
            .out   (puls_sync_ed[i])
        );
        
        always_ff@(posedge ref_clk)
        if(puls_ref[i])
            cntr_chan[i] <= '0;
        else if(puls_sync_ed[i])
            cntr_chan[i] <= cntr_chan[i] + 1'b1;
        
        always_ff@(posedge ref_clk)
        if(puls_ref[i])
            data_freq[i] <= cntr_chan[i];
    end
    
    assign data_freq_24[i] = data_freq[i];
    assign freq_rd[i] = (bus.addr == BASEADDR + 4 + i) & bus.rd;
    
    `ifndef SYNTHESIS
        assign freq_hz[i] = FREQ_REF_HZ*data_freq[i]/(2**PERIOD_MEAS);
    `endif
    
    always_comb
    case(1'b1)
        freq_rd[i] : rdata2[i] <= {FREQ_ID[i],data_freq_24[i]};
        default    : rdata2[i] <= 0;
    endcase
    
    if(i == 0)
        assign rdata2_or[i] = rdata2[i];
    else
        assign rdata2_or[i] = rdata2[i] | rdata2_or[i-1];
end


assign id_rd      = (bus.addr == BASEADDR + 0) & bus.rd;
assign chan_rd    = (bus.addr == BASEADDR + 1) & bus.rd;
assign period_rd  = (bus.addr == BASEADDR + 2) & bus.rd;
assign ref_rd     = (bus.addr == BASEADDR + 3) & bus.rd;

always_comb
case(1'b1)
    id_rd     : rdata1 <= {((4 + CHANNELS) << 16) | 16'h1C40};
    chan_rd   : rdata1 <= CHANNELS;
    period_rd : rdata1 <= {DATA_WIDTH,PERIOD_MEAS};
    ref_rd    : rdata1 <= FREQ_REF_HZ;
    default   : rdata1 <= 32'b0;
endcase

always_ff@(posedge bus.clk) begin
    bus.rdata <= rdata1 | rdata2_or[CHANNELS-1];
end

always_ff@(posedge bus.clk) begin
    bus.rvalid <= id_rd | chan_rd | period_rd | ref_rd | (|freq_rd);
end

endmodule