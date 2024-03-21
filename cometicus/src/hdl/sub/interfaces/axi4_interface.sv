interface axi4_interface
#(
    parameter D_WIDTH  = 64,
    parameter ID_WIDTH = 3
)
();

/// Bus signals
logic [31:0]         araddr;
logic [1:0]          arburst;
logic [3:0]          arcache;
logic [ID_WIDTH-1:0] arid;
logic [3:0]          arlen;
logic [1:0]          arlock;
logic [2:0]          arprot;
logic [3:0]          arqos;
logic                arready;
logic [2:0]          arsize;
logic [4:0]          aruser;
logic                arvalid;
logic [31:0]         awaddr;
logic [1:0]          awburst;
logic [3:0]          awcache;
logic [ID_WIDTH-1:0] awid;
logic [3:0]          awlen;
logic [1:0]          awlock;
logic [2:0]          awprot;
logic [3:0]          awqos;
logic                awready;
logic [2:0]          awsize;
logic [4:0]          awuser;
logic                awvalid;
logic [ID_WIDTH-1:0] bid;
logic                bready;
logic [1:0]          bresp;
logic                bvalid;
logic [D_WIDTH-1:0]  rdata;
logic [ID_WIDTH-1:0] rid;
logic                rlast;
logic                rready;
logic [1:0]          rresp;
logic                rvalid;
logic [D_WIDTH-1:0]  wdata;
logic [ID_WIDTH-1:0] wid;
logic                wlast;
logic                wready;
logic [7:0]          wstrb;
logic                wvalid;



modport master
(
    output araddr,
    output arburst,
    output arcache,
    output arid,
    output arlen,
    output arlock,
    output arprot,
    output arqos,
    input  arready,
    output arsize,
    output aruser,
    output arvalid,
    output awaddr,
    output awburst,
    output awcache,
    output awid,
    output awlen,
    output awlock,
    output awprot,
    output awqos,
    input  awready,
    output awsize,
    output awuser,
    output awvalid,
    input  bid,
    output bready,
    input  bresp,
    input  bvalid,
    input  rdata,
    input  rid,
    input  rlast,
    output rready,
    input  rresp,
    input  rvalid,
    output wdata,
    output wid,
    output wlast,
    input  wready,
    output wstrb,
    output wvalid
);

modport slave
(
    input  araddr,
    input  arburst,
    input  arcache,
    input  arid,
    input  arlen,
    input  arlock,
    input  arprot,
    input  arqos,
    output arready,
    input  arsize,
    input  aruser,
    input  arvalid,
    input  awaddr,
    input  awburst,
    input  awcache,
    input  awid,
    input  awlen,
    input  awlock,
    input  awprot,
    input  awqos,
    output awready,
    input  awsize,
    input  awuser,
    input  awvalid,
    output bid,
    input  bready,
    output bresp,
    output bvalid,
    output rdata,
    output rid,
    output rlast,
    input  rready,
    output rresp,
    output rvalid,
    input  wdata,
    input  wid,
    input  wlast,
    output wready,
    input  wstrb,
    input  wvalid
);

modport debug
(
    input araddr,
    input arburst,
    input arcache,
    input arid,
    input arlen,
    input arlock,
    input arprot,
    input arqos,
    input arready,
    input arsize,
    input aruser,
    input arvalid,
    input awaddr,
    input awburst,
    input awcache,
    input awid,
    input awlen,
    input awlock,
    input awprot,
    input awqos,
    input awready,
    input awsize,
    input awuser,
    input awvalid,
    input bid,
    input bready,
    input bresp,
    input bvalid,
    input rdata,
    input rid,
    input rlast,
    input rready,
    input rresp,
    input rvalid,
    input wdata,
    input wid,
    input wlast,
    input wready,
    input wstrb,
    input wvalid
);

endinterface