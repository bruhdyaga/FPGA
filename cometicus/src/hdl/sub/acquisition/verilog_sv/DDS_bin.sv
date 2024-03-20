`include "DDS_bin.svh"

module DDS_bin
#(
    parameter BASEADDR = 0
)
(
    input clk,
    input syn_reset,
    output logic out = '0,
    input en,//разрешение на работу счетчика фазы
    intbus_interf.slave bus
);


logic [31:0] sum_cntr = '0;
logic adr;

DDS_BIN_STRUCT PS;

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`DDS_BIN_ID_CONST),
    .DATATYPE (DDS_BIN_STRUCT)
) regs_file_dds_bin_inst(
    .clk    ('0),
    .bus    (bus),
    .in     ('0),
    .out    (PS),
    .pulse  (),
    .wr     (),
    .rd     ()
);

always_ff@(posedge clk)
if(syn_reset)
    out <= '0;
else begin
    case (adr)
        1'b0  : out <= '0;
        1'b1  : out <= '1;
    endcase
end

assign adr = sum_cntr[31];

always_ff@(posedge clk)
if(syn_reset)
    sum_cntr <= PS.CODE_FREQ;
else
    if(en == '1)
        sum_cntr <= sum_cntr + PS.CODE_FREQ;


endmodule
