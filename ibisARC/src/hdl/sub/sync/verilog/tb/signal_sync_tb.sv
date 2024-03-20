`timescale 1ns/10ps

module signal_sync_tb();

localparam SCLK_FREQ    = 59e6; //MHz
localparam DCLK_FREQ    = 105.6e6; //MHz

reg sclk = 1;
reg dclk = 1;
reg start = 0;
wire ready;

always #(1e9/SCLK_FREQ/2) sclk  = !sclk;
always #(1e9/DCLK_FREQ/2) dclk  = !dclk;

initial begin
@(posedge sclk)
start <= 1'b1;
@(posedge sclk)
start <= 1'b0;
end


signal_sync signal_sync_inst(
    .sclk     (sclk),
    .dclk     (dclk),
    .start    (start),
    .ready    (ready)
);

endmodule