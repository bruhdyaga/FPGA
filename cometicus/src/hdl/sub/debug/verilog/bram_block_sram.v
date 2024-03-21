/* 
bram_block_v2#(
	.OUT_REG (),//"EN" or else(def)
	.WIDTH   (),
	.DEPTH   ()
)
bram_block_v2_inst(
	.wr_clk  (),
	.rd_clk  (),
	.we      (),
	.re      (),
	.dat_in  (),
	.dat_out (),
	.wr_addr (),
	.rd_addr ()
);
 */
module bram_block_sram(
	//OUT_REG "EN" or else(def)
	wr_clk,
	rd_clk,
	we,
	re,
	dat_in,
	dat_out,
	wr_addr,
	rd_addr
);

`include "math.v"

// --- input parameters for configuration---
parameter integer OUT_REG = 0;//only "EN" for SRAM2_xKx8!!!//задержка выходных данных на клок относительно выставления адреса
parameter integer WIDTH = 1;
parameter integer DEPTH = 1;
// --- ---


// --- inside parameters, do not change! ---
localparam integer SRAM_WIDTH = 8;//разрядность примитива памяти
localparam integer SRAM_DEPTH = 2048;//объем примитива памяти
localparam integer SRAM_AWIDTH = log2(SRAM_DEPTH);//ширина шины адреса примитива памяти

localparam integer AWIDTH     = log2(DEPTH);
localparam integer NUM_SRAM_W = (WIDTH-1)/SRAM_WIDTH+1;//число блоков памяти с разрядностью SRAM_WIDTH бит для требуемой разрядности
localparam integer NUM_SRAM_D = (DEPTH-1)/SRAM_DEPTH+1;//число блоков памяти для достижения требуемого объема
// --- ---

input  wr_clk;
input  rd_clk;
input  we;
input  re;
input  [WIDTH-1:0] dat_in;
output [WIDTH-1:0] dat_out;
input  [AWIDTH-1:0] wr_addr;
input  [AWIDTH-1:0] rd_addr;

reg [WIDTH-1:0] ram [DEPTH-1:0];
genvar i_d;
genvar i_w;



generate

wire [SRAM_WIDTH-1:0]  QA [NUM_SRAM_D-1:0][NUM_SRAM_W-1:0];//выход всех блоков памяти
wire [SRAM_AWIDTH-1:0] AA;//шина адреса чтения
wire [SRAM_AWIDTH-1:0] AB;//шина адреса записи
wire [SRAM_WIDTH-1:0]  DB [NUM_SRAM_W-1:0];//шина данных
wire [NUM_SRAM_D-1:0]  wr_addr_page;//попадание адреса записи в i_d блок
reg  [`MAX(AWIDTH-SRAM_AWIDTH,1)-1:0] rd_addr_page;//номер страницы чтения

//если надо - дополняем лишние разряды адреса нулями
	if(AWIDTH >= SRAM_AWIDTH)
		assign AA = rd_addr[SRAM_AWIDTH-1:0];
	else
		assign AA = {{(SRAM_AWIDTH-AWIDTH){1'b0}},rd_addr[AWIDTH-1:0]};

	if(AWIDTH >= SRAM_AWIDTH)
		assign AB = wr_addr[SRAM_AWIDTH-1:0];
	else
		assign AB = {{(SRAM_AWIDTH-AWIDTH){1'b0}},wr_addr[AWIDTH-1:0]};

//--- цикл по блокам памяти, для набора требуемого объема памяти
for(i_d = 0;i_d < NUM_SRAM_D;i_d = i_d + 1) begin: loop_by_depth

		if(NUM_SRAM_D == 1)
			assign wr_addr_page[i_d] = 1'b1;
		else
			assign wr_addr_page[i_d] = wr_addr[AWIDTH-1:SRAM_AWIDTH] == i_d;

	

	//--- цикл по блокам памяти, для набора требуемой разрядности шины данных
	for(i_w = 0;i_w < NUM_SRAM_W;i_w = i_w + 1) begin: loop_by_width

		SRAM2_2Kx8 SRAM2_2Kx8_inst(
			.QA   (QA[i_d][i_w]),//разделяем данные по ширине между блоками памяти
			.CLKA (rd_clk),
			.CENA (!re),//active low
			.WENA (1'b1),//active low
			.AA   (AA),
			.DA   ({SRAM_WIDTH{1'b0}}),
			.QB   (),//не используется
			.CLKB (wr_clk),
			.CENB (!(we & wr_addr_page[i_d])),//active low
			.WENB (!(we & wr_addr_page[i_d])),//active low
			.AB   (AB),
			.DB   (DB[i_w])//разделяем данные по ширине между блоками памяти
		);


		//если надо - дополняем лишние разряды шины данных нулями
		if(i_d == 0) begin
			if(SRAM_WIDTH + i_w*SRAM_WIDTH > WIDTH)
				assign DB[i_w] = {{(SRAM_WIDTH*NUM_SRAM_W-WIDTH){1'b0}},dat_in[WIDTH-1:i_w*SRAM_WIDTH]};
			else
				assign DB[i_w] = dat_in[SRAM_WIDTH+i_w*SRAM_WIDTH-1:i_w*SRAM_WIDTH];
				
			assign dat_out[`MIN(WIDTH,SRAM_WIDTH+i_w*SRAM_WIDTH)-1:i_w*SRAM_WIDTH] = QA[rd_addr_page][i_w][`MIN(WIDTH - SRAM_WIDTH * i_w,SRAM_WIDTH)-1:0];//берем из шины SRAM только попадающие в нашу разрядность
		end

	end
	//--- --- loop_by_width
	
end
//--- --- loop_by_depth


	if(NUM_SRAM_D == 1)
		always@(posedge rd_clk)
			rd_addr_page <= 1'b0;
	else
		always@(posedge rd_clk)
			rd_addr_page <= rd_addr[AWIDTH-1:SRAM_AWIDTH];


endgenerate


endmodule