module test_slave#(
    parameter ADDR_WIDTH = 30,
    parameter READ_DATA  = 0,
    parameter BASEADDR   = 0
)
(
    intbus_interf.slave bus
);

wire [ADDR_WIDTH-1:0] baseaddr_mux;
assign baseaddr_mux = (BASEADDR == 0) ? bus.baseaddr : BASEADDR;

assign rd = ((bus.addr >= baseaddr_mux) & (bus.addr < (baseaddr_mux + 16))) & bus.rd;
assign bus.asize = 16;

conv_reg#(
    //width(1)
    .length(25)// number of registers
) conv_reg_inst(
    .clk    (bus.clk),
    .in     (rd),
    .out    (bus.rvalid)
);

assign bus.rdata = (bus.rvalid) ? READ_DATA : 0;

endmodule