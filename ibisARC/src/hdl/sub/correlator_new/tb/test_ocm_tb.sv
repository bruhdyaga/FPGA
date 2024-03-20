// `timescale 1ns/10ps
`timescale 1ns/1fs

`include "global_param.v"

// `define pclk     105.6  // MHz
`define pclk     100.001500// MHz
`define aclk     100    // MHz
`define core_clk 111    // MHz

`include "macro.svh"
`include "dma_intbus_axi_hp.svh"

module test_ocm_tb();

localparam BASEADDR     = 32'h40000000/4;
localparam N_TCOM       = 6; // количество шкал времени
localparam NBUSES       = 2;

reg  pclk     = 1;
reg  aclk     = 1;
reg  core_clk = 1;
reg  aresetn = 1;
wire presetn;

localparam PCLK_PERIOD = (1000/`pclk)/2;

always #((1000/`pclk)/2)     pclk     <= !pclk;
always #((1000/`aclk)/2)     aclk     <= !aclk;
always #((1000/`core_clk)/2) core_clk <= !core_clk;


axi3_interface   axi3();
intbus_interf    bus();
intbus_interf    bus_sl[NBUSES]();

axi_hp_interface#(
    .D_WIDTH (`AXI_HP_WIDTH)
) axi_hp0();

axi4_interface#(
    .D_WIDTH  (`AXI_ACP_WIDTH),
    .ID_WIDTH (3)
) axi_acp();

localparam ADC_PORTS = 1;
// ADC interface
adc_interf#(
    .PORTS (ADC_PORTS), // 0 - imitator
    .R     (2)
)adc ();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

