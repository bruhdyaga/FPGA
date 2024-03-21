`timescale 1ns/10ps

module signal_sync (
    sclk,
    dclk,
    start,
    ready
);

input sclk;
input dclk;
input start;
output ready;

reg rqst_start_s  = '0;
reg finish_rqst_d = '0;
wire finish_rqst_s;

always_ff@(posedge sclk)
if(start)
    rqst_start_s <= 1'b1;
else
    if(finish_rqst_s)
        rqst_start_s <= 0;

level_sync level_sync_rqst_start_inst(
    .clk     (dclk),
    .async   (rqst_start_s),
    .sync    (rqst_start_d)
);

ed_det
#(
    .TYPE      ("ris")
) ed_det_finish_start_inst(
    .clk   (dclk),
    .in    (rqst_start_d),
    .out   (finish_d_start)
);

ed_det
#(
    .TYPE      ("fal"),
    .FLIP_EN   (1)
) ed_det_finish_stop_inst(
    .clk   (dclk),
    .in    (rqst_start_d),
    .out   (finish_d_stop)
);

always_ff@(posedge dclk)
if(finish_d_start)
    finish_rqst_d <= 1'b1;
else
    if(finish_d_stop)
        finish_rqst_d <= 0;

level_sync level_sync_finish_inst(
    .clk     (sclk),
    .async   (finish_rqst_d),
    .sync    (finish_rqst_s)
);

assign ready = finish_d_stop;

endmodule
