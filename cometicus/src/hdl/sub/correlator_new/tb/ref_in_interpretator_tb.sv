`timescale 1ns/10ps

`include "ref_in_interpretator.svh"

module ref_in_interpretator_tb();

    parameter REFINTR_BASE 		= 32'h40000000;
    parameter CALIB_BASE 		= 32'h50000000;
    
    parameter INPUT  			= 0;			// ADC 0
    parameter SEC_WIDTH 		= 0.5e6;		// *1e-9 	(`timescale t1)
    parameter SEC_PERIOD 		= 10e6;			// *1e-9	
    parameter SEC_DELAY			= 100e3 + 1;	// *1e-9
    parameter SEC_JITTER 		= 1;

    parameter SINGEN_PHASE_RATE = 429496729;   // 200000 8589934592	// Повышение повышает частоту	 //	10MHz = 429496729


    reg clk;
    reg reset_n;
    reg sec_pulse;

    wire refintr_out;

always #5 clk = !clk;   // 100 MHz


// RefInterpetator

    reg [31:0] REF_CONFIG =     (2      << 0) |  // MODE    0 = OFF, 1 = pulse, 2 = SIN, 3 = SIN_180
                                (INPUT  << 4) |  // RE
                                (0      << 9);   // IM;
    reg [31:0] REF_ID;


// Calibration
    reg [31:0] CALIB_CONFIG =  	(0      << 1) |  // quadr
                                (INPUT  << 2) |  // RE
                                (0      << 7);   // IM;
                                // CONFIG = 8'hCA, 8'b0, 4'b0, IM, RE, quadr, 1'b0;

    reg [31:0] CALIB_PHASE_RATE = 100000;	// (int)(ref_freq/in_clk*TWOPOW32) 		// 429496729   250000
    reg [31:0] CALIB_PHASE_FIX  = 32'b0;	// RefPhase
    reg [31:0] CALIB_CYCLE_FIX  = 32'b0;	// RefCycles
    reg [31:0] CALIB_I          = 32'b0;	// DeltaPhi = atan2(1.0*regs->I, 1.0*regs->Q)/pi*180;
    reg [31:0] CALIB_Q          = 32'b0;	// printf("I: %d  Q: %d  angle: %g\n", regs->I, regs->Q, res->DeltaPhi);
    
	// wire [4:0] ref_cos;
	// wire [4:0] in_cos;
    
	reg  [31:0] READ_BUFF;



		
// Sec pulse
	initial
		begin
			sec_pulse = 0;
			#(SEC_DELAY)
			forever 
				begin
					sec_pulse = ~sec_pulse;
					#(SEC_WIDTH) sec_pulse = ~sec_pulse;
					#(SEC_PERIOD-SEC_WIDTH);
				end
		end

    wire [1:0] sinus;
    wire sinus_sign;
    wire ref_out;
    
    sin_gen #(
            .NSIN		(2),            //разрядность выходного сигнала
            .NTABLE     (2),            //разрядность кода фазы 
            .OUT_WIDTH  (2)
        )
    SGEN (
        .clk        (clk),
        .aresetn    (reset_n), 
        .syn_reset  (0),
        .code_freq  (SINGEN_PHASE_RATE),
        .sin_out    (sinus),
        .scale      (0),
        .cnt_ena    (1'b1)
    );


// ADC interface
adc_interf#(
    .PORTS (4),
    .R     (2)
)adc ();

// BUS interface
intbus_interf bus();

    assign adc.clk      = clk;
    assign adc.resetn   = reset_n;
    assign adc.data[0]  = sinus;

    assign bus.clk      = clk;
    assign bus.resetn   = reset_n;
    
    
    for (genvar i = 1; i < 4; i++) begin
        assign adc.data[i] = '0;
    end

    ed_det#(
        .TYPE("ris")
    ) REF_EDT_SEC (
        .clk   (clk),
        .reset (!reset_n),
        .in    (sec_pulse),
        .out   (sec_pulse_ed)   //одноклоковый сигнал _/- перепада
    );
    

// SV Module
ref_in_interpretator #(
        .BASEADDR   (REFINTR_BASE/4),
        .NUM_ACCUM  (1)
    ) REFINTER (
        .bus            (bus),          // CPU bus (axi clk)
        .adc            (adc),          // ADC bus (pclk)
        .sec_pulse_ed   (sec_pulse_ed),
        .intr_pulse     (),
        .debug          (),
        .out            (ref_out)
    );



    // Main initial
