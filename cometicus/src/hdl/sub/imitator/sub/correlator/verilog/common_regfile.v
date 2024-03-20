`timescale 1ns/10ps

`include "common_param.v"
`include "global_param.v"

module common_regfile(
    clk,
    reset_n,    
    wr_en,
    rd_en,
    reg_addr,
    wdata,
    rdata,
    smpl_cntl,
    smpl_cnth,
    intr_cnt,
`ifdef INTERRUPT_DIV2    
    fix_div2,
`endif
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
    progdone,
    locked,
    status,
    intr_cntl,
    clksource,
    extclk,
    intr_cntl_we,
    intr_per,
    intr_dur,
    prog_reset,
    ser_reset,
    lamp,
    mean,
`ifdef INTERRUPT_DIV2    
    intr_cntl_rd_en,
`endif
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
    do_init,
    cur_time,
    input0_reg,
    input1_reg,
    io0,
    io1,
    ext_src,
    pll_mult,
    pll_divide,
    pll_wr,
    pps_max,
    hist_addr,
    hist_dat,
    hist_lock
    );

    parameter BASE_ADDR = `ADDR_WIDTH'h4000;
  
    input clk;
    input reset_n;
    input wr_en;
    input rd_en;  
    input [`ADDR_WIDTH - 1 : 0] reg_addr;
    input [31 : 0] wdata;
    output [31 : 0] rdata;
    input [31 : 0] smpl_cntl;
    input [31 : 0] smpl_cnth;
    input [31 : 0] intr_cnt;
`ifdef INTERRUPT_DIV2    
    input fix_div2;
`endif
    input [31 : 0] code_rate_int;
    input [31 : 0] code_phase_int;
    input [31 : 0] code_phase_sec;
    input [31 : 0] code_phase_time;
    input [23 : 0] chip_int;
    input [23 : 0] chip_sec;
    input [23 : 0] chip_time;
    input [9 : 0] epoch_int;
    input [9 : 0] epoch_sec;
    input [9 : 0] epoch_time;
    input [9 : 0] epoch_int_intr;
    input [19 : 0] tow_int;
    input [19 : 0] tow_sec;
    input [19 : 0] tow_time;
    input [4 : 0] symb_int;        
    input [4 : 0] symb_sec;
    input [4 : 0] symb_time;
    input progdone;
    input locked;
    input status;    	
    output [3 : 0] intr_cntl;
    output clksource;
    output [2 : 0] extclk;
    output intr_cntl_we;
    output [`INTR_PERIOD_WIDTH - 1 : 0] intr_per;
`ifdef INTERRUPT_DIV2    
    output [`INTR_PULSE_DURATION_WIDTH - 1 + 8 : 0] intr_dur;
`else
    output [`INTR_PULSE_DURATION_WIDTH - 1 : 0] intr_dur;
`endif    
    output prog_reset;
    output ser_reset;
    output [`LAMP_NUMBER - 1 : 0] lamp;
    output [11 : 0] mean;
