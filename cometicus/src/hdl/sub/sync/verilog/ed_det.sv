`timescale 1ns/10ps
module ed_det#(
    parameter TYPE = "ed", // "ed"-default,"ris","fal"
    parameter FLIP_EN = 0  // 0(def) or 1
)
(
    input  clk,
    input  in,
    output reg out//одноклоковый сигнал перепада
);

reg lat   = '0;//звено задержки вх. сигнала на такт
reg out_s = '0;

generate
if(TYPE == "ed")
    always_ff@(posedge clk)
        lat <= in;
    
if(TYPE == "ris")
    always_ff@(posedge clk)
        lat <= in;
    
if(TYPE == "fal")
    always_ff@(posedge clk)
        lat <= in;
//-----
if(TYPE == "ed")
    always@(*)
        out_s = ((lat == 1'b0) & (in == 1'b1) | (lat == 1'b1) & (in == 1'b0));
    
if(TYPE == "ris")
    always@(*)
        out_s = ((lat == 1'b0) & (in == 1'b1));
        
if(TYPE == "fal")
    always@(*)
        out_s = ((lat == 1'b1) & (in == 1'b0));
        
if(FLIP_EN == 1) begin
    always_ff@(posedge clk)
        out <= out_s;
end else begin
    always@(*)
        out <= out_s;
end
endgenerate

endmodule
