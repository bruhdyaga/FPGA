`include "data_recorder.svh"

module data_recorder
#(
    parameter BASEADDR   = 0,
    parameter NUM_PORTS  = 0,
    parameter DATA_WIDTH = 1,
    parameter DATA_DEPTH = 1,
    parameter RAM_TYPE   = "BLOCK" //"BLOCK" or "LUT"
)
(
    input      clk,
    output reg valid,
    output [NUM_PORTS*DATA_WIDTH-1:0] data,
    intbus_interf.slave bus
);


localparam RAM_ADDR_WIDTH     = $clog2(DATA_DEPTH);
// localparam WR_DEPTH_REG_WIDTH = (RAM_ADDR_WIDTH + 1);    //разрядность регистра объема записи данных в датаколлектор

intbus_interf    bus_sl();
pipe_line_bus#(
    .PS_FF ("y"),
    .PL_FF ("y")
) pipe_line_bus(
    .master_bus (bus),
    .slave_bus  (bus_sl)
);

// The generator data structure definition
DATA_RECORDER_STRUCT PL;     // The registers from logic
DATA_RECORDER_STRUCT PS;     // The registers from CPU

wire [`DATA_RECORDER_SIZE-1:0] bus_rd;
wire [`DATA_RECORDER_SIZE-1:0] bus_wr;

//Define which bits will be pulsed
localparam NPULSE = 2;
localparam integer PULSE [NPULSE][2] = '{
    '{4, 0},// soft_reset
    '{6, 0} // trig_en_pulse
};

localparam [`DATA_RECORDER_SIZE-1:0] RVALID_FF = 'b10000000000;

regs_file#(
    .BASEADDR  (BASEADDR),
    .ID        (`DATA_RECORDER_ID_CONST),
    .DATATYPE  (DATA_RECORDER_STRUCT),
    .NPULSE    (NPULSE),
    .PULSE     (PULSE),
    .RVALID_FF (RVALID_FF)
)RF (
    .clk    (clk),
    .bus    (bus_sl),
    .in     (PL),
    .out    (PS),
    .pulse  ({trig_en_pulse,soft_reset}),
    .wr     (bus_wr),
    .rd     (bus_rd)
);

assign PL.DATA_RECORDER_NUM         = '0;
assign PL.DATA_RECORDER_NUM_PORTS   = NUM_PORTS;
assign PL.DATA_RECORDER_WIDTH       = DATA_WIDTH;
assign PL.DATA_RECORDER_DEPTH       = DATA_DEPTH;
assign PL.DATA_RECORDER_SOFT_RESETN = '0;
assign PL.DATA_RECORDER_BUS_CHAN    = '0;
assign PL.DATA_RECORDER_WR_PERM     = '0;
assign PL.DATA_RECORDER_RD_DEPTH    = '0;
assign PL.DATA_RECORDER_RW_REG      = '0;
assign PL.DATA_RECORDER_WE_DIS      = '0;

reg  [RAM_ADDR_WIDTH-1:0] addr_wr;     // адрес записи
reg  [RAM_ADDR_WIDTH-1:0] addr_rd;     // адрес чтения
reg  trig_en;

wire signed [DATA_WIDTH-1:0] ram_out [NUM_PORTS-1:0];
logic [DATA_WIDTH-1:0] ram_in [NUM_PORTS-1:0];

assign {>>{ram_in}} = {NUM_PORTS{bus_sl.wdata[DATA_WIDTH-1:0]}};
assign data = {>>{ram_out}};

generate
for(genvar i = 0; i < NUM_PORTS; i ++) begin: RAM_GEN
    if(RAM_TYPE == "BLOCK")
        bram_block_v2#(
            .OUT_REG ("EN"),
            .WIDTH   (DATA_WIDTH),
            .DEPTH   (DATA_DEPTH)
        )
        bram_block_v2_inst(
            .wr_clk  (bus.clk),
            .rd_clk  (clk),
            .we      (bus_wr[10] & (PS.DATA_RECORDER_BUS_CHAN == i)),
            .re      ('1),
            .dat_in  (ram_in[i]),
            .dat_out (ram_out[i]),
            .wr_addr (addr_wr),
            .rd_addr (addr_rd)
        );
    else
        $error("Invalid RAM_TYPE: %s",RAM_TYPE);
end
endgenerate

assign PL.DATA_RECORDER_RAM = ram_out[PS.DATA_RECORDER_BUS_CHAN];

always_ff@(posedge bus.clk)
if(bus_wr[4]) begin // soft_reset
    addr_wr <= '0;
end else begin
    if(bus_wr[10]) begin
        addr_wr <= addr_wr + 1'b1;
    end
end

always_ff@(posedge clk)
if(soft_reset) begin // сброс по записи
    trig_en <= '0;
end else begin
    if(trig_en_pulse) begin
        trig_en <= 1'b1;
    end else begin
        if(addr_rd == PS.DATA_RECORDER_RD_DEPTH - 1'b1) begin // окончил чтение
            trig_en <= 0;
        end
    end
end

assign PL.DATA_RECORDER_TRIG_EN = trig_en;

signal_sync signal_sync_cpu_rd_ram(
    .sclk     (bus.clk),
    .dclk     (clk),
    .start    (bus_rd[10]),
    .ready    (cpu_rd_ram)
);

always_ff@(posedge clk)
if(soft_reset) begin // сброс по записи
    addr_rd <= 0;
end else begin // можно читать
    if(trig_en | cpu_rd_ram) begin
        addr_rd <= addr_rd + 1'b1;
    end
end

always_ff@(posedge clk) begin
    valid <= trig_en;
end

endmodule
