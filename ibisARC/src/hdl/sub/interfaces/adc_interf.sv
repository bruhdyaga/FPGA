interface adc_interf
#(
    parameter PORTS = 0,
    parameter R     = 0
)
();

// localparam RNUM = 1+$clog2(PORTS); // The number of bits needed to store the port number

logic [R-1:0] data [PORTS-1:0];
logic clk;
logic valid;


modport master
(
    output data,
    output clk,
    output valid
);

modport slave
(
    input data,
    input clk,
    input valid
);

endinterface
