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
   
// Pipelined adder
// Module gets N_args values in a register args_in, one returns a sum
//   
// Attention! In accordance with Verilog standart maximum bus width is 2^16 = 65536. 
// For example, if you use 4-bit values, then maximum number of arguments is 1024 (c) Ivan
//
// Output bus width = Input arg width + ceil(log2(N_args)).
// Result delay is ceil(log2(N_args)) clks, it is showed by valid flag
module piped_adder(
    // Parameters: 
	// .N_args(0),             // Number of arguments for adding 
	// .arg_width(0),          // Bits per each argument
	// .reset_type("ASYNEG"),  // Reset type: "SYN" - sync pos, "ASYNEG" - async negedge or "ASY" - async posedge
	// .dis_valid(0)           // Disable delay of signal "valid"
	// ) instname ( 
	clk,       // [in]     
	reset,     // [in]     
	args_in,   // [in]     Bus of addends
	sum_out,   // [out]    Result of adding
	we,        // [in]     
	valid      // [out]    If .dis_valid(0), then valid is valid-flag for sum_out; else valid is we
);

parameter N_args        = 0;       
parameter arg_width     = 0;     
parameter reset_type    = "ASYNEG";
parameter dis_valid     = 0;    // 0-enable; other-disable

parameter tree_height 	= `CEIL_LOG2(N_args);        // = log2(N_args)
parameter args_in_size  = N_args*arg_width;          // input bus width 
parameter out_width     = arg_width + tree_height;

//--------------------------------------------

input                       clk;
input                       reset;
input   [args_in_size-1:0]  args_in;
output  [out_width-1:0]     sum_out;
input                       we;
output                      valid;

//--------------------------------------------

wire [out_width-1:0]                    sum_out;   
wire [tree_height:0]                    valid_arr;
wire [pipe_size(tree_height)-1:0]       pipe; 

genvar i;

//--------------------------------------------

assign pipe[args_in_size-1:0] = args_in;

generate 
    if (tree_height == 0) begin
        assign sum_out = args_in;
    end else begin
        assign sum_out = pipe[pipe_size(tree_height)-1:pipe_size(tree_height-1)];
    end
endgenerate 

assign valid_arr[0] = we;

generate
    if (dis_valid == 0) begin
	   assign valid = valid_arr[tree_height];
    end else begin
	   assign valid = 1;
	end
endgenerate

generate 
    for (i=0; i<tree_height; i=i+1) begin: adder_stage
        localparam integer w_in = arg_width + i;
        localparam integer w_out = arg_width + i + 1;
        localparam integer size_in = w_in * N_in(i);
        localparam integer size_out = w_out * N_out(i);
        localparam integer f_in = pipe_size(i) - size_in; 
        localparam integer l_in = pipe_size(i) - 1; 
        localparam integer f_out = pipe_size(i);
        localparam integer l_out = pipe_size(i) + size_out - 1;
        piped_adder_stage#(
            .arg_width(arg_width+i),
            .N_args(N_in(i)),
            .reset_type("ASYNEG"),
            .dis_valid(dis_valid)
        )
        ADDER_STAGE(
            .clk(clk),
            .reset(reset),
            .in(pipe[l_in:f_in]),
            .out(pipe[l_out:f_out]),
            .we(valid_arr[i]),
            .valid(valid_arr[i+1])
        );
    end
endgenerate

function automatic integer N_in;
    input stepnum;
    integer stepnum;
    integer i;
    begin
        N_in = N_args;
        for (i=0; i<stepnum; i=i+1) begin
            N_in = (N_in + 1)/2;
        end
    end
endfunction

function automatic integer N_out;
    input stepnum;
    integer stepnum; 
    begin
        N_out = N_in(stepnum+1);
    end
endfunction

function automatic integer pipe_size;
    input stepnum;
    integer stepnum;
    integer w_in;
    integer w_out;
    integer i;
    begin
        w_in = 0;
        pipe_size = 0;
        for (i=0; i<=stepnum; i=i+1) begin
            w_in = arg_width + i;
            pipe_size = pipe_size + N_in(i)*w_in;
        end
    end
endfunction
  
endmodule
