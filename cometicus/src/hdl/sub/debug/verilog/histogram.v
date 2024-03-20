module histogram(
	clk,     // клоки данных
	resetn,  // ресет данных
	in_data, // данные для измерений
	bus_clk,
	bus_resetn,
	rdata,
    rvalid,
	addr,
	rd
);

`include "math.v"

// --- input parameters for configuration---
parameter BUS_ADDR_WIDTH = -1;
parameter BASE_ADDR      = 0;//4-byte addressing
parameter LINES          = 1;//число анализируемых линий
// --- ---

// --- inside parameters, do not change! ---
localparam CNTR_LENGTH = 16;//длина расчетной выборки = 2^CNTR_LENGTH
localparam ID = 32'hEAD0007C;

// --- addresses ---
localparam ID_ADDR      = 0;
localparam LENGTH_ADDR  = 1;
localparam LINES_ADDR   = 2;
localparam IN_DATA_ADDR = 3;

input  clk;
input  resetn;
input  [LINES-1:0] in_data;
input  bus_clk;
input  bus_resetn;
output [31:0] rdata;
output rvalid;
input  [BUS_ADDR_WIDTH-1:0] addr;
input  rd;

reg  rvalid;
reg  [31:0] rdata;
wire [31:0] rdata_in_data_i [LINES-1:0];

reg  [CNTR_LENGTH-1:0] cntr;
reg  [CNTR_LENGTH-1:0] in_data_cntr [LINES-1:0];//рабочие счетчики
reg  [CNTR_LENGTH-1:0] in_data_result [LINES-1:0];//регистры хранения результата
wire [CNTR_LENGTH-1:0] in_data_result_syn [LINES-1:0];//регистры хранения результата сихронизированные с шиной


wire [LINES-1:0] in_data_res_rd;

genvar i;


assign id_rd     = (addr == BASE_ADDR + ID_ADDR)     & rd;
assign length_rd = (addr == BASE_ADDR + LENGTH_ADDR) & rd;
assign lines_rd  = (addr == BASE_ADDR + LINES_ADDR)  & rd;

always@(posedge clk or negedge resetn)
if(resetn == 0)
	cntr <= 0;
else
	cntr <= cntr + 1'b1;

generate
for(i = 0; i < LINES; i = i + 1)
begin: loop_lines
	always@(posedge clk or negedge resetn)
	if(resetn == 0)
		in_data_cntr[i] <= 0;
	else if(cntr == 0)
		in_data_cntr[i] <= 0;
	else if(in_data[i])
		in_data_cntr[i] <= in_data_cntr[i] + 1'b1;
	
	always@(posedge clk or negedge resetn)
	if(resetn == 0)
		in_data_result[i] <= 0;
	else if(cntr == 0)
		in_data_result[i] <= in_data_cntr[i];
	
	// synchronisation result to bus_clk
	level_sync#(
		.INIT_STATE (1'b0),        // 1'b0 or 1'b1(def=1'b0)
		.WIDTH      (CNTR_LENGTH), // (def=1)
		.RESET_TYPE ("ASY")        // "SYN" or "ASY"(def="ASY")
	)
	level_sync_in_data_result_inst(
		.clk     (bus_clk),
		.reset_n (bus_resetn),
		.async   (in_data_result[i]),
		.sync    (in_data_result_syn[i])
	);
	
	assign in_data_res_rd[i] = (addr == BASE_ADDR + IN_DATA_ADDR + i) & rd;
	
end
endgenerate


always@(posedge bus_clk or negedge bus_resetn)
if(bus_resetn == 0)
	rdata <= 0;
else case(1'b1)
	id_rd           : rdata <= ID;
	length_rd       : rdata <= CNTR_LENGTH;
	lines_rd        : rdata <= LINES;
	|in_data_res_rd : rdata <= rdata_in_data_i[LINES-1];
	default         : rdata <= 32'b0;
endcase

always@(posedge bus_clk or negedge bus_resetn)
if(bus_resetn == 0)
	rvalid <= 0;
else
    rvalid <= id_rd | length_rd | lines_rd | (|in_data_res_rd);

generate
assign rdata_in_data_i[0] = in_data_res_rd[0] ? {{(32-CNTR_LENGTH){1'b0}},in_data_result_syn[0]} : {32{1'b0}};
for(i = 1; i < LINES; i = i + 1)
	assign rdata_in_data_i[i] = in_data_res_rd[i] ? {{(32-CNTR_LENGTH){1'b0}},in_data_result_syn[i]} : rdata_in_data_i[i-1];
endgenerate



endmodule