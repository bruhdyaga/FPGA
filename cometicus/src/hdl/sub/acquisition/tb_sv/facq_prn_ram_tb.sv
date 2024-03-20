`timescale 1ns/10ps

`include "global_param.v"

`define prn_clk 166.35787  // MHz
`define aclk 100    // MHz

module facq_prn_ram_tb();

localparam BASEADDR    = 0;
localparam RAM_LENGTH  = 10230;
localparam RAM_DEPTH = (RAM_LENGTH - 1)/`AXI_GP_WIDTH + 1; // глубина памяти в словах
localparam FREQ_DIV = 4;

logic prn_clk = 1;
logic aclk = 1;
logic [15:0] prn_cntr = '0;
logic shift = '0;
logic clr   = '0;

logic [RAM_LENGTH-1:0] prn_in; // тестовая исходная ПСП

always #((1000/`prn_clk)/2) prn_clk <= !prn_clk;
always #((1000/`aclk)/2)    aclk    <= !aclk;

intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH-2)
)bus();

initial begin
    for(integer i = 0; i < RAM_LENGTH; i ++) begin
        prn_in[i] <= $random;
    end
end

initial begin
    @(posedge aclk)
    @(posedge aclk)
    bus.writeReg(0,1,(1<<31) | ((RAM_LENGTH - 1) & {14{1'b1}}));
    #100
    @(posedge prn_clk)
    clr <= '1;
    @(posedge prn_clk)
    clr <= '0;
    @(posedge prn_clk)
    
    for(integer i = 0; i < RAM_DEPTH; i ++) begin
        @(posedge prn_clk)
        bus.writeReg(0,2,(prn_in >> (32*i)) & 32'hFFFFFFFF);
    end
    
    @(posedge prn_clk)
    @(posedge prn_clk)
    shift <= 1'b1;
end

assign bus.clk = aclk;

facq_prn_ram#(
    .BASEADDR  (BASEADDR),
    .RAM_SIZE  (10230)
) FACQ_PRN_RAM(
    .bus      (bus),
    .clk      (prn_clk),
    .freq_div (FREQ_DIV),
    .shift    (shift),
    .clr      (clr),
    .prn      (prn),
    .valid    (valid)
);

logic [1:0] div_cntr = '0;
always_ff@(posedge prn_clk)
if(valid) begin
    if(div_cntr == (FREQ_DIV - 1))
        div_cntr <= '0;
    else
        div_cntr <= div_cntr + 1'b1;
end

always_ff@(posedge prn_clk)
if(valid) begin
    if(div_cntr == (FREQ_DIV - 1))
        if(prn_cntr == (RAM_LENGTH - 1))
            prn_cntr <= '0;
        else
            prn_cntr <= prn_cntr + 1'b1;
end

always_ff@(posedge prn_clk)
if(valid) begin
    if(prn != prn_in[prn_cntr]) begin
        $display("error in PRN [%d], prn_d = %d, prn_in = %d", prn_cntr, prn, prn_in[prn_cntr]);
        $exit;
    end
end

endmodule