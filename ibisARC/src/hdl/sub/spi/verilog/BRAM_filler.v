// Сбор данных канала АЦП

module BRAM_filler(
		wclk,
		cntrl,
		reset,
		status,
	
	   //BRAM ports
		waddr,
		w_ena
	);
	
	parameter width = 20;

	input wclk;
	input cntrl;
	input reset;
	
	output w_ena;
	output status; 
	output [width-1:0] waddr;
	
	reg [width-1:0] waddr = {width{1'b0}};
	wire start_pulse;
	wire stop_pulse;

		ed_det#(
			.TYPE("ris"),
			.RESET_TYPE("ASY"),
			.IN_RESET_VALUE(0)
		)
		ed(
			.clk(wclk),
			.reset(reset),
			.in(cntrl),
			.out(start_pulse)
		);
	
	
	reg cnt_ena;
	always @(posedge wclk)
		if (reset | stop_pulse)
			cnt_ena <= 1'b0;
		else if (start_pulse)
			cnt_ena <= 1'b1;
	
	// wire c_en;
	// assign c_en = cnt_ena;
    assign status = ~cnt_ena;
	assign w_ena = cnt_ena;
	
	always @(posedge wclk)
		if (reset | stop_pulse)
			waddr <= 0;
		else if (w_ena)
			waddr <= waddr + 1'b1;
		
	assign stop_pulse = waddr == {width{1'b1}};	
		
		
endmodule
		