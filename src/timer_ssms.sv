module timer_ssms(
	input clk, KEY2,
	input key0,
	input time_1ms,
	input time_t t_interval,
	output logic [19:0] t2,
	output time_t t
);
	
	logic [19:0] t_show;
	logic[3:0] C = 1'd0; 
	always_ff @(posedge clk or negedge KEY2) 
    if (!KEY2) begin 
      C <= '0; 
    end 
    else begin
			if (key0) begin 
				if(C == 4'd2) begin  
					C <= 1'd1; 
				end 
         else begin 
           C <= C+1'd1; 
        end 
		  end
      end 

	always @(posedge time_1ms or negedge KEY2) 
    if (!KEY2) begin 
      t <= '0;
    end 
		else begin
				if (C == 1) begin
				if (time_1ms) begin
				if (20'd999999 == t) begin
					t <= '0;			
				end
		else
			t <= t + 1'b1;
			t_show <= t;
	end
	end
	if (C == 2) begin
		t <= t;
		if (time_1ms) begin
				if (20'd5600 == t2) begin
					t2 <= '0;
					t <= t_show;
				end
		else
			t2 <= t2 + 1'b1;
			if (t2 == 3_200) begin
			t <= t_interval;
	end
	end
	end
	end

	
endmodule : timer_ssms