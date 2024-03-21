`timescale 100ps / 1ps

module randn_tb();

    reg             pclk;               // [in]
    reg             reset_n;

    wire signed [9:0] awgn1;             // [out]
    wire signed [9:0] awgn2;             // [out]

    randn #(
        .number(0)   
    ) AWGN1 (
        .clk        (pclk),         // [in] 
        .reset_n    (reset_n), 
        .out        (awgn1)          // [out]
    );
    
    randn #(
        .number(1)   
    ) AWGN2 (
        .clk        (pclk),         // [in] 
        .reset_n    (reset_n), 
        .out        (awgn2)          // [out]
    );

    initial begin
        pclk = 0;
        reset_n = 1;
    end
    
    always  // 105.6 MHz
        #47 pclk = !pclk;
       
    event reset, resetdone;

    initial begin
        forever begin
            @ (reset)
            @ (negedge pclk)
            reset_n = 0;
            @ (negedge pclk)
            reset_n = 1;
            -> resetdone;
        end
    end
    initial begin: TEST_CASE
        #10 -> reset;
        //forever begin
        //    #3000000
        //end
    end

    // Output results 
    integer Res_file;   // file handler
    integer nclk = 0;
    initial begin
        Res_file = $fopen("res.txt", "w");
        @ (resetdone);
        forever begin
            @(posedge pclk)
            nclk = nclk + 1;
            $fwrite(Res_file, "%d %d %d", nclk, $signed(awgn1), $signed(awgn2));
            $fwrite(Res_file, "\n");
            $fflush(Res_file);
        end
    end
        
   
endmodule