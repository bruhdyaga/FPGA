`ifndef time_pkg
`define time_pkg

package time_pkg;

	typedef struct packed {
		logic[19:0] t;
	} time_t;
	
	function time_t time_delta(time_t t2, time_t t1); // res is (t2-t1), t2 >= t1
		automatic time_t res;
		
		begin
		res = t2 - t1;
		end
		
		return res;
	endfunction
	
	function logic is_best_interval(time_t t_new, time_t t_old);
		automatic logic res = '0;
		
		if (t_new > t_old) begin
			res = '0;
			end
		else begin
			res = '1;
			end
			
		return res;
	endfunction
	
	function logic [5:0] transform([19:0] t, int digit);
		automatic logic [5:0] res = 0;
		begin
			res = ((t % digit)/(digit/4'd10));
		end
		return res;
	endfunction
	
endpackage 

`endif