`timescale 1ns/10ps
module histogram_tb();

`include "bus_syn_task.v"
`include "math.v"

parameter LINES = 7;
parameter BASE_ADDR = 32'h52000000/4;

localparam TEST_DATA_WIDTH = 10;

localparam ID_ADDR      = 0;
localparam LENGTH_ADDR  = 1;
localparam LINES_ADDR   = 2;
localparam IN_DATA_ADDR = 3;
localparam ID = 32'hEAD0007C;

reg clk = 1;
reg resetn;
reg signed [TEST_DATA_WIDTH-1:0] rand_data [LINES-1:0];
wire [LINES-1:0] sig;
wire [LINES-1:0] mag;
reg [31:0] rdata;
integer CNTR_LENGTH;
integer LINES_REG;




genvar i;
integer i_int,j_int;

always #5 clk = !clk;

initial begin
     resetn = 1'b1;
#30  resetn = 1'b0;
#200 resetn = 1'b1;
end


generate
for(i = 0; i < LINES; i = i + 1) begin: loop_test_data
	always@(posedge clk or negedge resetn)
	if(resetn == 0)
		rand_data[i] <= 0;
	else
		rand_data[i] <= $urandom_range(2**TEST_DATA_WIDTH,0) - 2**(TEST_DATA_WIDTH-1);
	
	assign sig[i] = rand_data[i] > 0;
	assign mag[i] = `ABS(rand_data[i]) > 2**(TEST_DATA_WIDTH-1)/3*2;
end
endgenerate

initial begin
forever begin
	@(negedge resetn)
	@(posedge resetn)//ну погнали!
	INIT_BIS_TASK;
	
	READ_BIS_TASK(BASE_ADDR + ID_ADDR,rdata,0);
	while(rdata != ID) begin//дожидаемся чтения нужной константы
		READ_BIS_TASK(BASE_ADDR + ID_ADDR,rdata,0);
		$display ("%7gns wait bus constant", $time);
	end//ресет завершен, датаколлектор готов
	$display ("%7gns bus constant OK!", $time);
	
	READ_BIS_TASK(BASE_ADDR + LENGTH_ADDR,rdata,0);
	CNTR_LENGTH <= rdata;
	$display ("%7gns CNTR_LENGTH : %d", $time, rdata);
	
	READ_BIS_TASK(BASE_ADDR + LINES_ADDR,rdata,0);
	LINES_REG <= rdata;
	$display ("%7gns LINES_REG : %d", $time, rdata);
	
	for(i_int = 0;i_int < 5;i_int = i_int + 1'b1) begin
		#1e6
		$display ("%7gns ---iteration--- : %d", $time, i_int);
		for(j_int = 0;j_int < LINES_REG/2;j_int = j_int + 1'b1) begin
			$display ("%7gns channel : %2d", $time, j_int);
			READ_BIS_TASK(BASE_ADDR + IN_DATA_ADDR + j_int,rdata,0);
			$display ("%7gns sig = %.1f", $time, rdata*100.0/(2**CNTR_LENGTH));
		end
		for(j_int = LINES_REG/2;j_int < LINES_REG;j_int = j_int + 1'b1) begin
			$display ("%7gns channel : %2d", $time, j_int);
			READ_BIS_TASK(BASE_ADDR + IN_DATA_ADDR + j_int,rdata,0);
			$display ("%7gns mag = %.1f", $time, rdata*100.0/(2**CNTR_LENGTH));
		end
	end
end
end

reg [1:0] test_sigmag_cntr = 0;
always@(posedge clk)
test_sigmag_cntr <= test_sigmag_cntr + 1'b1;

histogram#(
	.BUS_ADDR_WIDTH (BUS_ADDR_WIDTH),
	.BASE_ADDR      (BASE_ADDR),
	.LINES          (LINES*2+2)
)
histogram_inst(
	.clk        (clk),
	.resetn     (resetn),
	.in_data    ({mag,sig,test_sigmag_cntr==0,test_sigmag_cntr[0]}),
	.bus_clk    (BIS_clk),
	.bus_resetn (BIS_resetn),
	.rdata      (BIS_rdata),
	.addr       (BIS_addr),
	.rd         (BIS_rd)
);

endmodule