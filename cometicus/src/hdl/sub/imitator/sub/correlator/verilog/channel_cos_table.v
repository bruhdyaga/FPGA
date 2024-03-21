`timescale 1ns/10ps

module channel_cos_table (
    adc,
    phase_addr,
    cos_product
    );
    
    input [1 : 0] adc;
    input [4 : 0] phase_addr;
    output [4 : 0] cos_product;
    
    reg [4 : 0] cos_product;
    
    always @(*) begin
      case ({adc[1 : 0],phase_addr[4 : 0]})
        {2'b00,5'd0}    : cos_product = 5'h3;
        {2'b00,5'd1}    : cos_product = 5'h3;
        {2'b00,5'd2}    : cos_product = 5'h3;
        {2'b00,5'd3}    : cos_product = 5'h2;
        {2'b00,5'd4}    : cos_product = 5'h2;
        {2'b00,5'd5}    : cos_product = 5'h1;
        {2'b00,5'd6}    : cos_product = 5'h1;
        {2'b00,5'd7}    : cos_product = 5'h0;
        {2'b00,5'd8}    : cos_product = 5'h0;
        {2'b00,5'd9}    : cos_product = 5'h1f;
        {2'b00,5'd10}   : cos_product = 5'h1f;
        {2'b00,5'd11}   : cos_product = 5'h1e;
        {2'b00,5'd12}   : cos_product = 5'h1e;
        {2'b00,5'd13}   : cos_product = 5'h1d;
        {2'b00,5'd14}   : cos_product = 5'h1d;
        {2'b00,5'd15}   : cos_product = 5'h1d;
        {2'b00,5'd16}   : cos_product = 5'h1d;
        {2'b00,5'd17}   : cos_product = 5'h1d;
        {2'b00,5'd18}   : cos_product = 5'h1d;
        {2'b00,5'd19}   : cos_product = 5'h1e;
        {2'b00,5'd20}   : cos_product = 5'h1e;
        {2'b00,5'd21}   : cos_product = 5'h1f;
        {2'b00,5'd22}   : cos_product = 5'h1f;
        {2'b00,5'd23}   : cos_product = 5'h0;
        {2'b00,5'd24}   : cos_product = 5'h0;
        {2'b00,5'd25}   : cos_product = 5'h1;
        {2'b00,5'd26}   : cos_product = 5'h1;
        {2'b00,5'd27}   : cos_product = 5'h2;
        {2'b00,5'd28}   : cos_product = 5'h2;
        {2'b00,5'd29}   : cos_product = 5'h3;
        {2'b00,5'd30}   : cos_product = 5'h3;
        {2'b00,5'd31}   : cos_product = 5'h3;
        {2'b01,5'd0}    : cos_product = 5'h9;
        {2'b01,5'd1}    : cos_product = 5'h9;
        {2'b01,5'd2}    : cos_product = 5'h9;
        {2'b01,5'd3}    : cos_product = 5'h6;
        {2'b01,5'd4}    : cos_product = 5'h6;
        {2'b01,5'd5}    : cos_product = 5'h3;
        {2'b01,5'd6}    : cos_product = 5'h3;
        {2'b01,5'd7}    : cos_product = 5'h0;
        {2'b01,5'd8}    : cos_product = 5'h0;
        {2'b01,5'd9}    : cos_product = 5'h1d;
        {2'b01,5'd10}   : cos_product = 5'h1d;
        {2'b01,5'd11}   : cos_product = 5'h1a;
        {2'b01,5'd12}   : cos_product = 5'h1a;
        {2'b01,5'd13}   : cos_product = 5'h17;
        {2'b01,5'd14}   : cos_product = 5'h17;
        {2'b01,5'd15}   : cos_product = 5'h17;
        {2'b01,5'd16}   : cos_product = 5'h17;
        {2'b01,5'd17}   : cos_product = 5'h17;
        {2'b01,5'd18}   : cos_product = 5'h17;
        {2'b01,5'd19}   : cos_product = 5'h1a;
        {2'b01,5'd20}   : cos_product = 5'h1a;
        {2'b01,5'd21}   : cos_product = 5'h1d;
        {2'b01,5'd22}   : cos_product = 5'h1d;
        {2'b01,5'd23}   : cos_product = 5'h0;
        {2'b01,5'd24}   : cos_product = 5'h0;
        {2'b01,5'd25}   : cos_product = 5'h3;
        {2'b01,5'd26}   : cos_product = 5'h3;
        {2'b01,5'd27}   : cos_product = 5'h6;
        {2'b01,5'd28}   : cos_product = 5'h6;
        {2'b01,5'd29}   : cos_product = 5'h9;
        {2'b01,5'd30}   : cos_product = 5'h9;
        {2'b01,5'd31}   : cos_product = 5'h9;
        {2'b10,5'd0}    : cos_product = 5'h1d;
        {2'b10,5'd1}    : cos_product = 5'h1d;
        {2'b10,5'd2}    : cos_product = 5'h1d;
        {2'b10,5'd3}    : cos_product = 5'h1e;
        {2'b10,5'd4}    : cos_product = 5'h1e;
        {2'b10,5'd5}    : cos_product = 5'h1f;
        {2'b10,5'd6}    : cos_product = 5'h1f;
        {2'b10,5'd7}    : cos_product = 5'h0;
        {2'b10,5'd8}    : cos_product = 5'h0;
        {2'b10,5'd9}    : cos_product = 5'h1;
        {2'b10,5'd10}   : cos_product = 5'h1;
        {2'b10,5'd11}   : cos_product = 5'h2;
        {2'b10,5'd12}   : cos_product = 5'h2;
        {2'b10,5'd13}   : cos_product = 5'h3;
        {2'b10,5'd14}   : cos_product = 5'h3;
        {2'b10,5'd15}   : cos_product = 5'h3;
        {2'b10,5'd16}   : cos_product = 5'h3;
        {2'b10,5'd17}   : cos_product = 5'h3;
        {2'b10,5'd18}   : cos_product = 5'h3;
        {2'b10,5'd19}   : cos_product = 5'h2;
        {2'b10,5'd20}   : cos_product = 5'h2;
        {2'b10,5'd21}   : cos_product = 5'h1;
        {2'b10,5'd22}   : cos_product = 5'h1;
        {2'b10,5'd23}   : cos_product = 5'h0;
        {2'b10,5'd24}   : cos_product = 5'h0;
        {2'b10,5'd25}   : cos_product = 5'h1f;
        {2'b10,5'd26}   : cos_product = 5'h1f;
        {2'b10,5'd27}   : cos_product = 5'h1e;
        {2'b10,5'd28}   : cos_product = 5'h1e;
        {2'b10,5'd29}   : cos_product = 5'h1d;
        {2'b10,5'd30}   : cos_product = 5'h1d;
        {2'b10,5'd31}   : cos_product = 5'h1d;
        {2'b11,5'd0}    : cos_product = 5'h17;
        {2'b11,5'd1}    : cos_product = 5'h17;
        {2'b11,5'd2}    : cos_product = 5'h17;
        {2'b11,5'd3}    : cos_product = 5'h1a;
        {2'b11,5'd4}    : cos_product = 5'h1a;
        {2'b11,5'd5}    : cos_product = 5'h1d;
        {2'b11,5'd6}    : cos_product = 5'h1d;
        {2'b11,5'd7}    : cos_product = 5'h0;
        {2'b11,5'd8}    : cos_product = 5'h0;
        {2'b11,5'd9}    : cos_product = 5'h3;
        {2'b11,5'd10}   : cos_product = 5'h3;
        {2'b11,5'd11}   : cos_product = 5'h6;
        {2'b11,5'd12}   : cos_product = 5'h6;
        {2'b11,5'd13}   : cos_product = 5'h9;
        {2'b11,5'd14}   : cos_product = 5'h9;
        {2'b11,5'd15}   : cos_product = 5'h9;
        {2'b11,5'd16}   : cos_product = 5'h9;
        {2'b11,5'd17}   : cos_product = 5'h9;
        {2'b11,5'd18}   : cos_product = 5'h9;
        {2'b11,5'd19}   : cos_product = 5'h6;
        {2'b11,5'd20}   : cos_product = 5'h6;
        {2'b11,5'd21}   : cos_product = 5'h3;
        {2'b11,5'd22}   : cos_product = 5'h3;
        {2'b11,5'd23}   : cos_product = 5'h0;
        {2'b11,5'd24}   : cos_product = 5'h0;
        {2'b11,5'd25}   : cos_product = 5'h1d;
        {2'b11,5'd26}   : cos_product = 5'h1d;
        {2'b11,5'd27}   : cos_product = 5'h1a;
        {2'b11,5'd28}   : cos_product = 5'h1a;
        {2'b11,5'd29}   : cos_product = 5'h17;
        {2'b11,5'd30}   : cos_product = 5'h17;
        {2'b11,5'd31}   : cos_product = 5'h17;
      endcase
    end

endmodule
