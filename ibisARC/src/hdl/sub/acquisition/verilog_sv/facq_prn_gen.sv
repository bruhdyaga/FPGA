`include "facq_prn_gen.svh"

interface psp_gen_interface();

logic                     do_init;
logic [7:0]               freq_div;          // укоротить
logic [FACQ_PRNSIZE-1:0]  code_state1;       //
logic [FACQ_PRNSIZE-1:0]  code_reset_state1; //
logic [FACQ_PRNSIZE-1:0]  code_bitmask1;     //
logic [FACQ_PRNSIZE-1:0]  code_out_bitmask1; //
logic [FACQ_PRNSIZE-1:0]  code_state2;       //
logic [FACQ_PRNSIZE-1:0]  code_reset_state2; //
logic [FACQ_PRNSIZE-1:0]  code_bitmask2;     //
logic [FACQ_PRNSIZE-1:0]  code_out_bitmask2; //
logic [FACQ_PRNSIZE-1:0]  sr1;               //
logic [FACQ_PRNSIZE-1:0]  sr2;               //
logic [FACQ_CNTRSIZE-1:0] prn_length;        //
logic [FACQ_CNTRSIZE-1:0] prn_init;          //
logic [FACQ_CNTRSIZE-1:0] prn_counter;       //
logic                     psp_back_valid;
logic                     gps_l5_reset_en;
logic                     single_sr;
logic [19:0]              ovl;
logic [4:0]               ovl_length;
logic [4:0]               ovl_init;
logic [4:0]               ovl_cntr;

modport master
(
    input  do_init,
    input  freq_div,
    input  code_state1,
    input  code_reset_state1,
    input  code_bitmask1,
    input  code_out_bitmask1,
    input  code_state2,
    input  code_reset_state2,
    input  code_bitmask2,
    input  code_out_bitmask2,
    output sr1,
    output sr2,
    input  prn_length,
    input  prn_init,
    output prn_counter,
    input  gps_l5_reset_en,
    input  single_sr,
    input  ovl,
    input  ovl_length,
    input  ovl_init,
    output ovl_cntr
);

modport slave
(
    output do_init,
    output freq_div,
    output code_state1,
    output code_reset_state1,
    output code_bitmask1,
    output code_out_bitmask1,
    output code_state2,
    output code_reset_state2,
    output code_bitmask2,
    output code_out_bitmask2,
    input  sr1,
    input  sr2,
    output prn_length,
    output prn_init,
    input  prn_counter,
    output psp_back_valid,
    output gps_l5_reset_en,
    output single_sr,
    output ovl,
    output ovl_length,
    output ovl_init,
    input  ovl_cntr
);

endinterface

module facq_prn_gen
(
    input  clk,
    input  resetn,
    input  we,
    output psp_out_shift_reg,
    psp_gen_interface.master psp_gen_interface
);

logic [7:0] cntr = '0;
always_ff@(posedge clk or negedge resetn)
if(resetn == '0) begin
    cntr <= '0;
end else begin
    if(we) begin
        if(cntr == (psp_gen_interface.freq_div-1)) begin
            cntr <= '0;
        end else begin
            cntr <= cntr + 1'b1;
        end
    end else begin
        cntr <= '0;
    end
end

assign shift_en = (psp_gen_interface.freq_div == 1) ? we : we & (cntr == (psp_gen_interface.freq_div-1));

logic sr1_xor;
logic sr2_xor;

assign prn_reset = (psp_gen_interface.prn_counter == psp_gen_interface.prn_length) & shift_en;
assign gps_l5_reset = (psp_gen_interface.sr1[12:0] == FACQ_GPS_L5_PATTERN) & shift_en;

//prn_counter
always_ff@(posedge clk or negedge resetn) begin
    if(resetn == '0) begin
        psp_gen_interface.prn_counter <= '0;
    end else begin
        if(psp_gen_interface.do_init) begin
            psp_gen_interface.prn_counter <= psp_gen_interface.prn_init;
        end else if(prn_reset) begin
            psp_gen_interface.prn_counter <= '0;
        end else if(shift_en) begin
            psp_gen_interface.prn_counter <= psp_gen_interface.prn_counter + 1'b1;
        end
    end
end

//First shift register
always_ff@(posedge clk or negedge resetn) begin
    if(resetn == '0) begin
        psp_gen_interface.sr1 <= '0;
    end else begin
        if(psp_gen_interface.do_init) begin
            psp_gen_interface.sr1 <= psp_gen_interface.code_state1;
        end else if(prn_reset | (gps_l5_reset & psp_gen_interface.gps_l5_reset_en)) begin
            psp_gen_interface.sr1 <= psp_gen_interface.code_reset_state1;
        end else if(shift_en) begin
            psp_gen_interface.sr1 <= {psp_gen_interface.sr1[FACQ_PRNSIZE-2:0],sr1_xor};
        end
    end
end

assign sr2_fb = psp_gen_interface.single_sr ? psp_gen_interface.sr1[FACQ_PRNSIZE-1] : sr2_xor;

//Second shift register
always_ff@(posedge clk or negedge resetn) begin
    if(resetn == '0) begin
        psp_gen_interface.sr2 <= '0;
    end else begin
        if(psp_gen_interface.do_init) begin
            psp_gen_interface.sr2 <= psp_gen_interface.code_state2;
        end else if(prn_reset) begin
            psp_gen_interface.sr2 <= psp_gen_interface.code_reset_state2;
        end else if(shift_en) begin
            psp_gen_interface.sr2 <= {psp_gen_interface.sr2[FACQ_PRNSIZE-2:0],sr2_fb};
        end
    end
end

assign sr2_xor_fb = psp_gen_interface.single_sr ? sr2_xor : 1'b0;

always_ff@(posedge clk or negedge resetn) begin
    if(resetn == '0) begin
        psp_gen_interface.ovl_cntr <= '0;
    end else begin
        if(psp_gen_interface.do_init) begin
            psp_gen_interface.ovl_cntr <= psp_gen_interface.ovl_init;
        end else if(prn_reset) begin
            if(psp_gen_interface.ovl_cntr == psp_gen_interface.ovl_length) begin
                psp_gen_interface.ovl_cntr <= '0;
            end else begin
                psp_gen_interface.ovl_cntr <= psp_gen_interface.ovl_cntr + 1'b1;
            end
        end
    end
end

assign ovl = psp_gen_interface.ovl[psp_gen_interface.ovl_cntr];

assign sr1_xor = ^(psp_gen_interface.code_bitmask1     & psp_gen_interface.sr1) ^ sr2_xor_fb;
assign sr2_xor = ^(psp_gen_interface.code_bitmask2     & psp_gen_interface.sr2);
assign sr1_out = ^(psp_gen_interface.code_out_bitmask1 & psp_gen_interface.sr1);
assign sr2_out = ^(psp_gen_interface.code_out_bitmask2 & psp_gen_interface.sr2);
assign psp_out_shift_reg = (sr1_out ^ sr2_out) ^ ovl;

// debug
// PRBS (prn) sequences counter
logic [5:0] prbs_seq_cnt = '0;
always_ff@(posedge clk or negedge resetn) begin
  if(resetn == '0) begin
    prbs_seq_cnt <= '0;
  end else begin
    if(psp_gen_interface.do_init) begin
      // prbs_seq_cnt <= '0;
    end else if(prn_reset) begin
      prbs_seq_cnt <= prbs_seq_cnt + 1'b1;
    end
  end
end

endmodule
