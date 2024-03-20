`timescale 1ns/10ps
// `include "data_collector_tb.svh"

module data_collector_tb();

`define aclk_freq     83  // MHz
`define pclk_freq     125 // MHz

localparam BASE_ADDR = 32'h40000000;
localparam NUM_PORTS = 2;
localparam DATA_WIDTH = 8;


reg  aclk  = 1;
reg  pclk  = 1;
wire presetn;
reg  aresetn = 1;
// reg  done = 0;

logic [31:0] rdata;

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;
always #((1000/`pclk_freq)/2)     pclk     <= !pclk;

axi3_interface axi3();
intbus_interf  bus();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

initial begin
    @ (negedge aclk)
      aresetn = 0;
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
      aresetn = 1;
end

level_sync presetn_inst(
    .clk     (pclk),
    .reset_n (aresetn),
    .async   (aresetn),
    .sync    (presetn)
);

reg [DATA_WIDTH-1:0] cntr [NUM_PORTS-1:0];

for(genvar i = 0; i < NUM_PORTS; i ++) begin
    always@(posedge pclk or negedge presetn)
    if(presetn == '0) begin
        cntr[i] <= '0;
    end else begin
        cntr[i] <= cntr[i] + 1'b1 + i;
    end
end

data_collector#(
    .BASEADDR       (BASE_ADDR/4),
    .NUM_PORTS      (NUM_PORTS),
    .DATA_WIDTH     (DATA_WIDTH),
    .DATA_DEPTH     (1024)
)
data_collector_inst(
    .clk        (pclk),
    .resetn     (presetn),
    .we         (1'b1),
    .data       ({>>{cntr}}),
    .bus        (bus)
);

endmodule