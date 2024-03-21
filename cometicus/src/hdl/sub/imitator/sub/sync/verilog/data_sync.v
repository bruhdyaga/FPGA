`timescale 1ns/10ps

module data_sync (
    sclk,
    dclk,
    reset_n,
    start,
    data,
    ready,
    sync_data
    );

  parameter WIDTH = 1;
  
  input sclk;
  input dclk;
  input reset_n;
  input start;
  input [WIDTH - 1 : 0] data;
  output ready;
  output [WIDTH - 1 : 0] sync_data;
  
  reg sync;
  reg [WIDTH - 1 : 0] data_int;
  reg [WIDTH - 1 : 0] sync_data;
  reg busy;
  reg ready;
  
  reg dly_sync_s;
  reg dly_sync_d;
  
  wire sync_next;
  wire sync_ed;
  wire sync_d;
  wire sync_s;
  wire finish;
  
  //If start is asserted and busy deasserted, the data_int will contain the inout data
  always @ (posedge sclk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      data_int <= {WIDTH{1'b0}};
    end
    else begin
      if (start & ~busy) begin
        data_int <= data;
      end
    end
  end
  
  //sync is gets toggled when start is asserted and busy is not set
  always @ (posedge sclk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      sync <= 1'b0;
    end
    else begin
      sync <= sync_next;
    end
  end  
  
  assign sync_next = (start & ~busy) ? ~sync : sync;
  
  assign sync_ed = sync ^ sync_next;
  
  //busy gets asserted when sync_ed pulse is formed
  always @ (posedge sclk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      busy <= 1'b0;
    end
    else begin
      if (sync_ed) begin
        busy <= 1'b1;
      end
      else if (finish) begin
        busy <=1'b0;
      end
    end
  end
  
  //Level synchronization  of sync signal
  level_sync#(
	.WIDTH(1)
	)
	level_sync1 (
    .clk     (sclk),
    .reset_n (reset_n),
    .async   (sync_d),
    .sync    (sync_s)
  );
  
  //Edge detection for sync_s signal
  always @ (posedge sclk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      dly_sync_s <= 1'b0;
    end
    else begin
      dly_sync_s <= sync_s;
    end
  end
  
  assign finish = dly_sync_s ^ sync_s;  
  
  //Level synchronization  of sync signal
  level_sync#(
		.WIDTH(1)
	)
	level_sync2 (
    .clk     (dclk),
    .reset_n (reset_n),
    .async   (sync),
    .sync    (sync_d)
  );
  
  //Edge detection for sync_d signal
  always @ (posedge dclk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      dly_sync_d <= 1'b0;
    end
    else begin
      dly_sync_d <= sync_d;
    end
  end
  
  assign sync_d_ed = dly_sync_d ^ sync_d;
  
  //Synchronized data 
  always @ (posedge dclk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      sync_data <= {WIDTH{1'b0}};
    end
    else begin
      if (sync_d_ed) begin
        sync_data <= data_int;
      end
    end
  end
  
  always @ (posedge dclk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      ready <= 1'b0;
    end
    else begin
      ready <= sync_d_ed;
    end
  end
  
endmodule
