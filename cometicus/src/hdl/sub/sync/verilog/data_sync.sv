`timescale 1ns/10ps
module data_sync#(
    parameter WIDTH = 1
)
(
    input  sclk,
    input  dclk,
    input  start,
    input  [WIDTH-1:0] data,
    output reg ready,
    output reg [WIDTH-1:0] sync_data
);

reg sync;
reg [WIDTH - 1 : 0] data_int;
reg busy;

reg dly_sync_s;
reg dly_sync_d;

wire sync_next;
wire sync_ed;
wire sync_d_ed;
wire sync_d;
wire sync_s;
wire finish;

//If start is asserted and busy deasserted, the data_int will contain the inout data
always_ff@(posedge sclk) begin
    if(start & ~busy) begin
        data_int <= data;
    end
end

//sync is gets toggled when start is asserted and busy is not set
always_ff@(posedge sclk) begin
    sync <= sync_next;
end

assign sync_next = (start & ~busy) ? ~sync : sync;

assign sync_ed = sync ^ sync_next;

//busy gets asserted when sync_ed pulse is formed
always_ff@(posedge sclk) begin
    if(sync_ed) begin
        busy <= 1'b1;
    end
    else if(finish) begin
        busy <=1'b0;
    end
end

//Level synchronization  of sync signal
level_sync#(
    .WIDTH(1)
) level_sync1(
    .clk     (sclk),
    .async   (sync_d),
    .sync    (sync_s)
);

//Edge detection for sync_s signal
always_ff@(posedge sclk) begin
    dly_sync_s <= sync_s;
end

assign finish = dly_sync_s ^ sync_s;

//Level synchronization  of sync signal
level_sync#(
    .WIDTH(1)
) level_sync2(
    .clk     (dclk),
    .async   (sync),
    .sync    (sync_d)
);

//Edge detection for sync_d signal
always_ff@(posedge dclk) begin
    dly_sync_d <= sync_d;
end

assign sync_d_ed = dly_sync_d ^ sync_d;

//Synchronized data
always_ff@(posedge dclk) begin
    if(sync_d_ed) begin
        sync_data <= data_int;
    end
end

always_ff@(posedge dclk) begin
    ready <= sync_d_ed;
end

endmodule
