`timescale 1ns/1ns
module bus_interface_apb_syn_tb();

reg clk = 1;
reg resetn;

reg [31:0] apb_bridge_0_M_APB_PADDR;
reg apb_bridge_0_M_APB_PSEL;
reg apb_bridge_0_M_APB_PENABLE;
reg apb_bridge_0_M_APB_PWRITE;
reg [31:0] apb_bridge_0_M_APB_PWDATA;

wire [31:0] apb_out_wdata;
wire [31:0] apb_out_addr;
wire apb_out_wr_en;
wire apb_out_rd_en;

always #5 clk = !clk;

initial begin
resetn = 1'b1;
#70 resetn = 1'b0;
#70 resetn = 1'b1;
end

initial begin
#0
apb_bridge_0_M_APB_PADDR   = 0;
apb_bridge_0_M_APB_PSEL    = 0;
apb_bridge_0_M_APB_PENABLE = 0;
apb_bridge_0_M_APB_PWRITE  = 0;
apb_bridge_0_M_APB_PWDATA  = 0;
//read
#200
apb_bridge_0_M_APB_PADDR   = 32'h10;
apb_bridge_0_M_APB_PSEL    = 1'b1;
apb_bridge_0_M_APB_PENABLE = 1'b1;
apb_bridge_0_M_APB_PWRITE  = 0;
apb_bridge_0_M_APB_PWDATA  = 32'hAAABBBCC;
//write
end


bus_interface_apb_syn bus_interface_apb_syn_inst(
	.aclk                       (clk),
	.resetn                     (resetn),
	.apb_bridge_0_M_APB_PADDR   (apb_bridge_0_M_APB_PADDR),
	.apb_bridge_0_M_APB_PSEL    (apb_bridge_0_M_APB_PSEL),
	.apb_bridge_0_M_APB_PENABLE (apb_bridge_0_M_APB_PENABLE),
	.apb_bridge_0_M_APB_PWRITE  (apb_bridge_0_M_APB_PWRITE),
	.apb_bridge_0_M_APB_PWDATA  (apb_bridge_0_M_APB_PWDATA),
	.apb_bridge_0_M_APB_PREADY  (),
	.apb_bridge_0_M_APB_PSLVERR (),
	.out_wdata                  (apb_out_wdata),
	.out_addr                   (apb_out_addr),
	.out_rd                     (apb_out_wr_en),
	.out_wr                     (apb_out_rd_en)
);


endmodule