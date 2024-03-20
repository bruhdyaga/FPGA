`timescale 1ns/10ps
module bus_interface_ahb_syn_tb();
`include "ahb_task.v"
`include "data_collector_param.v"

parameter ADDR_WIDTH = 30;
parameter NUM        = 0;
parameter BASE_ADDR  = (32'h52000000/4);
parameter NUM_PORTS  = 1;
parameter DATA_WIDTH = 32;
parameter DATA_DEPTH = 8;

reg resetn;

initial begin
     resetn = 1'b1;
#30  resetn = 1'b0;
#200 resetn = 1'b1;
end

wire [ADDR_WIDTH-1:0] ahb_syn_addr_reg;
wire ahb_syn_rd;
wire ahb_syn_wr;


bus_interface_ahb_syn#(
	.ADDR_WIDTH (ADDR_WIDTH)
)
bus_interface_ahb_syn_inst(
	.ahb_clk       (AHB_SYN_clk),
	.ahb_resetn    (AHB_SYN_resetn),
	.ahb_haddr     (AHB_SYN_addr),
  	.ahb_hburst    (),
  	.ahb_hmastlock (),
  	.ahb_hprot     (),
  	.ahb_hready    (AHB_HREADY),
  	.ahb_hresp     (),
  	.ahb_hsize     (),
  	.ahb_htrans    (AHB_HTRANS),
  	.ahb_hwrite    (AHB_HWRITE),
	.ahb_hsel      (1'b1),
	.addr_reg      (ahb_syn_addr_reg),
	.rd            (ahb_syn_rd),
	.wr            (ahb_syn_wr)
);


initial begin
forever begin
	@(negedge resetn)
	@(posedge resetn)//ну погнали!
	INIT_AHB_SYN_TASK;
	
	WRITE_AHB_SYN_TASK((BASE_ADDR + SOFT_RESETN_ADDR)*4,1);//soft reset
	
	while(AHB_SYN_rdata != DATA_COLL_CONST) begin//дожидаемся чтения нужной константы
		READ_AHB_SYN_TASK((BASE_ADDR + DATA_COLL_CONST_ADDR)*4);
		$display ("%7gns wait bus constant", $time);
	end
end
end



//для тестирования шины
data_collector#(
	.BUS_ADDR_WIDTH (ADDR_WIDTH),
	.NUM            (NUM),
	.BASE_ADDR      (BASE_ADDR),
	.NUM_PORTS      (NUM_PORTS),
	.DATA_WIDTH     (DATA_WIDTH),
	.DATA_DEPTH     (DATA_DEPTH)
)
data_collector_inst(
	.clk        (1'b0),
	.resetn     (1'b1),
	.data       (0),
	.data_out   (),
	.bus_clk    (AHB_SYN_clk),
	.bus_resetn (AHB_SYN_resetn),
	.bus_addr   (ahb_syn_addr_reg),
	.bus_wdata  (AHB_SYN_wdata),
	.bus_rdata  (AHB_SYN_rdata),
	.bus_wr     (ahb_syn_wr),
	.bus_rd     (ahb_syn_rd)
);

endmodule