`ifdef INTERRUPT_DIV2    
    output intr_cntl_rd_en;
`endif
    output code_phase_init_wr;
    output chip_and_symb_init_wr;
    output epoch_and_tow_init_wr;
    output [31 : 0] code_rate;    
    output [31 : 0] code_phase_init;    
    output [23 : 0] chip_counter_init;
    output [23 : 0] chip_max;    
    output [9 : 0] epoch_counter_init;
    output [9 : 0] epoch_max;
    output [19 : 0] tow_counter_init;
    output [4 : 0] symb_counter_init;
    output [4 : 0] symb_max; 
    output [15 : 0] do_init;
    output cur_time;
    output [4 : 0] input0_reg;
    output [4 : 0] input1_reg;
    output io0;
    output io1;
    output [1 : 0] ext_src;
    output [7 : 0] pll_mult;
    output [7 : 0] pll_divide;
    output pll_wr;
    output [9:0] pps_max;
    output [7:0] hist_addr;
    input  [31:0] hist_dat;
    output hist_lock;
    
    reg [31 : 0] rdata;
    
    reg [3 : 0] intr_cntl;
    reg intr_cntl_we;
    reg [`INTR_PERIOD_WIDTH - 1 : 0] intr_per;
`ifdef INTERRUPT_DIV2    
    reg [`INTR_PULSE_DURATION_WIDTH - 1 + 8 : 0] intr_dur;
`else
    reg [`INTR_PULSE_DURATION_WIDTH - 1 : 0] intr_dur;
`endif      
    reg prog_reset_int;
    reg ser_reset;
    reg clksource;
    reg [2 : 0] extclk;
    
`ifdef INTERRUPT_DIV2    
    reg intr_cntl_rd_dly;
    reg intr_cntl_rd_en;
`endif
    
    reg [31 : 0] code_rate;  
    reg [31 : 0] code_phase_init;
    reg [23 : 0] chip_counter_init;
    reg [23 : 0] chip_max;  
    reg [9 : 0] epoch_counter_init;
    reg [9 : 0] epoch_max;   
    reg [19 : 0] tow_counter_init;    
    reg [4 : 0] symb_counter_init;
    reg [4 : 0] symb_max;    
    reg [15 : 0] do_init;
    reg [4 : 0] input0_reg;
    reg [4 : 0] input1_reg;
    reg io0;
    reg io1;
    reg [1 : 0] ext_src;
    reg cur_time;
    reg [7 : 0] pll_mult;
    reg [7 : 0] pll_divide;
    reg [9:0] pps_max;
    reg hist_lock;
    reg [7:0] hist_addr;
    
    reg [`LAMP_NUMBER - 1 : 0] lamp;
    reg [11 : 0] mean;
    wire lamp_wr;
    wire mean_wr;
    
    wire intr_cntl_wr;
    wire intr_per_wr;
    wire intr_dur_wr;        
    wire prog_reset;   
    
    wire intr_cntl_rd;
    wire intr_per_rd;
    wire intr_dur_rd;
    wire smpl_cntl_rd;
    wire smpl_cnth_rd; 
    wire intr_cnt_rd;
    wire lamp_rd;   
    
    assign intr_cntl_wr = (reg_addr == `INTR_CNTL_OFFSET) & wr_en;
    assign intr_cntl_rd = (reg_addr == `INTR_CNTL_OFFSET) & rd_en;
    assign intr_per_wr = (reg_addr == `INTR_PERIOD_OFFSET) & wr_en;
    assign intr_per_rd = (reg_addr == `INTR_PERIOD_OFFSET) & rd_en;
    assign intr_dur_wr = (reg_addr == `INTR_DURATION_OFFSET) & wr_en;
    assign intr_dur_rd = (reg_addr == `INTR_DURATION_OFFSET) & rd_en;
    assign smpl_cntl_rd = (reg_addr == `SAMPLE_COUNTL_OFFSET) & rd_en;
    assign smpl_cnth_rd = (reg_addr == `SAMPLE_COUNTH_OFFSET) & rd_en;
    assign int_cnt_rd = (reg_addr == `INTERRUPT_COUNTER_OFFSET) & rd_en;
    assign lamp_wr = (reg_addr == `LAMP_OFFSET) & wr_en;    
    assign lamp_rd = (reg_addr == `LAMP_OFFSET) & rd_en;
    assign code_rate_wr = (reg_addr == `COM_CODE_RATE_OFFSET) & wr_en;
    assign code_rate_rd = (reg_addr == `COM_CODE_RATE_OFFSET) & rd_en;
    assign code_phase_init_wr = (reg_addr == `COM_CODE_PHASE_INIT_OFFSET) & wr_en;
    assign chip_max_wr = (reg_addr == `COM_CHIP_MAX_OFFSET) & wr_en;
    assign chip_max_rd = (reg_addr == `COM_CHIP_MAX_OFFSET) & rd_en;
    assign chip_and_symb_init_wr = (reg_addr == `COM_CHIP_AND_SYMB_INIT_OFFSET) & wr_en;
    assign epoch_and_tow_init_wr = (reg_addr == `COM_EPOCH_AND_TOW_INIT_OFFSET) & wr_en;
    assign epoch_and_symb_max_wr = (reg_addr == `COM_EPOCH_AND_SYMB_MAX_OFFSET) & wr_en;
    assign epoch_and_symb_max_rd = (reg_addr == `COM_EPOCH_AND_SYMB_MAX_OFFSET) & rd_en;    
    assign do_init_wr = (reg_addr == `COM_DO_INIT_OFFSET) & wr_en;
    assign do_init_rd = (reg_addr == `COM_DO_INIT_OFFSET) & rd_en;
    assign code_phase_rd = (reg_addr == `COM_CODE_PHASE_OFFSET) & rd_en;
    assign code_phase_sec_rd = (reg_addr == `COM_CODE_PHASE_EXT_OFFSET) & rd_en;
    assign code_phase_time_rd = (reg_addr == `COM_CODE_PHASE_CUR_OFFSET) & rd_en;
    assign chip_and_symb_rd = (reg_addr == `COM_CHIP_AND_SYMB_OFFSET) & rd_en;
    assign chip_and_symb_sec_rd = (reg_addr == `COM_CHIP_AND_SYMB_EXT_OFFSET) & rd_en;
    assign chip_and_symb_time_rd = (reg_addr == `COM_CHIP_AND_SYMB_CUR_OFFSET) & rd_en;
    assign epoch_and_tow_rd = (reg_addr == `COM_EPOCH_AND_TOW_OFFSET) & rd_en;
    assign epoch_and_tow_sec_rd = (reg_addr == `COM_EPOCH_AND_TOW_EXT_OFFSET) & rd_en;
    assign epoch_and_tow_time_rd = (reg_addr == `COM_EPOCH_AND_TOW_CUR_OFFSET) & rd_en;
    assign epoch_intr_rd = (reg_addr == `COM_EPOCH_INTR_OFFSET) & rd_en;
    assign pll_wr = (reg_addr == `PLL_OFFSET) & wr_en;
    assign pll_rd = (reg_addr == `PLL_OFFSET) & rd_en;
    assign pps_max_wr = (reg_addr == `PPS_MAX_OFFSET) & wr_en;
    assign pps_max_rd = (reg_addr == `PPS_MAX_OFFSET) & rd_en;
    assign hist_lock_wr = (reg_addr == `HIST_LOCK_OFFSET) & wr_en;
	assign hist_addr_wr = (reg_addr == `HIST_ADDR_OFFSET) & wr_en;
    assign hist_lock_rd = (reg_addr == `HIST_LOCK_OFFSET) & rd_en;
    assign hist_addr_rd = (reg_addr == `HIST_ADDR_OFFSET) & rd_en;
    assign hist_dat_rd  = (reg_addr == `HIST_DAT_OFFSET)  & rd_en;
    
    
`ifdef INTERRUPT_DIV2
    `ifdef READ_ASYNC    
            level_sync#(
				.WIDTH(1)
			)
			level_sync_rd (
                .clk     (clk),
                .reset_n (reset_n),
                .async   (~intr_cntl_rd),
                .sync    (intr_cntl_rd_int)
            );
    `else
        assign intr_cntl_rd_int = ~intr_cntl_rd;      
    `endif
        
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_cntl_rd_dly <= 1'b0;
        end
        else begin
            intr_cntl_rd_dly <= intr_cntl_rd_int;
        end
    end
      
    assign intr_cntl_rd_ed = intr_cntl_rd_int & (~intr_cntl_rd_dly);
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_cntl_rd_en <= 1'b0;
        end
        else begin      
            intr_cntl_rd_en <= intr_cntl_rd_ed;
        end
    end
`endif    
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            lamp[`LAMP_NUMBER - 1 : 0] <= {`LAMP_NUMBER{1'b0}};
        end
        else begin
            if (lamp_wr) begin
                lamp[`LAMP_NUMBER - 1 : 0] <= wdata[`LAMP_NUMBER - 1 : 0];
            end
        end
    end
    
    assign mean_wr = (reg_addr == `MEAN_OFFSET) & wr_en;
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            mean <= 1'b0;
        end
        else begin
            if (mean_wr) begin
                mean <= wdata[11 : 0];
          end
        end
    end
    
    //Software reset registerf
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            prog_reset_int <= 1'b0;
        end
        else begin
            if (intr_cntl_wr) begin
                prog_reset_int <= wdata[8];
            end
            else begin
                prog_reset_int <= 1'b0;
            end
        end
    end
    
    assign prog_reset = ~prog_reset_int;
    
    //Software reset registerf
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            ser_reset <= 1'b0;
        end
        else begin
            if (intr_cntl_wr) begin
                ser_reset <= wdata[9];
            end
            else begin
                ser_reset <= 1'b0;
            end
        end
    end
    
    //Process interrupt control register
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_cntl <= 4'b0100;
        end
        else begin
            if (intr_cntl_wr) begin
                intr_cntl <= wdata[3 : 0];
            end
            else begin
                intr_cntl <= {1'b0, intr_cntl[2 : 0]};
            end
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            clksource <= 1'b0;
            extclk <= 3'b0;
        end
        else begin
            if (intr_cntl_wr) begin
                clksource <= wdata[4];
                extclk[2 : 0] <= wdata[7 : 5];
            end
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_cntl_we <= 1'b0;
        end
        else begin
            intr_cntl_we <= intr_cntl_wr;
        end
    end
    
    
    //Process interrupt period register
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            intr_per <= {`INTR_PERIOD_WIDTH{1'b0}};
        end
        else begin
            if (intr_per_wr) begin
                intr_per <= wdata;
            end      
        end
    end
    
    //Process interrupt duration register
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
`ifdef INTERRUPT_DIV2
            intr_dur <= {`INTR_PULSE_DURATION_WIDTH{1'b0}, 8'b0};
`else        
            intr_dur <= {`INTR_PULSE_DURATION_WIDTH{1'b0}};
`endif          
        end
        else begin
          if (intr_dur_wr) begin
`ifdef INTERRUPT_DIV2          
            intr_dur <= wdata[`INTR_PULSE_DURATION_WIDTH - 1 + 8 : 0];
`else            
            intr_dur <= wdata[`INTR_PULSE_DURATION_WIDTH - 1 : 0];
`endif  
          end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_rate <= 32'b0;
        end
        else begin
            if (code_rate_wr) begin
                code_rate <= wdata;
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            code_phase_init <= 32'b0;
        end
        else begin
            if (code_phase_init_wr) begin
                code_phase_init <= wdata;
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            chip_max <= 24'b0;            
        end
        else begin
            if (chip_max_wr) begin
                chip_max <= wdata[23 : 0];                
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            chip_counter_init <= 24'b0;
            symb_counter_init <= 5'b0;
        end
        else begin
            if (chip_and_symb_init_wr) begin
                chip_counter_init <= wdata[23 : 0];
                symb_counter_init <= wdata[28 : 24];
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_counter_init <= 10'b0;
            tow_counter_init <= 20'b0;
        end
        else begin
            if (epoch_and_tow_init_wr) begin
                epoch_counter_init <= wdata[9 : 0];
                tow_counter_init <= wdata[29 : 10];
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            epoch_max <= 10'b0;  
            symb_max <= 5'b0;          
        end
        else begin
            if (epoch_and_symb_max_wr) begin
                epoch_max <= wdata[9 : 0];
                symb_max <= wdata[14 : 10];                
            end      
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            do_init <= 16'b0;
            input0_reg <= 5'b0;
            input1_reg <= 5'b0;
            io0 <= 1'b0;
            io1 <= 1'b0;
            ext_src <= 2'b0;
            cur_time <= 1'b0;
        end
        else begin
            if (do_init_wr) begin
                do_init <= wdata[31 : 16];
                ext_src <= wdata[2 : 1];
                input0_reg <= wdata[7 : 3];
                io0 <= wdata[8];                
                input1_reg <= wdata[13 : 9];
                io1 <= wdata[14];                
                cur_time <= wdata[15];
            end
            else begin
                do_init <= 16'b0;
                cur_time <= 1'b0;
            end                
                  
        end
    end
    
    always @ (posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            pll_mult <= 8'b0;  
            pll_divide <= 8'b0;          
        end
        else begin
            if (pll_wr) begin
                pll_mult <= wdata[7 : 0];
                pll_divide <= wdata[15 : 8];                
            end      
        end
    end
    
    always@(posedge clk or negedge reset_n)
    if(reset_n == 1'b0)
        pps_max <= 0;
    else
        if(pps_max_wr)
            pps_max <= wdata[9:0];
    
    always@(posedge clk or negedge reset_n)
    if(reset_n == 1'b0)
        hist_lock <= 0;
    else
        if(hist_lock_wr)
            hist_lock <= wdata[0];
    
    always@(posedge clk or negedge reset_n)
    if(reset_n == 1'b0)
        hist_addr <= 0;
    else
        if(hist_addr_wr)
            hist_addr <= wdata[7:0];
    
    always @ (*) begin
        rdata = {32{1'b0}};
        case (1'b1)
`ifdef INTERRUPT_DIV2        
            intr_cntl_rd          : rdata = {8'hab, 8'd`CHANNELS, 8'b0, fix_div2, extclk, clksource, 1'b0, intr_cntl[2 : 0]};
`else
            intr_cntl_rd          : rdata = {8'hab, 8'd`CHANNELS, 8'b0, extclk, clksource, 1'b0, intr_cntl[2 : 0]};
`endif
			do_init_rd            : rdata = {16'b0, io1, input1_reg, io0, input0_reg, ext_src, 1'b0};
            intr_per_rd           : rdata = intr_per;
            intr_dur_rd           : rdata = intr_dur;    
            smpl_cntl_rd          : rdata = smpl_cntl;
            smpl_cnth_rd          : rdata = smpl_cnth;
            int_cnt_rd            : rdata = intr_cnt;
            lamp_rd               : rdata = lamp[`LAMP_NUMBER - 1 : 0];
            code_phase_rd         : rdata = code_phase_int;
            code_phase_sec_rd     : rdata = code_phase_sec;
            code_phase_time_rd    : rdata = code_phase_time;
            chip_max_rd           : rdata = chip_max;
            epoch_and_symb_max_rd : rdata = {symb_max, epoch_max};
            chip_and_symb_rd      : rdata = {symb_int, chip_int};
            chip_and_symb_sec_rd  : rdata = {symb_sec, chip_sec};
            chip_and_symb_time_rd : rdata = {symb_time, chip_time};
            epoch_and_tow_rd      : rdata = {tow_int, epoch_int};
            epoch_and_tow_sec_rd  : rdata = {tow_sec, epoch_sec};
            epoch_and_tow_time_rd : rdata = {tow_time, epoch_time};
            epoch_intr_rd         : rdata = epoch_int_intr;
            code_rate_rd          : rdata = code_rate_int;
            pll_rd                : rdata = {status, locked, progdone, pll_divide, pll_mult};
            pps_max_rd            : rdata = pps_max;
            hist_dat_rd           : rdata = hist_dat;
            hist_lock_rd          : rdata = {{31{1'b0}},hist_lock};
			hist_addr_rd          : rdata = {{24{1'b0}},hist_addr};
        endcase
    end 
    
endmodule
