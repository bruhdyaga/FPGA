interface axi4lite_interface
#(
	parameter ADDR_WIDTH = 32
);

/// Bus signals
logic                  aclk;
logic                  resetn;
logic [ADDR_WIDTH-1:0] araddr;
logic [2:0]            arprot;
logic                  arready;
logic                  arvalid;
logic [ADDR_WIDTH-1:0] awaddr;
logic [2:0]            awprot;
logic                  awready;
logic                  awvalid;
logic                  bready;
logic [1:0]            bresp;
logic                  bvalid;
logic [31:0]           rdata;
logic                  rready;
logic [1:0]            rresp;
logic                  rvalid;
logic [31:0]           wdata;
logic                  wready;
logic [3:0]            wstrb;
logic                  wvalid;



modport master
(
	output aclk    ,
	output resetn  ,
	output araddr  ,
	output arprot  ,
	input  arready ,
	output arvalid ,
	output awaddr  ,
	output awprot  ,
	input  awready ,
	output awvalid ,
	output bready  ,
	input  bresp   ,
	input  bvalid  ,
	input  rdata   ,
	output rready  ,
	input  rresp   ,
	input  rvalid  ,
	output wdata   ,
	input  wready  ,
	output wstrb   ,
	output wvalid
);

modport slave
(
	input  aclk    ,
	input  resetn  ,
	input  araddr  ,
	input  arprot  ,
	output arready ,
	input  arvalid ,
	input  awaddr  ,
	input  awprot  ,
	output awready ,
	input  awvalid ,
	input  bready  ,
	output bresp   ,
	output bvalid  ,
	output rdata   ,
	input  rready  ,
	output rresp   ,
	output rvalid  ,
	input  wdata   ,
	output wready  ,
	input  wstrb   ,
	input  wvalid
);

task Init;

	araddr  = 0;
	arprot  = 0;
	arvalid = 0;
	awaddr  = 0;
	awprot  = 0;
	awvalid = 0;
	bready  = 0;
	rready  = 0;
	wdata   = 0;
	wstrb   = 0;
	wvalid  = 0;

endtask

task Write
	(
	input [ADDR_WIDTH-1:0] base,
	input [ADDR_WIDTH-1:0] offset,
	input reg [31:0] val,
	input en_print
	);
	
	reg aw_ok;
	reg w_ok;
	
	@(posedge aclk)
	awaddr  = base + offset;
	wdata   = val;
	awvalid = '1;
	wvalid  = '1;
	if(en_print) $display ("%7gns Write  to addr : 0x%h | data : 0x%h", $time, awaddr, wdata);
	
	aw_ok = 0;
	w_ok = 0;
	
	do begin
		@(posedge aclk)
		
		if(aw_ok == 0) begin //проверка готовности адреса
			if(awready == 1'b1) begin
				aw_ok = 1'b1; end
		end else begin
			awvalid = '0;
			awaddr  = '0;
		end
		
		if(w_ok == 0) begin//проверка готовности данных
			if(wready == 1'b1) begin
				w_ok = 1'b1; end
		end else begin
			wvalid = '0;
			wdata  = '0;
		end
		
	end while((aw_ok == 0) || (w_ok == 0) || (awvalid != 1'b0) || (wvalid != 1'b0)); //устройство защелкнуло данные и адрес; а мастер опустил valid

endtask

task Read
	(
	input [ADDR_WIDTH-1:0] base,
	input [ADDR_WIDTH-1:0] offset,
	output reg [31:0] data,
	input en_print
	);
	
	reg ar_ok;
	reg rd_ok;
	reg [ADDR_WIDTH-1:0] addr;
	
	@(posedge aclk)
	araddr  = base + offset;
	addr = araddr; //запомнили адрес
	arvalid = '1; //адрес готов
	rready = '1; //мастер готов на прием
	
	
	ar_ok = 0;
	rd_ok = 0;
	
	do begin
		@(posedge aclk)
		
		if(ar_ok == 0) begin //проверка готовности адреса
			if(arready == 1'b1) begin
				ar_ok = '1; end
		end else begin
			arvalid = '0;
			araddr  = '0;
		end
		
		if(ar_ok == 1'b1) begin //адрес получен
			if(rvalid == 1'b1) begin
				rready = '0;
				data = rdata;
				rd_ok = '1;
			end
		end
		
	end while((ar_ok == 0) || (rd_ok == 0) || (arvalid != 1'b0) /* || (wvalid != 1'b0) */); //устройство защелкнуло адрес; а мастер опустил valid
	
	if(en_print) $display ("%7gns Read from addr : 0x%h | data : 0x%h", $time, addr, data);
	
endtask

endinterface