module bits_signed(
	input  sig_I,
	input  mag_I,
	output logic signed [2:0] data_out_I,
	input  sig_Q,
	input  mag_Q,
	output logic signed [2:0] data_out_Q
);

always_comb
case({mag_I,sig_I})
	2'b00:
		data_out_I <= $signed(1);
	2'b10:
		data_out_I <= $signed(3);
	2'b01:
		data_out_I <= $signed(-1);
	2'b11:
		data_out_I <= $signed(-3);
endcase

always_comb
case({mag_Q,sig_Q})
	2'b00:
		data_out_Q <= $signed(1);
	2'b10:
		data_out_Q <= $signed(3);
	2'b01:
		data_out_Q <= $signed(-1);
	2'b11:
		data_out_Q <= $signed(-3);
endcase

endmodule