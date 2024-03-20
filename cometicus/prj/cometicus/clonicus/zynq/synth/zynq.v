//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
//Date        : Wed Mar 20 09:58:00 2024
//Host        : ws2104201823 running 64-bit major release  (build 9200)
//Command     : generate_target zynq.bd
//Design      : zynq
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "zynq,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=zynq,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "zynq.hwdef" *) 
module zynq
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    aclk,
    axi3_0_araddr,
    axi3_0_arburst,
    axi3_0_arcache,
    axi3_0_arid,
    axi3_0_arlen,
    axi3_0_arlock,
    axi3_0_arprot,
    axi3_0_arqos,
    axi3_0_arready,
    axi3_0_arsize,
    axi3_0_arvalid,
    axi3_0_awaddr,
    axi3_0_awburst,
    axi3_0_awcache,
    axi3_0_awid,
    axi3_0_awlen,
    axi3_0_awlock,
    axi3_0_awprot,
    axi3_0_awqos,
    axi3_0_awready,
    axi3_0_awsize,
    axi3_0_awvalid,
    axi3_0_bid,
    axi3_0_bready,
    axi3_0_bresp,
    axi3_0_bvalid,
    axi3_0_rdata,
    axi3_0_rid,
    axi3_0_rlast,
    axi3_0_rready,
    axi3_0_rresp,
    axi3_0_rvalid,
    axi3_0_wdata,
    axi3_0_wid,
    axi3_0_wlast,
    axi3_0_wready,
    axi3_0_wstrb,
    axi3_0_wvalid,
    axi_clk,
    clk_50,
    gpio_i,
    gpio_o,
    gpio_t,
    irq,
    saxi3_0_araddr,
    saxi3_0_arburst,
    saxi3_0_arcache,
    saxi3_0_arid,
    saxi3_0_arlen,
    saxi3_0_arlock,
    saxi3_0_arprot,
    saxi3_0_arqos,
    saxi3_0_arready,
    saxi3_0_arsize,
    saxi3_0_arvalid,
    saxi3_0_awaddr,
    saxi3_0_awburst,
    saxi3_0_awcache,
    saxi3_0_awid,
    saxi3_0_awlen,
    saxi3_0_awlock,
    saxi3_0_awprot,
    saxi3_0_awqos,
    saxi3_0_awready,
    saxi3_0_awsize,
    saxi3_0_awvalid,
    saxi3_0_bid,
    saxi3_0_bready,
    saxi3_0_bresp,
    saxi3_0_bvalid,
    saxi3_0_rdata,
    saxi3_0_rid,
    saxi3_0_rlast,
    saxi3_0_rready,
    saxi3_0_rresp,
    saxi3_0_rvalid,
    saxi3_0_wdata,
    saxi3_0_wid,
    saxi3_0_wlast,
    saxi3_0_wready,
    saxi3_0_wstrb,
    saxi3_0_wvalid,
    uart_1_rxd,
    uart_1_txd);
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR ADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DDR, AXI_ARBITRATION_SCHEME TDM, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 11, CAS_WRITE_LATENCY 11, CS_ENABLED true, DATA_MASK_ENABLED true, DATA_WIDTH 8, MEMORY_TYPE COMPONENTS, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 1250" *) inout [14:0]DDR_addr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR BA" *) inout [2:0]DDR_ba;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CAS_N" *) inout DDR_cas_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CK_N" *) inout DDR_ck_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CK_P" *) inout DDR_ck_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CKE" *) inout DDR_cke;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CS_N" *) inout DDR_cs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR DM" *) inout [3:0]DDR_dm;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR DQ" *) inout [31:0]DDR_dq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR DQS_N" *) inout [3:0]DDR_dqs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR DQS_P" *) inout [3:0]DDR_dqs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR ODT" *) inout DDR_odt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR RAS_N" *) inout DDR_ras_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR RESET_N" *) inout DDR_reset_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR WE_N" *) inout DDR_we_n;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO DDR_VRN" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME FIXED_IO, CAN_DEBUG false" *) inout FIXED_IO_ddr_vrn;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO DDR_VRP" *) inout FIXED_IO_ddr_vrp;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO MIO" *) inout [53:0]FIXED_IO_mio;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_CLK" *) inout FIXED_IO_ps_clk;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_PORB" *) inout FIXED_IO_ps_porb;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_SRSTB" *) inout FIXED_IO_ps_srstb;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_RESET zynq_resetn:aresetn, CLK_DOMAIN zynq_processing_system7_0_0_0_FCLK_CLK0, FREQ_HZ 100000000, PHASE 0.000" *) output aclk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi3_0, ADDR_WIDTH 32, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN zynq_axi_clk, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 12, MAX_BURST_LENGTH 16, NUM_READ_OUTSTANDING 8, NUM_READ_THREADS 4, NUM_WRITE_OUTSTANDING 8, NUM_WRITE_THREADS 4, PHASE 0.000, PROTOCOL AXI3, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) output [31:0]axi3_0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARBURST" *) output [1:0]axi3_0_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARCACHE" *) output [3:0]axi3_0_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARID" *) output [11:0]axi3_0_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARLEN" *) output [3:0]axi3_0_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARLOCK" *) output [1:0]axi3_0_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARPROT" *) output [2:0]axi3_0_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARQOS" *) output [3:0]axi3_0_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARREADY" *) input axi3_0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARSIZE" *) output [2:0]axi3_0_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 ARVALID" *) output axi3_0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWADDR" *) output [31:0]axi3_0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWBURST" *) output [1:0]axi3_0_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWCACHE" *) output [3:0]axi3_0_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWID" *) output [11:0]axi3_0_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWLEN" *) output [3:0]axi3_0_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWLOCK" *) output [1:0]axi3_0_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWPROT" *) output [2:0]axi3_0_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWQOS" *) output [3:0]axi3_0_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWREADY" *) input axi3_0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWSIZE" *) output [2:0]axi3_0_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 AWVALID" *) output axi3_0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 BID" *) input [11:0]axi3_0_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 BREADY" *) output axi3_0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 BRESP" *) input [1:0]axi3_0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 BVALID" *) input axi3_0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 RDATA" *) input [31:0]axi3_0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 RID" *) input [11:0]axi3_0_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 RLAST" *) input axi3_0_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 RREADY" *) output axi3_0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 RRESP" *) input [1:0]axi3_0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 RVALID" *) input axi3_0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 WDATA" *) output [31:0]axi3_0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 WID" *) output [11:0]axi3_0_wid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 WLAST" *) output axi3_0_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 WREADY" *) input axi3_0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 WSTRB" *) output [3:0]axi3_0_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi3_0 WVALID" *) output axi3_0_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AXI_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AXI_CLK, ASSOCIATED_BUSIF axi3_0:saxi3_0, ASSOCIATED_RESET Reset_0:axi_resetn, CLK_DOMAIN zynq_axi_clk, FREQ_HZ 100000000, PHASE 0.000" *) input axi_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_50 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_50, CLK_DOMAIN zynq_processing_system7_0_0_0_FCLK_CLK1, FREQ_HZ 50000000, PHASE 0.000" *) output clk_50;
  input [31:0]gpio_i;
  output [31:0]gpio_o;
  output [31:0]gpio_t;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.IRQ INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.IRQ, PortWidth 5, SENSITIVITY LEVEL_HIGH" *) input [4:0]irq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME saxi3_0, ADDR_WIDTH 32, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN zynq_axi_clk, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 6, MAX_BURST_LENGTH 16, NUM_READ_OUTSTANDING 8, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 8, NUM_WRITE_THREADS 1, PHASE 0.000, PROTOCOL AXI3, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [31:0]saxi3_0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARBURST" *) input [1:0]saxi3_0_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARCACHE" *) input [3:0]saxi3_0_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARID" *) input [5:0]saxi3_0_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARLEN" *) input [3:0]saxi3_0_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARLOCK" *) input [1:0]saxi3_0_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARPROT" *) input [2:0]saxi3_0_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARQOS" *) input [3:0]saxi3_0_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARREADY" *) output saxi3_0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARSIZE" *) input [2:0]saxi3_0_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 ARVALID" *) input saxi3_0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWADDR" *) input [31:0]saxi3_0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWBURST" *) input [1:0]saxi3_0_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWCACHE" *) input [3:0]saxi3_0_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWID" *) input [5:0]saxi3_0_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWLEN" *) input [3:0]saxi3_0_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWLOCK" *) input [1:0]saxi3_0_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWPROT" *) input [2:0]saxi3_0_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWQOS" *) input [3:0]saxi3_0_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWREADY" *) output saxi3_0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWSIZE" *) input [2:0]saxi3_0_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 AWVALID" *) input saxi3_0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 BID" *) output [5:0]saxi3_0_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 BREADY" *) input saxi3_0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 BRESP" *) output [1:0]saxi3_0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 BVALID" *) output saxi3_0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 RDATA" *) output [31:0]saxi3_0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 RID" *) output [5:0]saxi3_0_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 RLAST" *) output saxi3_0_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 RREADY" *) input saxi3_0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 RRESP" *) output [1:0]saxi3_0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 RVALID" *) output saxi3_0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 WDATA" *) input [31:0]saxi3_0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 WID" *) input [5:0]saxi3_0_wid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 WLAST" *) input saxi3_0_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 WREADY" *) output saxi3_0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 WSTRB" *) input [3:0]saxi3_0_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 saxi3_0 WVALID" *) input saxi3_0_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 uart_1 RxD" *) input uart_1_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 uart_1 TxD" *) output uart_1_txd;

  wire [31:0]GPIO_I_0_1;
  wire M_AXI_GP0_ACLK_0_1;
  wire [31:0]S_AXI_GP0_0_1_ARADDR;
  wire [1:0]S_AXI_GP0_0_1_ARBURST;
  wire [3:0]S_AXI_GP0_0_1_ARCACHE;
  wire [5:0]S_AXI_GP0_0_1_ARID;
  wire [3:0]S_AXI_GP0_0_1_ARLEN;
  wire [1:0]S_AXI_GP0_0_1_ARLOCK;
  wire [2:0]S_AXI_GP0_0_1_ARPROT;
  wire [3:0]S_AXI_GP0_0_1_ARQOS;
  wire S_AXI_GP0_0_1_ARREADY;
  wire [2:0]S_AXI_GP0_0_1_ARSIZE;
  wire S_AXI_GP0_0_1_ARVALID;
  wire [31:0]S_AXI_GP0_0_1_AWADDR;
  wire [1:0]S_AXI_GP0_0_1_AWBURST;
  wire [3:0]S_AXI_GP0_0_1_AWCACHE;
  wire [5:0]S_AXI_GP0_0_1_AWID;
  wire [3:0]S_AXI_GP0_0_1_AWLEN;
  wire [1:0]S_AXI_GP0_0_1_AWLOCK;
  wire [2:0]S_AXI_GP0_0_1_AWPROT;
  wire [3:0]S_AXI_GP0_0_1_AWQOS;
  wire S_AXI_GP0_0_1_AWREADY;
  wire [2:0]S_AXI_GP0_0_1_AWSIZE;
  wire S_AXI_GP0_0_1_AWVALID;
  wire [5:0]S_AXI_GP0_0_1_BID;
  wire S_AXI_GP0_0_1_BREADY;
  wire [1:0]S_AXI_GP0_0_1_BRESP;
  wire S_AXI_GP0_0_1_BVALID;
  wire [31:0]S_AXI_GP0_0_1_RDATA;
  wire [5:0]S_AXI_GP0_0_1_RID;
  wire S_AXI_GP0_0_1_RLAST;
  wire S_AXI_GP0_0_1_RREADY;
  wire [1:0]S_AXI_GP0_0_1_RRESP;
  wire S_AXI_GP0_0_1_RVALID;
  wire [31:0]S_AXI_GP0_0_1_WDATA;
  wire [5:0]S_AXI_GP0_0_1_WID;
  wire S_AXI_GP0_0_1_WLAST;
  wire S_AXI_GP0_0_1_WREADY;
  wire [3:0]S_AXI_GP0_0_1_WSTRB;
  wire S_AXI_GP0_0_1_WVALID;
  wire [4:0]irq_1;
  wire processing_system7_0_0_FCLK_CLK1;
  wire [31:0]processing_system7_0_0_GPIO_O;
  wire [31:0]processing_system7_0_0_GPIO_T;
  wire processing_system7_0_0_UART_1_RxD;
  wire processing_system7_0_0_UART_1_TxD;
  wire [14:0]processing_system7_0_DDR_ADDR;
  wire [2:0]processing_system7_0_DDR_BA;
  wire processing_system7_0_DDR_CAS_N;
  wire processing_system7_0_DDR_CKE;
  wire processing_system7_0_DDR_CK_N;
  wire processing_system7_0_DDR_CK_P;
  wire processing_system7_0_DDR_CS_N;
  wire [3:0]processing_system7_0_DDR_DM;
  wire [31:0]processing_system7_0_DDR_DQ;
  wire [3:0]processing_system7_0_DDR_DQS_N;
  wire [3:0]processing_system7_0_DDR_DQS_P;
  wire processing_system7_0_DDR_ODT;
  wire processing_system7_0_DDR_RAS_N;
  wire processing_system7_0_DDR_RESET_N;
  wire processing_system7_0_DDR_WE_N;
  wire processing_system7_0_FCLK_CLK0;
  wire processing_system7_0_FIXED_IO_DDR_VRN;
  wire processing_system7_0_FIXED_IO_DDR_VRP;
  wire [53:0]processing_system7_0_FIXED_IO_MIO;
  wire processing_system7_0_FIXED_IO_PS_CLK;
  wire processing_system7_0_FIXED_IO_PS_PORB;
  wire processing_system7_0_FIXED_IO_PS_SRSTB;
  wire [31:0]processing_system7_0_M_AXI_GP0_ARADDR;
  wire [1:0]processing_system7_0_M_AXI_GP0_ARBURST;
  wire [3:0]processing_system7_0_M_AXI_GP0_ARCACHE;
  wire [11:0]processing_system7_0_M_AXI_GP0_ARID;
  wire [3:0]processing_system7_0_M_AXI_GP0_ARLEN;
  wire [1:0]processing_system7_0_M_AXI_GP0_ARLOCK;
  wire [2:0]processing_system7_0_M_AXI_GP0_ARPROT;
  wire [3:0]processing_system7_0_M_AXI_GP0_ARQOS;
  wire processing_system7_0_M_AXI_GP0_ARREADY;
  wire [2:0]processing_system7_0_M_AXI_GP0_ARSIZE;
  wire processing_system7_0_M_AXI_GP0_ARVALID;
  wire [31:0]processing_system7_0_M_AXI_GP0_AWADDR;
  wire [1:0]processing_system7_0_M_AXI_GP0_AWBURST;
  wire [3:0]processing_system7_0_M_AXI_GP0_AWCACHE;
  wire [11:0]processing_system7_0_M_AXI_GP0_AWID;
  wire [3:0]processing_system7_0_M_AXI_GP0_AWLEN;
  wire [1:0]processing_system7_0_M_AXI_GP0_AWLOCK;
  wire [2:0]processing_system7_0_M_AXI_GP0_AWPROT;
  wire [3:0]processing_system7_0_M_AXI_GP0_AWQOS;
  wire processing_system7_0_M_AXI_GP0_AWREADY;
  wire [2:0]processing_system7_0_M_AXI_GP0_AWSIZE;
  wire processing_system7_0_M_AXI_GP0_AWVALID;
  wire [11:0]processing_system7_0_M_AXI_GP0_BID;
  wire processing_system7_0_M_AXI_GP0_BREADY;
  wire [1:0]processing_system7_0_M_AXI_GP0_BRESP;
  wire processing_system7_0_M_AXI_GP0_BVALID;
  wire [31:0]processing_system7_0_M_AXI_GP0_RDATA;
  wire [11:0]processing_system7_0_M_AXI_GP0_RID;
  wire processing_system7_0_M_AXI_GP0_RLAST;
  wire processing_system7_0_M_AXI_GP0_RREADY;
  wire [1:0]processing_system7_0_M_AXI_GP0_RRESP;
  wire processing_system7_0_M_AXI_GP0_RVALID;
  wire [31:0]processing_system7_0_M_AXI_GP0_WDATA;
  wire [11:0]processing_system7_0_M_AXI_GP0_WID;
  wire processing_system7_0_M_AXI_GP0_WLAST;
  wire processing_system7_0_M_AXI_GP0_WREADY;
  wire [3:0]processing_system7_0_M_AXI_GP0_WSTRB;
  wire processing_system7_0_M_AXI_GP0_WVALID;

  assign GPIO_I_0_1 = gpio_i[31:0];
  assign M_AXI_GP0_ACLK_0_1 = axi_clk;
  assign S_AXI_GP0_0_1_ARADDR = saxi3_0_araddr[31:0];
  assign S_AXI_GP0_0_1_ARBURST = saxi3_0_arburst[1:0];
  assign S_AXI_GP0_0_1_ARCACHE = saxi3_0_arcache[3:0];
  assign S_AXI_GP0_0_1_ARID = saxi3_0_arid[5:0];
  assign S_AXI_GP0_0_1_ARLEN = saxi3_0_arlen[3:0];
  assign S_AXI_GP0_0_1_ARLOCK = saxi3_0_arlock[1:0];
  assign S_AXI_GP0_0_1_ARPROT = saxi3_0_arprot[2:0];
  assign S_AXI_GP0_0_1_ARQOS = saxi3_0_arqos[3:0];
  assign S_AXI_GP0_0_1_ARSIZE = saxi3_0_arsize[2:0];
  assign S_AXI_GP0_0_1_ARVALID = saxi3_0_arvalid;
  assign S_AXI_GP0_0_1_AWADDR = saxi3_0_awaddr[31:0];
  assign S_AXI_GP0_0_1_AWBURST = saxi3_0_awburst[1:0];
  assign S_AXI_GP0_0_1_AWCACHE = saxi3_0_awcache[3:0];
  assign S_AXI_GP0_0_1_AWID = saxi3_0_awid[5:0];
  assign S_AXI_GP0_0_1_AWLEN = saxi3_0_awlen[3:0];
  assign S_AXI_GP0_0_1_AWLOCK = saxi3_0_awlock[1:0];
  assign S_AXI_GP0_0_1_AWPROT = saxi3_0_awprot[2:0];
  assign S_AXI_GP0_0_1_AWQOS = saxi3_0_awqos[3:0];
  assign S_AXI_GP0_0_1_AWSIZE = saxi3_0_awsize[2:0];
  assign S_AXI_GP0_0_1_AWVALID = saxi3_0_awvalid;
  assign S_AXI_GP0_0_1_BREADY = saxi3_0_bready;
  assign S_AXI_GP0_0_1_RREADY = saxi3_0_rready;
  assign S_AXI_GP0_0_1_WDATA = saxi3_0_wdata[31:0];
  assign S_AXI_GP0_0_1_WID = saxi3_0_wid[5:0];
  assign S_AXI_GP0_0_1_WLAST = saxi3_0_wlast;
  assign S_AXI_GP0_0_1_WSTRB = saxi3_0_wstrb[3:0];
  assign S_AXI_GP0_0_1_WVALID = saxi3_0_wvalid;
  assign aclk = processing_system7_0_FCLK_CLK0;
  assign axi3_0_araddr[31:0] = processing_system7_0_M_AXI_GP0_ARADDR;
  assign axi3_0_arburst[1:0] = processing_system7_0_M_AXI_GP0_ARBURST;
  assign axi3_0_arcache[3:0] = processing_system7_0_M_AXI_GP0_ARCACHE;
  assign axi3_0_arid[11:0] = processing_system7_0_M_AXI_GP0_ARID;
  assign axi3_0_arlen[3:0] = processing_system7_0_M_AXI_GP0_ARLEN;
  assign axi3_0_arlock[1:0] = processing_system7_0_M_AXI_GP0_ARLOCK;
  assign axi3_0_arprot[2:0] = processing_system7_0_M_AXI_GP0_ARPROT;
  assign axi3_0_arqos[3:0] = processing_system7_0_M_AXI_GP0_ARQOS;
  assign axi3_0_arsize[2:0] = processing_system7_0_M_AXI_GP0_ARSIZE;
  assign axi3_0_arvalid = processing_system7_0_M_AXI_GP0_ARVALID;
  assign axi3_0_awaddr[31:0] = processing_system7_0_M_AXI_GP0_AWADDR;
  assign axi3_0_awburst[1:0] = processing_system7_0_M_AXI_GP0_AWBURST;
  assign axi3_0_awcache[3:0] = processing_system7_0_M_AXI_GP0_AWCACHE;
  assign axi3_0_awid[11:0] = processing_system7_0_M_AXI_GP0_AWID;
  assign axi3_0_awlen[3:0] = processing_system7_0_M_AXI_GP0_AWLEN;
  assign axi3_0_awlock[1:0] = processing_system7_0_M_AXI_GP0_AWLOCK;
  assign axi3_0_awprot[2:0] = processing_system7_0_M_AXI_GP0_AWPROT;
  assign axi3_0_awqos[3:0] = processing_system7_0_M_AXI_GP0_AWQOS;
  assign axi3_0_awsize[2:0] = processing_system7_0_M_AXI_GP0_AWSIZE;
  assign axi3_0_awvalid = processing_system7_0_M_AXI_GP0_AWVALID;
  assign axi3_0_bready = processing_system7_0_M_AXI_GP0_BREADY;
  assign axi3_0_rready = processing_system7_0_M_AXI_GP0_RREADY;
  assign axi3_0_wdata[31:0] = processing_system7_0_M_AXI_GP0_WDATA;
  assign axi3_0_wid[11:0] = processing_system7_0_M_AXI_GP0_WID;
  assign axi3_0_wlast = processing_system7_0_M_AXI_GP0_WLAST;
  assign axi3_0_wstrb[3:0] = processing_system7_0_M_AXI_GP0_WSTRB;
  assign axi3_0_wvalid = processing_system7_0_M_AXI_GP0_WVALID;
  assign clk_50 = processing_system7_0_0_FCLK_CLK1;
  assign gpio_o[31:0] = processing_system7_0_0_GPIO_O;
  assign gpio_t[31:0] = processing_system7_0_0_GPIO_T;
  assign irq_1 = irq[4:0];
  assign processing_system7_0_0_UART_1_RxD = uart_1_rxd;
  assign processing_system7_0_M_AXI_GP0_ARREADY = axi3_0_arready;
  assign processing_system7_0_M_AXI_GP0_AWREADY = axi3_0_awready;
  assign processing_system7_0_M_AXI_GP0_BID = axi3_0_bid[11:0];
  assign processing_system7_0_M_AXI_GP0_BRESP = axi3_0_bresp[1:0];
  assign processing_system7_0_M_AXI_GP0_BVALID = axi3_0_bvalid;
  assign processing_system7_0_M_AXI_GP0_RDATA = axi3_0_rdata[31:0];
  assign processing_system7_0_M_AXI_GP0_RID = axi3_0_rid[11:0];
  assign processing_system7_0_M_AXI_GP0_RLAST = axi3_0_rlast;
  assign processing_system7_0_M_AXI_GP0_RRESP = axi3_0_rresp[1:0];
  assign processing_system7_0_M_AXI_GP0_RVALID = axi3_0_rvalid;
  assign processing_system7_0_M_AXI_GP0_WREADY = axi3_0_wready;
  assign saxi3_0_arready = S_AXI_GP0_0_1_ARREADY;
  assign saxi3_0_awready = S_AXI_GP0_0_1_AWREADY;
  assign saxi3_0_bid[5:0] = S_AXI_GP0_0_1_BID;
  assign saxi3_0_bresp[1:0] = S_AXI_GP0_0_1_BRESP;
  assign saxi3_0_bvalid = S_AXI_GP0_0_1_BVALID;
  assign saxi3_0_rdata[31:0] = S_AXI_GP0_0_1_RDATA;
  assign saxi3_0_rid[5:0] = S_AXI_GP0_0_1_RID;
  assign saxi3_0_rlast = S_AXI_GP0_0_1_RLAST;
  assign saxi3_0_rresp[1:0] = S_AXI_GP0_0_1_RRESP;
  assign saxi3_0_rvalid = S_AXI_GP0_0_1_RVALID;
  assign saxi3_0_wready = S_AXI_GP0_0_1_WREADY;
  assign uart_1_txd = processing_system7_0_0_UART_1_TxD;
  zynq_processing_system7_0_0_0 processing_system7_0_0
       (.DDR_Addr(DDR_addr[14:0]),
        .DDR_BankAddr(DDR_ba[2:0]),
        .DDR_CAS_n(DDR_cas_n),
        .DDR_CKE(DDR_cke),
        .DDR_CS_n(DDR_cs_n),
        .DDR_Clk(DDR_ck_p),
        .DDR_Clk_n(DDR_ck_n),
        .DDR_DM(DDR_dm[3:0]),
        .DDR_DQ(DDR_dq[31:0]),
        .DDR_DQS(DDR_dqs_p[3:0]),
        .DDR_DQS_n(DDR_dqs_n[3:0]),
        .DDR_DRSTB(DDR_reset_n),
        .DDR_ODT(DDR_odt),
        .DDR_RAS_n(DDR_ras_n),
        .DDR_VRN(FIXED_IO_ddr_vrn),
        .DDR_VRP(FIXED_IO_ddr_vrp),
        .DDR_WEB(DDR_we_n),
        .FCLK_CLK0(processing_system7_0_FCLK_CLK0),
        .FCLK_CLK1(processing_system7_0_0_FCLK_CLK1),
        .GPIO_I(GPIO_I_0_1),
        .GPIO_O(processing_system7_0_0_GPIO_O),
        .GPIO_T(processing_system7_0_0_GPIO_T),
        .IRQ_F2P(irq_1),
        .MIO(FIXED_IO_mio[53:0]),
        .M_AXI_GP0_ACLK(M_AXI_GP0_ACLK_0_1),
        .M_AXI_GP0_ARADDR(processing_system7_0_M_AXI_GP0_ARADDR),
        .M_AXI_GP0_ARBURST(processing_system7_0_M_AXI_GP0_ARBURST),
        .M_AXI_GP0_ARCACHE(processing_system7_0_M_AXI_GP0_ARCACHE),
        .M_AXI_GP0_ARID(processing_system7_0_M_AXI_GP0_ARID),
        .M_AXI_GP0_ARLEN(processing_system7_0_M_AXI_GP0_ARLEN),
        .M_AXI_GP0_ARLOCK(processing_system7_0_M_AXI_GP0_ARLOCK),
        .M_AXI_GP0_ARPROT(processing_system7_0_M_AXI_GP0_ARPROT),
        .M_AXI_GP0_ARQOS(processing_system7_0_M_AXI_GP0_ARQOS),
        .M_AXI_GP0_ARREADY(processing_system7_0_M_AXI_GP0_ARREADY),
        .M_AXI_GP0_ARSIZE(processing_system7_0_M_AXI_GP0_ARSIZE),
        .M_AXI_GP0_ARVALID(processing_system7_0_M_AXI_GP0_ARVALID),
        .M_AXI_GP0_AWADDR(processing_system7_0_M_AXI_GP0_AWADDR),
        .M_AXI_GP0_AWBURST(processing_system7_0_M_AXI_GP0_AWBURST),
        .M_AXI_GP0_AWCACHE(processing_system7_0_M_AXI_GP0_AWCACHE),
        .M_AXI_GP0_AWID(processing_system7_0_M_AXI_GP0_AWID),
        .M_AXI_GP0_AWLEN(processing_system7_0_M_AXI_GP0_AWLEN),
        .M_AXI_GP0_AWLOCK(processing_system7_0_M_AXI_GP0_AWLOCK),
        .M_AXI_GP0_AWPROT(processing_system7_0_M_AXI_GP0_AWPROT),
        .M_AXI_GP0_AWQOS(processing_system7_0_M_AXI_GP0_AWQOS),
        .M_AXI_GP0_AWREADY(processing_system7_0_M_AXI_GP0_AWREADY),
        .M_AXI_GP0_AWSIZE(processing_system7_0_M_AXI_GP0_AWSIZE),
        .M_AXI_GP0_AWVALID(processing_system7_0_M_AXI_GP0_AWVALID),
        .M_AXI_GP0_BID(processing_system7_0_M_AXI_GP0_BID),
        .M_AXI_GP0_BREADY(processing_system7_0_M_AXI_GP0_BREADY),
        .M_AXI_GP0_BRESP(processing_system7_0_M_AXI_GP0_BRESP),
        .M_AXI_GP0_BVALID(processing_system7_0_M_AXI_GP0_BVALID),
        .M_AXI_GP0_RDATA(processing_system7_0_M_AXI_GP0_RDATA),
        .M_AXI_GP0_RID(processing_system7_0_M_AXI_GP0_RID),
        .M_AXI_GP0_RLAST(processing_system7_0_M_AXI_GP0_RLAST),
        .M_AXI_GP0_RREADY(processing_system7_0_M_AXI_GP0_RREADY),
        .M_AXI_GP0_RRESP(processing_system7_0_M_AXI_GP0_RRESP),
        .M_AXI_GP0_RVALID(processing_system7_0_M_AXI_GP0_RVALID),
        .M_AXI_GP0_WDATA(processing_system7_0_M_AXI_GP0_WDATA),
        .M_AXI_GP0_WID(processing_system7_0_M_AXI_GP0_WID),
        .M_AXI_GP0_WLAST(processing_system7_0_M_AXI_GP0_WLAST),
        .M_AXI_GP0_WREADY(processing_system7_0_M_AXI_GP0_WREADY),
        .M_AXI_GP0_WSTRB(processing_system7_0_M_AXI_GP0_WSTRB),
        .M_AXI_GP0_WVALID(processing_system7_0_M_AXI_GP0_WVALID),
        .PS_CLK(FIXED_IO_ps_clk),
        .PS_PORB(FIXED_IO_ps_porb),
        .PS_SRSTB(FIXED_IO_ps_srstb),
        .S_AXI_GP0_ACLK(M_AXI_GP0_ACLK_0_1),
        .S_AXI_GP0_ARADDR(S_AXI_GP0_0_1_ARADDR),
        .S_AXI_GP0_ARBURST(S_AXI_GP0_0_1_ARBURST),
        .S_AXI_GP0_ARCACHE(S_AXI_GP0_0_1_ARCACHE),
        .S_AXI_GP0_ARID(S_AXI_GP0_0_1_ARID),
        .S_AXI_GP0_ARLEN(S_AXI_GP0_0_1_ARLEN),
        .S_AXI_GP0_ARLOCK(S_AXI_GP0_0_1_ARLOCK),
        .S_AXI_GP0_ARPROT(S_AXI_GP0_0_1_ARPROT),
        .S_AXI_GP0_ARQOS(S_AXI_GP0_0_1_ARQOS),
        .S_AXI_GP0_ARREADY(S_AXI_GP0_0_1_ARREADY),
        .S_AXI_GP0_ARSIZE(S_AXI_GP0_0_1_ARSIZE),
        .S_AXI_GP0_ARVALID(S_AXI_GP0_0_1_ARVALID),
        .S_AXI_GP0_AWADDR(S_AXI_GP0_0_1_AWADDR),
        .S_AXI_GP0_AWBURST(S_AXI_GP0_0_1_AWBURST),
        .S_AXI_GP0_AWCACHE(S_AXI_GP0_0_1_AWCACHE),
        .S_AXI_GP0_AWID(S_AXI_GP0_0_1_AWID),
        .S_AXI_GP0_AWLEN(S_AXI_GP0_0_1_AWLEN),
        .S_AXI_GP0_AWLOCK(S_AXI_GP0_0_1_AWLOCK),
        .S_AXI_GP0_AWPROT(S_AXI_GP0_0_1_AWPROT),
        .S_AXI_GP0_AWQOS(S_AXI_GP0_0_1_AWQOS),
        .S_AXI_GP0_AWREADY(S_AXI_GP0_0_1_AWREADY),
        .S_AXI_GP0_AWSIZE(S_AXI_GP0_0_1_AWSIZE),
        .S_AXI_GP0_AWVALID(S_AXI_GP0_0_1_AWVALID),
        .S_AXI_GP0_BID(S_AXI_GP0_0_1_BID),
        .S_AXI_GP0_BREADY(S_AXI_GP0_0_1_BREADY),
        .S_AXI_GP0_BRESP(S_AXI_GP0_0_1_BRESP),
        .S_AXI_GP0_BVALID(S_AXI_GP0_0_1_BVALID),
        .S_AXI_GP0_RDATA(S_AXI_GP0_0_1_RDATA),
        .S_AXI_GP0_RID(S_AXI_GP0_0_1_RID),
        .S_AXI_GP0_RLAST(S_AXI_GP0_0_1_RLAST),
        .S_AXI_GP0_RREADY(S_AXI_GP0_0_1_RREADY),
        .S_AXI_GP0_RRESP(S_AXI_GP0_0_1_RRESP),
        .S_AXI_GP0_RVALID(S_AXI_GP0_0_1_RVALID),
        .S_AXI_GP0_WDATA(S_AXI_GP0_0_1_WDATA),
        .S_AXI_GP0_WID(S_AXI_GP0_0_1_WID),
        .S_AXI_GP0_WLAST(S_AXI_GP0_0_1_WLAST),
        .S_AXI_GP0_WREADY(S_AXI_GP0_0_1_WREADY),
        .S_AXI_GP0_WSTRB(S_AXI_GP0_0_1_WSTRB),
        .S_AXI_GP0_WVALID(S_AXI_GP0_0_1_WVALID),
        .UART1_RX(processing_system7_0_0_UART_1_RxD),
        .UART1_TX(processing_system7_0_0_UART_1_TxD));
endmodule
