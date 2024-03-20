`timescale 1ns/1ns
module piped_adder_tb();

localparam N_args    = 14;
localparam ARG_WIDTH = 6;

logic clk = 1;
always #5 clk = !clk;

logic signed [ARG_WIDTH-1:0] arg = '0;

always_ff@(posedge clk)
arg = arg + 1'b1;

piped_adder#(
    .N_args    (N_args),    // Number of arguments for adding 
    .arg_width (ARG_WIDTH), // Bits per each argument
    .dis_valid (0)          // Disable delay of signal "valid"
) PIPE(
    .clk     (clk),       // [in]     
    .args_in ({N_args{arg}}),   // [in]     Bus of addends
    .sum_out (),   // [out]    Result of adding
    .we      ('1),        // [in]     
    .valid   ()    // [out]    If .dis_valid(0), then valid is valid-flag for sum_out; else valid is we
);

endmodule