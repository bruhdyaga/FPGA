`include "global_param.v"

module cpu_top(
    arm_interface.master   arm,
    axi3_interface.master  m_axi3[`M_AXI_GP_NUM],
    axi3_interface.slave   s_axi3,
    input  [31:0]          gpio_i,
    output [31:0]          gpio_o,
    output [31:0]          gpio_t,
    input  [`IRQ_NUM-1:0]  irq,
    output                 clk_50,
    input                  uart_1_rxd,
    output                 uart_1_txd
);

wire aclk_buf;
wire clk_50_unbuf;

zynq zynq_inst(
    .DDR_addr                       (arm.DDR_addr         ),
    .DDR_ba                         (arm.DDR_ba           ),
    .DDR_cas_n                      (arm.DDR_cas_n        ),
    .DDR_ck_n                       (arm.DDR_ck_n         ),
    .DDR_ck_p                       (arm.DDR_ck_p         ),
    .DDR_cke                        (arm.DDR_cke          ),
    .DDR_cs_n                       (arm.DDR_cs_n         ),
    .DDR_dm                         (arm.DDR_dm           ),
    .DDR_dq                         (arm.DDR_dq           ),
    .DDR_dqs_n                      (arm.DDR_dqs_n        ),
    .DDR_dqs_p                      (arm.DDR_dqs_p        ),
    .DDR_odt                        (arm.DDR_odt          ),
    .DDR_ras_n                      (arm.DDR_ras_n        ),
    .DDR_reset_n                    (arm.DDR_reset_n      ),
    .DDR_we_n                       (arm.DDR_we_n         ),
    .FIXED_IO_ddr_vrn               (arm.FIXED_IO_ddr_vrn ),
    .FIXED_IO_ddr_vrp               (arm.FIXED_IO_ddr_vrp ),
    .FIXED_IO_mio                   (arm.FIXED_IO_mio     ),
    .FIXED_IO_ps_clk                (arm.FIXED_IO_ps_clk  ),
    .FIXED_IO_ps_porb               (arm.FIXED_IO_ps_porb ),
    .FIXED_IO_ps_srstb              (arm.FIXED_IO_ps_srstb),
    
    .axi3_0_araddr                  (m_axi3[0].araddr ),
    .axi3_0_arburst                 (m_axi3[0].arburst),
    .axi3_0_arcache                 (m_axi3[0].arcache),
    .axi3_0_arid                    (m_axi3[0].arid   ),
    .axi3_0_arlen                   (m_axi3[0].arlen  ),
    .axi3_0_arlock                  (m_axi3[0].arlock ),
    .axi3_0_arprot                  (m_axi3[0].arprot ),
    .axi3_0_arqos                   (m_axi3[0].arqos  ),
    .axi3_0_arready                 (m_axi3[0].arready),
    .axi3_0_arsize                  (m_axi3[0].arsize ),
    .axi3_0_arvalid                 (m_axi3[0].arvalid),
    .axi3_0_awaddr                  (m_axi3[0].awaddr ),
    .axi3_0_awburst                 (m_axi3[0].awburst),
    .axi3_0_awcache                 (m_axi3[0].awcache),
    .axi3_0_awid                    (m_axi3[0].awid   ),
    .axi3_0_awlen                   (m_axi3[0].awlen  ),
    .axi3_0_awlock                  (m_axi3[0].awlock ),
    .axi3_0_awprot                  (m_axi3[0].awprot ),
    .axi3_0_awqos                   (m_axi3[0].awqos  ),
    .axi3_0_awready                 (m_axi3[0].awready),
    .axi3_0_awsize                  (m_axi3[0].awsize ),
    .axi3_0_awvalid                 (m_axi3[0].awvalid),
    .axi3_0_bid                     (m_axi3[0].bid    ),
    .axi3_0_bready                  (m_axi3[0].bready ),
    .axi3_0_bresp                   (m_axi3[0].bresp  ),
    .axi3_0_bvalid                  (m_axi3[0].bvalid ),
    .axi3_0_rdata                   (m_axi3[0].rdata  ),
    .axi3_0_rid                     (m_axi3[0].rid    ),
    .axi3_0_rlast                   (m_axi3[0].rlast  ),
    .axi3_0_rready                  (m_axi3[0].rready ),
    .axi3_0_rresp                   (m_axi3[0].rresp  ),
    .axi3_0_rvalid                  (m_axi3[0].rvalid ),
    .axi3_0_wdata                   (m_axi3[0].wdata  ),
    .axi3_0_wid                     (m_axi3[0].wid    ),
    .axi3_0_wlast                   (m_axi3[0].wlast  ),
    .axi3_0_wready                  (m_axi3[0].wready ),
    .axi3_0_wstrb                   (m_axi3[0].wstrb  ),
    .axi3_0_wvalid                  (m_axi3[0].wvalid ),
    
    // .axi3_1_araddr                  (m_axi3[1].araddr ),
    // .axi3_1_arburst                 (m_axi3[1].arburst),
    // .axi3_1_arcache                 (m_axi3[1].arcache),
    // .axi3_1_arid                    (m_axi3[1].arid   ),
    // .axi3_1_arlen                   (m_axi3[1].arlen  ),
    // .axi3_1_arlock                  (m_axi3[1].arlock ),
    // .axi3_1_arprot                  (m_axi3[1].arprot ),
    // .axi3_1_arqos                   (m_axi3[1].arqos  ),
    // .axi3_1_arready                 (m_axi3[1].arready),
    // .axi3_1_arsize                  (m_axi3[1].arsize ),
    // .axi3_1_arvalid                 (m_axi3[1].arvalid),
    // .axi3_1_awaddr                  (m_axi3[1].awaddr ),
    // .axi3_1_awburst                 (m_axi3[1].awburst),
    // .axi3_1_awcache                 (m_axi3[1].awcache),
    // .axi3_1_awid                    (m_axi3[1].awid   ),
    // .axi3_1_awlen                   (m_axi3[1].awlen  ),
    // .axi3_1_awlock                  (m_axi3[1].awlock ),
    // .axi3_1_awprot                  (m_axi3[1].awprot ),
    // .axi3_1_awqos                   (m_axi3[1].awqos  ),
    // .axi3_1_awready                 (m_axi3[1].awready),
    // .axi3_1_awsize                  (m_axi3[1].awsize ),
    // .axi3_1_awvalid                 (m_axi3[1].awvalid),
    // .axi3_1_bid                     (m_axi3[1].bid    ),
    // .axi3_1_bready                  (m_axi3[1].bready ),
    // .axi3_1_bresp                   (m_axi3[1].bresp  ),
    // .axi3_1_bvalid                  (m_axi3[1].bvalid ),
    // .axi3_1_rdata                   (m_axi3[1].rdata  ),
    // .axi3_1_rid                     (m_axi3[1].rid    ),
    // .axi3_1_rlast                   (m_axi3[1].rlast  ),
    // .axi3_1_rready                  (m_axi3[1].rready ),
    // .axi3_1_rresp                   (m_axi3[1].rresp  ),
    // .axi3_1_rvalid                  (m_axi3[1].rvalid ),
    // .axi3_1_wdata                   (m_axi3[1].wdata  ),
    // .axi3_1_wid                     (m_axi3[1].wid    ),
    // .axi3_1_wlast                   (m_axi3[1].wlast  ),
    // .axi3_1_wready                  (m_axi3[1].wready ),
    // .axi3_1_wstrb                   (m_axi3[1].wstrb  ),
    // .axi3_1_wvalid                  (m_axi3[1].wvalid ),
    
    .saxi3_0_araddr                 (s_axi3.araddr   ),
    .saxi3_0_arburst                (s_axi3.arburst  ),
    .saxi3_0_arcache                (s_axi3.arcache  ),
    .saxi3_0_arid                   (s_axi3.arid     ),
    .saxi3_0_arlen                  (s_axi3.arlen    ),
    .saxi3_0_arlock                 (s_axi3.arlock   ),
    .saxi3_0_arprot                 (s_axi3.arprot   ),
    .saxi3_0_arqos                  (s_axi3.arqos    ),
    .saxi3_0_arready                (s_axi3.arready  ),
    .saxi3_0_arsize                 (s_axi3.arsize   ),
    .saxi3_0_arvalid                (s_axi3.arvalid  ),
    .saxi3_0_awaddr                 (s_axi3.awaddr   ),
    .saxi3_0_awburst                (s_axi3.awburst  ),
    .saxi3_0_awcache                (s_axi3.awcache  ),
    .saxi3_0_awid                   (s_axi3.awid     ),
    .saxi3_0_awlen                  (s_axi3.awlen    ),
    .saxi3_0_awlock                 (s_axi3.awlock   ),
    .saxi3_0_awprot                 (s_axi3.awprot   ),
    .saxi3_0_awqos                  (s_axi3.awqos    ),
    .saxi3_0_awready                (s_axi3.awready  ),
    .saxi3_0_awsize                 (s_axi3.awsize   ),
    .saxi3_0_awvalid                (s_axi3.awvalid  ),
    .saxi3_0_bid                    (s_axi3.bid      ),
    .saxi3_0_bready                 (s_axi3.bready   ),
    .saxi3_0_bresp                  (s_axi3.bresp    ),
    .saxi3_0_bvalid                 (s_axi3.bvalid   ),
    .saxi3_0_rdata                  (s_axi3.rdata    ),
    .saxi3_0_rid                    (s_axi3.rid      ),
    .saxi3_0_rlast                  (s_axi3.rlast    ),
    .saxi3_0_rready                 (s_axi3.rready   ),
    .saxi3_0_rresp                  (s_axi3.rresp    ),
    .saxi3_0_rvalid                 (s_axi3.rvalid   ),
    .saxi3_0_wdata                  (s_axi3.wdata    ),
    .saxi3_0_wid                    (s_axi3.wid      ),
    .saxi3_0_wlast                  (s_axi3.wlast    ),
    .saxi3_0_wready                 (s_axi3.wready   ),
    .saxi3_0_wstrb                  (s_axi3.wstrb    ),
    .saxi3_0_wvalid                 (s_axi3.wvalid   ),
    
    .axi_clk                        (aclk_buf       ),
    .clk_50                         (clk_50_unbuf   ),
    .aclk                           (aclk           ),
    
    .gpio_i                         (gpio_i         ),
    .gpio_o                         (gpio_o         ),
    .gpio_t                         (gpio_t         ),
    .irq                            (irq            ),
    
    .uart_1_rxd                     (uart_1_rxd     ),
    .uart_1_txd                     (uart_1_txd     )
);

BUFG BUFG_ACLK (
    .O (aclk_buf),
    .I (aclk)
);

BUFG BUFG_CLK_50 (
    .O (clk_50),
    .I (clk_50_unbuf)
);

assign m_axi3[0].aclk = aclk_buf;
// assign m_axi3[1].aclk = aclk_buf;

endmodule