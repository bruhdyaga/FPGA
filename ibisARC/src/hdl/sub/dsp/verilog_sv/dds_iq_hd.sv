module dds_iq_hd
#(
    parameter IQ_WIDTH    = 0,
    parameter PHASE_WIDTH = 0,
    parameter TABLE_NAME  = ""
)
(
    input                            clk,
    output reg signed [IQ_WIDTH-1:0] sin,
    output reg signed [IQ_WIDTH-1:0] cos,
    input  [31:0]                    code,
    output [32:0]                    phase_cntr
);

localparam ROM_WIDTH = IQ_WIDTH*2;

reg  [ROM_WIDTH-1:0]   rom [(2**PHASE_WIDTH)-1:0];
reg  [ROM_WIDTH-1:0]   rom_reg;
wire [PHASE_WIDTH-1:0] addr;
reg  [31:0]            phase_cntr_reg = '0;

initial
    if (TABLE_NAME) $readmemb(TABLE_NAME, rom, 0, (2**PHASE_WIDTH)-1);

assign addr = phase_cntr[31:32-PHASE_WIDTH];

assign phase_cntr = phase_cntr_reg + code;

always_ff@(posedge clk) begin
    phase_cntr_reg <= phase_cntr[31:0];
end

always_ff@(posedge clk)
    rom_reg <= rom[addr];

assign sin = rom_reg[ROM_WIDTH-1:IQ_WIDTH];
assign cos = rom_reg[IQ_WIDTH-1:0];

endmodule