//эмуляция шины AHB
//1-byte addressing!
//подключаем к bus_interface_ahb_syn и в бой!

parameter AHB_ADDR_WIDTH = 32;

reg  [AHB_ADDR_WIDTH-1:0] AHB_SYN_addr;
reg  [31:0] AHB_SYN_wdata;
wire [31:0] AHB_SYN_rdata;
reg  [2:0]  AHB_HBURST = 3'b000;//Single transfer
reg         AHB_HMASTLOCK = 1'b0;//no Locked transfers
reg  [3:0]  AHB_HPROT = 4'b0000;//for burst
wire        AHB_HREADY;//input
wire        AHB_HRESP;//input
reg  [2:0]  AHB_HSIZE = 3'b000;
reg  [1:0]  AHB_HTRANS;
reg         AHB_HWRITE;
reg         AHB_SYN_resetn = 1'b1;
reg         AHB_SYN_clk = 1;

// always #8.01 AHB_SYN_clk = !AHB_SYN_clk;//62.42 MHz
//always #4.5 AHB_SYN_clk = !AHB_SYN_clk;//111 MHz
always #5 AHB_SYN_clk = !AHB_SYN_clk;//100 MHz



initial begin
	AHB_SYN_addr  <= 0;
	AHB_SYN_wdata <= 0;
	AHB_HWRITE    <= 0;
	AHB_HTRANS    <= 0;
end

task INIT_AHB_SYN_TASK;
	begin
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	
	AHB_SYN_resetn = 1'b0;//reset
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)
	@(posedge AHB_SYN_clk)//10 clks
	AHB_SYN_resetn = 1'b1;
	$display ("%7gns Initial BUS done!", $time);
	end
endtask

task WRITE_AHB_SYN_TASK;
input [AHB_ADDR_WIDTH-1:0] waddr;
input [31:0] wdata;
integer num_trans;
integer ready;
integer timeout;

begin
	$display ("%7gns Write  to addr : 0x%h | data : 0x%h", $time, waddr, wdata);
	@(posedge AHB_SYN_clk)
	AHB_SYN_addr  <= waddr;
	AHB_HWRITE    <= 1'b1;
	AHB_HTRANS[1] <= 1'b1;
	
	@(posedge AHB_SYN_clk)
	AHB_SYN_addr  <= 0;
	AHB_HWRITE    <= 0;
	AHB_HTRANS[1] <= 0;
	AHB_SYN_wdata <= wdata;
	
	num_trans = 0;
	ready = 0;
	timeout = 0;
	while((ready == 0) && (timeout == 0)) begin//если за 64 клока не будет реди, то таймаут!
	@(posedge AHB_SYN_clk)
	if(AHB_HREADY) begin
		ready = 1;
		AHB_SYN_wdata <= 0;
	end
	if(num_trans == 63) begin
		$display ("%7gns READY TIMEOUT! WRITE FAIL", $time);
		timeout = 1;
		AHB_SYN_wdata <= 0;
	end
	num_trans = num_trans + 1;
	end
end
endtask

task READ_AHB_SYN_TASK;
input  [AHB_ADDR_WIDTH-1:0] raddr;
integer num_trans;
integer ready;
integer timeout;

begin
	@(posedge AHB_SYN_clk)
	AHB_SYN_addr  <= raddr;
	AHB_HWRITE    <= 1'b0;
	AHB_HTRANS[1] <= 1'b1;
	
	@(posedge AHB_SYN_clk)
	AHB_SYN_addr  <= 0;
	AHB_HTRANS[1] <= 0;
	
	num_trans = 0;
	ready = 0;
	timeout = 0;
	while((ready == 0) && (timeout == 0)) begin//если за 64 клока не будет реди, то таймаут!
	@(posedge AHB_SYN_clk)
	if(AHB_HREADY) begin
		ready = 1;
		$display ("%7gns Read from addr : 0x%h | data : 0x%h", $time, raddr, AHB_SYN_rdata);
	end
	if(num_trans == 63) begin
		$display ("%7gns READY TIMEOUT! READ FAIL", $time);
		timeout = 1;
	end
	num_trans = num_trans + 1;
	end
end
endtask
