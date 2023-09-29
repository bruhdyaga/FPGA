`include "time_pkg.sv"
import time_pkg::*;
module main_cntrl(
	input clk, KEY2,
	
	input key0, key_interval,
	
	input [19:0] t,
	output logic [19:0] t_interval
);
	
	logic [19:0] t_old = '0;
	logic [19:0] t_delta;
	logic [19:0] best_int;
	logic is_registred = '0;

	assign t_delta = time_delta(t, t_old);
	assign best_int = is_best_interval(t_delta, t_interval);
	
	always_ff @(posedge clk or negedge KEY2)
		if (!KEY2) begin
			is_registred <= '0;
			t_interval <= '0;
			t_old <= '0;
		end
		else begin
			if (key_interval) begin
					if (!is_registred) begin
						t_interval <= t;
						t_old <= t;
						is_registred <= 1'd1;
						end
					else begin 
						if (is_best_interval(t_delta, t_interval)) begin
							t_interval <= t_delta;
							end
							t_old <= t;
					end
				end
				end


endmodule : main_cntrl