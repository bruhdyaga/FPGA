interface apb_interface
#(
    parameter ADDR_WIDTH = 30
);


/// Bus signals
logic                  clk;
logic                  resetn;
logic [ADDR_WIDTH-1:0] paddr;
logic                  penable;
logic [31:0]           prdata;
logic                  pready;
logic                  psel;
logic                  pslverr;
logic [31:0]           pwdata;
logic                  pwrite;

modport master
(
    output clk,
    output resetn,
    output paddr,
    output penable,
    input  prdata,
    input  pready,
    output psel,
    input  pslverr,
    output pwdata,
    output pwrite
);

modport slave
(
    input  clk,
    input  resetn,
    input  paddr,
    input  penable,
    output prdata,
    output pready,
    input  psel,
    output pslverr,
    input  pwdata,
    input  pwrite
);

endinterface