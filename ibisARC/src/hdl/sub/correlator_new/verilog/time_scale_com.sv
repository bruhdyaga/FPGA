`include "time_scale_com.svh"
`include "global_param.v"

module time_scale_com
#(
    parameter BASEADDR     = 0
)
(
    intbus_interf.slave bus,          // CPU bus bus,
    input      clk,                   // RF clk
    input      trig_facq,
    input      trig_pps,
    output     epoch_pulse,
    output     sec_pulse,
    input      fix_pulse,
    output reg pps_out,
    output     TIME_SCALE_COM_STRUCT time_out
);


// The system timescale data structure definition
TIME_SCALE_COM_STRUCT PL;              // The registers to read from the CPU
TIME_SCALE_COM_STRUCT PS;              // The registers to write by the CPU
TIME_SCALE_COM_STRUCT T;               // Registers to use in time generator

assign time_out = T;

//Define which bits will be pulsed
localparam NPULSE = 3;
localparam integer PULSE [NPULSE][2] = '{
    '{0,  0}, // do_rqst_int
    '{0,  1}, // eph_rqst_int
    '{8, 31} // trig_pps_clean_int // если иззменится структура time/time_com - изменится регистр 8
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`TIME_SCALE_COM_ID_CONST),
    .DATATYPE (TIME_SCALE_COM_STRUCT),
    .OUTFF    ("n"),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  ({trig_pps_clean, eph_rqst, do_rqst}),
    .wr     (),
    .rd     ()
);

assign PL.TM_CH.PHASE                      = '0;
assign PL.TM_CH.CODE_RATE                  = '0;
assign PL.TM_CH.CHIP_EPOCH.RESERVED        = '0;
assign PL.TM_CH.RESERVED_SEC               = '0;
assign PL.TM_CH.CHIP_EPOCH_MAX             = '0;
assign PL.TM_TRIG_FACQ.RESERVED_SEC        = '0;
assign PL.TM_TRIG_FACQ.CHIP_EPOCH.RESERVED = '0;
assign PL.TM_TRIG_FACQ.TRIG                = '0;
assign PL.TM_TRIG_PPS.RESERVED_SEC         = '0;
assign PL.TM_TRIG_PPS.CHIP_EPOCH.RESERVED  = '0;
assign PL.PPS_CFG                          = '0;

assign T.TM_CH.CODE_RATE                   = '0;
assign T.TM_TRIG_FACQ                      = '0;
assign T.TM_TRIG_PPS                       = '0;
assign T.PPS_CFG                           = '0;

wire eph_apply;
wire apply;

reg eph_set;

always_ff@(posedge clk) begin
    if(eph_rqst == '1)
        eph_set <= '1;
    else if(epoch_pulse == '1)
        eph_set <= '0;
end

assign eph_apply = epoch_pulse & eph_set;
assign apply = do_rqst | eph_apply;

// Chip accumulator
assign epoch_pulse = T.TM_CH.CHIP_EPOCH.CHIP == T.TM_CH.CHIP_EPOCH_MAX.CHIP_MAX;

always_ff@(posedge clk) begin
    if(apply) begin
        T.TM_CH.CHIP_EPOCH.CHIP <= PS.TM_CH.CHIP_EPOCH.CHIP;
    end
    else if(epoch_pulse) begin
        T.TM_CH.CHIP_EPOCH.CHIP <= '0;
    end
    else begin
        T.TM_CH.CHIP_EPOCH.CHIP <= T.TM_CH.CHIP_EPOCH.CHIP + 1'b1;
    end
    
    T.TM_CH.CHIP_EPOCH.RESERVED <= '0;
end

// Epoch counter
assign sec_pulse = (T.TM_CH.CHIP_EPOCH.EPOCH == T.TM_CH.CHIP_EPOCH_MAX.EPOCH_MAX) & epoch_pulse;

always_ff@(posedge clk) begin
    if(apply) begin
        T.TM_CH.CHIP_EPOCH.EPOCH <= PS.TM_CH.CHIP_EPOCH.EPOCH;
    end
    else if(sec_pulse) begin
        T.TM_CH.CHIP_EPOCH.EPOCH <= '0;
    end
    else if(epoch_pulse) begin
        T.TM_CH.CHIP_EPOCH.EPOCH <= T.TM_CH.CHIP_EPOCH.EPOCH + 1'b1;
    end
end

assign week_pulse = (T.TM_CH.SEC == (`SEC_IN_WEEK - 1)) & sec_pulse;

