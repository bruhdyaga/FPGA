`include "prn_gen.svh"
`include "global_param.v"

module prn_gen
#(
    parameter BASEADDR  = 0
)
(
    intbus_interf.slave bus,
    input  clk,
    input  sr_shift,
    input  [2:0] phase_hi,
    input  update,
    input  epoch_pulse,
    output logic code_out,
    output logic mask
);

reg [PRNSIZE-1:0]  sr1;
reg [PRNSIZE-1:0]  sr2;
reg [CNTRSIZE-1:0] prn_counter;
wire prn_reset;
wire gps_l5_reset;
wire sr1_xor;
wire sr2_xor;
wire sr1_out;
wire sr2_out;

// The generator data structure definition
PRN_GEN_STRUCT PS;     // The registers from CPU

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`PRN_GEN_ID_CONST),
    .DATATYPE (PRN_GEN_STRUCT),
    .OUTFF    ("n")
)RF (
    .clk    (clk),
    .bus    (bus),
    .in     ('0),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

//prn_counter
always_ff@(posedge clk) begin
    if(update | prn_reset) begin
        prn_counter <= '0;
    end
    else if(sr_shift == '1) begin
        prn_counter <= prn_counter + 1'b1;
    end
end

assign prn_reset = (prn_counter == PS.CNTR_LENGTH) & sr_shift;
assign gps_l5_reset = ((sr1 == GPS_L5_PATTERN) & PS.CODE_STATES.GPS_L5_EN) & sr_shift;

//First sfift register
always_ff@(posedge clk) begin
    if(update | prn_reset | gps_l5_reset) begin
        sr1 <= PS.CODE_STATES.CODE_STATE1;
    end
    else if(sr_shift == '1) begin
        sr1 <= {sr1[PRNSIZE-2:0],sr1_xor};
    end
end

assign sr2_fb = PS.CODE_STATES.SINGLE_SR ? sr1[PRNSIZE-1] : sr2_xor;

//Second shift register
always_ff@(posedge clk) begin
    if(update | prn_reset) begin
        sr2 <= PS.CODE_STATES.CODE_STATE2;
    end
    else if(sr_shift == '1) begin
        sr2 <= {sr2[PRNSIZE-2:0],sr2_fb};
    end
end

assign sr2_xor_fb = PS.CODE_STATES.SINGLE_SR ? sr2_xor : 1'b0;

assign sr1_xor = ^(PS.CODE_BITMASKS.CODE_BITMASK1         & sr1) ^ sr2_xor_fb;
assign sr2_xor = ^(PS.CODE_BITMASKS.CODE_BITMASK2         & sr2);
assign sr1_out = ^(PS.CODE_OUT_BITMASKS.CODE_OUT_BITMASK1 & sr1);
assign sr2_out = ^(PS.CODE_OUT_BITMASKS.CODE_OUT_BITMASK2 & sr2);

logic [2:0] phase_hi_reg;
logic boc_mod;
always_ff@(posedge clk)
case(PS.CODE_OUT_BITMASKS.BOC_MODE)
    2'd1    : boc_mod <= !phase_hi_reg[2];
    2'd2    : boc_mod <= !phase_hi_reg[1];
    2'd3    : boc_mod <= !phase_hi_reg[0];
    default : boc_mod <= '1;
endcase

logic code;
always_ff@(posedge clk) begin
    code <= sr1_out ^ sr2_out;
end

assign code_out = (boc_mod) ? code : !code;

// count PN codes
reg [3:0] sPNcnt;
reg       sTimeSlotMask = 1'b0;
always_ff@(posedge clk) begin
  // count PN repetition 
  if (update) sPNcnt <= '0;
  else begin
    if (prn_reset)   sPNcnt <= sPNcnt + 1'b1;
    if (epoch_pulse) sPNcnt <= '0;
  end
  // check time slot masks
  sTimeSlotMask <= 1'b0;
  if (PS.CNTR_TIME_SLOTS_EN) if (sPNcnt != PS.CNTR_TIME_SLOT_ACTIVE_NUM) sTimeSlotMask <= 1'b1;

end

always_ff@(posedge clk) begin
    phase_hi_reg <= phase_hi;
end

reg sTDMAmask = 1'b0;
always_ff@(posedge clk)
case(PS.CODE_BITMASKS.TDMA_MODE)
    'd1     : sTDMAmask <= !phase_hi_reg[2];
    'd2     : sTDMAmask <=  phase_hi_reg[2];
    default : sTDMAmask <= '0;
endcase
assign mask = sTimeSlotMask | sTDMAmask;

endmodule
