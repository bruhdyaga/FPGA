interface adc_interf_3d
#(
    parameter PORTS = 0,
    parameter GROUP = 0,
    parameter R     = 0
)
();

logic [R-1:0] data [GROUP-1:0][PORTS-1:0];
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
