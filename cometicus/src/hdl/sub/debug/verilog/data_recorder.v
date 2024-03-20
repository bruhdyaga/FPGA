module data_recorder(
	clk,
	resetn,
	data_out,
	valid,
	bus_clk,
	bus_resetn,
	bus_addr,
	bus_wdata,
	bus_rdata,
	bus_wr,
	bus_rd
);

`include "math.v"
`include "data_recorder_param.v"

parameter BUS_ADDR_WIDTH = -1;
parameter NUM            = 0;//госномер, можно выдавать каждому inst для удобства
parameter BASE_ADDR      = 0;//4-byte addressing
parameter NUM_PORTS      = 1;
parameter DATA_WIDTH     = 1;
parameter DATA_DEPTH     = 1;

localparam RAM_ADDR_WIDTH     = log2(DATA_DEPTH);
localparam WR_DEPTH_REG_WIDTH = (RAM_ADDR_WIDTH + 1);//разрядность регистра объема записи данных в датаколлектор
localparam BUS_CHAN_WIDTH     = (log2(NUM_PORTS) + 1);


input  clk;
input  resetn;
output [NUM_PORTS*DATA_WIDTH-1:0] data_out;
output valid;
input  bus_clk;
input  bus_resetn;
input  [BUS_ADDR_WIDTH-1:0] bus_addr;
input  [31:0] bus_wdata;
output [31:0] bus_rdata;
input  bus_wr;
input  bus_rd;

reg  [31:0] bus_rdata;
wire [DATA_WIDTH-1:0] data_parse [NUM_PORTS-1:0];//выходные данные разделенные по портам
reg  [RAM_ADDR_WIDTH-1:0] addr_wr;//адрес записи
reg  [RAM_ADDR_WIDTH-1:0] addr_rd;//адрес чтения
reg  [WR_DEPTH_REG_WIDTH-1:0] rd_depth;//сколько записывать данных в память, едино на все каналы
reg  [31:0] rw_reg;
reg  [BUS_CHAN_WIDTH-1:0] bus_chan;//номер канала для записи с процессора
reg  rd_start;//разрешение чтения
wire rd_start_syn;
reg  valid;

reg  soft_resetn_int;
reg  [3:0] soft_resetn_cntr;//счетчик для удержания ресета
wire soft_resetn;//софт ресет, удерживается 16 клоков, снимается автоматически

genvar i;

assign data_recorder_const_rd = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + DATA_RECORDER_CONST_ADDR) & bus_rd;
assign data_recorder_num_rd   = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + DATA_RECORDER_NUM_ADDR)   & bus_rd;
assign num_ports_rd           = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + NUM_PORTS_ADDR)           & bus_rd;
assign data_width_rd          = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + DATA_WIDTH_ADDR)          & bus_rd;
assign data_depth_rd          = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + DATA_DEPTH_ADDR)          & bus_rd;
assign bus_chan_rd            = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + BUS_CHAN_ADDR)            & bus_rd;
assign rd_start_rd            = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RD_START_ADDR)            & bus_rd;
assign rd_depth_rd            = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RD_DEPTH_ADDR)            & bus_rd;
assign rw_reg_rd              = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RW_REG_ADDR)              & bus_rd;



assign soft_resetn_wr     = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + SOFT_RESETN_ADDR)     & bus_wr;
assign bus_chan_wr        = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + BUS_CHAN_ADDR)        & bus_wr;
assign rd_start_wr        = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RD_START_ADDR)        & bus_wr;
assign rd_depth_wr        = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RD_DEPTH_ADDR)        & bus_wr;
assign rw_reg_wr          = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RW_REG_ADDR)          & bus_wr;
assign ram_wr             = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RAM_ADDR)             & bus_wr;

