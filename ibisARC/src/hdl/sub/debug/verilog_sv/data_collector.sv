`include "data_collector.svh"

module data_collector
#(
    parameter BASEADDR   = 0,
    parameter NUM_PORTS  = 0,
    parameter DATA_WIDTH = 1,
    parameter DATA_DEPTH = 1,
    parameter RAM_TYPE   = "BLOCK" //"BLOCK" or "LUT"
)
(
    input  clk,
    input  we,
    input  [NUM_PORTS*DATA_WIDTH-1:0] data,
    output write_done,
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
DATA_COLLECTOR PL;     // The registers from logic
DATA_COLLECTOR PS;     // The registers from CPU

wire [`DATA_COLLECTOR_SIZE-1:0] bus_rd;
wire [`DATA_COLLECTOR_SIZE-1:0] bus_wr;

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{6, 0} // trig_en_pulse
};

localparam [`DATA_COLLECTOR_SIZE-1:0] RVALID_FF = 'b10000000000;

regs_file#(
    .BASEADDR  (BASEADDR),
    .ID        (`DATA_COLLECTOR_ID_CONST),
    .DATATYPE  (DATA_COLLECTOR),
    .NPULSE    (NPULSE),
    .PULSE     (PULSE),
    .RVALID_FF (RVALID_FF)
)RF (
    .clk    (clk),
    .bus    (bus_sl),
    .in     (PL),
    .out    (PS),
    .pulse  (trig_en_pulse),
    .wr     (bus_wr),
    .rd     (bus_rd)
);

assign PL.DATA_COLL_NUM         = '0;
assign PL.DATA_COLL_NUM_PORTS   = NUM_PORTS;
assign PL.DATA_COLL_WIDTH       = DATA_WIDTH;
assign PL.DATA_COLL_DEPTH       = DATA_DEPTH;
assign PL.DATA_COLL_SOFT_RESETN = '0;
assign PL.DATA_COLL_BUS_CHAN    = '0;
assign PL.DATA_COLL_WR_PERM     = '0;
assign PL.DATA_COLL_WR_DEPTH    = '0;
assign PL.DATA_COLL_RW_REG      = '0;
assign PL.DATA_COLL_WE_DIS      = '0;

reg  [RAM_ADDR_WIDTH-1:0] addr_wr;     // адрес записи
reg  [RAM_ADDR_WIDTH-1:0] addr_rd;     // адрес чтения
reg  trig_en;                          //глобальный сигнал записи данных по каналам. В домене процессора
wire wr;                               //сигнал разрешения записи в память

wire signed [DATA_WIDTH-1:0] ram_out [NUM_PORTS-1:0];
logic [DATA_WIDTH-1:0] ram_in [NUM_PORTS-1:0];

assign {>>{ram_in}} = data;
generate
for(genvar i = 0; i < NUM_PORTS; i ++) begin: RAM_GEN
    if(RAM_TYPE == "BLOCK")
        bram_block_v2#(
            .OUT_REG ("EN"),
            .WIDTH   (DATA_WIDTH),
            .DEPTH   (DATA_DEPTH)
        )
        bram_block_v2_inst(
            .wr_clk  (clk),
            .rd_clk  (bus.clk),
            .we      (wr),
            .re      (bus_rd[10]),
            .dat_in  (ram_in[i]),
            .dat_out (ram_out[i]),
            .wr_addr (addr_wr),
            .rd_addr (addr_rd)
        );
    else if(RAM_TYPE == "LUT")
        bram_lut_v2#(
            .OUT_REG ("EN"),
            .WIDTH   (DATA_WIDTH),
            .DEPTH   (DATA_DEPTH)
        )
        bram_lut_v2_inst(
            .wr_clk  (clk),
            .rd_clk  (bus.clk),
            .we      (wr),
            .re      (bus_rd[10]),
            .dat_in  (ram_in[i]),
            .dat_out (ram_out[i]),
            .wr_addr (addr_wr),
            .rd_addr (addr_rd)
        );
    else
        initial $error("Invalid RAM_TYPE: %s",RAM_TYPE);
end
endgenerate

assign PL.DATA_COLL_RAM = ram_out[PS.DATA_COLL_BUS_CHAN];

assign wr = we & trig_en;
assign write_done = ~trig_en;

always_ff@(posedge clk)
if(trig_en_pulse) begin
    addr_wr <= '0;
end else begin
    if(wr) begin
        addr_wr <= addr_wr + 1'b1;
    end
end

always_ff@(posedge clk)
if(trig_en_pulse) begin
    trig_en <= 1'b1;
end else begin
    if(addr_wr == PS.DATA_COLL_WR_DEPTH - 1'b1) begin // окончил запись
        trig_en <= 0;
    end
end

assign PL.DATA_COLL_TRIG_EN = trig_en;

always_ff@(posedge bus.clk)
if(trig_en | bus_wr[5]) begin // сброс по записи
    addr_rd <= 0;
end else begin // можно читать
    if(bus_rd[10]) begin // прошла транзакция чтения
        addr_rd <= addr_rd + 1'b1;
    end
end

endmodule
