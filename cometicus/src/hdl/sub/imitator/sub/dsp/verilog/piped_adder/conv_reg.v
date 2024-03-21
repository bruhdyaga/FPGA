// Register pipeline
module conv_reg(
    // Parameters:
	// .width(1)           // Bits in each register
	// .length(0)          // Number of registers
	// .RESET_TYPE("ASY")  // Reset type: "SYN" - sync pos, "ASYNEG" - async negedge or "ASY" - async posedge (def="ASY")
	reset, // [in]     
	clk,   // [in]
	in,    // [in]     Input data
	out    // [out]    Output delayed data
);

parameter width         = 1;
parameter length        = 0;
parameter RESET_TYPE    = "ASY";

input               reset;
input               clk;
input   [width-1:0] in;
output  [width-1:0] out;

wire    reset_n;
if (RESET_TYPE == "ASY") begin 
    assign reset_n = ~reset;  // convert posedge reset to negedge
end else if (RESET_TYPE == "ASYNEG") begin
    assign reset_n = reset;
end else begin
    assign reset_n = 1'b1;
end
    
genvar i;
generate
    if (length > 0) begin
        reg [width-1:0] reg_mem [length-1:0];
        for (i=0; i<length; i=i+1)	begin: reg_mem_gen
            if (RESET_TYPE == "SYN") begin  // Synchronous reset
                always @(posedge clk) begin
                    if (reset) begin
                        reg_mem[i] <= {width{1'b0}};
                    end else begin
                        if (i == 0) begin
                            reg_mem[i] <= in;
                        end else begin
                            reg_mem[i] <= reg_mem[i-1];
                        end
                    end
                end
            end else begin // Asynchronous reset
                always @(posedge clk or negedge reset_n) begin
                    if (reset_n == 1'b0) begin
                        reg_mem[i] <= {width{1'b0}};
                    end else begin
                        if (i == 0) begin
                            reg_mem[i] <= in;
                        end else begin
                            reg_mem[i] <= reg_mem[i-1];
                        end
                   end
               end            
            end
        end
        assign out = reg_mem[length-1];
    end else begin
        assign out = in; 
    end
endgenerate

endmodule
