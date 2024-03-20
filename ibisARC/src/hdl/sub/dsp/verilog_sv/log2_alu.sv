module log2_alu
#(
    parameter OUT_FF = 0
)
(
    input               clk,
    input               ce,
    input        [31:0] in,
    output logic [4:0]  out
);

logic [4:0] out_comb;

always_comb begin
    if(in[31]) begin
        out_comb <= 31;
    end else if(in[30]) begin
        out_comb <= 30;
    end else if(in[29]) begin
        out_comb <= 29;
    end else if(in[28]) begin
        out_comb <= 28;
    end else if(in[27]) begin
        out_comb <= 27;
    end else if(in[26]) begin
        out_comb <= 26;
    end else if(in[25]) begin
        out_comb <= 25;
    end else if(in[24]) begin
        out_comb <= 24;
    end else if(in[23]) begin
        out_comb <= 23;
    end else if(in[22]) begin
        out_comb <= 22;
    end else if(in[21]) begin
        out_comb <= 21;
    end else if(in[20]) begin
        out_comb <= 20;
    end else if(in[19]) begin
        out_comb <= 19;
    end else if(in[18]) begin
        out_comb <= 18;
    end else if(in[17]) begin
        out_comb <= 17;
    end else if(in[16]) begin
        out_comb <= 16;
    end else if(in[15]) begin
        out_comb <= 15;
    end else if(in[14]) begin
        out_comb <= 14;
    end else if(in[13]) begin
        out_comb <= 13;
    end else if(in[12]) begin
        out_comb <= 12;
    end else if(in[11]) begin
        out_comb <= 11;
    end else if(in[10]) begin
        out_comb <= 10;
    end else if(in[9]) begin
        out_comb <= 9;
    end else if(in[8]) begin
        out_comb <= 8;
    end else if(in[7]) begin
        out_comb <= 7;
    end else if(in[6]) begin
        out_comb <= 6;
    end else if(in[5]) begin
        out_comb <= 5;
    end else if(in[4]) begin
        out_comb <= 4;
    end else if(in[3]) begin
        out_comb <= 3;
    end else if(in[2]) begin
        out_comb <= 2;
    end else if(in[1]) begin
        out_comb <= 1;
    end else begin
        out_comb <= 0;
    end
end

if(OUT_FF == 1) begin
    always_ff@(posedge clk) begin
        if(ce) begin
            out <= out_comb;
        end
    end
end else begin
    always_comb begin
        out <= out_comb;
    end
end

endmodule