`timescale 1ns/1ns

module data_recorder_tb();

`include "bus_syn_task.v"
`include "data_recorder_param.v"

parameter NUM            = 1;
parameter BASE_ADDR      = (32'h52000000/4);
parameter NUM_PORTS      = 1;
parameter DATA_WIDTH     = 32;
parameter DATA_DEPTH     = 8;

reg clk = 1;
wire [NUM_PORTS*DATA_WIDTH-1:0] data_out;

always #5 clk = !clk;
reg resetn = 1;

initial begin
     resetn = 1'b1;
#30  resetn = 1'b0;
#200 resetn = 1'b1;
end

initial begin
forever begin
	@(negedge resetn)
	@(posedge resetn)//ну погнали!
	INIT_BIS_TASK;
	
	WRITE_BIS_TASK(BASE_ADDR + SOFT_RESETN_ADDR,1);//soft reset
	
	while(BIS_rdata != DATA_RECORDER_CONST) begin//дожидаемся чтения нужной константы
		READ_BIS_TASK(BASE_ADDR + DATA_RECORDER_CONST_ADDR);
		$display ("%7gns wait bus constant", $time);
	end
	
	WRITE_BIS_TASK(BASE_ADDR + BUS_CHAN_ADDR,0);//выбрали 0-й канал
	
	
	WRITE_BIS_TASK(BASE_ADDR + RAM_ADDR,1);
	WRITE_BIS_TASK(BASE_ADDR + RAM_ADDR,2);
	WRITE_BIS_TASK(BASE_ADDR + RAM_ADDR,3);
	WRITE_BIS_TASK(BASE_ADDR + RAM_ADDR,4);
	WRITE_BIS_TASK(BASE_ADDR + RAM_ADDR,5);
	WRITE_BIS_TASK(BASE_ADDR + RAM_ADDR,6);
	WRITE_BIS_TASK(BASE_ADDR + RAM_ADDR,7);
	WRITE_BIS_TASK(BASE_ADDR + RAM_ADDR,8);
	
	WRITE_BIS_TASK(BASE_ADDR + RD_DEPTH_ADDR,8);//сколько читать по кругу
	WRITE_BIS_TASK(BASE_ADDR + RD_START_ADDR,1);//дали команду на старт
	
	#330
	WRITE_BIS_TASK(BASE_ADDR + RD_START_ADDR,0);//стоп
	WRITE_BIS_TASK(BASE_ADDR + BUS_CHAN_ADDR,0);
end
end

data_recorder#(
	.BUS_ADDR_WIDTH (BUS_ADDR_WIDTH),
	.NUM            (NUM),
	.BASE_ADDR      (BASE_ADDR),
	.NUM_PORTS      (NUM_PORTS),
	.DATA_WIDTH     (DATA_WIDTH),
	.DATA_DEPTH     (DATA_DEPTH)
)
data_recorder_inst(
	.clk        (clk),
	.resetn     (resetn),
	.data_out   (data_out),
	.valid      (valid),
	.bus_clk    (BIS_clk),
	.bus_resetn (BIS_resetn),
	.bus_addr   (BIS_addr),
	.bus_wdata  (BIS_wdata),
	.bus_rdata  (BIS_rdata),
	.bus_wr     (BIS_wr),
	.bus_rd     (BIS_rd)
);

endmodule