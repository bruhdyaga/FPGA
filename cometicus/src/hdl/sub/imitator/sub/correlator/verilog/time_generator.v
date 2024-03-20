module time_generator(
    clk,
    reset_n,
    doinit,
    fix_pulse,
    intr_pulse,
    intr_fix_pulse,
    dly_epoch,
    sec_in,
    cur_time,
    code_phase_init_wr,
    chip_and_symb_init_wr,
    epoch_and_tow_init_wr,
    code_rate,
    code_phase_init,
    chip_counter_init,
    chip_max,
    epoch_counter_init,
    epoch_max,
    tow_counter_init,
    symb_counter_init,
    symb_max,
    code_rate_int,
    code_phase_int,
    code_phase_sec,
    code_phase_time,
    chip_int,
    chip_sec,
    chip_time,
    epoch_int,
    epoch_sec,
    epoch_time,
    epoch_int_intr,
    tow_int,
    tow_sec,
    tow_time,
    symb_int,
    symb_sec,
    symb_time,
    shift,
    epoch_pulse,
    sec_pulse,
    pps_pulse,
    prn_reset,
    code_phase_ext,
    chip_and_symb_ext,
    epoch_and_tow_ext,
    dly_epoch_flag_intr,
    pps_max
    );
    
    input clk;
    input reset_n;
    input doinit;
    input fix_pulse;
    input intr_pulse;    
    input intr_fix_pulse;
    input dly_epoch;
    input sec_in;
    input cur_time;
    input code_phase_init_wr;
    input chip_and_symb_init_wr;
    input epoch_and_tow_init_wr;
    input [31 : 0] code_rate;
    input [31 : 0] code_phase_init;
    input [23 : 0] chip_counter_init;
    input [23 : 0] chip_max;    
    input [9 : 0] epoch_counter_init;
    input [9 : 0] epoch_max;
    input [19 : 0] tow_counter_init;
    input [4 : 0] symb_counter_init;
    input [4 : 0] symb_max;
    output [31 : 0] code_rate_int;
    output [31 : 0] code_phase_int;
    output [31 : 0] code_phase_sec;
    output [31 : 0] code_phase_time;
    output [23 : 0] chip_int;
    output [23 : 0] chip_sec;
    output [23 : 0] chip_time;
    output [9 : 0] epoch_int;
    output [9 : 0] epoch_sec;
    output [9 : 0] epoch_time;
    output [9 : 0] epoch_int_intr;
    output [19 : 0] tow_int;
    output [19 : 0] tow_sec;
    output [19 : 0] tow_time;
    output [4 : 0] symb_int;    
    output [4 : 0] symb_sec;
    output [4 : 0] symb_time;
    output shift;     
    output epoch_pulse;
    output sec_pulse;
    output pps_pulse;
    input  prn_reset;
    output [31 : 0] code_phase_ext;
    output [28 : 0] chip_and_symb_ext;
    output [29 : 0] epoch_and_tow_ext;
    output dly_epoch_flag_intr;
    input [9:0] pps_max; 

    parameter SCALE_TYPE = 1'b0;  // 0 - шкала, основанная на счётчике с переполнением (шкала сигнала)
                                  // 1 - шкала, основанная на счётчике тактов          (шкала приёмника)
   
    reg [31 : 0] code_phase;
    reg [31 : 0] code_rate_int;  
    reg [31 : 0] code_phase_int;
    reg [31 : 0] code_phase_sec;
    reg [31 : 0] code_phase_time;
    reg [9 : 0] epoch_counter;
    reg [9 : 0] epoch_int;
    reg [9 : 0] epoch_sec;
    reg [9 : 0] epoch_time;
    reg [9 : 0] epoch_int_intr;
    reg [23 : 0] chip_counter;
    reg [23 : 0] chip_int;  
    reg [23 : 0] chip_sec;
    reg [23 : 0] chip_time;
    reg [19 : 0] tow_counter; 
    reg [19 : 0] tow_int;
    reg [19 : 0] tow_sec;
    reg [19 : 0] tow_time;
    reg [4 : 0] symb_counter;
    reg [4 : 0] symb_int;
    reg [4 : 0] symb_sec;
    reg [4 : 0] symb_time;
    reg dly_epoch_flag;
    reg dly_epoch_flag_intr;
    reg [9:0] pps_cntr;
    reg pps_pulse; 
    
    wire sec_pulse;
    wire week_pulse;
    
    wire [32 : 0] code_phase_sum; 

   assign time_corr_pulse = (SCALE_TYPE == 1'b0) ? epoch_pulse : fix_pulse;
   
    //Code frequency register
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_rate_int <= 32'b0;
        end
        else begin
            if (((doinit == 1'b1) & (intr_pulse == 1'b1)) | epoch_pulse) begin
                code_rate_int <= code_rate;
            end
        end
    end
        
    //Phase counter
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_phase <= 32'b0;
        end
        else begin
        	if (((doinit == 1'b1) & (intr_pulse == 1'b1)) | ((code_phase_init_wr == 1'b1) & time_corr_pulse)) begin
                code_phase[31 : 0] <= code_phase_init;
            end
            else if (SCALE_TYPE == 1'b0) begin                
                code_phase[31 : 0] <= code_phase_sum[31 : 0];
            end
	    	else begin
 	        	code_phase[31 : 0] <= 32'b0;
	    	end
        end
    end
    
    assign code_phase_sum[32 : 0] = code_phase[31 : 0] + code_rate_int[31 : 0];
    assign shift = (SCALE_TYPE == 1'b0) ? code_phase_sum[32] : 1'b1;
  
    //Code phase regiter is latched when interrupt pulse asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_phase_int <= 32'b0;
        end
        else if (fix_pulse == 1'b1) begin
            code_phase_int[31 : 0] <= code_phase[31 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_phase_sec <= 32'b0;
        end
        else if (sec_in == 1'b1) begin
            code_phase_sec[31 : 0] <= code_phase[31 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_phase_time <= 32'b0;
        end
        else if (cur_time == 1'b1) begin
            code_phase_time[31 : 0] <= code_phase[31 : 0];
        end
    end 
    
    //epoch counter
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            chip_counter <= 24'b0;
        end
        else begin
        	if (((doinit == 1'b1) & (intr_pulse == 1'b1)) | ((chip_and_symb_init_wr == 1'b1) & time_corr_pulse)) begin
                chip_counter <= chip_counter_init;
            end
            else if (epoch_pulse == 1'b1) begin
                chip_counter <= 24'b0;
            end            
            else if (shift == 1'b1) begin
                chip_counter <= chip_counter + 1'b1;
            end
        end
    end
    
    //code_chip regiter is latched when interrupt pulse is asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            chip_int <= 24'b0;
        end
        else if (fix_pulse == 1'b1) begin
            chip_int[23 : 0] <= chip_counter[23 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            chip_sec <= 24'b0;
        end
        else if (sec_in == 1'b1) begin
            chip_sec[23 : 0] <= chip_counter[23 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            chip_time <= 24'b0;
        end
        else if (cur_time == 1'b1) begin
            chip_time[23 : 0] <= chip_counter[23 : 0];
        end
    end 
  
    assign epoch_pulse = ( (chip_counter == chip_max) | (prn_reset == 1'b1) ) & shift;  
  
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_counter <= 10'b0;
        end
        else begin
        	if (((doinit == 1'b1) & (intr_pulse == 1'b1)) | ((epoch_and_tow_init_wr == 1'b1) & time_corr_pulse)) begin
                epoch_counter <= epoch_counter_init;
            end
            else if (sec_pulse == 1'b1) begin
                epoch_counter <= 10'b0;
            end
            else if (epoch_pulse == 1'b1) begin
                epoch_counter <= epoch_counter + 1'b1;
            end        
        end
    end
    
    assign sec_pulse = (epoch_counter == epoch_max) & epoch_pulse;
    
    assign pps_ovl = ((pps_cntr == pps_max) & epoch_pulse) | sec_pulse;
    
    always@ (posedge clk or negedge reset_n) begin
    	if (reset_n == 1'b0) begin
        	pps_cntr <= 0;
    	end
    	else if (pps_ovl) begin
            pps_cntr <= 0;
    	end
    	else if (epoch_pulse) begin
            pps_cntr <= pps_cntr + 1'b1;
    	end
    end
    
    always@ (posedge clk or negedge reset_n) begin
    	if(reset_n == 1'b0) begin
        	pps_pulse <= 0;
    	end
    	else if (pps_ovl) begin
            pps_pulse <= 1'b1;
    	end
    	else if (pps_cntr == 10) begin
            pps_pulse <= 0;
    	end
    end
    
    
    //epoch regiter is latched when interrupt pulse asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_int <= 10'b0;
        end
        else if (fix_pulse == 1'b1) begin
            epoch_int[9 : 0] <= epoch_counter[9 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_sec <= 10'b0;
        end
        else if (sec_in == 1'b1) begin
            epoch_sec[9 : 0] <= epoch_counter[9 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_time <= 10'b0;
        end
        else if (cur_time == 1'b1) begin
            epoch_time[9 : 0] <= epoch_counter[9 : 0];
        end
    end
    
    //epoch regiter is latched when interrupt pulse asserted
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_int_intr <= 10'b0;
        end
        else if (intr_fix_pulse == 1'b1) begin
            epoch_int_intr[9 : 0] <= epoch_counter[9 : 0];
        end
    end  
   
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            tow_counter <= 20'b0;
        end
        else if (((doinit == 1'b1) & (intr_pulse == 1'b1)) | ((epoch_and_tow_init_wr == 1'b1) & time_corr_pulse)) begin
            tow_counter <= tow_counter_init;
        end
        else if (week_pulse == 1'b1) begin
            tow_counter <= 20'b0;
        end
        else if (sec_pulse == 1'b1) begin
            tow_counter <= tow_counter + 1'b1;
        end
    end
    
    assign week_pulse = (tow_counter == (20'd604800 - 1)) & sec_pulse;
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            tow_int <= 20'b0;
        end
        else if (fix_pulse == 1'b1) begin
            tow_int[19 : 0] <= tow_counter[19 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            tow_sec <= 20'b0;
        end
        else if (sec_in == 1'b1) begin
            tow_sec[19 : 0] <= tow_counter[19 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            tow_time <= 20'b0;
        end
        else if (cur_time == 1'b1) begin
            tow_time[19 : 0] <= tow_counter[19 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            symb_counter <= 5'b0;
        end
        else if (((doinit == 1'b1) & (intr_pulse == 1'b1)) | ((chip_and_symb_init_wr == 1'b1) & time_corr_pulse)) begin
            symb_counter <= symb_counter_init;
        end
        else if (symb_counter == symb_max) begin
            symb_counter <= 5'b0;
        end
        else if (epoch_pulse == 1'b1) begin
            symb_counter <= symb_counter + 1'b1;
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            symb_int <= 5'b0;
        end
        else if (fix_pulse == 1'b1) begin
            symb_int[4 : 0] <= symb_counter[4 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            symb_sec <= 5'b0;
        end
        else if (sec_in == 1'b1) begin
            symb_sec[4 : 0] <= symb_counter[4 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            symb_time <= 5'b0;
        end
        else if (cur_time == 1'b1) begin
            symb_time[4 : 0] <= symb_counter[4 : 0];
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            dly_epoch_flag <= 1'b0;
        end
        else if (epoch_pulse) begin
            dly_epoch_flag <= 1'b1;
        end
        else if (dly_epoch) begin
            dly_epoch_flag <= 1'b0;
        end
    end
    
     always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            dly_epoch_flag_intr <= 1'b0;
        end
        else if (intr_fix_pulse == 1'b1) begin
            dly_epoch_flag_intr <= dly_epoch_flag;
        end
    end  
    
    assign code_phase_ext = code_phase;
    assign chip_and_symb_ext = {symb_counter, chip_counter};
    assign epoch_and_tow_ext = {epoch_counter, tow_counter};
    
    
endmodule
