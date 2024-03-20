`timescale 1ns/10ps

`include "global_param.v"

module dma_dsp_tb();

localparam CPU_FREQ    = 59e6;  //MHz
localparam AXI_HP_FREQ = 150e6;  //MHz

localparam AXI_HP_WIDTH = 64;


reg aclk     = 1;
reg a_hp_clk = 1;

always #(1e9/CPU_FREQ/2) aclk <= !aclk;
always #(1e9/AXI_HP_FREQ/2) a_hp_clk <= !a_hp_clk;

localparam ID_OFFS = 0;
localparam R0_OFFS = 2*4;
localparam R1_OFFS = 3*4;
localparam R2_OFFS = 4*4;
localparam R3_OFFS = 5*4;


axi3_interface axi3();
intbus_interf int_bus();

axi3_interface#(
    .D_WIDTH (AXI_HP_WIDTH)
) axi_hp();
axi3_interface#(
    .D_WIDTH (AXI_HP_WIDTH)
) s_wr_axi3();
axi3_interface#(
    .D_WIDTH (AXI_HP_WIDTH)
) s_rd_axi3();

intbus_interf#(
    .DATA_WIDTH (AXI_HP_WIDTH)
) int_bus_s_rd();
intbus_interf#(
    .DATA_WIDTH (AXI_HP_WIDTH)
) int_bus_s_wr();

axi4_stream_interface#(
    .D_WIDTH (32)
) m_axis_data();
axi4_stream_interface#(
    .D_WIDTH (32)
) s_axis_data();

always_comb begin
// ===========================================
// по этой шине идет запись
    s_wr_axi3.aclk    <= axi_hp.aclk   ;
    s_wr_axi3.araddr  <= '0;
    s_wr_axi3.arburst <= '0;
    s_wr_axi3.arcache <= '0;
    s_wr_axi3.arid    <= '0;
    s_wr_axi3.arlen   <= '0;
    s_wr_axi3.arlock  <= '0;
    s_wr_axi3.arprot  <= '0;
    s_wr_axi3.arqos   <= '0;
    s_wr_axi3.arsize  <= '0;
    s_wr_axi3.arvalid <= '0;
    s_wr_axi3.awaddr  <= axi_hp.awaddr ;
    s_wr_axi3.awburst <= axi_hp.awburst;
    s_wr_axi3.awcache <= axi_hp.awcache;
    s_wr_axi3.awid    <= axi_hp.awid   ;
    s_wr_axi3.awlen   <= axi_hp.awlen  ;
    s_wr_axi3.awlock  <= axi_hp.awlock ;
    s_wr_axi3.awprot  <= axi_hp.awprot ;
    s_wr_axi3.awqos   <= axi_hp.awqos  ;
    s_wr_axi3.awsize  <= axi_hp.awsize ;
    s_wr_axi3.awvalid <= axi_hp.awvalid;
    s_wr_axi3.bready  <= axi_hp.bready ;
    s_wr_axi3.rready  <= '0;
    s_wr_axi3.wdata   <= axi_hp.wdata  ;
    s_wr_axi3.wid     <= axi_hp.wid    ;
    s_wr_axi3.wlast   <= axi_hp.wlast  ;
    s_wr_axi3.wstrb   <= axi_hp.wstrb  ;
    s_wr_axi3.wvalid  <= axi_hp.wvalid ;
    
    axi_hp.awready <= s_wr_axi3.awready;
    axi_hp.bid     <= s_wr_axi3.bid    ;
    axi_hp.bresp   <= s_wr_axi3.bresp  ;
    axi_hp.bvalid  <= s_wr_axi3.bvalid ;
    axi_hp.wready  <= s_wr_axi3.wready ;
// ===========================================
// по этой шине идет чтение
    s_rd_axi3.aclk    <= axi_hp.aclk   ;
    s_rd_axi3.araddr  <= axi_hp.araddr ;
    s_rd_axi3.arburst <= axi_hp.arburst;
    s_rd_axi3.arcache <= axi_hp.arcache;
    s_rd_axi3.arid    <= axi_hp.arid   ;
    s_rd_axi3.arlen   <= axi_hp.arlen  ;
    s_rd_axi3.arlock  <= axi_hp.arlock ;
    s_rd_axi3.arprot  <= axi_hp.arprot ;
    s_rd_axi3.arqos   <= axi_hp.arqos  ;
    s_rd_axi3.arsize  <= axi_hp.arsize ;
    s_rd_axi3.arvalid <= axi_hp.arvalid;
    s_rd_axi3.awaddr  <= '0;
    s_rd_axi3.awburst <= '0;
    s_rd_axi3.awcache <= '0;
    s_rd_axi3.awid    <= '0;
    s_rd_axi3.awlen   <= '0;
    s_rd_axi3.awlock  <= '0;
    s_rd_axi3.awprot  <= '0;
    s_rd_axi3.awqos   <= '0;
    s_rd_axi3.awsize  <= '0;
    s_rd_axi3.awvalid <= '0;
    s_rd_axi3.bready  <= '0;
    s_rd_axi3.rready  <= axi_hp.rready;
    s_rd_axi3.wdata   <= '0;
    s_rd_axi3.wid     <= '0;
    s_rd_axi3.wlast   <= '0;
    s_rd_axi3.wstrb   <= '0;
    s_rd_axi3.wvalid  <= '0;
    
    axi_hp.arready <= s_rd_axi3.arready;
    axi_hp.rdata   <= s_rd_axi3.rdata  ;
    axi_hp.rid     <= s_rd_axi3.rid    ;
    axi_hp.rlast   <= s_rd_axi3.rlast  ;
    axi_hp.rresp   <= s_rd_axi3.rresp  ;
    axi_hp.rvalid  <= s_rd_axi3.rvalid ;
