interface axi3_interface#(
    parameter  D_WIDTH  = 32,
    parameter  ID_WIDTH = 12
    
)
();

localparam WSTRB_W  = D_WIDTH/8; // количество байт и стробов записи на них

/// Bus signals
logic                aclk;
logic [31:0]         araddr;
logic [1:0]          arburst;
logic [3:0]          arcache;
logic [ID_WIDTH-1:0] arid;
logic [3:0]          arlen;
logic [1:0]          arlock;
logic [2:0]          arprot;
logic [3:0]          arqos;
logic                arready;
logic [2:0]          arsize;
logic                arvalid;
logic [31:0]         awaddr;
logic [1:0]          awburst;
logic [3:0]          awcache;
logic [ID_WIDTH-1:0] awid;
logic [3:0]          awlen;
logic [1:0]          awlock;
logic [2:0]          awprot;
logic [3:0]          awqos;
logic                awready;
logic [2:0]          awsize;
logic                awvalid;
logic [ID_WIDTH-1:0] bid;
logic                bready;
logic [1:0]          bresp;
logic                bvalid;
logic [D_WIDTH-1:0]  rdata;
logic [ID_WIDTH-1:0] rid;
logic                rlast;
logic                rready;
logic [1:0]          rresp;
logic                rvalid;
logic [D_WIDTH-1:0]  wdata;
logic [ID_WIDTH-1:0] wid;
logic                wlast;
logic                wready;
logic [WSTRB_W-1:0]  wstrb;
logic                wvalid;



modport master
(
    output aclk,
    output araddr,
    output arburst,
    output arcache,
    output arid,
    output arlen,
    output arlock,
    output arprot,
    output arqos,
    input  arready,
    output arsize,
    output arvalid,
    output awaddr,
    output awburst,
    output awcache,
    output awid,
    output awlen,
    output awlock,
    output awprot,
    output awqos,
    input  awready,
    output awsize,
    output awvalid,
    input  bid,
    output bready,
    input  bresp,
    input  bvalid,
    input  rdata,
    input  rid,
    input  rlast,
    output rready,
    input  rresp,
    input  rvalid,
    output wdata,
    output wid,
    output wlast,
    input  wready,
    output wstrb,
    output wvalid
);

modport slave
(
    input  aclk,
    input  araddr,
    input  arburst,
    input  arcache,
    input  arid,
    input  arlen,
    input  arlock,
    input  arprot,
    input  arqos,
    output arready,
    input  arsize,
    input  arvalid,
    input  awaddr,
    input  awburst,
    input  awcache,
    input  awid,
    input  awlen,
    input  awlock,
    input  awprot,
    input  awqos,
    output awready,
    input  awsize,
    input  awvalid,
    output bid,
    input  bready,
    output bresp,
    output bvalid,
    output rdata,
    output rid,
    output rlast,
    input  rready,
    output rresp,
    output rvalid,
    input  wdata,
    input  wid,
    input  wlast,
    output wready,
    input  wstrb,
    input  wvalid
);

modport debug
(
    input aclk,    // probe 0
    input araddr,  // probe 2
    input arburst, // probe 3
    input arcache, // probe 4
    input arid,    // probe 5
    input arlen,   // probe 6
    input arlock,  // probe 7
    input arprot,  // probe 8
    input arqos,   // probe 9
    input arready, // probe 10
    input arsize,  // probe 11
    input arvalid, // probe 12
    input awaddr,  // probe 13
    input awburst, // probe 14
    input awcache, // probe 15
    input awid,    // probe 16
    input awlen,   // probe 17
    input awlock,  // probe 18
    input awprot,  // probe 19
    input awqos,   // probe 20
    input awready, // probe 21
    input awsize,  // probe 22
    input awvalid, // probe 23
    input bid,     // probe 24
    input bready,  // probe 25
    input bresp,   // probe 26
    input bvalid,  // probe 27
    input rdata,   // probe 28
    input rid,     // probe 29
    input rlast,   // probe 30
    input rready,  // probe 31
    input rresp,   // probe 32
    input rvalid,  // probe 33
    input wdata,   // probe 34
    input wid,     // probe 35
    input wlast,   // probe 36
    input wready,  // probe 37
    input wstrb,   // probe 38
    input wvalid   // probe 39
);

    // Additional tasks for simulation
    // Delay
