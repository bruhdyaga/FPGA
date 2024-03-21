module antiglitch
#(
    parameter N = 0,  // N >=1
    parameter M = 0   // N by M; N<=M
)
( 
    input  clk,
    input  glitch,
    output reg clean = 0
);

if(M < 2) begin
    always_ff@(posedge clk) begin
        clean <= glitch;
    end
    
end else begin
    reg  [M-1:0] input_reg;
    
    always_ff@(posedge clk) begin
        input_reg <= {input_reg[M-2:0],glitch};
    end

    wire [$clog2(M):0] sum [M-2:0];
    for(genvar i=0; i<=M-2; i=i+1)
    begin: loop_sum_bits
        if(i == 0)
            assign sum[i] = (clean^input_reg[i]) + (clean^input_reg[i+1]);
        else
            assign sum[i] = sum[i-1] + (clean^input_reg[i+1]);
    end
    
    always_ff@(posedge clk) begin
        if(sum[M-2] >= N) begin
            if(clean == 0)
                clean <= 1'b1;
            else
                clean <= 0;
        end
    end
end

endmodule
