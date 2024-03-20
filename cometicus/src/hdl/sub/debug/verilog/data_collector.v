module data_collector(
	clk,
	resetn,
	data,
	we,
	bus_clk,
	bus_resetn,
	bus_addr,
	bus_wdata,
	bus_rdata,
	bus_rvalid,
	bus_wr,
	bus_rd
);

`include "math.v"
`include "data_collector_param.v"

// --- input parameters for configuration---
parameter BUS_ADDR_WIDTH = -1;
parameter NUM            = 0;//больше не используется
parameter BASE_ADDR      = 0;//4-byte addressing
parameter NUM_PORTS      = 1;
parameter DATA_WIDTH     = 1;
parameter DATA_DEPTH     = 1;
parameter RAM_TYPE       = "BLOCK";//"BLOCK" or "LUT"
// --- ---

// --- inside parameters, do not change! ---
localparam RAM_ADDR_WIDTH     = log2(DATA_DEPTH);
localparam WR_DEPTH_REG_WIDTH = (RAM_ADDR_WIDTH + 1);//разрядность регистра объема записи данных в датаколлектор
localparam BUS_CHAN_WIDTH     = (log2(NUM_PORTS) + 1);



input  [NUM_PORTS-1:0] clk;
input  [NUM_PORTS-1:0] resetn;
input  [NUM_PORTS*DATA_WIDTH-1:0] data;
input  [NUM_PORTS-1:0] we;//синхронный сигнал разрешения по каждому каналу
input  bus_clk;
input  bus_resetn;
input  [BUS_ADDR_WIDTH-1:0] bus_addr;
input  [31:0] bus_wdata;
output [31:0] bus_rdata;
output bus_rvalid;
input  bus_wr;
input  bus_rd;

reg  [RAM_ADDR_WIDTH-1:0] addr_wr [NUM_PORTS-1:0];//массив адресов записи для всех портов
reg  [RAM_ADDR_WIDTH-1:0] addr_rd;//адрес чтения
reg  trig_en;//глобальный сигнал записи данных по каналам. В домене процессора
wire [NUM_PORTS-1:0] trig_en_syn;//trig_en переведенный в домены соответствующих портов
reg  [NUM_PORTS-1:0] wr_perm;//в каких каналах разрешено записывать данные
wire [NUM_PORTS-1:0] wr_perm_syn;//wr_perm в домене каждого из клоков записи
wire [NUM_PORTS-1:0] wr;//сигнал разрешения записи в память
reg  [NUM_PORTS-1:0] wr_stop;//сигнал окончания записи по каждому каналу
wire [NUM_PORTS-1:0] wr_stop_syn;//сигнал окончания записи по каждому каналу в домене шины
reg  [WR_DEPTH_REG_WIDTH-1:0] wr_depth;//сколько записывать данных в память, едино на все каналы
reg  we_dis;//сигнал игнорирования входного сигнала we (запись будет включаться процессором по trig_en)
wire [NUM_PORTS-1:0] we_dis_syn;//we_dis в домене каждого из клоков записи

reg [31:0] rw_reg;
reg ram_rd_reg;
reg bus_rvalid;

wire [DATA_WIDTH-1:0] data_parse [NUM_PORTS-1:0];//входные данные разделенные по портам
wire signed [DATA_WIDTH-1:0] ram_out [NUM_PORTS-1:0];//выходы памяти по всем каналам

reg [31:0] bus_rdata1;
reg [BUS_CHAN_WIDTH-1:0] bus_chan;//номер канала для чтения с процессора

reg  soft_resetn_int;
reg  [3:0] soft_resetn_cntr;//счетчик для удержания ресета
wire soft_resetn;//софт ресет, удерживается 16 клоков, снимается автоматически

genvar i;