initial begin
    bus.init;
    READ_BUFF   = 0;

    clk	= 1;
    reset_n = 0;
    // #50 reset_n = 0;
    #50 reset_n = 1;

    bus.waitClks(5);
    bus.readReg(REFINTR_BASE/4, 0, READ_BUFF);
    $display(" <-- READ from REG 0x%h = 0x%h",REFINTR_BASE/4, READ_BUFF);

    bus.readReg(REFINTR_BASE/4, 1, READ_BUFF);
    $display(" <-- READ from REG 0x%h = 0x%h",REFINTR_BASE/4 + 32'd1, READ_BUFF);

    bus.readReg(REFINTR_BASE/4, 2, READ_BUFF);
    $display(" <-- READ from REG 0x%h = 0x%h",REFINTR_BASE/4 + 32'd2, READ_BUFF);

    
    // bus.waitClks(5);
    bus.writeReg(REFINTR_BASE/4, 2 , REF_CONFIG);

    
    // #20 WRITE_TASK((REFINTR_BASE + 32'h4)/4 , REF_CONFIG);  
    // #20 READ_TASK((REFINTR_BASE)/4 , REF_ID);   
    // #20 WRITE_TASK((0), CALIB_CONFIG);		
    // #20 READ_TASK((0), CALIB_CONFIG);
    // #20 WRITE_TASK((1), CALIB_PHASE_RATE);

    // #50001  sec_pulse = 1;
    // #500000 sec_pulse = 0;
    // #500001 sec_pulse = 1;
    // #500000 sec_pulse = 0;
end
      
endmodule










// OLD style
/*
// =============== TASKS ================
	task READ_TASK;
		input [31:0] raddr;
		output [31:0] dataout;

		begin
			assign	dataout 	= Bus_rdata;

			@ (posedge clk) begin
				Bus_we_en 	= 1'b0;		
				Bus_rd_en   = 1'b1;
				Bus_addr 	= raddr;
			end
			
			@ (posedge clk);				
			@ (posedge clk) begin
				$display(" <-- READ from REG 0x%h = 0x%h",raddr,dataout);
				Bus_rd_en   = 1'b0;
			end
			
		end
	endtask
	
// ---------

	task WRITE_TASK;
		input [31:0] waddr;
		input [31:0] wdata;

		begin
			Bus_rd_en 	= 1'b0;			
			Bus_addr  	= waddr;
			Bus_wdata 	= wdata;
			Bus_we_en 	= 1'b1;			

			$display(" --> WRITE to REG  0x%h = 0x%h", waddr, wdata);

		@ (posedge clk)				
			Bus_we_en 	= 1'b0;	
		end
	endtask
// =============== ENDTASKS ================
*/


        // ref_in_interpretator #(
				// .BASE_ADDR	(REFINTR_BASE/4)	
		// ) REFIN (
			// .clk		(clk),					
			// .pclk		(clk),					
			// .reset_n	(reset_n),    
			
			// .we_en		(Bus_we_en),
			// .rd_en		(Bus_rd_en),
			// .reg_addr	(Bus_addr),
			// .wdata		(Bus_wdata),
			// .rdata		(Bus_rdata),

			// .intr_pulse	(),
			// .imi_in		(),
			// .adc0		(sinus),
			// .adc1		(),
			// .adc2		(),
			// .adc3		(),
			// .adc4		(),
			// .adc5		(),
			// .adc6		(),
			// .adc7		(),
			// .adc8		(),
			// .adc9		(),
			// .adc10		(),
			// .adc11		(),

			// .sec_pulse	(sec_pulse),			
			// .debug		(sinus_sign),
			// .out		(refintr_out)					
		// );
	
	// calibration #(
				// .BASE_ADDR(0)
		// ) CALIBR (
			// .clk            (clk),
			// .pclk           (clk),
			// .reset_n        (reset_n),    			// [in]  Асинхронный резет с активным низким уровнем
			
			// .we_en          (Bus_we_en),            // [in]  Write Enable
			// .rd_en          (Bus_rd_en),            // [in]  Read Enable
			// .reg_addr       (Bus_addr),             // [in]  Шина адреса
			// .wdata          (Bus_wdata),            // [in]  Данные на запись
			// .rdata          (Bus_rdata),            // [out] Данные на чтение
			
			// .intr_pulse     (),                 	// [in]  Импульс прерывания
			// .sec_pulse		(sec_pusle_w),			// start_calib_ed
			// .imi_in         (),
			
			// .adc0           (sinus),
			// .adc1           (),
			// .adc2           (),
			// .adc3           (),
			// .adc4           (),
			// .adc5           (),
			// .adc6           (),
			// .adc7           (),
			// .adc8           (),
			// .adc9           (),
			// .adc10          (),
			// .adc11          (2'b0),
			
			// .ref_cos        (ref_cos),
			// .in_cos         (in_cos)
		// );
		
		




