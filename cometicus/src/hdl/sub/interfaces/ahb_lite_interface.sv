interface ahb_lite_interface
#(
	parameter ADDR_WIDTH = 32
);

/// Bus signals
logic                  aclk;
logic                  resetn;
logic [ADDR_WIDTH-1:0] haddr;
logic [2:0]            hburst;
logic                  hmastlock;
logic [3:0]            hprot;
logic [31:0]           hrdata;
logic                  hready;
logic                  hresp;
logic [2:0]            hsize;
logic [1:0]            htrans;
logic [31:0]           hwdata;
logic                  hwrite;

modport master
(
    output aclk,
    output resetn,
    output haddr,
    output hburst,
    output hmastlock,
    output hprot,
    input  hrdata,
    input  hready,
    input  hresp,
    output hsize,
    output htrans,
    output hwdata,
    output hwrite
);

modport slave
(
    input  aclk,
    input  resetn,
    input  haddr,
    input  hburst,
    input  hmastlock,
    input  hprot,
    output hrdata,
    output hready,
    output hresp,
    input  hsize,
    input  htrans,
    input  hwdata,
    input  hwrite
);

endinterface