assign data_coll_const_rd = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + DATA_COLL_CONST_ADDR) & bus_rd;
assign data_coll_num_rd   = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + DATA_COLL_NUM_ADDR)   & bus_rd;
assign num_ports_rd       = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + NUM_PORTS_ADDR)       & bus_rd;
assign data_width_rd      = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + DATA_WIDTH_ADDR)      & bus_rd;
assign data_depth_rd      = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + DATA_DEPTH_ADDR)      & bus_rd;
assign bus_chan_rd        = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + BUS_CHAN_ADDR)        & bus_rd;
assign trig_en_rd         = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + TRIG_EN_ADDR)         & bus_rd;
assign en_wr_rd           = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + WR_PERM_ADDR)         & bus_rd;
assign wr_depth_rd        = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + WR_DEPTH_ADDR)        & bus_rd;
assign rw_reg_rd          = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RW_REG_ADDR)          & bus_rd;
assign ram_rd             = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RAM_ADDR)             & bus_rd;
assign we_dis_rd          = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + WE_DIS_ADDR)          & bus_rd;


assign soft_resetn_wr     = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + SOFT_RESETN_ADDR)     & bus_wr;
assign bus_chan_wr        = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + BUS_CHAN_ADDR)        & bus_wr;
assign trig_en_wr         = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + TRIG_EN_ADDR)         & bus_wr;
assign en_wr_wr           = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + WR_PERM_ADDR)         & bus_wr;
assign wr_depth_wr        = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + WR_DEPTH_ADDR)        & bus_wr;
assign rw_reg_wr          = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + RW_REG_ADDR)          & bus_wr;
assign we_dis_wr          = (bus_addr == BASE_ADDR[BUS_ADDR_WIDTH-1:0] + WE_DIS_ADDR)          & bus_wr;

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
	assign data_parse[i] = data[DATA_WIDTH-1+DATA_WIDTH*i:0+DATA_WIDTH*i];//разконкитинация входных данных
	
    if(RAM_TYPE == "BLOCK")
        bram_block_v2#(
            .OUT_REG ("EN"),
            .WIDTH   (DATA_WIDTH),
            .DEPTH   (DATA_DEPTH)
        )
        bram_block_v2_inst(
            .wr_clk  (clk[i]),
            .rd_clk  (bus_clk),
            .we      (wr[i]),
            .re      (ram_rd),
            .dat_in  (data_parse[i]),
            .dat_out (ram_out[i]),
            .wr_addr (addr_wr[i]),
            .rd_addr (addr_rd)
        );
    else if(RAM_TYPE == "LUT")
        bram_lut_v2#(
            .OUT_REG ("EN"),
            .WIDTH   (DATA_WIDTH),
            .DEPTH   (DATA_DEPTH)
        )
        bram_lut_v2_inst(
            .wr_clk  (clk[i]),
            .rd_clk  (bus_clk),
            .we      (wr[i]),
            .re      (ram_rd),
            .dat_in  (data_parse[i]),
            .dat_out (ram_out[i]),
            .wr_addr (addr_wr[i]),
            .rd_addr (addr_rd)
        );
    else
        $error("Invalid RAM_TYPE: %s",RAM_TYPE);
	
	
	always@(posedge clk[i] or negedge resetn[i] or negedge soft_resetn)
	if(resetn[i] == 0)
		wr_stop[i] <= 0;
	else if(soft_resetn == 0)
		wr_stop[i] <= 0;
	else
		wr_stop[i] <= addr_wr[i][RAM_ADDR_WIDTH-1:0] == wr_depth[WR_DEPTH_REG_WIDTH-1:0] - 1'b1;
	
	assign wr[i] = (we[i] | we_dis_syn[i]) & trig_en_syn[i] & wr_perm_syn[i] & !wr_stop[i];
	
	always@(posedge clk[i] or negedge resetn[i] or negedge soft_resetn)
	if(resetn[i] == 0)
		addr_wr[i] <= 0;
	else if(soft_resetn == 0)
		addr_wr[i] <= 0;
	else if(trig_en_syn[i]) begin//запись началась
		if(wr[i])
			if(addr_wr[i][RAM_ADDR_WIDTH-1:0] != wr_depth[WR_DEPTH_REG_WIDTH-1:0] - 1'b1)
				addr_wr[i] <= addr_wr[i] + 1'b1;
	end else//запись окончена, можно сбросить счетчик записи
		addr_wr[i] <= 0;
	
	level_sync#(
		.INIT_STATE (1'b0),// 1'b0 or 1'b1(def=1'b0)
		.WIDTH      (3),   // (def=1)
		.RESET_TYPE ("ASY")// "SYN" or "ASY"(def="ASY")
	)
	level_sync_sync_signals_inst(
		.clk     (clk[i]),
		.reset_n (resetn[i]),
		.async   ({wr_perm[i],we_dis,trig_en}),
		.sync    ({wr_perm_syn[i],we_dis_syn[i],trig_en_syn[i]})
	);
	
	level_sync level_sync_wr_stop_syn_inst(
		.clk     (bus_clk),
		.reset_n (bus_resetn),
		.async   (wr_stop[i]),
		.sync    (wr_stop_syn[i])
	);

