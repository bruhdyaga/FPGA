`timescale 1ns/10ps

module common_sync (
    sclk,
    dclk,
    reset_n,
    intr_cntl,
    intr_cntl_we,
`ifdef INTERRUPT_DIV2    
    intr_cntl_rd_en,    
    intr_cntl_sync,
    intr_cntl_rd_en_sync
`else
    intr_cntl_sync
`endif    
    );
    
    input sclk;
    input dclk;
    input reset_n;
    input [3 : 0] intr_cntl;
    input intr_cntl_we;
`ifdef INTERRUPT_DIV2  
    input intr_cntl_rd_en;
`endif    
    output [3 : 0] intr_cntl_sync;
`ifdef INTERRUPT_DIV2    
    output intr_cntl_rd_en_sync;
`endif   
  
    data_sync
    #(3) sync1(
        .sclk      (sclk),
        .dclk      (dclk),
        .reset_n   (reset_n),
        .start     (intr_cntl_we),
        .data      (intr_cntl[2 : 0]),
        .ready     (),
        .sync_data (intr_cntl_sync[2 : 0]) 
    ); 

    signal_sync sync2(
        .sclk      (sclk),
        .dclk      (dclk),
        .reset_n   (reset_n),
        .start     (intr_cntl[3]),
        .ready     (intr_cntl_sync[3])
    );

`ifdef INTERRUPT_DIV2
    signal_sync sync3(
        .sclk      (sclk),
        .dclk      (dclk),
        .reset_n   (reset_n),
        .start     (intr_cntl_rd_en),    
        .ready     (intr_cntl_rd_en_sync)    
    );
`endif          

endmodule
