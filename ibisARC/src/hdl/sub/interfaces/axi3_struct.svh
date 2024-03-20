`ifndef AXI3_STRUCT_SVH
`define AXI3_STRUCT_SVH

typedef struct packed {
    logic [31:0] araddr;
    logic [1:0]  arburst;
    logic [3:0]  arcache;
    logic [11:0] arid;
    logic [3:0]  arlen;
    logic [1:0]  arlock;
    logic [2:0]  arprot;
    logic [3:0]  arqos;
    logic [2:0]  arsize;
    logic        arvalid;
    logic [31:0] awaddr;
    logic [1:0]  awburst;
    logic [3:0]  awcache;
    logic [11:0] awid;
    logic [3:0]  awlen;
    logic [1:0]  awlock;
    logic [2:0]  awprot;
    logic [3:0]  awqos;
    logic [2:0]  awsize;
    logic        awvalid;
    logic        bready;
    logic        rready;
    logic [31:0] wdata;
    logic [11:0] wid;
    logic        wlast;
    logic [3:0]  wstrb;
    logic        wvalid;
} AXI3_MASTER_STRUCT;

typedef struct packed {
    logic        arready;
    logic        awready;
    logic [11:0] bid;
    logic [1:0]  bresp;
    logic        bvalid;
    logic [31:0] rdata;
    logic [11:0] rid;
    logic        rlast;
    logic [1:0]  rresp;
    logic        rvalid;
    logic        wready;
} AXI3_SLAVE_STRUCT;

`endif