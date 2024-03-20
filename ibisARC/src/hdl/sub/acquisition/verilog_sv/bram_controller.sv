`include "bram_controller.svh"
`include "global_param.v"

interface bram_controller_interface();

logic [31:0] rd_depth;
logic [31:0] rd_start_addr;
logic rd_start;
logic rd_done;
logic valid;


modport master
(
    input  rd_depth,
    input  rd_start_addr,
    input  rd_start,
    output rd_done,
    output valid
);

modport slave
(
    output rd_depth,
    output rd_start_addr,
    output rd_start,
    input  rd_done,
    input  valid
);

endinterface

module bram_controller
#(
    parameter BASEADDR         = 0,
    parameter DEPTH            = 0,
    parameter OUT_WIDTH_NKG    = 0
)
(
  // debug
    input [OUT_WIDTH_NKG-1:0]        R,
    input [31:0]                     tau,
    input                            tauEnd,
    input                            pps,
  //
    input                            rf_clk,
    input                            core_clk,
    input                            wr_clr,
    input                            rd_clr,
    input                            I_sum_sig,
    input                            I_sum_mag,
    input                            Q_sum_sig,
    input                            Q_sum_mag,
    input                            we_sum,
    output logic                     I_mem_sig,
    output logic                     I_mem_mag,
    output logic                     Q_mem_sig,
    output logic                     Q_mem_mag,
    output                           timegen_wr,
    bram_controller_interface.master bram_controller_interface,
    intbus_interf.slave              bus,
    input  wire                      TIME_SCALE_COM_STRUCT time_in
);

//---

localparam AWIDTH = $clog2(DEPTH)+1; // разрядность расширена для возможности хранения адреса=DEPTH

BRAM_CONTROLLER_STRUCT PL;
BRAM_CONTROLLER_STRUCT PS;

logic [`BRAM_CONTROLLER_SIZE-1:0] bus_rd;

//Define which bits will be pulsed
localparam NPULSE = 2;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 0}, // wr_start
    '{0, 25} // wr_data
};

localparam [`BRAM_CONTROLLER_SIZE-1:0] RVALID_FF   = 1'b1;
// localparam [7:0] SYNCI [`BRAM_CONTROLLER_SIZE-1:0] = '{`BRAM_CONTROLLER_SIZE{"l"}};
wire wr_start_pulse;
wire wr_start;

