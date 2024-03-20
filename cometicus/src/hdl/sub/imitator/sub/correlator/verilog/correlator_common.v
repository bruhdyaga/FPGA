`timescale 1ns/10ps

`include "common_param.v"
`include "global_param.v" 

module correlator_common ( 
    clk,
    pclk,
    reset_n,
    wr_en,
    rd_en,
    reg_addr,
    wdata,
    sec_in,
    progdone,
    locked,
    status,
    rdata,
`ifdef DATA_COLLECTOR    
    time_int,
`endif    
    prog_reset,
    ser_reset,
    intr_pulse,
    fix_pulse,
    intr,
`ifdef INTERRUPT_DIV2
    intr_div2,
`endif    
    clksource,
    extclk,
    mean,
    lamp,
    sec_out,
    pps_pulse,
    pll_mult,
    pll_divide,
    pll_wr,
    input0_reg,
    input1_reg,
    io0,
    io1,
    ext_src,
    code_phase_ext,
    chip_and_symb_ext,
    epoch_and_tow_ext,
    hist_addr,
    hist_dat,
    hist_lock
    );

    input clk;
    input pclk;
    input reset_n;
    input wr_en;
    input rd_en;
    input [`ADDR_WIDTH - 1 : 0] reg_addr;
    input [31 : 0] wdata;
    input sec_in;
    input progdone;
    input locked;
    input status;

    output [31 : 0] rdata;
`ifdef DATA_COLLECTOR    
    output [63 : 0] time_int;
`endif
	output intr_pulse;
    output fix_pulse;
    output prog_reset;
    output ser_reset;
    output intr;
