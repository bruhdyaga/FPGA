`timescale 1ns / 1ps

module reset_sync_tb(
    );
    
    
parameter RESET_POL = "POS";  //POS or NEG


    reg clk = 0;
    reg resetn_in = 'b0;
    always #23 clk  = !clk;
    
    initial begin
#55 resetn_in  = !resetn_in;
#150 resetn_in  = !resetn_in;
#123 resetn_in  = !resetn_in;
#88 resetn_in  = !resetn_in;

    end

    reset_sync#
    (
        .RESET_POL       (RESET_POL)
    ) 
    RESET_SYNC (
        .clk     (clk),
        .resetn_in     (resetn_in),
        .resetn_out    (resetn_out)
    );
    
    endmodule   
    
