/* 
bus_interface_ahb_syn#(
	.ADDR_WIDTH ()
)
bus_interface_ahb_syn_inst(
	.ahb_clk       (),
	.ahb_resetn    (),
	.ahb_haddr     (),
  	.ahb_hburst    (),
  	.ahb_hmastlock (),
  	.ahb_hprot     (),
  	.ahb_hready    (),
  	.ahb_hresp     (),
  	.ahb_hsize     (),
  	.ahb_htrans    (),
  	.ahb_hwrite    (),
	.ahb_hsel      (),
	.addr_reg      (),
	.rd            (),
	.wr            ()
);
 */
module bus_interface_ahb_syn(
	ahb_clk,
	ahb_resetn,
	ahb_haddr,
  	ahb_hburst,
  	ahb_hmastlock,
  	ahb_hprot,
  	ahb_hready,
  	ahb_hresp,
  	ahb_hsize,
  	ahb_htrans,
  	ahb_hwrite,
	ahb_hsel,
	addr_reg,
	rd,
	wr
);

parameter ADDR_WIDTH = -1;

input ahb_clk;
input ahb_resetn;
input [31:0] ahb_haddr;
input [2:0] ahb_hburst;
input ahb_hmastlock;
input [3:0] ahb_hprot;
output ahb_hready;
output ahb_hresp;
input [2:0] ahb_hsize;
input [1:0] ahb_htrans;
input ahb_hwrite;
input ahb_hsel;
output [ADDR_WIDTH - 1 : 0] addr_reg;
output rd;
output wr;

reg [ADDR_WIDTH - 1 : 0] addr_reg;
reg rd;
reg wr;
reg ahb_hready;

always @(posedge ahb_clk or  negedge ahb_resetn) begin
	if (ahb_resetn == 1'b0) begin
		addr_reg <= {ADDR_WIDTH{1'b0}};
	end
	else if ((ahb_htrans[1] == 1'b1) && (ahb_hsel == 1'b1)) begin
		addr_reg <= ahb_haddr[ADDR_WIDTH+1 : 2];            
	end
end
	
always @(posedge ahb_clk or  negedge ahb_resetn) begin
	if (ahb_resetn == 1'b0) begin
		rd <= 1'b0;
	end
	else if ((ahb_htrans[1] == 1'b1) && (ahb_hwrite == 1'b0) && (ahb_hsel == 1'b1)) begin
		rd <= 1'b1;            
	end
	else begin
		rd <= 1'b0;
	end
end
	
always @(posedge ahb_clk or  negedge ahb_resetn) begin
	if (ahb_resetn == 1'b0) begin
		wr <= 1'b0;
	end
	else if ((ahb_htrans[1] == 1'b1) && (ahb_hwrite == 1'b1) && (ahb_hsel == 1'b1)) begin
		wr <= 1'b1;            
	end
	else begin
		wr <= 1'b0;
	end
end


always @(posedge ahb_clk or  negedge ahb_resetn) begin
	if (ahb_resetn == 1'b0) begin
		ahb_hready <= 1'b0;
	end
	else if(ahb_hready == 1'b0) begin
		ahb_hready <= 1'b1;
	end
	else if ((ahb_htrans[1] == 1'b1) && (ahb_hsel == 1'b1)) begin
		ahb_hready <= 1'b0;            
	end
	else begin
		ahb_hready <= 1'b1;
	end
end

assign ahb_hresp = 1'b0;//Answer - OKAY
// assign ahb_hready = 1'b1;
// assign ahb_hready = !(wr | rd);

endmodule


