module debouncing (
input KEY0, KEY1,
input clk, KEY2,
output logic key0, key_interval
);

logic[2:0] key0_d;
logic[2:0] key1_d;

always @(posedge clk or negedge KEY2) 
    if (!KEY2) begin 
      key0_d <= '0; 
      key1_d <= '0; 
    end 
    else begin 
      key0_d <= {key0_d[1:0], ~KEY0}; 
      key1_d <= {key1_d[1:0], ~KEY1}; 
   
		key0 <= ~key0_d[2] & key0_d[1]; 
		key_interval <= ~key1_d[2] & key1_d[1]; 
  end
endmodule  