// Seconds counter
always_ff@(posedge clk) begin
    if(apply) begin
        T.TM_CH.SEC <= PS.TM_CH.SEC;
    end else begin
        if(week_pulse) begin
            T.TM_CH.SEC <= '0;
        end else begin
            if(sec_pulse) begin
                T.TM_CH.SEC <= T.TM_CH.SEC + 1'b1;
            end
        end
    end
    
    T.TM_CH.RESERVED_SEC <= '0;
end

// === Registers update ===
always_ff@(posedge clk) begin
    if(apply) begin
        T.TM_CH.CHIP_EPOCH_MAX.CHIP_MAX  <= PS.TM_CH.CHIP_EPOCH_MAX.CHIP_MAX ;
        T.TM_CH.CHIP_EPOCH_MAX.EPOCH_MAX <= PS.TM_CH.CHIP_EPOCH_MAX.EPOCH_MAX;
    end
    
    T.TM_CH.CHIP_EPOCH_MAX.CHIP_MAX_RESERVED <= '0;
end

always_ff@(posedge clk) begin
    if(fix_pulse) begin
        PL.TM_CH.CHIP_EPOCH.EPOCH <= T.TM_CH.CHIP_EPOCH.EPOCH;
        PL.TM_CH.CHIP_EPOCH.CHIP  <= T.TM_CH.CHIP_EPOCH.CHIP;
        PL.TM_CH.SEC              <= T.TM_CH.SEC;
    end
end

always_ff@(posedge clk) begin
    if(trig_facq) begin
        PL.TM_TRIG_FACQ.CHIP_EPOCH.EPOCH <= T.TM_CH.CHIP_EPOCH.EPOCH;
        PL.TM_TRIG_FACQ.CHIP_EPOCH.CHIP  <= T.TM_CH.CHIP_EPOCH.CHIP;
        PL.TM_TRIG_FACQ.SEC              <= T.TM_CH.SEC;
    end
end

always_ff@(posedge clk) begin
    if(trig_pps) begin
        PL.TM_TRIG_PPS.CHIP_EPOCH.EPOCH <= T.TM_CH.CHIP_EPOCH.EPOCH;
        PL.TM_TRIG_PPS.CHIP_EPOCH.CHIP  <= T.TM_CH.CHIP_EPOCH.CHIP;
        PL.TM_TRIG_PPS.SEC              <= T.TM_CH.SEC;
    end
end

always_ff@(posedge clk) begin
    if(trig_pps_clean) begin
        PL.TM_TRIG_PPS.TRIG <= '0;
    end else if(trig_pps) begin
        PL.TM_TRIG_PPS.TRIG <= '1;
    end
end

// === PPS output ===
reg   [6:0]  epch_cntr;    // счетчик эпох задает длительность PPS
reg   [26:0] pps_dly_cntr; // счетчик для задержки PPS внутри секунды
reg   [9:0]  pps_10_cntr;  // счетчик для 10us PPS
logic [6:0]  pps_len_asy;  // длительность PPS в эпохах
logic [6:0]  pps_len;


assign rst_pps = (pps_len == 0) ? pps_10_cntr == '1 : epch_cntr == pps_len;



always_ff@(posedge clk) begin
    if(sec_pulse) begin
        pps_dly_cntr <= '0;
    end else begin
        pps_dly_cntr <= pps_dly_cntr + 1'b1;
    end
end

assign pps_dly_asy = pps_dly_cntr == PS.PPS_CFG.DLY;

level_sync PPS_DLY_SYNC(
    .clk     (clk),
    .async   (pps_dly_asy),
    .sync    (pps_dly)
);

always_comb begin
case(PS.PPS_CFG.LEN)
    0:       pps_len_asy <= 'd0;
    1:       pps_len_asy <= 'd3;
    2:       pps_len_asy <= 'd7;
    3:       pps_len_asy <= 'd15;
    4:       pps_len_asy <= 'd31;
    5:       pps_len_asy <= 'd63;
    6:       pps_len_asy <= 'd127;
    default: pps_len_asy <= 'd3;
endcase
end

level_sync#(
    .WIDTH   (7)
) PPS_LEN_SYNC(
    .clk     (clk),
    .async   (pps_len_asy),
    .sync    (pps_len)
);

always_ff@(posedge clk) begin
    if(pps_dly) begin
        pps_10_cntr  <= '0;
    end else if(pps_10_cntr != '1) begin
        pps_10_cntr <= pps_10_cntr + 1'b1;
    end
end

always_ff@(posedge clk) begin
    if(pps_dly) begin
        epch_cntr <= '0;
    end else if(epoch_pulse & (epch_cntr != '1)) begin
        epch_cntr <= epch_cntr + 1'b1;
    end
end

always_ff@(posedge clk) begin
    if(pps_dly) begin
        pps_out <= '1;
    end else if(rst_pps) begin
        pps_out <= '0;
    end
end

endmodule
