`timescale 1ns/10ps

`include "global_param.v"

module dma_tb();

localparam CPU_FREQ    = 59e6;  //MHz


reg aclk = 1;

always #(1e9/CPU_FREQ/2) aclk <= !aclk;

localparam ID_OFFS = 0;
localparam R0_OFFS = 2*4;
localparam R1_OFFS = 3*4;
localparam R2_OFFS = 4*4;
localparam R3_OFFS = 5*4;


axi3_interface axi3();
axi3_interface s_axi3();
axi3_interface s_wr_axi3();
axi3_interface s_rd_axi3();
intbus_interf int_bus();
intbus_interf int_bus_s_rd();
intbus_interf int_bus_s_wr();

always_comb begin
// ===========================================
// по этой шине идет запись
    s_wr_axi3.aclk    <= s_axi3.aclk   ;
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
    s_wr_axi3.awaddr  <= s_axi3.awaddr ;
    s_wr_axi3.awburst <= s_axi3.awburst;
    s_wr_axi3.awcache <= s_axi3.awcache;
    s_wr_axi3.awid    <= s_axi3.awid   ;
    s_wr_axi3.awlen   <= s_axi3.awlen  ;
    s_wr_axi3.awlock  <= s_axi3.awlock ;
    s_wr_axi3.awprot  <= s_axi3.awprot ;
    s_wr_axi3.awqos   <= s_axi3.awqos  ;
    s_wr_axi3.awsize  <= s_axi3.awsize ;
    s_wr_axi3.awvalid <= s_axi3.awvalid;
    s_wr_axi3.bready  <= s_axi3.bready ;
    s_wr_axi3.rready  <= '0;
    s_wr_axi3.wdata   <= s_axi3.wdata  ;
    s_wr_axi3.wid     <= s_axi3.wid    ;
    s_wr_axi3.wlast   <= s_axi3.wlast  ;
    s_wr_axi3.wstrb   <= s_axi3.wstrb  ;
    s_wr_axi3.wvalid  <= s_axi3.wvalid ;
    
    s_axi3.awready <= s_wr_axi3.awready;
    s_axi3.bid     <= s_wr_axi3.bid    ;
    s_axi3.bresp   <= s_wr_axi3.bresp  ;
    s_axi3.bvalid  <= s_wr_axi3.bvalid ;
    s_axi3.wready  <= s_wr_axi3.wready ;
// ===========================================
// по этой шине идет чтение
    s_rd_axi3.aclk    <= s_axi3.aclk   ;
    s_rd_axi3.araddr  <= s_axi3.araddr ;
    s_rd_axi3.arburst <= s_axi3.arburst;
    s_rd_axi3.arcache <= s_axi3.arcache;
    s_rd_axi3.arid    <= s_axi3.arid   ;
    s_rd_axi3.arlen   <= s_axi3.arlen  ;
    s_rd_axi3.arlock  <= s_axi3.arlock ;
    s_rd_axi3.arprot  <= s_axi3.arprot ;
    s_rd_axi3.arqos   <= s_axi3.arqos  ;
    s_rd_axi3.arsize  <= s_axi3.arsize ;
    s_rd_axi3.arvalid <= s_axi3.arvalid;
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
    s_rd_axi3.rready  <= s_axi3.rready;
    s_rd_axi3.wdata   <= '0;
    s_rd_axi3.wid     <= '0;
    s_rd_axi3.wlast   <= '0;
    s_rd_axi3.wstrb   <= '0;
    s_rd_axi3.wvalid  <= '0;
    
    s_axi3.arready <= s_rd_axi3.arready;
    s_axi3.rdata   <= s_rd_axi3.rdata  ;
    s_axi3.rid     <= s_rd_axi3.rid    ;
    s_axi3.rlast   <= s_rd_axi3.rlast  ;
    s_axi3.rresp   <= s_rd_axi3.rresp  ;
    s_axi3.rvalid  <= s_rd_axi3.rvalid ;
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

dma#(
    .BASEADDR (0)
) dma_inst(
    .bus     (int_bus),
    .s_axi3  (s_axi3)
);

axi3_to_inter s_rd_axi3_to_inter_inst(
    .axi3    (s_rd_axi3),
    .int_bus (int_bus_s_rd)
);

axi3_to_inter s_wr_axi3_to_inter_inst(
    .axi3    (s_wr_axi3),
    .int_bus (int_bus_s_wr)
);

localparam N_REGS = 50;
typedef struct packed {
    logic [0:N_REGS-1][31:0] REG_RO;
} TEST_RW_STRUCT;

TEST_RW_STRUCT PL1;
TEST_RW_STRUCT PS1;
TEST_RW_STRUCT PL2;
TEST_RW_STRUCT PS2;

regs_file#(
    .BASEADDR (0),
    .ID       (16'hABCD),
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
    .BASEADDR (0),
    .ID       (16'hABCD),
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
    assign PL1.REG_RO[i] = i;
end

endmodule