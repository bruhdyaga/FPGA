module sin_cos_table (
    input        [4:0] phase,
    output logic [4:0] sin_product,
    output logic [4:0] cos_product
);

always_comb begin
    case(phase)
        {5'd0}    : sin_product = 5'h0;
        {5'd1}    : sin_product = 5'h3;
        {5'd2}    : sin_product = 5'h6;
        {5'd3}    : sin_product = 5'h8;
        {5'd4}    : sin_product = 5'hB;
        {5'd5}    : sin_product = 5'hC;
        {5'd6}    : sin_product = 5'hE;
        {5'd7}    : sin_product = 5'hF;
        {5'd8}    : sin_product = 5'hF;
        {5'd9}    : sin_product = 5'hF;
        {5'd10}   : sin_product = 5'hE;
        {5'd11}   : sin_product = 5'hC;
        {5'd12}   : sin_product = 5'hB;
        {5'd13}   : sin_product = 5'h8;
        {5'd14}   : sin_product = 5'h6;
        {5'd15}   : sin_product = 5'h3;
        {5'd16}   : sin_product = 5'h0;
        {5'd17}   : sin_product = 5'h1D;
        {5'd18}   : sin_product = 5'h1A;
        {5'd19}   : sin_product = 5'h18;
        {5'd20}   : sin_product = 5'h15;
        {5'd21}   : sin_product = 5'h14;
        {5'd22}   : sin_product = 5'h12;
        {5'd23}   : sin_product = 5'h11;
        {5'd24}   : sin_product = 5'h11;
        {5'd25}   : sin_product = 5'h11;
        {5'd26}   : sin_product = 5'h12;
        {5'd27}   : sin_product = 5'h14;
        {5'd28}   : sin_product = 5'h15;
        {5'd29}   : sin_product = 5'h18;
        {5'd30}   : sin_product = 5'h1A;
        {5'd31}   : sin_product = 5'h1D;
    endcase
end

always_comb begin
    case(phase)
        {5'd0}    : cos_product = 5'hF;
        {5'd1}    : cos_product = 5'hF;
        {5'd2}    : cos_product = 5'hE;
        {5'd3}    : cos_product = 5'hC;
        {5'd4}    : cos_product = 5'hB;
        {5'd5}    : cos_product = 5'h8;
        {5'd6}    : cos_product = 5'h6;
        {5'd7}    : cos_product = 5'h3;
        {5'd8}    : cos_product = 5'h0;
        {5'd9}    : cos_product = 5'h1D;
        {5'd10}   : cos_product = 5'h1A;
        {5'd11}   : cos_product = 5'h18;
        {5'd12}   : cos_product = 5'h15;
        {5'd13}   : cos_product = 5'h14;
        {5'd14}   : cos_product = 5'h12;
        {5'd15}   : cos_product = 5'h11;
        {5'd16}   : cos_product = 5'h11;
        {5'd17}   : cos_product = 5'h11;
        {5'd18}   : cos_product = 5'h12;
        {5'd19}   : cos_product = 5'h14;
        {5'd20}   : cos_product = 5'h15;
        {5'd21}   : cos_product = 5'h18;
        {5'd22}   : cos_product = 5'h1A;
        {5'd23}   : cos_product = 5'h1D;
        {5'd24}   : cos_product = 5'h0;
        {5'd25}   : cos_product = 5'h3;
        {5'd26}   : cos_product = 5'h6;
        {5'd27}   : cos_product = 5'h8;
        {5'd28}   : cos_product = 5'hB;
        {5'd29}   : cos_product = 5'hC;
        {5'd30}   : cos_product = 5'hE;
        {5'd31}   : cos_product = 5'hF;
    endcase
end

endmodule
