module reset_sync
#(
    parameter RESET_POL = "NEG"
)
(
    input  clk,
    input  resetn_in,
    output resetn_out
);

(* ASYNC_REG="TRUE", SHIFT_EXTRACT="NO" *)
reg sync1 = '0;
(* ASYNC_REG="TRUE", SHIFT_EXTRACT="NO" *)
reg sync2 = '0;

generate if(RESET_POL == "NEG") begin
    always_ff@(posedge clk or negedge resetn_in) begin
        if (resetn_in == 1'b0) begin
            sync1 <= '0;
            sync2 <= '0;
        end
        else begin
            sync1 <= resetn_in;
            sync2 <= sync1;
        end
    end
end else if(RESET_POL == "POS") begin
    always_ff@(posedge clk or posedge resetn_in) begin
        if (resetn_in == 1'b1) begin
            sync1 <= '1;
            sync2 <= '1;
        end
        else begin
            sync1 <= resetn_in;
            sync2 <= sync1;
        end
    end
end else begin
    initial $error("non valid RESET_POL (%s)", RESET_POL);
end
endgenerate

assign resetn_out = sync2;

endmodule