`ifndef SYNTHESIS
task waitClks (input integer numclks);
    repeat (numclks) begin
        @(posedge aclk);
    end
endtask

// task Init;

    // araddr  <= 0;
    // arburst <= 0;
    // arcache <= 0;
    // arid    <= 0;
    // arlen   <= 0;
    // arlock  <= 0;
    // arprot  <= 0;
    // arqos   <= 0;
    // arsize  <= 0;
    // arvalid <= 0;
    // awaddr  <= 0;
    // awburst <= 0;
    // awcache <= 0;
    // awid    <= 0;
    // awlen   <= 0;
    // awlock  <= 0;
    // awprot  <= 0;
    // awqos   <= 0;
    // awsize  <= 0;
    // awvalid <= 0;
    // bready  <= 0;
    // rready  <= 0;
    // wdata   <= 0;
    // wid     <= 0;
    // wlast   <= 0;
    // wstrb   <= 0;
    // wvalid  <= 0;

// endtask

// Register read and write simultaneously
task readwriteReg
(
    //read
    input integer r_base,
    input integer r_offset,
    input [3:0]   r_burst_len, // burst length
    
    //write
    input integer    w_base,
    input integer    w_offset,
    input [3:0]      w_burst_len, // burst length
    input reg [31:0] w_val [2**4]
);
    integer disp_r_addr;
    integer disp_w_addr;
    
    //read
    araddr      <= r_base + r_offset;
    arlen       <= r_burst_len;
    arvalid     <= 1;
    disp_r_addr <= araddr;
    rready      <= 1;
    
    //write
    wlast   <= 1;
    bready  <= 0;
    
    awaddr  <= w_base + w_offset;
    awlen   <= w_burst_len;
    awvalid <= 1;
    bready  <= 1;
    wvalid  <= 1;
    wdata   <= w_val[0];
    
    
    @ (posedge aclk);
    arvalid <= 0;
    awvalid <= 0;
    
    @ (posedge aclk);
    while(bvalid != 1'b1) begin
        @ (posedge aclk);
    end
    bready  <= 0;
    
endtask

// Register read
task readReg
(
    input integer base,
    input integer offset,
    input [3:0]   burst_len // burst length
);
    integer disp_addr;
    
    araddr    <= base + offset;
    arlen     <= burst_len;
    arvalid   <= 1;
    disp_addr <= araddr;
    @ (posedge aclk);
    while(arready != 1'b1) begin
        @ (posedge aclk);
    end
    araddr  <= 0;
    arlen   <= 0;
    arvalid <= 0;
    
    rready  <= 1;
    
    @ (posedge aclk);
    while(rlast != 1'b1) begin
        if(rvalid) begin
            $display ("%7gns Read from addr : 0x%h | data : 0x%h", $time, disp_addr, rdata);
            disp_addr <= disp_addr + 4;
        end
        @ (posedge aclk);
    end
    
    $display ("%7gns Read from addr : 0x%h | data : 0x%h", $time, disp_addr, rdata);
    
    rready  <= 0;
    
endtask

task writeReg
(
    input integer    base,
    input integer    offset,
    input [3:0]      burst_len, // burst length
    input reg [31:0] val [2**4]
);
    
    wlast   <= 0;
    bready  <= 0;
    
    awaddr  <= base + offset;
    awlen   <= burst_len;
    awvalid <= 1;
    bready  <= 1;
    @ (posedge aclk);
    while(awready != 1'b1) begin
        @ (posedge aclk);
    end
    awaddr  <= 0;
    awlen   <= 0;
    awvalid <= 0;
    
    wvalid  <= 1;
    for(int i = 0;i <= burst_len;i ++) begin
        if(i == burst_len)
            wlast <= 1;
        
        wdata <= val[i];
        @ (posedge aclk);
        while(wready != 1'b1) begin
            @ (posedge aclk);
        end
    end
    wdata   <= 0;
    wvalid  <= 0;
    wlast   <= 0;
    
    @ (posedge aclk);
    while(bvalid != 1'b1) begin
        @ (posedge aclk);
    end
    bready  <= 0;

endtask

// эмуляция outstanding чтение подряд из 2-х адресов
// Outstanding register read
task readReg_2
(
    input integer base,
    input integer offset
);
    rready    <= 1;
    araddr    <= base + offset;
    arlen     <= 0;
    arvalid   <= 1;

    @ (posedge aclk);
    while(arready != 1'b1) begin
        @ (posedge aclk);
    end// первый адрес чтения передан
    araddr  <= araddr + 4;
    arid    <= arid + 1;
    
    @ (posedge aclk);
    while(arready != 1'b1) begin
        @ (posedge aclk);
    end// второй адрес чтения передан
    
    arvalid <= 0;
    

    
    @ (posedge aclk);
    while(rlast != 1'b1) begin
        @ (posedge aclk);
    end
    
    // rready  <= 0;
    
endtask

// эмуляция записи, первый адрес-два данных-второй адрес
task write_addr_2data_addr
(
    input integer    base,
    input integer    offset,
    input reg [31:0] val [2**4]
);
    
    @ (posedge aclk);
    wlast   <= 0;
    bready  <= 0;
    
    awaddr  <= base + offset;
    awlen   <= 0;
    awvalid <= 1;
    bready  <= 1;
    @ (posedge aclk);
    while(awready != 1'b1) begin
        @ (posedge aclk);
    end
    awaddr  <= awaddr + 4;
    
    wvalid <= 1;
    wdata  <= val[0];
    wlast  <= 1;
    @ (posedge aclk);
    while(wready != 1'b1) begin
        @ (posedge aclk);
    end
    
    @ (posedge aclk);
    while(awready != 1'b1) begin
        @ (posedge aclk);
    end
    awvalid <= 0;
    
    wvalid <= 1;
    wdata  <= val[1];
    wlast  <= 1;
    @ (posedge aclk);
    while(wready != 1'b1) begin
        @ (posedge aclk);
    end
    
    wdata   <= 0;
    wvalid  <= 0;
    wlast   <= 0;
    
    
    // ДОРАБОТАТЬ!!!!!!!!!!!!!!!!!!!!!!!!!!!
    @ (posedge aclk);
    while(bvalid != 1'b1) begin
        @ (posedge aclk);
    end
    bready  <= 0;
    
endtask
`endif

endinterface