`timescale 1ns/10ps

module channel_sin_table (
    adc,
    phase_addr,
    sin_product
    );
    
    input [1 : 0] adc;
    input [4 : 0] phase_addr;
    output [4 : 0] sin_product;
    
    reg [4 : 0] sin_product;
    
    always @(*) begin
      case ({adc[1 : 0],phase_addr[4 : 0]})
        {2'b00,5'd0}    : sin_product = 5'h0;
        {2'b00,5'd1}    : sin_product = 5'h1;
        {2'b00,5'd2}    : sin_product = 5'h1;
        {2'b00,5'd3}    : sin_product = 5'h2;
        {2'b00,5'd4}    : sin_product = 5'h2;
        {2'b00,5'd5}    : sin_product = 5'h3;
        {2'b00,5'd6}    : sin_product = 5'h3;
        {2'b00,5'd7}    : sin_product = 5'h3;
        {2'b00,5'd8}    : sin_product = 5'h3;
        {2'b00,5'd9}    : sin_product = 5'h3;
        {2'b00,5'd10}   : sin_product = 5'h3;
        {2'b00,5'd11}   : sin_product = 5'h2;
        {2'b00,5'd12}   : sin_product = 5'h2;
        {2'b00,5'd13}   : sin_product = 5'h1;
        {2'b00,5'd14}   : sin_product = 5'h1;
        {2'b00,5'd15}   : sin_product = 5'h0;
        {2'b00,5'd16}   : sin_product = 5'h0;
        {2'b00,5'd17}   : sin_product = 5'h1f;
        {2'b00,5'd18}   : sin_product = 5'h1f;
        {2'b00,5'd19}   : sin_product = 5'h1e;
        {2'b00,5'd20}   : sin_product = 5'h1e;
        {2'b00,5'd21}   : sin_product = 5'h1d;
        {2'b00,5'd22}   : sin_product = 5'h1d;
        {2'b00,5'd23}   : sin_product = 5'h1d;
        {2'b00,5'd24}   : sin_product = 5'h1d;
        {2'b00,5'd25}   : sin_product = 5'h1d;
        {2'b00,5'd26}   : sin_product = 5'h1d;
        {2'b00,5'd27}   : sin_product = 5'h1e;
        {2'b00,5'd28}   : sin_product = 5'h1e;
        {2'b00,5'd29}   : sin_product = 5'h1f;
        {2'b00,5'd30}   : sin_product = 5'h1f;
        {2'b00,5'd31}   : sin_product = 5'h0;
        {2'b01,5'd0}    : sin_product = 5'h0;
        {2'b01,5'd1}    : sin_product = 5'h3;
        {2'b01,5'd2}    : sin_product = 5'h3;
        {2'b01,5'd3}    : sin_product = 5'h6;
        {2'b01,5'd4}    : sin_product = 5'h6;
        {2'b01,5'd5}    : sin_product = 5'h9;
        {2'b01,5'd6}    : sin_product = 5'h9;
        {2'b01,5'd7}    : sin_product = 5'h9;
        {2'b01,5'd8}    : sin_product = 5'h9;
        {2'b01,5'd9}    : sin_product = 5'h9;
        {2'b01,5'd10}   : sin_product = 5'h9;
        {2'b01,5'd11}   : sin_product = 5'h6;
        {2'b01,5'd12}   : sin_product = 5'h6;
        {2'b01,5'd13}   : sin_product = 5'h3;
        {2'b01,5'd14}   : sin_product = 5'h3;
        {2'b01,5'd15}   : sin_product = 5'h0;
        {2'b01,5'd16}   : sin_product = 5'h0;
        {2'b01,5'd17}   : sin_product = 5'h1d;
        {2'b01,5'd18}   : sin_product = 5'h1d;
        {2'b01,5'd19}   : sin_product = 5'h1a;
        {2'b01,5'd20}   : sin_product = 5'h1a;
        {2'b01,5'd21}   : sin_product = 5'h17;
        {2'b01,5'd22}   : sin_product = 5'h17;
        {2'b01,5'd23}   : sin_product = 5'h17;
        {2'b01,5'd24}   : sin_product = 5'h17;
        {2'b01,5'd25}   : sin_product = 5'h17;
        {2'b01,5'd26}   : sin_product = 5'h17;
        {2'b01,5'd27}   : sin_product = 5'h1a;
        {2'b01,5'd28}   : sin_product = 5'h1a;
        {2'b01,5'd29}   : sin_product = 5'h1d;
        {2'b01,5'd30}   : sin_product = 5'h1d;
        {2'b01,5'd31}   : sin_product = 5'h0;
        {2'b10,5'd0}    : sin_product = 5'h0;
        {2'b10,5'd1}    : sin_product = 5'h1f;
        {2'b10,5'd2}    : sin_product = 5'h1f;
        {2'b10,5'd3}    : sin_product = 5'h1e;
        {2'b10,5'd4}    : sin_product = 5'h1e;
        {2'b10,5'd5}    : sin_product = 5'h1d;
        {2'b10,5'd6}    : sin_product = 5'h1d;
        {2'b10,5'd7}    : sin_product = 5'h1d;
        {2'b10,5'd8}    : sin_product = 5'h1d;
        {2'b10,5'd9}    : sin_product = 5'h1d;
        {2'b10,5'd10}   : sin_product = 5'h1d;
        {2'b10,5'd11}   : sin_product = 5'h1e;
        {2'b10,5'd12}   : sin_product = 5'h1e;
        {2'b10,5'd13}   : sin_product = 5'h1f;
        {2'b10,5'd14}   : sin_product = 5'h1f;
        {2'b10,5'd15}   : sin_product = 5'h0;
        {2'b10,5'd16}   : sin_product = 5'h0;
        {2'b10,5'd17}   : sin_product = 5'h1;
        {2'b10,5'd18}   : sin_product = 5'h1;
        {2'b10,5'd19}   : sin_product = 5'h2;
        {2'b10,5'd20}   : sin_product = 5'h2;
        {2'b10,5'd21}   : sin_product = 5'h3;
        {2'b10,5'd22}   : sin_product = 5'h3;
        {2'b10,5'd23}   : sin_product = 5'h3;
        {2'b10,5'd24}   : sin_product = 5'h3;
        {2'b10,5'd25}   : sin_product = 5'h3;
        {2'b10,5'd26}   : sin_product = 5'h3;
        {2'b10,5'd27}   : sin_product = 5'h2;
        {2'b10,5'd28}   : sin_product = 5'h2;
        {2'b10,5'd29}   : sin_product = 5'h1;
        {2'b10,5'd30}   : sin_product = 5'h1;
        {2'b10,5'd31}   : sin_product = 5'h0;
        {2'b11,5'd0}    : sin_product = 5'h0;
        {2'b11,5'd1}    : sin_product = 5'h1d;
        {2'b11,5'd2}    : sin_product = 5'h1d;
        {2'b11,5'd3}    : sin_product = 5'h1a;
        {2'b11,5'd4}    : sin_product = 5'h1a;
        {2'b11,5'd5}    : sin_product = 5'h17;
        {2'b11,5'd6}    : sin_product = 5'h17;
        {2'b11,5'd7}    : sin_product = 5'h17;
        {2'b11,5'd8}    : sin_product = 5'h17;
        {2'b11,5'd9}    : sin_product = 5'h17;
        {2'b11,5'd10}   : sin_product = 5'h17;
        {2'b11,5'd11}   : sin_product = 5'h1a;
        {2'b11,5'd12}   : sin_product = 5'h1a;
        {2'b11,5'd13}   : sin_product = 5'h1d;
        {2'b11,5'd14}   : sin_product = 5'h1d;
        {2'b11,5'd15}   : sin_product = 5'h0;
        {2'b11,5'd16}   : sin_product = 5'h0;
        {2'b11,5'd17}   : sin_product = 5'h3;
        {2'b11,5'd18}   : sin_product = 5'h3;
        {2'b11,5'd19}   : sin_product = 5'h6;
        {2'b11,5'd20}   : sin_product = 5'h6;
        {2'b11,5'd21}   : sin_product = 5'h9;
        {2'b11,5'd22}   : sin_product = 5'h9;
        {2'b11,5'd23}   : sin_product = 5'h9;
        {2'b11,5'd24}   : sin_product = 5'h9;
        {2'b11,5'd25}   : sin_product = 5'h9;
        {2'b11,5'd26}   : sin_product = 5'h9;
        {2'b11,5'd27}   : sin_product = 5'h6;
        {2'b11,5'd28}   : sin_product = 5'h6;
        {2'b11,5'd29}   : sin_product = 5'h3;
        {2'b11,5'd30}   : sin_product = 5'h3;
        {2'b11,5'd31}   : sin_product = 5'h0;
      endcase
    end

endmodule
