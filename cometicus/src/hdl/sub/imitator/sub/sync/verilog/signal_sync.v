`timescale 1ns/10ps

module signal_sync (
    sclk,
    dclk,
    reset_n,
    start,
    ready
    );
    
  input sclk;
  input dclk;
  input reset_n;
  input start;
  output ready;  
  
  reg sync;
  reg busy;
  reg ready;
  
  reg dly_sync_s;
  reg dly_sync_d;
  
  wire sync_next;
  wire sync_ed;
  wire sync_d;
  wire sync_s;
  wire finish;  
  
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
  
  always @ (posedge dclk or negedge reset_n) begin
    if (reset_n == 1'b0) begin
      ready <= 1'b0;
    end
    else begin
      ready <= sync_d_ed;
    end
  end

endmodule