//Software resetn register
always @ (posedge bus_clk or negedge bus_resetn)
if(bus_resetn == 1'b0)
	soft_resetn_int <= 0;
else begin
	if (soft_resetn_wr & bus_wdata[0])
		soft_resetn_int <= 1'b1;
	else
		if(soft_resetn_cntr[3:0] == 4'b1111)
			soft_resetn_int <= 1'b0;
end

always@(posedge bus_clk or negedge bus_resetn)
if(bus_resetn == 1'b0)
	soft_resetn_cntr <= 0;
else begin
	if(soft_resetn_wr & bus_wdata[0]) begin
		soft_resetn_cntr <= 0;
	end else begin
		if(soft_resetn_cntr[3:0] == 4'b1111)
			soft_resetn_cntr <= 4'b1111;
		else
			soft_resetn_cntr <= soft_resetn_cntr + 1'b1;
	end
end

level_sync#(
	.INIT_STATE(1'b1)
)
level_sync_soft_resetn_inst(
	.clk     (bus_clk),
	.reset_n (1'b1),
	.async   (!soft_resetn_int),
	.sync    (soft_resetn)
);
//Software resetn register END

generate//----------------------------------------
for(i=0;i<NUM_PORTS;i=i+1)
begin:loop_data_parse
	assign data_out[DATA_WIDTH-1+DATA_WIDTH*i:0+DATA_WIDTH*i] = data_parse[i];//конкитинация выходных данных
	
	bram_block_v2#(
		.OUT_REG ("EN"),//"EN" or else(def)
		.WIDTH   (DATA_WIDTH),
		.DEPTH   (DATA_DEPTH)
	)
	bram_block_v2_inst(
		.wr_clk  (bus_clk),
		.rd_clk  (clk),
		.we      (ram_wr & (bus_chan == i)),
		.re      (rd_start_syn),
		.dat_in  (bus_wdata[DATA_WIDTH-1:0]),
		.dat_out (data_parse[i]),
		.wr_addr (addr_wr),
		.rd_addr (addr_rd)
	);
	
end
endgenerate//----------------------------------------

always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if((bus_resetn == 0) | (soft_resetn == 0))
	addr_wr <= 0;
else begin
if(bus_chan_wr)//сброс счетчика при выставлении канала
	addr_wr <= 0;
else
	if(ram_wr)
		addr_wr <= addr_wr + 1'b1;
end

always@(posedge clk or negedge resetn or negedge soft_resetn)
if((resetn == 0) | (soft_resetn == 0))
	addr_rd <= 0;
else
	if(bus_chan_wr)//сброс по записи или по смене номера канала
		addr_rd <= 0;
	else
		if(addr_rd < (rd_depth-1)) begin
			if(rd_start)//погнали читать
				addr_rd <= addr_rd + 1'b1;
		end else
			addr_rd <= 0;

level_sync level_sync_rd_start_syn_inst(
	.clk     (clk),
	.reset_n (resetn),
	.async   (rd_start),
	.sync    (rd_start_syn)
);


always@(posedge clk or negedge resetn or negedge soft_resetn)
if((resetn == 0) | (soft_resetn == 0))
	valid <= 0;
else
	valid <= rd_start;


always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if((bus_resetn == 0) | (soft_resetn == 0))
	bus_rdata <= 0;
else case(1)
	data_recorder_const_rd : bus_rdata <= DATA_RECORDER_CONST;
	data_recorder_num_rd   : bus_rdata <= NUM;
	num_ports_rd           : bus_rdata <= NUM_PORTS;
	data_width_rd          : bus_rdata <= DATA_WIDTH;
	data_depth_rd          : bus_rdata <= DATA_DEPTH;
	bus_chan_rd            : bus_rdata <= bus_chan;
	rd_start_rd            : bus_rdata <= rd_start;
	rd_depth_rd            : bus_rdata <= rd_depth;
	rw_reg_rd              : bus_rdata <= rw_reg;
	default                : bus_rdata <= 0;
endcase

always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if((bus_resetn == 0) | (soft_resetn == 0)) begin
	bus_chan <= 0;
	rd_start <= 0;
	rd_depth <= 0;
	rw_reg   <= 0;
end else
case(1'b1)
	bus_chan_wr : bus_chan  <= bus_wdata[BUS_CHAN_WIDTH-1:0];
	rd_start_wr : rd_start  <= bus_wdata[0];
	rd_depth_wr : rd_depth  <= bus_wdata[WR_DEPTH_REG_WIDTH-1:0];
	rw_reg_wr   : rw_reg    <= bus_wdata;
endcase

endmodule