end
endgenerate//----------------------------------------

always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if(bus_resetn == 0)
	trig_en <= 0;
else if (soft_resetn == 0)
	trig_en <= 0;
else
	if(trig_en_wr & bus_wdata[0])
		trig_en <= 1'b1;
	else
		if(&(wr_stop_syn | (~wr_perm)))//все разрешенные каналы окончили запись
			trig_en <= 0;

always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if(bus_resetn == 0)
	addr_rd <= 0;
else if (soft_resetn == 0)
	addr_rd <= 0;
else
	if(trig_en | bus_chan_wr)//сброс по записи или по смене номера канала
		addr_rd <= 0;
	else//можно читать
		if(ram_rd)//прошла транзакция чтения
			addr_rd <= addr_rd + 1'b1;

always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if (bus_resetn == 0)
	bus_rdata1 <= 0;
else if (soft_resetn == 0)
	bus_rdata1 <= 0;
else case(1)
	data_coll_const_rd : bus_rdata1 <= (13 << 16) | DATA_COLL_CONST;
	data_coll_num_rd   : bus_rdata1 <= NUM;
	num_ports_rd       : bus_rdata1 <= NUM_PORTS;
	data_width_rd      : bus_rdata1 <= DATA_WIDTH;
	data_depth_rd      : bus_rdata1 <= DATA_DEPTH;
	bus_chan_rd        : bus_rdata1 <= bus_chan;
	trig_en_rd         : bus_rdata1 <= trig_en;
	en_wr_rd           : bus_rdata1 <= wr_perm[bus_chan[BUS_CHAN_WIDTH-1:0]];
	wr_depth_rd        : bus_rdata1 <= wr_depth;
	rw_reg_rd          : bus_rdata1 <= rw_reg;
	we_dis_rd          : bus_rdata1 <= we_dis;
	default            : bus_rdata1 <= 0;
endcase

always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if (bus_resetn == 0)
	ram_rd_reg <= 0;
else if (soft_resetn == 0)
	ram_rd_reg <= 0;
else
	ram_rd_reg <= ram_rd;

assign bus_rdata  = (ram_rd_reg) ? ram_out[bus_chan] : bus_rdata1;

always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if (bus_resetn == 0)
    bus_rvalid <= 0;
else if (soft_resetn == 0)
    bus_rvalid <= 0;
else
    bus_rvalid <= data_coll_const_rd |
                  data_coll_num_rd   |
                  num_ports_rd       |
                  data_width_rd      |
                  data_depth_rd      |
                  bus_chan_rd        |
                  trig_en_rd         |
                  en_wr_rd           |
                  wr_depth_rd        |
                  rw_reg_rd          |
                  ram_rd             |
                  we_dis_rd;

always@(posedge bus_clk or negedge bus_resetn or negedge soft_resetn)
if (bus_resetn == 0) begin 
	bus_chan <= 0;
	wr_perm  <= 0;
	wr_depth <= 0;
	rw_reg   <= 0;
	we_dis   <= 0;
end else if (soft_resetn == 0) begin
	bus_chan <= 0;
	wr_perm  <= 0;
	wr_depth <= 0;
	rw_reg   <= 0;
	we_dis   <= 0;
end else
case(1'b1)
	bus_chan_wr : bus_chan                              <= bus_wdata[BUS_CHAN_WIDTH-1:0];
	en_wr_wr    : wr_perm[bus_chan[BUS_CHAN_WIDTH-1:0]] <= bus_wdata[0];
	wr_depth_wr : wr_depth                              <= bus_wdata[WR_DEPTH_REG_WIDTH-1:0];
	rw_reg_wr   : rw_reg                                <= bus_wdata;
	we_dis_wr   : we_dis                                <= bus_wdata[0];
endcase

endmodule
