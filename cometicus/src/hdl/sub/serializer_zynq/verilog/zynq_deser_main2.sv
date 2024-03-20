module zynq_deser_main2
#(
    parameter DESER_LINES = 1, // число линий LVDS с данными
    parameter S           = 8,
    parameter FRAME       = 8'hF0
)
(
    input                      clk, // continuous clock for io_reset
    input                      reset_deser,
    input                      ADC_DCO_P,
    input                      ADC_DCO_N,
    input                      ADC_FRM_P,
    input                      ADC_FRM_N,
    input  [DESER_LINES-1:0]   ADC_DAT_P,
    input  [DESER_LINES-1:0]   ADC_DAT_N,
    output                     clk_out,
    output [DESER_LINES*S-1:0] data_out,
    output                     dat_lock
);

reg  [1:0]   bs_cntr;
reg          bitslip;
wire [S-1:0] data_frm;

level_sync#(
    .INIT_STATE (1'b1),
    .WIDTH      (1)
) level_sync_clk_reset_inst(
    .clk     (clk),
    .reset_n (!reset_deser),
    .async   (reset_deser),
    .sync    (clk_reset)
);

reg [3:0] io_reset_cntr;
always_ff@(posedge clk)
if(clk_reset) begin
    io_reset_cntr <= '0;
end else begin
    if(io_reset_cntr != '1) begin
        io_reset_cntr <= io_reset_cntr + 1'b1;
    end
end
assign io_reset_asy = io_reset_cntr != '1;

level_sync#(
    .INIT_STATE (1'b1),
    .WIDTH      (1)
) level_sync_io_reset_inst(
    .clk     (clk_out),
    .reset_n (!io_reset_asy),
    .async   (io_reset_asy),
    .sync    (io_reset)
);

zynq_selectio_wiz#(
    .LINES      (DESER_LINES + 1), // 1 - FRAME
    .DATA_WIDTH (8)
) zynq_selectio_wiz_inst(
    .data_in_from_pins_p ({ADC_FRM_P,ADC_DAT_P}),
    .data_in_from_pins_n ({ADC_FRM_N,ADC_DAT_N}),
    .data_out            ({data_frm, data_out}),
    .bitslip             (bitslip),
    .clk_in_p            (ADC_DCO_P),
    .clk_in_n            (ADC_DCO_N),
    .gclk                (clk_out),
    .clk_reset           (clk_reset),
    .io_reset            (io_reset)
);

assign dat_lock = data_frm == FRAME;

always_ff@(posedge clk_out) begin
    if(!dat_lock) begin
        bs_cntr <= bs_cntr + 1'b1;
    end else begin
        bs_cntr <= '0;
    end
end

always_ff@(posedge clk_out) begin
    if(bs_cntr == '1) begin
        bitslip <= '1;
    end else begin
        bitslip <= '0;
    end
end

endmodule