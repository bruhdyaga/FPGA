// Sum values in each pair
// Module takes N_args arguments, distributes to pairs and then calculate sum for each pair.
// It returns the (N_args+1)/2 sums.
module piped_adder_stage(
    // Parameters:
	// .arg_width(0)           // bits per each argument 
	// .N_args(0)              // number of the arguments
	// .dis_valid(0)           // Disable delay of signal "valid"
	clk,   // [in] 
	in,    // [in]         // Input dataset in one wide register (N_args*arg_width bits)
	out,   // [out]        // The sums (N_args/2, out width = in width + 1)
	we,    // [in]
	valid  // [out]        // If .dis_valid(0), then valid is delayed by clk signal we; else valid is we
);

parameter arg_width     = 0;
parameter N_args        = 0;
parameter dis_valid     = 0; // 0-enable; other-disable

parameter out_width     = arg_width + 1;
parameter N_sums        = (N_args+1)/2; // (4+1)/2 = 2, (3+1)/2 = 2
parameter N_full_pairs  = (N_args)/2;   //  4/2    = 2,  3/2    = 1

input                           clk;
input   [N_args*arg_width-1:0]  in;
output  [N_sums*out_width-1:0]  out;
input                           we;
output                          valid;

// -----------------------------------------------------

wire signed [arg_width-1:0] args    [N_args-1:0];   // Input arguments
reg signed [out_width-1:0] sum_reg  [N_sums-1:0];   // Output sums

// Distribute arguments to pairs
genvar i;
generate
    for(i=0;i<N_args;i=i+1) begin : loop_in_pars
        assign args[i][arg_width-1:0] = in[(i+1)*arg_width-1:i*arg_width];
    end
endgenerate


// Calculate sums
generate
    for (i=0; i<N_sums; i=i+1) begin: loop_sum_reg
        always@(posedge clk)
        if (i == N_full_pairs) begin // N_sum = N_full_pairs + 1, and it is the last pair  
            sum_reg[i] <= $signed(args[i*2]); // + 0
        end else begin
            sum_reg[i] <= $signed(args[i*2]) + $signed(args[(i+1)*2-1]);
        end
    end
endgenerate

// Glue output values
generate
    for (i=0; i<N_sums; i=i+1) begin: loop_out_pars
        assign out[(i+1)*out_width-1:i*out_width] = sum_reg[i];
    end
endgenerate

// Delay we to valid
generate
    if (dis_valid == 0) begin
        reg reg_valid;
        
        always@(posedge clk) begin
            reg_valid <= we;
        end
        
        assign valid = reg_valid;
    end else begin
        assign valid = we;
    end
endgenerate

endmodule
