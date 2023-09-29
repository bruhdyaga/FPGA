`timescale 1ns / 1ps



module main(
    input clk, KEY0, KEY1, KEY2,
	 output [9:0] LED_RED,
    output [0:6] HEX0, 
	 output [0:6] HEX1,
	 output [0:6] HEX2,
	 output [0:6] HEX3
    );
    
	 	
	
    // Internal wires for connecting inner modules
    logic w_1000Hz;
    logic [3:0] ones, tens, huns, thous, ten_thous, hun_thous;
    logic [19:0] vremya, interval, time2;
	 logic key_start, key_int;
	  
    // Instantiate inner design modules
	 debouncing button(.clk(clk), .KEY0(KEY0), .KEY1(KEY1), .KEY2(KEY2), .key0(key_start), .key_interval(key_int));
	 
    _1ms one_ms(.clk(clk), .key0(key_start), .KEY2(KEY2), .time_1ms(w_1000Hz));
	 
	 timer_ssms timer(.t(vremya), .t2(time2), .t_interval(interval), .key0(key_start), .time_1ms(w_1000Hz), .KEY2(KEY2), .clk(clk));
    
    transformer megatron(.t(vremya), .ones(ones), 
                .tens(tens), .hundreds(huns), .thousands(thous), .ten_thousands(ten_thous), .hun_thousands(hun_thous));
    
    seg7_control seg7(.ones(ones), .tens(tens), .t(vremya), .time_1ms(w_1000Hz), .KEY2(KEY2), .clk(clk), .LED_RED(LED_RED), .t2(time2),
                      .hundreds(huns), .thousands(thous), .ten_thousands(ten_thous), .hun_thousands(hun_thous), .HEX0(HEX0), .HEX1(HEX1),.HEX2(HEX2),.HEX3(HEX3));
							 

	
	main_cntrl inter(.clk(clk), .key0(key_start), .KEY2(KEY2), .key_interval(key_int), .t(vremya), .t_interval(interval));
  
endmodule
