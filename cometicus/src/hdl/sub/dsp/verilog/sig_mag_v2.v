module sig_mag_v2(
	clk,
	resetn,
	data_in,//signed
	sig,
	mag,
	valid
);

parameter width = 14;


`define cntr_width 14//разрядность счетчика магов
`define num_mag 5461//требуемое число магов


input clk;
input resetn;
input signed [width-1:0] data_in;
output sig;
output mag;
output valid;

reg mag_bisec;
reg sig;
reg mag;
reg sig_reg;
reg mag_reg;

reg [width-2:0] por_reg;
reg [width-2:0] por_reg_a;
reg [width-2:0] por_reg_b;
reg [width-2:0] por_res;

reg [`cntr_width-1:0] mag_cntr;//считает маги
reg [`cntr_width-1:0] cntr;//отсчитывает интервал подсчета магов
reg [4:0] cntr_iter;
reg valid;


//---result---
always@(posedge clk or negedge resetn)
if(resetn == 1'b0)
	mag_cntr <= 0;
else
	if(cntr[`cntr_width-1:0] == {`cntr_width{1'b1}})
		mag_cntr <= 0;
	else
		if(mag_bisec)
			mag_cntr <= mag_cntr + 1'b1;

always@(posedge clk or negedge resetn)
if(resetn == 1'b0)
	cntr_iter <= 0;
else
	if(cntr_iter[4:0] != width) begin
		if(cntr[`cntr_width-1:0] == {`cntr_width{1'b1}})
			cntr_iter <= cntr_iter + 1'b1;
	end else
		cntr_iter <= 0;

always@(posedge clk or negedge resetn)
if(resetn == 1'b0)
	valid <= 0;
else
	if(cntr_iter[4:0] == width)
		valid <= 1'b1;

//---por---
always@(posedge clk or negedge resetn)
if(resetn == 1'b0) begin
	por_reg   <= {1'b0,{width-2{1'b1}}};
	por_reg_a <= 0;
	por_reg_b <= {width-1{1'b1}};
end else begin
	if(cntr_iter[4:0] != width) begin
		if(cntr[`cntr_width-1:0] == {`cntr_width{1'b1}}) begin//в конце интервала наблюдения делаем коррекцию порога
			if(mag_cntr[`cntr_width-1:0] > `cntr_width'd`num_mag)
				por_reg_a <= por_reg;
			else
				por_reg_b <= por_reg;
		end
		por_reg <= (por_reg_b + por_reg_a)>>1;
	end else begin
		por_reg   <= {1'b0,{width-2{1'b1}}};
		por_reg_a <= 0;
		por_reg_b <= {width-1{1'b1}};
		por_res <= por_reg;
	end
end
//---por end---




always@(posedge clk or negedge resetn)
if(resetn == 1'b0)
	cntr <= 0;
else
	cntr <= cntr + 1'b1;


always@(posedge clk or negedge resetn)
if(resetn == 1'b0)
	sig_reg <= 0;
else
	sig_reg <= data_in[width-1];


always@(posedge clk or negedge resetn)
if(resetn == 1'b0)
	mag_bisec <= 0;
else
	if(($signed(data_in[width-1:0]) > $signed({1'b0,por_reg})) | ($signed(data_in[width-1:0]) < -$signed({1'b0,por_reg})))
		mag_bisec <= 1'b1;
	else
		mag_bisec <= 1'b0;

always@(posedge clk or negedge resetn)
if(resetn == 1'b0)
	mag_reg <= 0;
else
	if(($signed(data_in[width-1:0]) > $signed({1'b0,por_res})) | ($signed(data_in[width-1:0]) < -$signed({1'b0,por_res})))
		mag_reg <= 1'b1;
	else
		mag_reg <= 1'b0;

always@(posedge clk or negedge resetn)
if(resetn == 1'b0) begin
	sig <= 0;
	mag <= 0;
end else
	if(valid) begin
		sig <= sig_reg;
		mag <= mag_reg;
	end


endmodule