// ===========================================
end

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);


axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (int_bus)
);

axi4_stream_interface
#(
    .D_WIDTH (AXI_HP_WIDTH)
) m_axis_dma();
axi4_stream_interface
#(
    .D_WIDTH (AXI_HP_WIDTH)
) s_axis_dma();

dma_dsp#(
    .BASEADDR  (0),
    .AXI_WIDTH (AXI_HP_WIDTH)
) dma_dsp_inst(
    .bus         (int_bus),
    .axi3        (axi_hp),
    .s_axi3_aclk (a_hp_clk),
    .m_axis      (m_axis_dma), // 64-bit
    .s_axis      (s_axis_dma)  // 64-bit
);
// m_axis_data 32-bit to   FFT
// s_axis_data 32-bit from FFT

axi4_stream_converter_64_to_32 axi4_stream_converter_64_to_32_inst(
    .s_axis_data_64 (m_axis_dma),
    .m_axis_data_64 (s_axis_dma),
    .s_axis_data_32 (s_axis_data),
    .m_axis_data_32 (m_axis_data)
);

/* logic m_mux = '0;
logic s_mux = '0;

assign m_axis_data.aclk   = m_axis_dma.aclk;
assign m_axis_data.tdata  = m_mux ? m_axis_dma.tdata[63:32] : m_axis_dma.tdata[31:0];
assign m_axis_data.tvalid = m_axis_dma.tvalid;
assign m_axis_dma.tready  = m_axis_data.tready & m_mux;

always_ff@(posedge m_axis_dma.aclk) begin
    if(m_axis_data.tready & m_axis_data.tvalid) begin
        m_mux <= !m_mux;
    end
end

assign s_axis_dma.aclk    = s_axis_data.aclk;
assign s_axis_data.tready = s_axis_dma.tready;
always_ff@(posedge s_axis_dma.aclk) begin
    if(s_mux) begin
        s_axis_dma.tdata[63:32] = s_axis_data.tdata;
    end else begin
        s_axis_dma.tdata[31:0] = s_axis_data.tdata;
    end
end

always_ff@(posedge s_axis_dma.aclk) begin
    if(s_axis_data.tvalid & s_axis_data.tready) begin
        s_mux <= !s_mux;
    end
end

always_ff@(posedge s_axis_dma.aclk) begin
    if(s_axis_dma.tvalid & s_axis_dma.tready) begin
        s_axis_dma.tvalid <= '0;
    end else if(s_axis_data.tvalid & s_axis_data.tready & s_mux) begin
        s_axis_dma.tvalid <= '1;
    end
end */

axi3_to_inter#(
    .D_WIDTH (AXI_HP_WIDTH)
) s_rd_axi3_to_inter_inst(
    .axi3    (s_rd_axi3),
    .int_bus (int_bus_s_rd)
);

axi3_to_inter#(
    .D_WIDTH (AXI_HP_WIDTH)
) s_wr_axi3_to_inter_inst(
    .axi3    (s_wr_axi3),
    .int_bus (int_bus_s_wr)
);

localparam N_REGS = 256;
typedef struct packed {
    logic [0:N_REGS-1][AXI_HP_WIDTH-1:0] REG_RO;
} TEST_RW_STRUCT;

TEST_RW_STRUCT PL1;
TEST_RW_STRUCT PS1;
TEST_RW_STRUCT PL2;
TEST_RW_STRUCT PS2;

logic tvalid_dly;
logic [31:0] tdata_dly;
conv_reg#(
    .width      (32 + 1),
    .length     (N_REGS*2 + 20)
) conv_reg_data(
    .clk (m_axis_data.aclk),
    .in  ({m_axis_data.tvalid,m_axis_data.tdata}),
    .out ({tvalid_dly,tdata_dly})
);

logic [15:0] wr_fifo_cntr = '0;
logic [15:0] rd_fifo_cntr = '0;
logic [31:0] fifo [N_REGS*2-1:0];
always_ff@(posedge m_axis_data.aclk) begin
    if(tvalid_dly) begin
        fifo[wr_fifo_cntr] <= tdata_dly;
        wr_fifo_cntr <= wr_fifo_cntr + 1'b1;
    end
end

always_ff@(posedge m_axis_data.aclk) begin
    if(s_axis_data.tvalid & s_axis_data.tready) begin
        rd_fifo_cntr <= rd_fifo_cntr + 1'b1;
    end
end

assign fifo_empty = wr_fifo_cntr == rd_fifo_cntr;

assign m_axis_data.tready = '1;
assign s_axis_data.aclk   = m_axis_data.aclk;
assign s_axis_data.tdata  = fifo[rd_fifo_cntr];
assign s_axis_data.tvalid = !fifo_empty;

regs_file#(
    .BASEADDR   (0),
    .DATA_WIDTH (AXI_HP_WIDTH),
    .ID         (16'hABCD),
    .DATATYPE (TEST_RW_STRUCT)
)RF1 (
    .clk    (),
    .bus    (int_bus_s_rd),
    .in     (PL1),
    .out    (PS1),
    .pulse  (),
    .wr     (),
    .rd     ()
);
regs_file#(
    .BASEADDR   (0),
    .DATA_WIDTH (AXI_HP_WIDTH),
    .ID         (16'hABCD),
    .DATATYPE (TEST_RW_STRUCT)
)RF2 (
    .clk    (),
    .bus    (int_bus_s_wr),
    .in     (PL2),
    .out    (PS2),
    .pulse  (),
    .wr     (),
    .rd     ()
);

for(genvar i = 0; i < N_REGS; i = i + 1) begin
    assign PL1.REG_RO[i] = i * 2 | ((i * 2 + 1) << 32);
end

endmodule