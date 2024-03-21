`include "max_args.svh"

interface max_args_interface();

logic reset_max;
logic [15:0] Ntau;
logic [15:0] Nf;
logic done_max;

modport master
(
    input  reset_max,
    input  Ntau,
    input  Nf,
    output done_max
);

modport slave
(
    output reset_max,
    output Ntau,
    output Nf,
    input  done_max
);

endinterface

module max_args
#(
    parameter BASEADDR = 0,
    parameter IN_WIDTH = 0,
    parameter N_args   = 0
)
(
  // debug
    output [31:0]         oAmpMax,
    output [31:0]         oTauMax,
    output                oTauEnd,
  //
    input                 clk,
    input  [IN_WIDTH-1:0] R,
    input                 we,
    max_args_interface.master max_args_interface,
    intbus_interf.slave bus
);

MAX_ARGS_STRUCT PL;

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`MAX_ARGS_ID_CONST),
    .DATATYPE (MAX_ARGS_STRUCT)
) regs_file_max_args_inst(
    .clk    ('0),
    .bus    (bus),
    .in     (PL),
    .out    (),
    .pulse  (),
    .wr     (),
    .rd     ()
);

assign PL.FREQ_RESERVED = '0;
// ---

logic [$clog2(N_args)-1:0] nx              = '0;
logic [31:0]               tau             = '0;
logic [15:0]               N_tau_zone_cntr = '0;
logic [15:0]               freq            = '0;

assign end_nx       = nx == N_args - 1;
assign end_tau_zone = end_nx       & (N_tau_zone_cntr == max_args_interface.Ntau - 1);
assign end_max      = end_tau_zone & (freq            == max_args_interface.Nf   - 1);

latency#(// компенсация задержки данных перед памятью на 2-х триггерах
    .length(3)
) LATENCY_WE_MEM_INST(
    .clk     (clk),
    .in      (end_max),
    .out     (max_args_interface.done_max),
    .out_reg ()
);

always_ff@(posedge clk)
if(max_args_interface.reset_max)
    nx <= 0;
else begin
    if(we) begin
        if(end_nx)
            nx <= 0;
        else
            nx <= nx + 1'b1;
    end
end

always_ff@(posedge clk)
if(max_args_interface.reset_max)
    tau <= 0;
else begin
    if(we) begin
        if(end_tau_zone)
            tau <= 0;
        else
            tau <= tau + 1'b1;
    end
end

always_ff@(posedge clk)
if(max_args_interface.reset_max)
    N_tau_zone_cntr <= 0;
else begin
    if(end_nx) begin
        if(end_tau_zone)
            N_tau_zone_cntr <= 0;
        else
            N_tau_zone_cntr <= N_tau_zone_cntr + 1'b1;
    end
end

always_ff@(posedge clk)
if(max_args_interface.reset_max)
    freq <= 0;
else begin
    if(end_max)
        freq <= 0;
    else if(end_tau_zone)
        freq <= freq + 1'b1;
end

//--------------------------------------------
//DeSerializer
logic                CE_reg = '0;
logic [IN_WIDTH-1:0] dat1   = '0;
logic [IN_WIDTH-1:0] dat2   = '0;

always_ff@(posedge clk)
if(max_args_interface.reset_max)
    CE_reg <= 1'b0;
else
    if(we)
        CE_reg <= ~CE_reg;

always_ff@(posedge clk)
if(we & CE_reg)
    dat1 <= R;

always_ff@(posedge clk)
if(we & !CE_reg)
    dat2 <= R;
// END
//--------------------------------------------

logic [31:0] tau_lat;
logic [15:0] freq_lat;

conv_reg#(
    .width  (32),
    .length (1)
)
conv_reg_tau_cntr_inst(
    .clk    (clk),
    .in     (tau),
    .out    (tau_lat)
);

conv_reg#(
    .width  (16),
    .length (1)
)
conv_reg_freq_cntr_inst(
    .clk    (clk),
    .in     (freq),
    .out    (freq_lat)
);

//--------------------------------------------
//MAX
logic [IN_WIDTH-1:0] maxR         [2];
logic [31:0]         tau_lat_max  [2];
logic [15:0]         freq_lat_max [2];

always_ff@(posedge clk)
if(max_args_interface.reset_max) begin
    maxR[0]         <= 0;
    tau_lat_max[0]  <= 0;
    freq_lat_max[0] <= 0;
end else if(dat1 > maxR[0]) begin
    maxR[0]         <= dat1;
    tau_lat_max[0]  <= tau_lat;
    freq_lat_max[0] <= freq_lat;
end

always_ff@(posedge clk)
if(max_args_interface.reset_max) begin
    maxR[1]         <= 0;
    tau_lat_max[1]  <= 0;
    freq_lat_max[1] <= 0;
end else if(dat2 > maxR[1]) begin
    maxR[1]         <= dat2;
    tau_lat_max[1]  <= tau_lat;
    freq_lat_max[1] <= freq_lat;
end

reg [31:0] tau_max; // debug
reg [31:0] amp_max; // debug
always_ff@(posedge clk)
if(!max_args_interface.reset_max) begin
    if(maxR[0] > maxR[1]) begin
        {PL.R_HI,PL.R_LO} <= {{(64-IN_WIDTH){1'b0}},maxR[0]};
        PL.TAU            <= tau_lat_max[0];
        PL.FREQ           <= freq_lat_max[0];
        tau_max           <= tau_lat_max[0]; // debug
        amp_max           <= maxR[0];        // debug
    end else begin
        {PL.R_HI,PL.R_LO} <= {{(64-IN_WIDTH){1'b0}},maxR[1]};
        PL.TAU            <= tau_lat_max[1];
        PL.FREQ           <= freq_lat_max[1];
        tau_max           <= tau_lat_max[1]; // debug
        amp_max           <= maxR[1];        // debug
    end
end

// debug
assign oAmpMax = amp_max;
assign oTauMax = tau_max;
assign oTauEnd = end_tau_zone;
endmodule
