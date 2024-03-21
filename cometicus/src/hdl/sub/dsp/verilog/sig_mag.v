module sig_mag(
	//parameter width(def 14)
	clk,//rf domain(adc)
	reset,
	DAT_in,//signed
	sig,
	mag
);

parameter width = 14;


`ifdef SIM
	`define cntr_width 6//разрядность счетчика магов
	`define num_mag 21//требуемое число магов
`else
	`define cntr_width 10//разрядность счетчика магов
	`define num_mag 338//требуемое число магов
`endif

input clk;
input reset;
input signed [width-1:0] DAT_in;
output sig;
output mag;

reg sig;
reg mag;

reg [width-2:0] por_reg;

reg [`cntr_width-1:0] mag_cntr;//считает маги
reg [`cntr_width-1:0] cntr;//отсчитывает интервал подсчета магов
reg valid;


//---result---
always@(posedge clk or posedge reset)
if(reset)
	mag_cntr <= 0;
else
	if(cntr[`cntr_width-1:0] == {`cntr_width{1'b1}})
		mag_cntr <= 0;
	else
		if(mag)
			mag_cntr <= mag_cntr + 1'b1;


//---por---
always@(posedge clk or posedge reset)
if(reset)
	por_reg <= 0;
else
	if(cntr[`cntr_width-1:0] == {`cntr_width{1'b1}})//в конце интервала наблюдения делаем коррекцию порога
		if(mag_cntr[`cntr_width-1:0] > `cntr_width'd`num_mag)
			por_reg <= por_reg + 1'b1;
		else
			por_reg <= por_reg - 1'b1;
//---por end---


always@(posedge clk or posedge reset)
if(reset)
	cntr <= 0;
else
	cntr <= cntr + 1'b1;


always@(posedge clk or posedge reset)
if(reset)
	sig <= 0;
else
	sig <= DAT_in[width-1];


always@(posedge clk or posedge reset)
if(reset)
	mag <= 0;
else
	if(($signed(DAT_in[width-1:0]) > $signed({1'b0,por_reg})) | ($signed(DAT_in[width-1:0]) < -$signed({1'b0,por_reg})))
		mag <= 1'b1;
	else
		mag <= 1'b0;




endmodule
