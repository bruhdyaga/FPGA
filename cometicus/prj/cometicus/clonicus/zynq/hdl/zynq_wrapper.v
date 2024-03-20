//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
//Date        : Wed Mar 20 09:58:01 2024
//Host        : ws2104201823 running 64-bit major release  (build 9200)
//Command     : generate_target zynq_wrapper.bd
//Design      : zynq_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module zynq_wrapper
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
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output aclk;
  output [31:0]axi3_0_araddr;
  output [1:0]axi3_0_arburst;
  output [3:0]axi3_0_arcache;
  output [11:0]axi3_0_arid;
  output [3:0]axi3_0_arlen;
  output [1:0]axi3_0_arlock;
  output [2:0]axi3_0_arprot;
  output [3:0]axi3_0_arqos;
  input axi3_0_arready;
  output [2:0]axi3_0_arsize;
  output axi3_0_arvalid;
  output [31:0]axi3_0_awaddr;
  output [1:0]axi3_0_awburst;
  output [3:0]axi3_0_awcache;
  output [11:0]axi3_0_awid;
  output [3:0]axi3_0_awlen;
  output [1:0]axi3_0_awlock;
  output [2:0]axi3_0_awprot;
  output [3:0]axi3_0_awqos;
  input axi3_0_awready;
  output [2:0]axi3_0_awsize;
  output axi3_0_awvalid;
  input [11:0]axi3_0_bid;
  output axi3_0_bready;
  input [1:0]axi3_0_bresp;
  input axi3_0_bvalid;
  input [31:0]axi3_0_rdata;
  input [11:0]axi3_0_rid;
  input axi3_0_rlast;
  output axi3_0_rready;
  input [1:0]axi3_0_rresp;
  input axi3_0_rvalid;
  output [31:0]axi3_0_wdata;
  output [11:0]axi3_0_wid;
  output axi3_0_wlast;
  input axi3_0_wready;
  output [3:0]axi3_0_wstrb;
  output axi3_0_wvalid;
  input axi_clk;
  output clk_50;
  input [31:0]gpio_i;
  output [31:0]gpio_o;
  output [31:0]gpio_t;
  input [4:0]irq;
  input [31:0]saxi3_0_araddr;
  input [1:0]saxi3_0_arburst;
  input [3:0]saxi3_0_arcache;
  input [5:0]saxi3_0_arid;
  input [3:0]saxi3_0_arlen;
  input [1:0]saxi3_0_arlock;
  input [2:0]saxi3_0_arprot;
  input [3:0]saxi3_0_arqos;
  output saxi3_0_arready;
  input [2:0]saxi3_0_arsize;
  input saxi3_0_arvalid;
  input [31:0]saxi3_0_awaddr;
  input [1:0]saxi3_0_awburst;
  input [3:0]saxi3_0_awcache;
  input [5:0]saxi3_0_awid;
  input [3:0]saxi3_0_awlen;
  input [1:0]saxi3_0_awlock;
  input [2:0]saxi3_0_awprot;
  input [3:0]saxi3_0_awqos;
  output saxi3_0_awready;
  input [2:0]saxi3_0_awsize;
  input saxi3_0_awvalid;
  output [5:0]saxi3_0_bid;
  input saxi3_0_bready;
  output [1:0]saxi3_0_bresp;
  output saxi3_0_bvalid;
  output [31:0]saxi3_0_rdata;
  output [5:0]saxi3_0_rid;
  output saxi3_0_rlast;
  input saxi3_0_rready;
  output [1:0]saxi3_0_rresp;
  output saxi3_0_rvalid;
  input [31:0]saxi3_0_wdata;
  input [5:0]saxi3_0_wid;
  input saxi3_0_wlast;
  output saxi3_0_wready;
  input [3:0]saxi3_0_wstrb;
  input saxi3_0_wvalid;
  input uart_1_rxd;
  output uart_1_txd;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire aclk;
  wire [31:0]axi3_0_araddr;
  wire [1:0]axi3_0_arburst;
  wire [3:0]axi3_0_arcache;
  wire [11:0]axi3_0_arid;
  wire [3:0]axi3_0_arlen;
  wire [1:0]axi3_0_arlock;
  wire [2:0]axi3_0_arprot;
  wire [3:0]axi3_0_arqos;
  wire axi3_0_arready;
  wire [2:0]axi3_0_arsize;
  wire axi3_0_arvalid;
  wire [31:0]axi3_0_awaddr;
  wire [1:0]axi3_0_awburst;
  wire [3:0]axi3_0_awcache;
  wire [11:0]axi3_0_awid;
  wire [3:0]axi3_0_awlen;
  wire [1:0]axi3_0_awlock;
  wire [2:0]axi3_0_awprot;
  wire [3:0]axi3_0_awqos;
  wire axi3_0_awready;
  wire [2:0]axi3_0_awsize;
  wire axi3_0_awvalid;
  wire [11:0]axi3_0_bid;
  wire axi3_0_bready;
  wire [1:0]axi3_0_bresp;
  wire axi3_0_bvalid;
  wire [31:0]axi3_0_rdata;
  wire [11:0]axi3_0_rid;
  wire axi3_0_rlast;
  wire axi3_0_rready;
  wire [1:0]axi3_0_rresp;
  wire axi3_0_rvalid;
  wire [31:0]axi3_0_wdata;
  wire [11:0]axi3_0_wid;
  wire axi3_0_wlast;
  wire axi3_0_wready;
  wire [3:0]axi3_0_wstrb;
  wire axi3_0_wvalid;
  wire axi_clk;
  wire clk_50;
  wire [31:0]gpio_i;
  wire [31:0]gpio_o;
  wire [31:0]gpio_t;
  wire [4:0]irq;
  wire [31:0]saxi3_0_araddr;
  wire [1:0]saxi3_0_arburst;
  wire [3:0]saxi3_0_arcache;
  wire [5:0]saxi3_0_arid;
  wire [3:0]saxi3_0_arlen;
  wire [1:0]saxi3_0_arlock;
  wire [2:0]saxi3_0_arprot;
  wire [3:0]saxi3_0_arqos;
  wire saxi3_0_arready;
  wire [2:0]saxi3_0_arsize;
  wire saxi3_0_arvalid;
  wire [31:0]saxi3_0_awaddr;
  wire [1:0]saxi3_0_awburst;
  wire [3:0]saxi3_0_awcache;
  wire [5:0]saxi3_0_awid;
  wire [3:0]saxi3_0_awlen;
  wire [1:0]saxi3_0_awlock;
  wire [2:0]saxi3_0_awprot;
  wire [3:0]saxi3_0_awqos;
  wire saxi3_0_awready;
  wire [2:0]saxi3_0_awsize;
  wire saxi3_0_awvalid;
  wire [5:0]saxi3_0_bid;
  wire saxi3_0_bready;
  wire [1:0]saxi3_0_bresp;
  wire saxi3_0_bvalid;
  wire [31:0]saxi3_0_rdata;
  wire [5:0]saxi3_0_rid;
  wire saxi3_0_rlast;
  wire saxi3_0_rready;
  wire [1:0]saxi3_0_rresp;
  wire saxi3_0_rvalid;
  wire [31:0]saxi3_0_wdata;
  wire [5:0]saxi3_0_wid;
  wire saxi3_0_wlast;
  wire saxi3_0_wready;
  wire [3:0]saxi3_0_wstrb;
  wire saxi3_0_wvalid;
  wire uart_1_rxd;
  wire uart_1_txd;

  zynq zynq_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .aclk(aclk),
        .axi3_0_araddr(axi3_0_araddr),
        .axi3_0_arburst(axi3_0_arburst),
        .axi3_0_arcache(axi3_0_arcache),
        .axi3_0_arid(axi3_0_arid),
        .axi3_0_arlen(axi3_0_arlen),
        .axi3_0_arlock(axi3_0_arlock),
        .axi3_0_arprot(axi3_0_arprot),
        .axi3_0_arqos(axi3_0_arqos),
        .axi3_0_arready(axi3_0_arready),
        .axi3_0_arsize(axi3_0_arsize),
        .axi3_0_arvalid(axi3_0_arvalid),
        .axi3_0_awaddr(axi3_0_awaddr),
        .axi3_0_awburst(axi3_0_awburst),
        .axi3_0_awcache(axi3_0_awcache),
        .axi3_0_awid(axi3_0_awid),
        .axi3_0_awlen(axi3_0_awlen),
        .axi3_0_awlock(axi3_0_awlock),
        .axi3_0_awprot(axi3_0_awprot),
        .axi3_0_awqos(axi3_0_awqos),
        .axi3_0_awready(axi3_0_awready),
        .axi3_0_awsize(axi3_0_awsize),
        .axi3_0_awvalid(axi3_0_awvalid),
        .axi3_0_bid(axi3_0_bid),
        .axi3_0_bready(axi3_0_bready),
        .axi3_0_bresp(axi3_0_bresp),
        .axi3_0_bvalid(axi3_0_bvalid),
        .axi3_0_rdata(axi3_0_rdata),
        .axi3_0_rid(axi3_0_rid),
        .axi3_0_rlast(axi3_0_rlast),
        .axi3_0_rready(axi3_0_rready),
        .axi3_0_rresp(axi3_0_rresp),
        .axi3_0_rvalid(axi3_0_rvalid),
        .axi3_0_wdata(axi3_0_wdata),
        .axi3_0_wid(axi3_0_wid),
        .axi3_0_wlast(axi3_0_wlast),
        .axi3_0_wready(axi3_0_wready),
        .axi3_0_wstrb(axi3_0_wstrb),
        .axi3_0_wvalid(axi3_0_wvalid),
        .axi_clk(axi_clk),
        .clk_50(clk_50),
        .gpio_i(gpio_i),
        .gpio_o(gpio_o),
        .gpio_t(gpio_t),
        .irq(irq),
        .saxi3_0_araddr(saxi3_0_araddr),
        .saxi3_0_arburst(saxi3_0_arburst),
        .saxi3_0_arcache(saxi3_0_arcache),
        .saxi3_0_arid(saxi3_0_arid),
        .saxi3_0_arlen(saxi3_0_arlen),
        .saxi3_0_arlock(saxi3_0_arlock),
        .saxi3_0_arprot(saxi3_0_arprot),
        .saxi3_0_arqos(saxi3_0_arqos),
        .saxi3_0_arready(saxi3_0_arready),
        .saxi3_0_arsize(saxi3_0_arsize),
        .saxi3_0_arvalid(saxi3_0_arvalid),
        .saxi3_0_awaddr(saxi3_0_awaddr),
        .saxi3_0_awburst(saxi3_0_awburst),
        .saxi3_0_awcache(saxi3_0_awcache),
        .saxi3_0_awid(saxi3_0_awid),
        .saxi3_0_awlen(saxi3_0_awlen),
        .saxi3_0_awlock(saxi3_0_awlock),
        .saxi3_0_awprot(saxi3_0_awprot),
        .saxi3_0_awqos(saxi3_0_awqos),
        .saxi3_0_awready(saxi3_0_awready),
        .saxi3_0_awsize(saxi3_0_awsize),
        .saxi3_0_awvalid(saxi3_0_awvalid),
        .saxi3_0_bid(saxi3_0_bid),
        .saxi3_0_bready(saxi3_0_bready),
        .saxi3_0_bresp(saxi3_0_bresp),
        .saxi3_0_bvalid(saxi3_0_bvalid),
        .saxi3_0_rdata(saxi3_0_rdata),
        .saxi3_0_rid(saxi3_0_rid),
        .saxi3_0_rlast(saxi3_0_rlast),
        .saxi3_0_rready(saxi3_0_rready),
        .saxi3_0_rresp(saxi3_0_rresp),
        .saxi3_0_rvalid(saxi3_0_rvalid),
        .saxi3_0_wdata(saxi3_0_wdata),
        .saxi3_0_wid(saxi3_0_wid),
        .saxi3_0_wlast(saxi3_0_wlast),
        .saxi3_0_wready(saxi3_0_wready),
        .saxi3_0_wstrb(saxi3_0_wstrb),
        .saxi3_0_wvalid(saxi3_0_wvalid),
        .uart_1_rxd(uart_1_rxd),
        .uart_1_txd(uart_1_txd));
endmodule
