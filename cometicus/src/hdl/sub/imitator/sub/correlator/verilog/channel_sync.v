`timescale 1ns/10ps

module channel_sync (
    sclk,
    dclk,
    reset_n,
    doinit,
    doinit_sync
    );

  input sclk;
  input dclk;
  input reset_n;
  input doinit;
  output doinit_sync;
  
  signal_sync sync1(
    .sclk      (sclk),
    .dclk      (dclk),
    .reset_n   (reset_n),
    .start     (doinit),
    .ready     (doinit_sync)
    );   

endmodule
