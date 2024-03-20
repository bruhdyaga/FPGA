//работа соответсвтует модулю bus_interface_syn.v
//BIS (Bus Interface Syn)

parameter BUS_ADDR_WIDTH = 30;

reg  [BUS_ADDR_WIDTH-1:0] BIS_addr;
reg  [31:0] BIS_wdata;
wire [31:0] BIS_rdata;
reg         BIS_wr;
reg         BIS_rd;
reg         BIS_resetn = 1'b1;
reg         BIS_clk = 1;

// always #8.01 BIS_clk = !BIS_clk;//62.42 MHz
always #4.5 BIS_clk = !BIS_clk;//111 MHz


//4-byte addressing!
initial begin
	BIS_addr  <= 0;
	BIS_wdata <= 0;
	BIS_wr    <= 0;
	BIS_rd    <= 0;
end

task INIT_BIS_TASK;
	begin
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	
	BIS_resetn = 1'b0;//reset
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)
	@(posedge BIS_clk)//10 clks
	BIS_resetn = 1'b1;
	$display ("%7gns Initial BUS done!", $time);
	end
endtask

task WRITE_BIS_TASK;
	input [BUS_ADDR_WIDTH-1:0] waddr;
	input [31:0] wdata;
	input en_disp;
	
	begin
	if(en_disp) $display ("%7gns Write  to addr : 0x%h | data : 0x%h", $time, waddr, wdata);
	@(posedge BIS_clk)
	BIS_addr  <= waddr;
	BIS_wdata <= wdata;
	BIS_wr    <= 1'b1;
	BIS_rd    <= 0;
	
	@(posedge BIS_clk)
	BIS_addr  <= 0;
	BIS_wdata <= 0;
	BIS_wr    <= 0;
	BIS_rd    <= 0;
	end
endtask

task READ_BIS_TASK;
	input  [BUS_ADDR_WIDTH-1:0] raddr;
	output [31:0] data_out;
	input en_disp;
	
	reg [31:0] data_out;

	begin
	@(posedge BIS_clk)
	BIS_addr  <= raddr;
	BIS_wdata <= 0;
	BIS_wr    <= 0;
	BIS_rd    <= 1'b1;
	
	@(posedge BIS_clk)
	BIS_addr  <= 0;
	BIS_wdata <= 0;
	BIS_wr    <= 0;
	BIS_rd    <= 0;
	
	@(/* posedge */negedge BIS_clk)
	data_out <= BIS_rdata;
	@(posedge BIS_clk)
	if(en_disp) $display ("%7gns Read from addr : 0x%h | data : 0x%h", $time, raddr, data_out);
	
	
	
	end
endtask
