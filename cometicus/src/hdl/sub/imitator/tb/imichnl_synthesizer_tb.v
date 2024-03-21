`timescale 100ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2016 16:15:08
// Design Name: 
// Module Name: imichnl_synthesizer_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imichnl_synthesizer_tb();

    reg             pclk;               // [in]
    reg             reset_n;
    reg [32-1:0]    phase_rate;
    reg             doinit;
    reg             fix_pulse;
    reg             dly_epoch;

    wire [32-1:0]   phase_rate_int;     // [out]
    wire [32-1:0]   phase_int;
    wire [32-1:0]   phase_cycles_int;
    wire [5-1:0]    phase_addr;

    // Генератор фазы несущей,
    // отображает phase_rate в phase_addr
    // по задержанной эпохе dly_epoch защелкивает счетчики циклов и фазы, а также регистр phase_rate
    // по задержанной эпохе dly_epoch применяет записанное значение phase_rate
    // 
    imichnl_synthesizer CHSYN (
        .clk                  (pclk),               // [in]
        .reset_n              (reset_n),
        .phase_rate           (phase_rate),
        .doinit               (doinit),
        .fix_pulse            (fix_pulse),
        .epoch_pulse          (dly_epoch),
        .phase_rate_int       (phase_rate_int),     // [out]
        .phase_int            (phase_int),
        .phase_cycles_int     (phase_cycles_int),
        .phase_addr           (phase_addr)
    );

    initial begin
        pclk = 0;
        reset_n = 1;
        phase_rate  = 0;
        doinit = 0;
        fix_pulse = 0;
        dly_epoch = 0;
    end
    
    always  // 105.6 MHz
        #47 pclk = !pclk;
       
    event reset;
    event epoch;
    event fix;

    initial begin
        forever begin
            @ (reset)
            @ (negedge pclk)
            reset_n = 0;
            @ (negedge pclk)
            reset_n = 1;
        end
    end
    
    initial begin
        forever begin
            @ (epoch)
            @ (negedge pclk)
            dly_epoch = 1;
            @ (negedge pclk)
            dly_epoch = 0;
        end
    end
    
    initial begin
        forever begin
            @ (fix)
            @ (negedge pclk)
            fix_pulse = 1;
            @ (negedge pclk)
            fix_pulse = 0;
        end
    end    

    initial begin
        forever begin
            #10000500 -> epoch;
        end
    end
    
    initial begin
        #2000000
        forever begin
            #10000000 -> fix;
        end
    end

    initial begin: TEST_CASE
        #10 -> reset;
        forever begin
            #3000000
            phase_rate = phase_rate + 500;
            @ (epoch);
        end
    end

endmodule