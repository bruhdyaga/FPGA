`timescale 1ns/10ps

`include "global_param.v"

module dsp_lut_iq_tb();

localparam IN_WIDTH  = 8;
localparam OUT_WIDTH = 7;

`define aclk_freq     100  // MHz
`define rf_clk_freq   125  // MHz

logic aclk     = 1;
logic rf_clk   = 1;
always #((1000/`aclk_freq)/2)     aclk     <= !aclk;
always #((1000/`rf_clk_freq)/2)   rf_clk   <= !rf_clk;

logic we;

axi3_interface  axi3();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

logic signed [IN_WIDTH -1:0] i_in = (1 << (IN_WIDTH - 1)) - 1;
logic signed [IN_WIDTH -1:0] q_in = (1 << (IN_WIDTH - 1)) - 1;
logic signed [OUT_WIDTH-1:0] i_out;
logic signed [OUT_WIDTH-1:0] q_out;

initial begin
we <= '0;
// #25000
    while(1) begin
        @(posedge rf_clk)
        we <= ! we;
    end
end

always_ff@(posedge rf_clk)
if(we) begin
    i_in <= i_in + 1'b1;
    q_in <= q_in + 1'b1;
    // i_in = -1*$signed(i_in);
    // q_in = -1*$signed(q_in);
end

logic data_valid;
always_ff@(posedge rf_clk)
data_valid <= we;


dsp_lut_iq#(
    .BASEADDR  (0),
    .IN_WIDTH  (IN_WIDTH),
    .OUT_WIDTH (OUT_WIDTH)
) dsp_lut_iq_inst(
    .bus   (bus),
    .clk   (rf_clk),
    .i_in  (i_in),
    .q_in  (q_in),
    .i_out (i_out),
    .q_out (q_out),
    .we    (data_valid),
    .valid (valid)
);

endmodule