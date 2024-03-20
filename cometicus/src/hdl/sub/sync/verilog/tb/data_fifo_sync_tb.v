`timescale 1ns/1ps
module data_fifo_sync_tb();

parameter WIDTH      = 16;
parameter DEPTH_TEST = 32;

reg  clk = 0;
reg  wrclk_jit = 0;
reg  rdclk_jit = 0;
reg  resetn;
wire [WIDTH-1:0] data_asy;
wire [WIDTH-1:0] data_syn;
wire error;
reg  [15:0] num_errors = 0;
reg  [31:0] wr_addr;
reg  [31:0] rd_addr;
reg  [WIDTH-1:0] test_data_mem [DEPTH_TEST-1:0];
reg  [WIDTH-1:0] rd_data_mem [DEPTH_TEST-1:0];

parameter CLK_PER = 5;
parameter JITTER  = 30;// % from clk
integer SEED1;
integer SEED2;
integer cntr_1;
integer cntr_2;
wire [5:0] cntr_diff;

integer i_mem_d;//count depth

//инициализация массива данных случайными числами на весь объем дата коллектора
initial begin
	for(i_mem_d = 0;i_mem_d < DEPTH_TEST;i_mem_d = i_mem_d + 1) begin
		test_data_mem[i_mem_d] = $urandom_range(2**WIDTH-1,0);
	end
end

initial begin
SEED1 = $urandom_range(2**32-1,0);
SEED2 = $urandom_range(2**32-1,0);
end

always #CLK_PER clk = ~clk;

always@(edge clk)
#($dist_uniform(SEED1,0,CLK_PER*10*JITTER)/1000.0) wrclk_jit <= clk;

always@(edge clk)
#($dist_uniform(SEED2,0,CLK_PER*10*JITTER)/1000.0) rdclk_jit <= clk;


always@(posedge wrclk_jit or negedge resetn)
if(resetn == 0)
	cntr_1 <= 0;
else
	cntr_1 <= cntr_1 + 1'b1;

always@(posedge rdclk_jit or negedge resetn)
if(resetn == 0)
	cntr_2 <= 0;
else
	cntr_2 <= cntr_2 + 1'b1;

assign cntr_diff = cntr_2 - cntr_1;


initial begin
     resetn = 1'b1;
#30  resetn = 1'b0;
#100 resetn = 1'b1;
end


// always@(posedge wrclk_jit or negedge resetn)
// if(resetn == 0)
	// data_asy <= 0;
// else
	// data_asy <= data_asy + 1'b1;

always@(posedge wrclk_jit or negedge resetn)
if(resetn == 0)
	wr_addr <= 0;
else
	if(wr_addr == DEPTH_TEST - 1)
		wr_addr <= 0;
	else
		wr_addr <= wr_addr + 1'b1;


assign data_asy = test_data_mem[wr_addr];

data_fifo_sync#(
    .WIDTH (WIDTH)
)data_fifo_sync (
    .wrclk    (wrclk_jit),
    .wrresetn (resetn),
    .rdclk    (rdclk_jit),
    .rdresetn (resetn),
    .async    (data_asy),
    .sync     (data_syn),
    .error    (error)
);

always@(posedge rdclk_jit or negedge resetn)
if(resetn == 0)
	rd_addr <= 0;
else
	if(rd_addr == DEPTH_TEST - 1)
		rd_addr <= 0;
	else
		rd_addr <= rd_addr + 1'b1;

always@(posedge rdclk_jit or negedge resetn)
rd_data_mem[rd_addr] <= data_syn;


reg [WIDTH-1:0] asy_data_compare;
reg [WIDTH-1:0] syn_data_compare;

initial begin
forever begin

@(negedge resetn)
@(posedge resetn)//ну погнали!
$display ("%7gns after reset", $time);

@(posedge wrclk_jit)
@(posedge wrclk_jit)
@(posedge wrclk_jit)
$display ("%7gns after pause", $time);

forever begin
	@(posedge wrclk_jit)
	asy_data_compare <= data_asy;
	// $display ("%7gns wr_addr = %d", $time, wr_addr);
	// $display ("%7gns forever2", $time);
end

end
end

initial begin
forever begin
	@(posedge rdclk_jit)
	syn_data_compare <= data_syn;
	// $display ("%7gns rd_addr = %d", $time, rd_addr);
end
end


integer i_int;

initial begin
i_int = 0;
forever begin
	@(posedge wrclk_jit)
	$display ("%7gns %3d | wr_addr = %d | asy = 0x%h", $time, i_int, wr_addr, asy_data_compare);
	i_int = i_int + 1;
end
end

initial begin
i_int = 0;
forever begin
	@(posedge rdclk_jit)
	$display ("%7gns %3d | rd_addr = %d | syn = 0x%h", $time, i_int, rd_addr, syn_data_compare);
	i_int = i_int + 1;
end
end

// always@(posedge rdclk_jit or negedge resetn)
// if(resetn == 0)
	// num_errors <= 0;
// else
	// if(data_syn != wr_addr[wr_addr-3])
		// num_errors <= num_errors + 1'b1;

endmodule