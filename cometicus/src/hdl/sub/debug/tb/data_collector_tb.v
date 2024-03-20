// vsim -novopt +notimingchecks +nospecify debug.data_collector_tb

`timescale 1ns/10ps
module data_collector_tb();
`include "data_collector_param.v"
`include "bus_syn_task.v"
`include "math.v"

parameter NUM        = 0;
parameter BASE_ADDR  = (32'h52000000/4);
parameter NUM_PORTS  = 3;
parameter DATA_WIDTH = 31;
parameter DATA_DEPTH = 12369;

reg /* [NUM_PORTS-1:0]  */clk = '1;
reg  resetn;
wire [DATA_WIDTH*NUM_PORTS-1:0] test_data_cong;
reg  we = 1'b0;
reg  reset_data = 1'b0;
reg  [DATA_WIDTH-1:0] test_data_mem [NUM_PORTS-1:0][DATA_DEPTH-1:0];
reg  [log2(DATA_DEPTH)-1:0] addr_data;
reg [31:0] rdata;

genvar i;
integer i_int, j_int, k_int;
integer err = 0;

initial begin
     resetn = 1'b1;
#30  resetn = 1'b0;
#200 resetn = 1'b1;
end

always #5 clk = !clk;
// always #5 clk[0] = !clk[0];
// always #6 clk[1] = !clk[1];

integer i_mem_d;//count depth
integer i_mem_p;//count ports

//инициализация массива данных случайными числами на весь объем дата коллектора
initial begin
	for(i_mem_p = 0;i_mem_p < NUM_PORTS;i_mem_p = i_mem_p + 1) begin
		for(i_mem_d = 0;i_mem_d < DATA_DEPTH;i_mem_d = i_mem_d + 1) begin
			test_data_mem[i_mem_p][i_mem_d] = $urandom_range(2**DATA_WIDTH-1,0);
		end
	end
end


generate
	for(i=0;i < NUM_PORTS;i = i + 1) begin
		assign test_data_cong[DATA_WIDTH+i*DATA_WIDTH-1:i*DATA_WIDTH] = test_data_mem[i][addr_data];
	end
endgenerate

always@(posedge clk or negedge resetn)
if(resetn == 0)
	addr_data <= 0;
else if(reset_data)
	addr_data <= 0;
else if(we)
	addr_data <= addr_data + 1'b1;

initial begin
forever begin
	@(negedge resetn)
	@(posedge resetn)//ну погнали!
	INIT_BIS_TASK;
	
for(k_int = 0; k_int < 2; k_int = k_int + 1) begin
	we <= 1'b0;//отключаем синхронный старт
	@(posedge clk)
	@(posedge clk)
	reset_data <= 1'b1;//сбрасываем счетчик данных
	@(posedge clk)
	@(posedge clk)
	reset_data <= 1'b0;//сняли ресет
	
	$display ("%7gns send soft_reset", $time);
	WRITE_BIS_TASK(BASE_ADDR + SOFT_RESETN_ADDR,1,0);//soft reset
	
	READ_BIS_TASK(BASE_ADDR + DATA_COLL_CONST_ADDR,rdata,0);
	while(rdata != DATA_COLL_CONST) begin//дожидаемся чтения нужной константы
		READ_BIS_TASK(BASE_ADDR + DATA_COLL_CONST_ADDR,rdata,0);
		$display ("%7gns wait bus constant", $time);
	end//ресет завершен, датаколлектор готов
	$display ("%7gns bus constant OK!", $time);
	
	// WRITE_BIS_TASK(BASE_ADDR + WE_DIS_ADDR,1);//отключаем синхронный старт
	
	for(i_int = 0;i_int < NUM_PORTS;i_int = i_int + 1'b1) begin//разрешаем запись по всем каналам
		$display ("%7gns change channel %d", $time, i_int);
		WRITE_BIS_TASK(BASE_ADDR + BUS_CHAN_ADDR,i_int,0);//выбрали канал
		$display ("%7gns wr enable", $time);
		WRITE_BIS_TASK(BASE_ADDR + WR_PERM_ADDR,1,0);//разрешили запись
	end
	
	// /*временно*/$display ("%7gns change channel %d", $time, 0);
	// /*временно*/WRITE_BIS_TASK(BASE_ADDR + BUS_CHAN_ADDR,0,0);//выбрали 0-й канал
	// /*временно*/$display ("%7gns wr enable", $time);
	// /*временно*/WRITE_BIS_TASK(BASE_ADDR + WR_PERM_ADDR,0,0);//запретили запись
	
	
	$display ("%7gns wr depth %d", $time, DATA_DEPTH);
	WRITE_BIS_TASK(BASE_ADDR + WR_DEPTH_ADDR,DATA_DEPTH,0);//задаем объем записи
	
	$display ("%7gns wr start", $time);
	WRITE_BIS_TASK(BASE_ADDR + TRIG_EN_ADDR,1,0);//триггер старта записи
	
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)//ждем синхронизации триггера trig_en несколько клоков
		we <= 1'b1;//даем синхронный старт
	
	
	$display ("%7gns writing...", $time);
	READ_BIS_TASK(BASE_ADDR + TRIG_EN_ADDR,rdata,0);
	while(BIS_rdata[0] == 1'b1) begin//дожидаемся окончания записи выборки
		READ_BIS_TASK(BASE_ADDR + TRIG_EN_ADDR,rdata,0);
		// $display ("%7gns wait end of write data_coll", $time);
	end
	$display ("%7gns write complete!", $time);
	
	for(j_int = 0;j_int < NUM_PORTS;j_int = j_int + 1'b1) begin//перебираем все каналы и читаем данные
		$display ("%7gns chan %d", $time, j_int);
		WRITE_BIS_TASK(BASE_ADDR + BUS_CHAN_ADDR,j_int,0);//выбрали канал
		for(i_int = 0;i_int < DATA_DEPTH;i_int = i_int + 1'b1) begin
			READ_BIS_TASK(BASE_ADDR + RAM_ADDR,rdata,0);//погнали читать
			// $display ("%7gns addr = %d rdata = 0x%h",$time, i_int, rdata);
			if(rdata == test_data_mem[j_int][i_int]) begin
				err = err;
			end else begin
				$display ("%7gns ERROR! addr = %d rdata = 0x%h | valid = 0x%h",$time, i_int, rdata,test_data_mem[j_int][i_int]);
				err = err + 1;
			end
		end
	end
	
	$display ("-------------");
	$display ("%7gns THE END", $time);
	if(err == 0)
		$display ("all good, test PASSED");
	else begin
		$display ("ERRORS!, test FAILED");
		$display ("number of errors = %d",err);
	end
	$display ("-------------");
	
end
	
end
end



data_collector#(
	.BUS_ADDR_WIDTH (BUS_ADDR_WIDTH),
	.NUM            (NUM),
	.BASE_ADDR      (BASE_ADDR),
	.NUM_PORTS      (NUM_PORTS),
	.DATA_WIDTH     (DATA_WIDTH),
	.DATA_DEPTH     (DATA_DEPTH)
)
data_collector_inst(
	.clk        ({NUM_PORTS{clk}}),
	.resetn     ({NUM_PORTS{resetn}}),
	.data       (test_data_cong),
	.we         ({NUM_PORTS{we}}),
	.bus_clk    (BIS_clk),
	.bus_resetn (BIS_resetn),
	.bus_addr   (BIS_addr),
	.bus_wdata  (BIS_wdata),
	.bus_rdata  (BIS_rdata),
	.bus_wr     (BIS_wr),
	.bus_rd     (BIS_rd)
);

endmodule