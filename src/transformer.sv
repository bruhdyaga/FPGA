`include "time_pkg.sv"

module transformer (
	input [19:0] t,
	output logic [3:0] ones,
   output logic [3:0] tens,
   output logic [3:0] hundreds,
   output logic [3:0] thousands,
	output logic [3:0] ten_thousands,
	output logic [3:0] hun_thousands
);

always_comb begin
	ones = transform(t, 10);
	tens = transform(t, 100);
	hundreds = transform(t, 1000);
	thousands = transform(t, 10000);
	ten_thousands = transform(t, 100000);
	hun_thousands = transform(t, 1000000);
end


endmodule
