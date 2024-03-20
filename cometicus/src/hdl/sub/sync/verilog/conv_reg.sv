module conv_reg#(
    parameter width      = 1,
    parameter length     = 0,
    parameter INIT_STATE = 1'b0
)
(
    input  clk,
    input  [width-1:0] in,
    output [width-1:0] out
);

if(length>0) begin
    reg [width-1:0] reg_mem [length-1:0] = '{default:INIT_STATE};
    for(genvar i=0; i<length; i=i+1) begin: reg_mem_gen
        always@(posedge clk) begin
            if(i==0)
                reg_mem[i] <= in;
            else
                reg_mem[i] <= reg_mem[i-1];
        end
    end
    assign out = reg_mem[length-1];
end
else begin
    assign out = in;//без конвееризации
end

endmodule
