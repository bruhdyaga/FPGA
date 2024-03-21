`ifndef RGB_CH
`define RGB_CH

`include "macro.svh"

localparam WIDTH = 4;

typedef struct packed {
    logic [31:28]      WIDTH_RGB;
    logic [27:WIDTH*3] RESERVED;
    logic [WIDTH-1:0]  B;
    logic [WIDTH-1:0]  G;
    logic [WIDTH-1:0]  R;
} RGB_CFG;

typedef struct packed {
    RGB_CFG RGB;
} RGB_STRUCT;

`define RGB_ID_CONST  (16'h8BFF)
`define RGB_SIZE      (`size32(RGB_STRUCT))
`define RGB_FULL_SIZE (`RGB_SIZE + `RWREGSSIZE)

`endif