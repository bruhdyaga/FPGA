`timescale 1ns/10ps

`include "global_param.v"

`define prn_clk 150  // MHz
`define aclk 100    // MHz

module prn_gen_tb();

localparam BASEADDR    = 0;

logic prn_clk = 1;
logic aclk = 1;
logic prn_rd = 0;
logic PN [10230*2-1:0] = '{default:'0};
logic [15:0] prn_cntr = '0;
logic update = '0;

always #((1000/`prn_clk)/2) prn_clk <= !prn_clk;
always #((1000/`aclk)/2)    aclk    <= !aclk;

intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH-2)
)bus();

initial begin
    @(posedge aclk)
    @(posedge aclk)
    bus.writeReg(0,1,14'h1FFF | (14'h4EA << 14) | (1 << 28));
    @(posedge aclk)
    bus.writeReg(0,2,14'h1B00 | (14'h18ED << 14));
    @(posedge aclk)
    bus.writeReg(0,3,14'h1000 | (14'h1000 << 14));
    @(posedge aclk)
    bus.writeReg(0,4,10229);
    @(posedge aclk)
    update <= '1;
    @(posedge aclk)
    update <= '0;
    #100
    @(posedge prn_clk)
    @(negedge prn_clk)
    prn_rd <= 1'b1;
end

assign bus.clk = aclk;

logic [31:0] data;
// assign prn = $signed(data[15:0]) > 0;
// prn_gen_facq#(
    // .BASEADDR  (0),
    // .SCALE     (2048)  // масштаб выходного сигнала
// ) prn_gen_facq_inst(
    // .bus     (bus),
    // .prn_clk (prn_clk),
    // .prn_rd  (prn_rd),
    // .data    (data),
    // .valid   (valid)
// );

prn_gen prn_gen_inst(
    .bus      (bus),
    .clk      (prn_clk),
    .sr_shift (prn_rd),
    .phase_hi ('0),
    .update   (update),
    .code_out (prn),
    .mask     ()
);

logic valid;
always_ff@(posedge prn_clk) begin
    valid <= prn_rd;
end

always_ff@(posedge prn_clk)
if(valid) begin
    PN[prn_cntr] <= prn;
    prn_cntr     <= prn_cntr + 1'b1;
end

endmodule