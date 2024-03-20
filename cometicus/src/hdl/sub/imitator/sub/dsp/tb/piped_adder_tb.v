`timescale 100ps / 1ps

`define CEIL_LOG2(x)  (  \
   ((x) <= 1)    ? 0 : \
   ((x) <= 2)    ? 1 : \
   ((x) <= 4)    ? 2 : \
   ((x) <= 8)    ? 3 : \
   ((x) <= 16)   ? 4 : \
   ((x) <= 32)   ? 5 : \
   ((x) <= 64)   ? 6 : \
   ((x) <= 128)  ? 7 : \
   ((x) <= 256)  ? 8 : \
   ((x) <= 512)  ? 9 : \
   ((x) <= 1024) ? 10: \
   ((x) <= 2048) ? 11: \
   ((x) <= 4096) ? 12: \
   ((x) <= 8192) ? 13: \
   ((x) <= 16384)? 14: \
   ((x) <= 32768)? 15: \
   ((x) <= 65536)? 16: \
   -1)
   
   
module piped_adder_tb();
    reg             pclk;         
    reg             reset_n;

    wire            valid;
    reg             we;    

    parameter   N_args = 9;
    parameter   tree_height = `CEIL_LOG2(N_args);

    parameter   w_arg  = 4;
    reg signed  [w_arg - 1:0]           arg [N_args-1 : 0];
    wire signed  [N_args*w_arg - 1:0]   args;
    wire signed [w_arg+tree_height-1:0] sum;
    
    integer j;
    
    genvar i;
    generate
        for (i=0; i<N_args; i=i+1) begin: loop_args
            assign args[(i+1)*w_arg-1:i*w_arg] = arg[i];
        end
    endgenerate
    
    // Pipelined adder
    // Module gets N_args values in a register args_in, one returns a sum
    //   
    // Attention! In accordance with Verilog standart maximum bus width is 2^16 = 65536. 
    // For example, if you use 4-bit values, then maximum number of arguments is 1024 (c) Ivan
    //
    // Output bus width = Input arg width + ceil(log2(N_args)).
    // Result delay is ceil(log2(N_args)) clks, it is showed by valid flag
    piped_adder #(
        // Parameters: 
           .N_args(N_args),       // Number of arguments for adding 
           .arg_width(w_arg),      // Bits per each argument
           .reset_type("ASYNEG")  // Reset type: "SYN" - sync pos, "ASYNEG" - async negedge or "ASY" - async posedge
        // .dis_valid(0)       // Disable delay of signal "valid"
    ) ADDER (         
        .clk(pclk),         // [in]     
        .reset(reset_n),    // [in]     
        .args_in(args),     // [in]     Bus of addends
        .sum_out(sum),      // [out]    Result of adding
        .we(we),            // [in]     
        .valid(valid)       // [out]    If .dis_valid(0), then valid is valid-flag for sum_out; else valid is we
    );

   initial begin
        pclk = 0;
        reset_n = 1;
        
        we = 0;
       
        for (j=0;j<N_args;j=j+1) begin
            arg[j] <= 0;
        end 
    end
    
    always  // 105.6 MHz
        #47 pclk = !pclk;
       
    event reset, resetdone;
    event wepulse;

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

    initial begin
        forever begin
            @ (wepulse)
            //@ (posedge pclk)
            we = 1;
            @ (posedge pclk)
            @ (posedge pclk)
            we = 0;
        end
    end
    

    integer signed true_sum = 0;
    initial begin: TEST_CASE
        #10 -> reset;
        @ (resetdone);

        @ (posedge pclk)
        true_sum = 0;
        for (j=0; j<N_args; j=j+1) begin
            arg[j] = $signed($random);
            true_sum = true_sum + arg[j]; 
        end

        -> wepulse;
        
    end

    // Output results 
    integer Res_file;   // file handler
    integer nclk = 0;
    initial begin
//        Res_file = $fopen("Res.txt", "w");
//        @ (resetdone);
//        forever begin
//            @(posedge pclk)
//            nclk = nclk + 1;
//            $fwrite(Res_file, "%d %d", nclk, $signed(awgn));
//            $fwrite(Res_file, "\n");
//            $fflush(Res_file);
//        end
    end
        
   
endmodule