regs_file#(
    .BASEADDR  (BASEADDR),
    .ID        (`BRAM_CONTROLLER_ID_CONST),
    .DATATYPE  (BRAM_CONTROLLER_STRUCT),
    // .SYNCI     (SYNCI),
    .NPULSE    (NPULSE),
    .PULSE     (PULSE),
    .RVALID_FF (RVALID_FF)
) regs_file_bram_controller_inst(
    .clk    (rf_clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  ({wr_data, wr_start_pulse}),
    .wr     (),
    .rd     (bus_rd)
);

assign PL.WR_DEPTH  = PS.WR_DEPTH;
assign PL.RAM_DEPTH = DEPTH;

assign PL.CONTROL.FIFO_RD_EN     = '0;
assign PL.CONTROL.RESERVED       = '0;
assign PL.CONTROL.WR_START       = '0;
assign PL.CONTROL.ACQ_SYNC_EN    = '0;
assign PL.CONTROL.ACQ_SYNC_EPOCH = '0;

//---

logic [AWIDTH-1:0] wr_addr      = '1;// максимальный, чтобы избежать совпадения c регистром глубины записи на старте. Важно для симуляции.
logic [AWIDTH-1:0] rd_addr      = '0;// абсолютный адрес чтения
logic [AWIDTH-1:0] rd_addr_cntr = '0;// количество прочитанных элементов
logic we_mux;
logic we_ram;
logic re_ram;
logic [3:0] data_mux;

logic [3:0] data_out;
// вся память объявлена здесь
//===================================================================

logic [AWIDTH-2:0] fifo_rd_addr;

always_ff@(posedge bus.clk)
if(PS.CONTROL.FIFO_RD_EN == '0) begin
    fifo_rd_addr <= '0;
end else begin
    if(bus_rd[0]) begin
        fifo_rd_addr <= fifo_rd_addr + 1'b1;
    end
end

wire [AWIDTH-2:0] rd_addr_mux = (PS.CONTROL.FIFO_RD_EN) ? fifo_rd_addr : rd_addr[AWIDTH-2:0];

bram_block_v2#(
    .OUT_REG ("EN"),
    .WIDTH   (4),
    .DEPTH   (DEPTH)
) bram_block_v2_inst(
    .wr_clk  (rf_clk),
    .rd_clk  (core_clk),
    .we      (we_ram),
    .re      ('1),
    .dat_in  (data_mux),
    .dat_out (data_out),
    .wr_addr (wr_addr[AWIDTH-2:0]),
    .rd_addr (rd_addr_mux)
);

always_comb begin
    {Q_mem_mag,Q_mem_sig,I_mem_mag,I_mem_sig} <= data_out;
end
always_comb begin
    PL.CONTROL.DATA <= data_out;
end

wire I_mem_sig_n = ~data_out[0];
//===================================================================



//===============================
// синхронизации поиска
logic acq_sync = '0;
reg   wr_done  = '0;

always_ff@(posedge rf_clk)
if(wr_clr) begin
    acq_sync <= '0;
end else begin
    if(PS.CONTROL.ACQ_SYNC_EN) begin // Синхронный старт
        if(time_in.TM_CH.CHIP_EPOCH.EPOCH == PS.CONTROL.ACQ_SYNC_EPOCH[EPOCHSIZE-1:0]) begin
            acq_sync <= '1;
        end else begin
            if(wr_done) begin
                acq_sync <= '0;
            end
        end
    end else begin // Асинхронный старт
        acq_sync <= '1;
    end
end
//===============================

// управление записью ----------------------
logic wr_allow      = '0;
logic time_wr_allow = '0; // разрешение на защелкивание шкалы времени
logic wr_end_addr;
always_ff@(posedge rf_clk)
if(wr_clr)
    wr_allow <= 0;
else begin
    if(wr_start)
        wr_allow <= 1'b1;
    else
        if(PL.CONTROL.WR_DONE)
            wr_allow <= 0;
end

always_ff@(posedge rf_clk)
if(wr_clr)
    wr_addr <= '1;
else begin
    if(wr_start)
        wr_addr <= 0;
    else begin
        if(we_ram)
            wr_addr <= wr_addr + 1'b1;
    end
end

always_ff@(posedge rf_clk)
if(wr_clr)
    wr_done <= 1'b0;
else begin
    if(wr_start)
        wr_done <= 0;
    else begin
        if(wr_end_addr)
            wr_done <= 1'b1;
    end
end

always_ff@(posedge rf_clk)
if(wr_clr)
    time_wr_allow <= 0;
else begin
    if(timegen_wr) // послали
        time_wr_allow <= 0;
    else
        if(wr_start)
            time_wr_allow <= 1'b1;
end

assign wr_end_addr = wr_addr == PS.WR_DEPTH[AWIDTH-1:0];// порядковое число (32 - запись 32-х отсчетов)
assign PL.CONTROL.WR_DONE = wr_done;

assign data_mux   = (PS.CONTROL.FIFO_WR_EN) ? PS.CONTROL.DATA : {Q_sum_mag,Q_sum_sig,I_sum_mag,I_sum_sig};
assign we_mux     = (PS.CONTROL.FIFO_WR_EN) ? wr_data : we_sum;
assign we_ram     = wr_allow & acq_sync & (!wr_end_addr) & we_mux;
assign timegen_wr = time_wr_allow & acq_sync & we_mux; // !!!!!!!!!!!!!!!!!! учетсть задрежку поиска !!!!

// управление чтением ----------------------
logic rd_allow = '0;
always_ff@(posedge core_clk)
if(rd_clr)
    rd_allow <= 0;
else begin
    if(bram_controller_interface.rd_start & !rd_allow)
        rd_allow <= 1'b1;
    else
        if(bram_controller_interface.rd_done)
            rd_allow <= 0;
end

always_ff@(posedge core_clk)
if(rd_clr)
    rd_addr     <= 0;
else begin
    if(bram_controller_interface.rd_start & !rd_allow) begin
        rd_addr <= bram_controller_interface.rd_start_addr;
    end else begin
        if(re_ram)
            rd_addr <= rd_addr + 1'b1;
    end
end

always_ff@(posedge core_clk)
if(rd_clr)
    rd_addr_cntr <= 0;
else begin
    if(bram_controller_interface.rd_start & !rd_allow)
        rd_addr_cntr <= 0;
    else begin
        if(re_ram)
            rd_addr_cntr <= rd_addr_cntr + 1'b1;
    end
end

assign bram_controller_interface.rd_done = rd_addr_cntr == bram_controller_interface.rd_depth[AWIDTH-1:0];

assign re_ram = rd_allow & (!bram_controller_interface.rd_done);

always_ff@(posedge core_clk)
if(rd_clr)
    bram_controller_interface.valid <= 0;
else
    bram_controller_interface.valid <= re_ram;

assign PL.WR_CNTR = {{32-AWIDTH{1'b0}},wr_addr};

`ifdef FACQ_DEBUG
    assign PL.CONTROL.DEBUG.WE_RAM        = we_ram;
    assign PL.CONTROL.DEBUG.WR_ALLOW      = wr_allow;
    assign PL.CONTROL.DEBUG.WR_END_ADDR   = wr_end_addr;
    assign PL.CONTROL.DEBUG.TIMEGEN_WR    = timegen_wr;
    assign PL.CONTROL.DEBUG.TIME_WR_ALLOW = time_wr_allow;
    assign PL.CONTROL.DEBUG.ACQ_SYNC      = acq_sync;
    assign PL.CONTROL.DEBUG.WE_SUM        = we_mux;
    assign PL.CONTROL.DEBUG.RD_DONE       = bram_controller_interface.rd_done;
    assign PL.CONTROL.DEBUG.RD_ALLOW      = rd_allow;
    assign PL.CONTROL.DEBUG.RE_RAM        = re_ram;
`else
    assign PL.CONTROL.DEBUG = '0;
`endif

// // // // // // //
// debug
// // // // // // //
reg  [ 23:0] sumWr;
reg  [ 23:0] sumRd;

wire [ 31:0] vioTreshold;
wire [ 31:0] vioBits;

// vio_0 vio_i (
  // .clk       (rf_clk),
  // .probe_in0 (0),
  // .probe_out0(vioTreshold),
  // .probe_out1(vioBits)
// );

wire detWr  = (sumWr   > vioTreshold) ? 1 : 0;
wire detRd  = (sumRd   > vioTreshold) ? 1 : 0;
wire detRes = (R[31:0] > vioTreshold) ? 1 : 0;

mf #(128) MFwriteSide
(
  .clk  (rf_clk),
  .code (128'h7e619f867e6079819f86799f86799f86),  // locl2ob
  .I_mag(data_mux[1]),
  .I_sig(data_mux[0]),
  .Q_mag(data_mux[3]),
  .Q_sig(data_mux[2]),
  .iVld (we_ram),
  .sum  (sumWr)
);

mf #(128) MFreadSide
(
  .clk  (core_clk),
  .code (128'h7e619f867e6079819f86799f86799f86), // locl2ob
  .I_mag(data_out[1]),
  .I_sig(data_out[0]),
  .Q_mag(data_out[3]),
  .Q_sig(data_out[2]),
  .iVld (bram_controller_interface.valid),
  .sum  (sumRd)
);

// RE sDetWrRE
reg detWrD1;
wire sDetWrRE  = detWr & ~detWrD1;
always_ff@(posedge rf_clk) detWrD1 <= detWr;

// RE sDetRdRE
reg detRdD1;
wire sDetRdRE  = detRd & ~detRdD1;
always_ff@(posedge core_clk) detRdD1 <= detRd;

reg [7:0] sDetWrCnt, sDetRdCnt;
always_ff@(posedge rf_clk)   if (sDetWrRE) sDetWrCnt <= sDetWrCnt + 1;
always_ff@(posedge core_clk) if (sDetRdRE) sDetRdCnt <= sDetRdCnt + 1;
//

reg [23:0] wrStartCnt      = '0;
reg [23:0] ppsCnt          = '0;
wire sWrStart = wr_allow & acq_sync;

reg  sWrStartD1;
wire sWrStartRE = sWrStart & ~sWrStartD1;
//
reg  pps_inD1, pps_inD2, pps_inD3;
wire pps_inRE = pps_inD2 & ~pps_inD3;
//
always_ff@(posedge rf_clk)
begin
  if (sWrStartRE) wrStartCnt <= '0; else wrStartCnt <= wrStartCnt + 1'b1;
  sWrStartD1 <= sWrStart;
  //
  pps_inD1 <= pps;
  pps_inD2 <= pps_inD1;
  pps_inD3 <= pps_inD2;
  //
  if (pps_inRE) ppsCnt <= '0; else ppsCnt <= ppsCnt + 1'b1;
end

// ila_0 ila_wr_i (
  // .clk   (rf_clk),
  // .probe0({0
    // //,PS.WR_DEPTH
    // // ,detWr
    // // ,sDetWrCnt
    // // ,sumWr
    // // ,wr_clr
    // ,wr_addr
    // // ,sWrStartRE
    // // ,wrStartCnt
    // // ,pps_inD2
    // // ,ppsCnt
    // ,wr_start
  // })
// );

// ila_0 ila_rd_i (
  // .clk   (core_clk),
  // .probe0({0
    // ,R[31:0]
    // ,detRes
    // ,tauEnd
    // ,tau
    // ,detRd
    // ,sDetRdCnt
    // ,sumRd
    // ,rd_addr_mux
  // })
// );

// BRAM write control
wire sWrStartAlwaysOn;
wire sWrEn;
reg  sWrEnD1;
wire sWrEnRE = sWrEn & ~sWrEnD1;
reg  wr_start_en;
always_ff@(posedge rf_clk)
begin
  sWrEnD1 <= sWrEn;
  if (sWrEnRE) wr_start_en <= 1'b1; else if (wr_start) wr_start_en <= 1'b0;
end
assign wr_start = wr_start_pulse; //(wr_start_en | sWrStartAlwaysOn) & wr_start_pulse;

`ifdef SIMULATE
  assign sWrStartAlwaysOn = 1'b1;
`else
  assign sWrStartAlwaysOn = 1'b1;
  // assign sWrStartAlwaysOn = vioBits[1];
  assign sWrEn            = vioBits[0];
`endif

// debug
reg wr_done_CDC, wr_clr_CDC, wr_start_CDC;
reg wr_allow_CDC, acq_sync_CDC, wr_end_addr_CDC, we_mux_CDC;
always_ff@(posedge bus.clk)
begin
  wr_done_CDC     <= wr_done;
  wr_clr_CDC      <= wr_clr;
  wr_start_CDC    <= wr_start;
  wr_allow_CDC    <= wr_allow;
  acq_sync_CDC    <= acq_sync;
  wr_end_addr_CDC <= wr_end_addr;
  we_mux_CDC      <= we_mux;
end


wire sReadAddrDet  = 1'b0;
wire sReadValueDet = 1'b0;
wire sReadDone  = sReadAddrDet & sReadValueDet;
assign oDbg = wr_done_CDC;
reg [27:0] sCntWr        = '0;
reg [27:0] sCntReadDone  = '0;
reg [27:0] sCntRead      = '0;
reg [27:0] sCntReadLatch = '0;
reg        sReadDoneDet  =  0;
// ila_0 ila_0 (
  // .clk   (rf_clk),
  // .probe0({
     // wr_start
    // ,wr_end_addr
    // ,wr_done
    // ,we_ram
    // ,sReadAddrDet
    // ,sReadValueDet
    // ,sCntReadLatch
    // ,sReadDone
    // ,sReadDoneDet
    // ,sCntWr
    // ,sCntReadDone
    // // ,bus.wr
    // // ,bus.wdata
    // // ,bus_rd
    // // ,bus.addr[15:0]
    // // ,bus.rd
    // // ,bus.rdata
    // // ,bus.rvalid
// //    ,I_raw
// //    ,Q_raw   
  // })
// );

always_ff@(posedge rf_clk) if (wr_start)  sCntWr <= '0; else if (we_ram) sCntWr <= sCntWr + 1'b1;

reg sReadAddrDetD1;
wire sReadAddrDetRE = sReadAddrDet & (~sReadAddrDetD1);
always_ff@(posedge rf_clk)
begin
 sReadAddrDetD1 <= sReadAddrDet;
 
 if (wr_start) sReadDoneDet <= 1'b0; else if (sReadDone) sReadDoneDet <= 1'b1; 
 
 if (wr_start) begin
   sCntRead      <= '0;
   sCntReadLatch <= '0;
 end else begin
    if (sReadAddrDetRE) begin
      sCntRead      <= '0; 
      sCntReadLatch <= sCntRead; 
    end else sCntRead <= sCntRead + 1'b1;
 end
 
 if (wr_start) sCntReadDone <= '0; else if (!sReadDoneDet) sCntReadDone <= sCntReadDone + 1'b1;
end

endmodule
