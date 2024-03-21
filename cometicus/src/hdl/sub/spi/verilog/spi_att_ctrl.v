module spi_att_ctrl(
	clk,
	reset,
	spi_clk,
	spi_nncs,
	spi_mosi,
	DATA
);

parameter CLK_DIV   = 1;//(2,4,6...256)
parameter N_BITS    = 8;//(1,2,3...64)
parameter N_PACKETS = 1;//(1,2,3...256)

parameter N_CS     = 16; //number of CS (number of devices)
// parameter DATA      = 0;

parameter BIT_CNTR_WIDTH = 6;

input  clk;
input  reset;
input [N_BITS-1 : 0] DATA;

output spi_clk;
output [N_CS-1:0] spi_nncs;
output spi_mosi;

wire [N_CS-1:0] spi_nncs;

reg  [7:0] div_cntr;
wire clk_en;
wire reset_syn;
reg  [BIT_CNTR_WIDTH-1:0] bit_cntr;
reg  [7:0] packet_cntr;
reg  [BIT_CNTR_WIDTH+8-1:0] send_cntr;
reg  spi_clk;
reg  spi_ncs = 1'b1;
reg  spi_mosi;

initial div_cntr = 0;



level_sync#(
	.INIT_STATE(1'b1)
)
level_sync_reset(
	.clk     (clk),
	.reset_n (1'b1),
	.async   (reset),
	.sync    (reset_syn)
);

always@(posedge clk)
if(clk_en)
	div_cntr <= 0;
else
	div_cntr <= div_cntr + 1'b1;

assign clk_en = (div_cntr == (CLK_DIV/2-1'd1));

parameter START       = 3'b000;//0
parameter SLEEP       = 3'b001;//1
parameter PACK_CNTR   = 3'b010;//2
parameter ACTIVATE    = 3'b011;//3
parameter DISACTIVATE = 3'b100;//4
parameter CLK0        = 3'b101;//5
parameter CLK1        = 3'b110;//6


(* FSM_ENCODING="sequential", SAFE_IMPLEMENTATION="YES" *)
reg [2:0] state = START;

always@(posedge clk)
if (reset_syn) begin
	state <= START;
end
else if(clk_en)
	(* PARALLEL_CASE *) case (state)
		START : begin
			state <= ACTIVATE;
		end
		ACTIVATE : begin
			state <= CLK0;
		end
		CLK0 : begin
			state <= CLK1;
		end
		CLK1 : begin
		if(bit_cntr == {BIT_CNTR_WIDTH{1'b1}})
			state <= DISACTIVATE;
		else
			state <= CLK0;
		end
		DISACTIVATE : begin
			state <= PACK_CNTR;
		end
		PACK_CNTR : begin
		if(packet_cntr == N_PACKETS)
			state <= SLEEP;
		else
			state <= ACTIVATE;
		end
		default : begin  // Fault Recovery
			state <= SLEEP;
		end
	endcase


always@(posedge clk)
if(clk_en)
case(state)
	START       : spi_ncs <= 1'b1;
	ACTIVATE    : spi_ncs <= 1'b0;
	DISACTIVATE : spi_ncs <= 1'b1;
	default     : spi_ncs <= spi_ncs;
endcase

always@(posedge clk)
if(clk_en)
case(state)
	START       : spi_clk <= 1'b1;
	ACTIVATE    : spi_clk <= 1'b1;
	DISACTIVATE : spi_clk <= 1'b1;
	CLK0        : spi_clk <= 1'b0;
	CLK1        : spi_clk <= 1'b1;
	default     : spi_clk <= spi_clk;
endcase

always@(posedge clk)
if(clk_en)
case(state)
	ACTIVATE : bit_cntr <= N_BITS-1'b1;
	CLK0     : bit_cntr <= bit_cntr - 1'b1;
	default  : bit_cntr <= bit_cntr;
endcase

always@(posedge clk)
if(clk_en)
case(state)
	START       : packet_cntr <= 0;
	DISACTIVATE : packet_cntr <= packet_cntr + 1'b1;
	default     : packet_cntr <= packet_cntr;
endcase

always@(posedge clk)
if(clk_en)
case(state)
	START       : send_cntr <= N_BITS*N_PACKETS-1'b1;
	CLK0        : send_cntr <= send_cntr - 1'b1;
	default     : send_cntr <= send_cntr;
endcase

always@(posedge clk)
if(clk_en)
case(state)
	CLK0        : spi_mosi <= DATA[send_cntr];
	DISACTIVATE : spi_mosi <= 1'b1;
	default     : spi_mosi <= spi_mosi;
endcase


assign spi_nncs = {N_CS{spi_ncs}};

endmodule