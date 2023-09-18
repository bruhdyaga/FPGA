`timescale 1ns / 1ps

module seg7_control(
	 input time_1ms, clk,
	 input KEY2,
	 input [19:0] t,
	 input [19:0] t2,
    input [3:0] ones,
    input [3:0] tens,
    input [3:0] hundreds,
    input [3:0] thousands,
    input [3:0] ten_thousands,
    input [3:0] hun_thousands,
	 output [9:0] LED_RED,
    output logic [0:6] HEX0,  
    output logic [0:6] HEX1,
    output logic [0:6] HEX2,
	 output logic [0:6] HEX3
    );
	 
    logic [3:0]range_one;
	 logic [3:0]range_two;
	 logic [3:0]range_three;
	 logic [3:0]range_four;
	 
    parameter ZERO  = 7'b000_0001;  // 0
    parameter ONE   = 7'b100_1111;  // 1
    parameter TWO   = 7'b001_0010;  // 2 
    parameter THREE = 7'b000_0110;  // 3
    parameter FOUR  = 7'b100_1100;  // 4
    parameter FIVE  = 7'b010_0100;  // 5
    parameter SIX   = 7'b010_0000;  // 6
    parameter SEVEN = 7'b000_1111;  // 7
    parameter EIGHT = 7'b000_0000;  // 8
    parameter NINE  = 7'b000_0100;  // 9

always_ff @(posedge clk or negedge KEY2)
		if (!KEY2) begin
			range_one <= '0;
			range_two <= '0;
			range_three <= '0;
			range_four <= '0;
			LED_RED[6] <= '0;
			LED_RED[7] <= '0;
			LED_RED[8] <= '0;
			end
			
			else begin
			
			if (t > 99_999) begin
				range_one <= hundreds;
				range_two <= thousands;
				range_three <= ten_thousands;
				range_four <= hun_thousands;
						LED_RED[6] <= '1;
						LED_RED[7] <= '0;
						LED_RED[8] <= '0;
			end
				else begin
				if (t > 9999) begin
					range_one <= tens;
					range_two <= hundreds;
					range_three <= thousands;
					range_four <= ten_thousands;
						LED_RED[6] <= '0;
						LED_RED[7] <= '1;
						LED_RED[8] <= '0;
					end
					else begin
						if (t < 9999) begin
						range_one <= ones;
						range_two <= tens;
						range_three <= hundreds;
						range_four <= thousands;
						LED_RED[6] <= '0;
						LED_RED[7] <= '0;
						LED_RED[8] <= '1;
						end
						end
						end
						end
						
always @(posedge time_1ms or negedge KEY2) 
    if (!KEY2) begin 
	 
	 end
	 else begin
	 if ((t2 < 3000)|((t2 > 3200)&(t2 < 3800))|((t2 > 4000)&(t2 < 4600))|(t2 > 4800)) begin
		case(range_one)
			 4'b0000 : HEX0 = ZERO;
			 4'b0001 : HEX0 = ONE;
			 4'b0010 : HEX0 = TWO;
			 4'b0011 : HEX0 = THREE;
			 4'b0100 : HEX0 = FOUR;
			 4'b0101 : HEX0 = FIVE;
			 4'b0110 : HEX0 = SIX;
			 4'b0111 : HEX0 = SEVEN;
			 4'b1000 : HEX0 = EIGHT;
			 4'b1001 : HEX0 = NINE;
			 default : HEX0 = ZERO;
		endcase

		case(range_two)
			 4'b0000 : HEX1 = ZERO;
			 4'b0001 : HEX1 = ONE;
			 4'b0010 : HEX1 = TWO;
			 4'b0011 : HEX1 = THREE;
			 4'b0100 : HEX1 = FOUR;
			 4'b0101 : HEX1 = FIVE;
			 4'b0110 : HEX1 = SIX;
			 4'b0111 : HEX1 = SEVEN;
			 4'b1000 : HEX1 = EIGHT;
			 4'b1001 : HEX1 = NINE;
			 default : HEX1 = ZERO;
		endcase

		case(range_three)
			 4'b0000 : HEX2 = ZERO;
			 4'b0001 : HEX2 = ONE;
			 4'b0010 : HEX2 = TWO;
			 4'b0011 : HEX2 = THREE;
			 4'b0100 : HEX2 = FOUR;
			 4'b0101 : HEX2 = FIVE;
			 4'b0110 : HEX2 = SIX;
			 4'b0111 : HEX2 = SEVEN;
			 4'b1000 : HEX2 = EIGHT;
			 4'b1001 : HEX2 = NINE;
			 default : HEX2 = ZERO;
		endcase

		case(range_four)
			 4'b0000 : HEX3 = ZERO;
			 4'b0001 : HEX3 = ONE;
			 4'b0010 : HEX3 = TWO;
			 4'b0011 : HEX3 = THREE;
			 4'b0100 : HEX3 = FOUR;
			 4'b0101 : HEX3 = FIVE;
			 4'b0110 : HEX3 = SIX;
			 4'b0111 : HEX3 = SEVEN;
			 4'b1000 : HEX3 = EIGHT;
			 4'b1001 : HEX3 = NINE;
			 default : HEX3 = ZERO;
		endcase
		end
		else begin 
			 	case(range_one)
			 4'b0000 : HEX0 = 7'b111_1111;
			 4'b0001 : HEX0 = 7'b111_1111;
			 4'b0010 : HEX0 = 7'b111_1111;
			 4'b0011 : HEX0 = 7'b111_1111;
			 4'b0100 : HEX0 = 7'b111_1111;
			 4'b0101 : HEX0 = 7'b111_1111;
			 4'b0110 : HEX0 = 7'b111_1111;
			 4'b0111 : HEX0 = 7'b111_1111;
			 4'b1000 : HEX0 = 7'b111_1111;
			 4'b1001 : HEX0 = 7'b111_1111;
			 default : HEX0 = 7'b111_1111;
		endcase

		case(range_two)
			 4'b0000 : HEX1 = 7'b111_1111;
			 4'b0001 : HEX1 = 7'b111_1111;
			 4'b0010 : HEX1 = 7'b111_1111;
			 4'b0011 : HEX1 = 7'b111_1111;
			 4'b0100 : HEX1 = 7'b111_1111;
			 4'b0101 : HEX1 = 7'b111_1111;
			 4'b0110 : HEX1 = 7'b111_1111;
			 4'b0111 : HEX1 = 7'b111_1111;
			 4'b1000 : HEX1 = 7'b111_1111;
			 4'b1001 : HEX1 = 7'b111_1111;
			 default : HEX1 = 7'b111_1111;
		endcase

		case(range_three)
			 4'b0000 : HEX2 = 7'b111_1111;
			 4'b0001 : HEX2 = 7'b111_1111;
			 4'b0010 : HEX2 = 7'b111_1111;
			 4'b0011 : HEX2 = 7'b111_1111;
			 4'b0100 : HEX2 = 7'b111_1111;
			 4'b0101 : HEX2 = 7'b111_1111;
			 4'b0110 : HEX2 = 7'b111_1111;
			 4'b0111 : HEX2 = 7'b111_1111;
			 4'b1000 : HEX2 = 7'b111_1111;
			 4'b1001 : HEX2 = 7'b111_1111;
			 default : HEX2 = 7'b111_1111;
		endcase

		case(range_four)
			 4'b0000 : HEX3 = 7'b111_1111;
			 4'b0001 : HEX3 = 7'b111_1111;
			 4'b0010 : HEX3 = 7'b111_1111;
			 4'b0011 : HEX3 = 7'b111_1111;
			 4'b0100 : HEX3 = 7'b111_1111;
			 4'b0101 : HEX3 = 7'b111_1111;
			 4'b0110 : HEX3 = 7'b111_1111;
			 4'b0111 : HEX3 = 7'b111_1111;
			 4'b1000 : HEX3 = 7'b111_1111;
			 4'b1001 : HEX3 = 7'b111_1111;
			 default : HEX3 = 7'b111_1111;
		endcase
end
end
endmodule
