`include "imitator_channel.svh"

module wiper(
    input                            clk,
    input                            epoch_pulse,
    input                            sec2_pulse,
    input  IMI_DATA_STRUCT           data,
    output                           data_symb
);

logic [IMI_SYMB_PER_PACK_WIDTH-1:0] imi_symb_per_pack_cntr = '0;
always_ff@(posedge clk) 
if(sec2_pulse == '1) begin
    imi_symb_per_pack_cntr <= '0;
end else if(epoch_pulse == '1) begin
    if(imi_symb_per_pack_cntr == (IMI_SYMB_PER_PACK - 1)) begin
        imi_symb_per_pack_cntr <= '0;
    end else begin
        imi_symb_per_pack_cntr <= imi_symb_per_pack_cntr + 1'b1;
    end
end

assign next_reg_pulse = ((imi_symb_per_pack_cntr == (IMI_SYMB_PER_PACK - 1)) & epoch_pulse) | sec2_pulse;

logic reg_mux = '0; // выбор регистра с данными
logic [IMI_SYMB_PER_PACK-1:0] slice_reg = '0;
always_ff@(posedge clk)
if(next_reg_pulse == '1) begin
    if((reg_mux == '0) | sec2_pulse) begin
        slice_reg <= data.DATA_0;
        reg_mux   <= '1;
    end else begin
        slice_reg <= data.DATA_1;
        reg_mux   <= '0;
    end
end else if(epoch_pulse == '1) begin
    slice_reg <= slice_reg >> 1;
end

assign data_symb = slice_reg[0];

endmodule