// IMI interface
imi_interf#(
    .WIDTH (`IMI_OUTWIDTH)
)imi ();

initial begin
    @ (negedge aclk)
      aresetn = 0;
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
      aresetn = 1;
end

level_sync ADC_RESETN(
    .clk     (pclk),
    .reset_n (aresetn),
    .async   (aresetn),
    .sync    (presetn)
);

assign adc.clk    = pclk;
assign adc.resetn = presetn;
assign adc.data   = {'{'0}};

assign rd    = axi_hp0.rvalid  & axi_hp0.rready;
assign ard   = axi_hp0.arready & axi_hp0.arvalid;
assign rlast = axi_hp0.rlast   & rd;

assign axi_hp0.arready = '1;


assign axi_hp0.awready = '1;
assign axi_hp0.bid     = '0;
assign axi_hp0.bresp   = '0;
assign axi_hp0.bvalid  = '0;
assign axi_hp0.rid     = '0;
assign axi_hp0.rresp   = '0;

assign axi_hp0.wready  = '1;
// initial begin
// axi_hp0.wready  = '0;

// @ (posedge fix_pulse)
// @ (negedge fix_pulse)
// #300 axi_hp0.wready  = '1;
// end

reg [10:0] wr_cntr; // счетчки burst транзакций при записи в PL

always_ff@(posedge aclk or negedge aresetn)
if(aresetn == '0) begin
    wr_cntr <= '0;
end else begin
    if(ard & (!rlast)) begin
        wr_cntr <= wr_cntr + 1'b1;
    end else begin
        if(rlast & (wr_cntr != '0)) begin
            wr_cntr <= wr_cntr - 1'b1;
        end
    end
end

always_ff@(posedge aclk or negedge aresetn)
if(aresetn == '0) begin
    axi_hp0.rvalid <= '0;
end else begin
    if(ard | (rlast & (wr_cntr != 1))) begin
        axi_hp0.rvalid <= '1;
    end else begin
        if(rlast) begin
            axi_hp0.rvalid <= '0;
        end
    end
end


reg [3:0] burst_cntr;
reg [3:0] burst_len;
always_ff@(posedge aclk or negedge aresetn)
if(aresetn == '0) begin
    burst_len <= '0;
end else begin
    if(ard) begin
        burst_len <= axi_hp0.arlen;
    end
end

always_ff@(posedge aclk or negedge aresetn)
if(aresetn == '0) begin
    burst_cntr <= '0;
end else begin
    if(ard | (rlast & (wr_cntr != 1))) begin
        burst_cntr <= '0;
    end else begin
        if((burst_cntr != burst_len) & (axi_hp0.rvalid == '1) & rd) begin
            burst_cntr <= burst_cntr + 1'b1;
        end
    end
end

always_ff@(posedge aclk or negedge aresetn)
if(aresetn == '0) begin
    axi_hp0.rlast <= '0;
end else begin
    if((burst_cntr == (burst_len - 1)) & rd) begin
        axi_hp0.rlast <= '1;
    end else begin
        if(rd) begin
            axi_hp0.rlast <= '0;
        end
    end
end

// localparam TEST_DATA_SIZE = 33;
localparam TEST_DATA_SIZE = 42;
reg [31:0] test_data [TEST_DATA_SIZE-1:0];
reg [15:0] test_data_addr;

initial begin
test_data = {
    // {21},                                 //33
    // {5}, // PRN BDSS_CNTR                 //32
    
    {2}, // CORR IQ                          //41
    {2}, // CORR IQ                          //40
    {2}, // CORR IQ                          //39
    {2}, // CORR EPOCH_IRQ                   //38
    {2}, // CORR CAR_CYCLES                  //37
    {2}, // CORR CAR_PHASE                   //36
    {2}, // CORR PHASE_RATE                  //35
    {2}, // CORR CFG                         //34
    {1}, // CORR MASK                        //33
    {32'hCECECECE}, // CORR ID               //32
    {5}, // PRN CNTR_LENGTH                  //31
    {4}, // PRN CODE_OUT_BITMASKS            //30
    {3}, // PRN CODE_BITMASKS                //29
    {2}, // PRN CODE_STATES                  //28
    {5{1'b1}}, // PRN MASK                   //27
    {32'hABABABAB}, // PRN ID                //26
    {7}, // TCH RESERVED                     //25
    {6}, // TCH CODE_RATE                    //24
    {5}, // TCH CHIP_EPOCH_MAX               //23
    {4}, // TCH SEC                          //22
    {3}, // TCH CHIP_EPOCH                   //21
    {2}, // TCH PHASE                        //20
    {1}, // TCH MASK                         //19
    {32'hCECECECE}, // TCH ID                //18
    {32'hDDDDCCCC}, // 2-nd stream HUB       //17
    {32'hBBBBAAAA}, // 2-nd stream HUB       //16
    {12},// RESERVED                         //15
    {11},// PPS_CFG                          //14
    {10},// TM_TRIG_PPS                      //13
    {9},// TM_TRIG_PPS                       //12
    {8},// TM_TRIG_FACQ                      //11
    {7},// TM_TRIG_FACQ                      //10
    {6}, // RESERVED                         // 9
    {5}, // CODE_RATE                        // 8
    {4}, // CHIP_EPOCH_MAX                   // 7
    {3}, // SEC                              // 6
    {2}, // CHIP_EPOCH                       // 5
    {1}, // PHASE                            // 4
    {32{1'b1}}, // TCOM MASK                 // 3
    {32'hEFEFEFEF}, // TCOM ID               // 2
    {32'hDDDDCCCC}, // 1-st stream HUB       // 1
    {32'hBBBBAAAA}  // 1-st stream HUB       // 0
};
end
/* 
always_ff@(posedge aclk or negedge aresetn)
if(aresetn == '0) begin
    test_data_addr <= '0;
end else begin
    // if(ard | (rlast & (wr_cntr != 1))) begin
        // axi_hp0.rdata <= '0;
    // end else begin
        if(rd) begin
            test_data_addr <= test_data_addr + 2'd2;
        end
    // end
end */

// assign axi_hp0.rdata = axi_hp0.rvalid ? {{test_data[test_data_addr + 1]},test_data[test_data_addr]} : '0;

// localparam AXI_HP_MASTER_BASE_ADDR = BASEADDR + `HUBSIZE;
// axi_hp_master#(
    // .BASEADDR (AXI_HP_MASTER_BASE_ADDR)
// ) AXI_HP_MASTER(
    // .axi_hp        (axi_hp0),
    // .stream_intbus (stream_intbus),
    // .int_bus_s     (bus_sl[0])
// );

// localparam DMA_INTBUS_AXI_HP_BASE_ADDR = BASEADDR;
// dma_intbus_axi_hp#(
    // .BASEADDR (DMA_INTBUS_AXI_HP_BASE_ADDR)
// ) dma_intbus_axi_hp_inst(
    // .axi_hp       (axi_hp0),
    // .int_bus_cpu  (bus),
    // .int_bus_fpga (bus_dma),
    // .dma_done     (dma_done)
// );

// localparam STREAMBUS_BASE_ADDR = AXI_HP_MASTER_BASE_ADDR + `AXI_HP_MASTER_FULL_SIZE;
// test_streambus#(
    // .BASEADDR     (STREAMBUS_BASE_ADDR),
    // .CHANNELS     (N_TCOM)
// ) TEST_STREAMBUS(
    // .bus           (bus_sl[2]),
    // .adc           (adc),
    // .stream_intbus (stream_intbus),
    // .fix_pulse     (fix_pulse)
// );

// localparam TRCV_BASE_ADDR = DMA_INTBUS_AXI_HP_BASE_ADDR + `DMA_INTBUS_AXI_HP_FULL_SIZE;

acp_test#(
    .BASEADDR (BASEADDR)
) acp_test_inst(
    .bus     (bus),
    .axi_acp (axi_acp)
);

assign axi_acp.arready = '1;
assign axi_acp.awready = '1;
assign axi_acp.wready  = '1;

reg [3:0]  latency_rlast;
always_ff@(posedge aclk or negedge aresetn)
if(aresetn == '0) begin
    latency_rlast <= '0;
end else begin
    latency_rlast <= {latency_rlast[2:0],axi_acp.arvalid & axi_acp.arready};
end

assign axi_acp.rlast = latency_rlast[3];
assign axi_acp.rvalid = '1;

trcv#(
    .BASEADDR        (BASEADDR + 1),
    .ADC_PORTS       (ADC_PORTS)
) TRCV(
    .bus           (bus_sl[1]),
    .adc           (adc),
    .imi           (imi),
    .core_clk      (core_clk),
    .fix_pulse     (), // out
    .irq           (), // out
    .pps_in        ('0),
    .pps_out       ()
);

endmodule