`ifdef INTERRUPT_DIV2    
    output intr_div2;
`endif    
    output clksource;
    output [2 : 0] extclk;
    output [11 : 0] mean;
    output [`LAMP_NUMBER - 1 : 0] lamp;
    output sec_out;
    output pps_pulse;
    output [7 : 0] pll_mult;
    output [7 : 0] pll_divide;
    output pll_wr;
    output [4 : 0] input0_reg;
    output [4 : 0] input1_reg;
    output io0;
    output io1;
    output [1 : 0] ext_src;
    output [31 : 0] code_phase_ext;
    output [28 : 0] chip_and_symb_ext;
    output [29 : 0] epoch_and_tow_ext;
    output [7:0] hist_addr;
    input  [31:0] hist_dat;
    output hist_lock;
    
    
    parameter BASE_ADDR = `ADDR_WIDTH'h4000;

    wire [3 : 0] intr_cntl;
    wire [3 : 0] intr_cntl_int;
    wire [`INTR_PERIOD_WIDTH - 1 : 0] intr_per; 
`ifdef INTERRUPT_DIV2           
    wire [`INTR_PULSE_DURATION_WIDTH - 1 + 8 : 0] intr_dur;
`else
    wire [`INTR_PULSE_DURATION_WIDTH - 1 : 0] intr_dur;
`endif         
    wire [31 : 0] smpl_cntl;
    wire [31 : 0] smpl_cnth;    
    wire [31 : 0] intr_cnt;
    wire [31 : 0] code_phase_int;
    wire [31 : 0] code_phase_sec;
    wire [31 : 0] code_phase_time;
    wire [23 : 0] chip_int;
    wire [23 : 0] chip_sec;
    wire [23 : 0] chip_time;
    wire [9 : 0] epoch_int;
    wire [9 : 0] epoch_sec;
    wire [9 : 0] epoch_time;
    wire [9 : 0] epoch_int_intr;
    wire [19 : 0] tow_int;
    wire [19 : 0] tow_sec;
    wire [19 : 0] tow_time;
    wire [4 : 0] symb_int;
    wire [4 : 0] symb_sec;
    wire [4 : 0] symb_time;
    wire [31 : 0] code_rate;
    wire [31 : 0] code_phase_init;
    wire [23 : 0] chip_counter_init;
    wire [23 : 0] chip_max;    
    wire [9 : 0] epoch_counter_init;
    wire [9 : 0] epoch_max;
    wire [19 : 0] tow_counter_init;
    wire [4 : 0] symb_counter_init;
    wire [4 : 0] symb_max;
    wire [31 : 0] code_rate_int;
    wire [9:0] pps_max;
    
    wire [7:0] hist_addr;
    wire [31:0] hist_dat;
    
    reg sec_out;
    reg dly_sec;

    wire [15 : 0] doinit_pulse;
   
    common_regfile 
    #(BASE_ADDR) COM_REGFILE(
        .clk                   (clk),
        .reset_n               (reset_n),
        .wr_en                 (wr_en),
        .rd_en                 (rd_en),
        .reg_addr              (reg_addr),
        .wdata                 (wdata),
        .rdata                 (rdata),
        .smpl_cntl             (smpl_cntl),
        .smpl_cnth             (smpl_cnth),
        .intr_cnt              (intr_cnt),
`ifdef INTERRUPT_DIV2        
        .fix_div2              (fix_div2),
`endif
        .code_rate_int         (code_rate_int),
        .code_phase_int        (code_phase_int),
        .code_phase_sec        (code_phase_sec),
        .code_phase_time       (code_phase_time),
        .chip_int              (chip_int),
        .chip_sec              (chip_sec),
        .chip_time             (chip_time),
        .epoch_int             (epoch_int),
        .epoch_sec             (epoch_sec),
        .epoch_time            (epoch_time),
        .epoch_int_intr        (epoch_int_intr),
        .tow_int               (tow_int),
        .tow_sec               (tow_sec),
        .tow_time              (tow_time),
        .symb_int              (symb_int),
        .symb_sec              (symb_sec),
        .symb_time             (symb_time),
        .progdone              (progdone),
    	.locked                (locked),
    	.status                (status),
        .intr_cntl             (intr_cntl),
        .clksource             (clksource),
        .extclk                (extclk),
        .intr_cntl_we          (intr_cntl_we),
        .intr_per              (intr_per),
        .intr_dur              (intr_dur),
        .prog_reset            (prog_reset),
        .ser_reset             (ser_reset),
        .lamp                  (lamp),
        .mean                  (mean),
`ifdef INTERRUPT_DIV2        
        .intr_cntl_rd_en       (intr_cntl_rd_en),
`endif
        .code_phase_init_wr    (code_phase_init_wr),
        .chip_and_symb_init_wr (chip_and_symb_init_wr),
        .epoch_and_tow_init_wr (epoch_and_tow_init_wr),        
        .code_rate             (code_rate),
        .code_phase_init       (code_phase_init),
        .chip_counter_init     (chip_counter_init),
        .chip_max              (chip_max),
        .epoch_counter_init    (epoch_counter_init),
        .epoch_max             (epoch_max),
        .tow_counter_init      (tow_counter_init),
        .symb_counter_init     (symb_counter_init),
        .symb_max              (symb_max),
        .do_init               (doinit_pulse),
        .cur_time              (cur_time),
        .input0_reg            (input0_reg),
        .input1_reg            (input1_reg),
        .io0                   (io0),
        .io1                   (io1),
        .ext_src               (ext_src),
        .pll_mult              (pll_mult),
    	.pll_divide            (pll_divide),
    	.pll_wr                (pll_wr),
    	.pps_max               (pps_max),
        .hist_addr             (hist_addr),
        .hist_dat              (hist_dat),
        .hist_lock             (hist_lock)
    );   
    
    common_sync COM_SYNC (
        .sclk                 (clk),
        .dclk                 (pclk),
        .reset_n              (reset_n & prog_reset),
        .intr_cntl            (intr_cntl),
        .intr_cntl_we         (intr_cntl_we),
`ifdef INTERRUPT_DIV2        
        .intr_cntl_rd_en      (intr_cntl_rd_en),       
        .intr_cntl_sync       (intr_cntl_int),
        .intr_cntl_rd_en_sync (intr_cntl_rd_en_sync)
`else
        .intr_cntl_sync       (intr_cntl_int)
`endif        
    );
    
    flag_sync_n DO_INIT (
        .sclk          (clk),
        .dclk          (pclk),
        .reset_n       (reset_n & prog_reset),
        .set_pulse     (doinit_pulse),
        .rst_pulse     (intr_pulse),
        .flag          (doinit)
    );
    
    flag_sync CODE_PHASE_INIT (
        .sclk          (clk),
        .dclk          (pclk),
        .reset_n       (reset_n & prog_reset),
        .set_pulse     (code_phase_init_wr),
        .rst_pulse     (fix_pulse),
        .flag          (code_phase_init_wr_sync)
    );
    
    flag_sync EPOCH_AND_TOW_INIT (
        .sclk          (clk),
        .dclk          (pclk),
        .reset_n       (reset_n & prog_reset),
        .set_pulse     (epoch_and_tow_init_wr),
        .rst_pulse     (fix_pulse),
        .flag          (epoch_and_tow_init_wr_sync)
    );    
    
    flag_sync CHIP_AND_SYMB_INIT (
        .sclk          (clk),
        .dclk          (pclk),
        .reset_n       (reset_n & prog_reset),
        .set_pulse     (chip_and_symb_init_wr),
        .rst_pulse     (fix_pulse),
        .flag          (chip_and_symb_init_wr_sync)
    );
    
    signal_sync CURTIME(
        .sclk      (clk),
        .dclk      (pclk),
        .reset_n   (reset_n & prog_reset),
        .start     (cur_time),
        .ready     (cur_time_int)
    );
    
    common_timegen COM_TIMEGEN(
        .clk                (pclk),
        .reset_n            (reset_n & prog_reset),
        .time_enable        (1'b1),
        .intr_period        (intr_per),
        .intr_enable        (intr_cntl_int[0]),    
        .intr_type          (intr_cntl_int[1]),
        .intr_polarity      (intr_cntl_int[2]),
        .intr_duration      (intr_dur[`INTR_PULSE_DURATION_WIDTH - 1 : 0]),
`ifdef INTERRUPT_DIV2        
        .intr_div2_duration (intr_dur[`INTR_PULSE_DURATION_WIDTH - 1 + 8 : `INTR_PULSE_DURATION_WIDTH]),
`endif        
        .intr_release       (intr_cntl_int[3]),
`ifdef INTERRUPT_DIV2        
        .fix_div2_clear     (intr_cntl_rd_en_sync),
`endif        
        .fix_pulse          (intr_pulse),
`ifdef INTERRUPT_DIV2        
        .fix_div2           (fix_div2),
`endif        
        .time_0             (smpl_cntl),
        .time_1             (smpl_cnth),
        .intr_cnt           (intr_cnt),
`ifdef DATA_COLLECTOR        
        .time_int           (time_int),
`endif        
`ifdef INTERRUPT_DIV2        
        .intr               (intr),
        .intr_div2          (intr_div2)
`else
        .intr               (intr)
`endif        
    );
    
    time_generator
      #(.SCALE_TYPE            (1'b1))  // 1 - общая шкала времени приёмника
      COM_TG(
        .clk                   (pclk),
        .reset_n               (reset_n & prog_reset),
        .doinit                (doinit),
        .fix_pulse             (fix_pulse),
        .intr_pulse            (intr_pulse),
        .intr_fix_pulse        (intr_pulse),
        .dly_epoch             (fix_pulse),
        .sec_in                (sec_in_int),
        .cur_time              (cur_time_int),
        .code_phase_init_wr    (code_phase_init_wr_sync),
        .chip_and_symb_init_wr (chip_and_symb_init_wr_sync),
        .epoch_and_tow_init_wr (epoch_and_tow_init_wr_sync),
        .code_rate             (code_rate),
        .code_phase_init       (code_phase_init),
        .chip_counter_init     (chip_counter_init),
        .chip_max              (chip_max),
        .epoch_counter_init    (epoch_counter_init),
        .epoch_max             (epoch_max),
        .tow_counter_init      (tow_counter_init),
        .symb_counter_init     (symb_counter_init),
        .symb_max              (symb_max),
        .code_rate_int         (code_rate_int),
        .code_phase_int        (code_phase_int),
        .code_phase_sec        (code_phase_sec),
        .code_phase_time       (code_phase_time),
        .chip_int              (chip_int),
        .chip_sec              (chip_sec),
        .chip_time             (chip_time),
        .epoch_int             (epoch_int),
        .epoch_sec             (epoch_sec),
        .epoch_time            (epoch_time),
        .epoch_int_intr        (epoch_int_intr),
        .tow_int               (tow_int),
        .tow_sec               (tow_sec),
        .tow_time              (tow_time),
        .symb_int              (symb_int),
        .symb_sec              (symb_sec),
        .symb_time             (symb_time),
        .shift                 (),
        .epoch_pulse           (fix_pulse),
        .sec_pulse             (sec_pulse),
        .pps_pulse             (pps_pulse),
		.prn_reset             (1'b0),
		.code_phase_ext        (code_phase_ext),
		.chip_and_symb_ext     (chip_and_symb_ext),
		.epoch_and_tow_ext     (epoch_and_tow_ext),
		.dly_epoch_flag_intr   (),
		.pps_max               (pps_max)
    );
    
    level_sync#(
		.WIDTH(1)
	)
	level_sync1 (
    	.clk     (pclk),
    	.reset_n (reset_n),
    	.async   (sec_in),
    	.sync    (sec_in_sync)
  	);
  	
  	always @ (posedge pclk or negedge reset_n) begin
    	if (reset_n == 1'b0) begin
      		dly_sec <= 1'b0;
    	end
    	else begin
      		dly_sec <= sec_in_sync;
    	end
  	end
  
  	assign sec_in_int = (~dly_sec) & sec_in_sync;
    
    always @ (posedge pclk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            sec_out <= 32'b0;
        end
        else begin
            if (sec_pulse) begin
                sec_out <= 1'b1;
            end
            else if (fix_pulse) begin
                sec_out <= 1'b0;
            end
        end
    end
    
endmodule
