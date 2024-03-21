`include "DDS_sin_cos.svh"
`include "global_param.v"

module DDS_sin_cos
#(
    parameter BASEADDR   = 0,
    parameter BUS_EN     = 0,
    parameter CODE_WIDTH = 0
)
(
    input                     clk,
    input                     syn_reset,
    output logic signed [2:0] sin = '0,
    output logic signed [2:0] cos = '0,
    input                     en,//разрешение на работу счетчика фазы
    input [CODE_WIDTH-1:0]    code_in,
    intbus_interf.slave       bus
);

localparam PHASE_WIDTH = 5;

logic [CODE_WIDTH-1:0]  code;
logic [CODE_WIDTH-1:0]  sum_cntr = '0;
logic [PHASE_WIDTH-1:0] phase;

generate
if(BUS_EN) begin: bus_interface
    DDS_SIN_COS_STRUCT PL;
    DDS_SIN_COS_STRUCT PS;
    
    regs_file#(
        .BASEADDR (BASEADDR),
        .ID       (`DDS_SIN_COS_ID_CONST),
        .DATATYPE (DDS_SIN_COS_STRUCT)
    ) regs_file_dds_sin_cos_inst(
        .clk    ('0),
        .bus    (bus),
        .in     ('0),
        .out    (PS),
        .pulse  (),
        .wr     (),
        .rd     ()
    );
    
    assign code       = PS.CODE;
end else begin
    assign code       = code_in;
    assign bus.rvalid = '0; // bus is not used
    assign bus.rdata  = '0; // bus is not used
end
endgenerate

assign phase = sum_cntr[CODE_WIDTH-1:CODE_WIDTH-PHASE_WIDTH];

always_ff@(posedge clk)
if(syn_reset) begin
    sin <= '0;
    cos <= '0;
end else begin
    case (phase)
        // 5'd0  : {sin,cos} <= {4'd0 ,4'd5};  // sin,cos
        // 5'd1  : {sin,cos} <= {4'd1 ,4'd5};  // sin,cos
        // 5'd2  : {sin,cos} <= {4'd2 ,4'd5};  // sin,cos
        // 5'd3  : {sin,cos} <= {4'd3 ,4'd4};  // sin,cos
        // 5'd4  : {sin,cos} <= {4'd4 ,4'd4};  // sin,cos
        // 5'd5  : {sin,cos} <= {4'd4 ,4'd3};  // sin,cos
        // 5'd6  : {sin,cos} <= {4'd5 ,4'd2};  // sin,cos
        // 5'd7  : {sin,cos} <= {4'd5 ,4'd1};  // sin,cos
        // 5'd8  : {sin,cos} <= {4'd5 ,4'd0};  // sin,cos
        // 5'd9  : {sin,cos} <= {4'd5 ,-4'd1}; // sin,cos
        // 5'd10 : {sin,cos} <= {4'd5 ,-4'd2}; // sin,cos
        // 5'd11 : {sin,cos} <= {4'd4 ,-4'd3}; // sin,cos
        // 5'd12 : {sin,cos} <= {4'd4 ,-4'd4}; // sin,cos
        // 5'd13 : {sin,cos} <= {4'd3 ,-4'd4}; // sin,cos
        // 5'd14 : {sin,cos} <= {4'd2 ,-4'd5}; // sin,cos
        // 5'd15 : {sin,cos} <= {4'd1 ,-4'd5}; // sin,cos
        // 5'd16 : {sin,cos} <= {4'd0 ,-4'd5}; // sin,cos
        // 5'd17 : {sin,cos} <= {-4'd1,-4'd5}; // sin,cos
        // 5'd18 : {sin,cos} <= {-4'd2,-4'd5}; // sin,cos
        // 5'd19 : {sin,cos} <= {-4'd3,-4'd4}; // sin,cos
        // 5'd20 : {sin,cos} <= {-4'd4,-4'd4}; // sin,cos
        // 5'd21 : {sin,cos} <= {-4'd4,-4'd3}; // sin,cos
        // 5'd22 : {sin,cos} <= {-4'd5,-4'd2}; // sin,cos
        // 5'd23 : {sin,cos} <= {-4'd5,-4'd1}; // sin,cos
        // 5'd24 : {sin,cos} <= {-4'd5,4'd0};  // sin,cos
        // 5'd25 : {sin,cos} <= {-4'd5,4'd1};  // sin,cos
        // 5'd26 : {sin,cos} <= {-4'd5,4'd2};  // sin,cos
        // 5'd27 : {sin,cos} <= {-4'd4,4'd3};  // sin,cos
        // 5'd28 : {sin,cos} <= {-4'd4,4'd4};  // sin,cos
        // 5'd29 : {sin,cos} <= {-4'd3,4'd4};  // sin,cos
        // 5'd30 : {sin,cos} <= {-4'd2,4'd5};  // sin,cos
        // 5'd31 : {sin,cos} <= {-4'd1,4'd5};  // sin,cos
        
            5'd0  : {sin,cos} <= {3'b000,3'b011}; //  0    3
            5'd1  : {sin,cos} <= {3'b001,3'b011}; //  1    3
            5'd2  : {sin,cos} <= {3'b001,3'b011}; //  1    3
            5'd3  : {sin,cos} <= {3'b010,3'b010}; //  2    2
            5'd4  : {sin,cos} <= {3'b010,3'b010}; //  2    2
            5'd5  : {sin,cos} <= {3'b010,3'b010}; //  2    2
            5'd6  : {sin,cos} <= {3'b011,3'b001}; //  3    1
            5'd7  : {sin,cos} <= {3'b011,3'b001}; //  3    1
            5'd8  : {sin,cos} <= {3'b011,3'b000}; //  3    0
            5'd9  : {sin,cos} <= {3'b011,3'b111}; //  3   -1
            5'd10 : {sin,cos} <= {3'b011,3'b111}; //  3   -1
            5'd11 : {sin,cos} <= {3'b010,3'b110}; //  2   -2
            5'd12 : {sin,cos} <= {3'b010,3'b110}; //  2   -2
            5'd13 : {sin,cos} <= {3'b010,3'b110}; //  2   -2
            5'd14 : {sin,cos} <= {3'b001,3'b101}; //  1   -3
            5'd15 : {sin,cos} <= {3'b001,3'b101}; //  1   -3
            5'd16 : {sin,cos} <= {3'b000,3'b101}; //  0   -3
            5'd17 : {sin,cos} <= {3'b111,3'b101}; // -1   -3
            5'd18 : {sin,cos} <= {3'b111,3'b101}; // -1   -3
            5'd19 : {sin,cos} <= {3'b110,3'b110}; // -2   -2
            5'd20 : {sin,cos} <= {3'b110,3'b110}; // -2   -2
            5'd21 : {sin,cos} <= {3'b110,3'b110}; // -2   -2
            5'd22 : {sin,cos} <= {3'b101,3'b111}; // -3   -1
            5'd23 : {sin,cos} <= {3'b101,3'b111}; // -3   -1
            5'd24 : {sin,cos} <= {3'b101,3'b000}; // -3    0
            5'd25 : {sin,cos} <= {3'b101,3'b001}; // -3    1
            5'd26 : {sin,cos} <= {3'b101,3'b001}; // -3    1
            5'd27 : {sin,cos} <= {3'b110,3'b010}; // -2    2
            5'd28 : {sin,cos} <= {3'b110,3'b010}; // -2    2
            5'd29 : {sin,cos} <= {3'b110,3'b010}; // -2    2
            5'd30 : {sin,cos} <= {3'b111,3'b011}; // -1    3
            5'd31 : {sin,cos} <= {3'b111,3'b011}; // -1    3
    endcase
end

always_ff@(posedge clk)
if(syn_reset)
    sum_cntr <= code;
else
    if(en == '1)
        sum_cntr <= sum_cntr + code;
    else
        sum_cntr <= '0;


endmodule
