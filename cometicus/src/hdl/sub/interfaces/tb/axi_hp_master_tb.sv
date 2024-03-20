`timescale 1ns/10ps

`include "corr_ch.svh"

`define aclk_freq     100    // MHz
`define pclk_freq     105.6  // MHz

module axi_hp_master_tb();

localparam AXI_HP_MASTER_BASE = 32'h40180000/4;
localparam HUB_BASE           = 32'h40000000/4;
localparam CHANNELS           = 10;

localparam BASECORRCH = HUB_BASE + `HUBSIZE;
localparam ENDCORRCH  = BASECORRCH + CHANNELS * `CORR_CH_FULL_SIZE - 1;

logic [31:0] rdata;
reg aclk  = 1;
reg pclk  = 1;

always #((1000/`aclk_freq)/2)     aclk     <= !aclk;
always #((1000/`pclk_freq)/2)     pclk     <= !pclk;

intbus_interf    bus();
intbus_interf    bus_m();
axi_hp_interface axi_hp();
intbus_interf    bus_sl[CHANNELS]();

// ADC interface
adc_interf#(
    .PORTS (1),
    .R     (2)
)adc ();

assign adc.clk = pclk;

always@(posedge adc.clk or negedge adc.resetn)
if(adc.resetn == '0)
    adc.data[0] <= '0;
else
    adc.data[0] <= {$random,$random};

level_sync ADC_RESETN(
    .clk     (adc.clk),
    .reset_n (bus.resetn),
    .async   (bus.resetn),
    .sync    (adc.resetn)
);

initial begin
    bus.resetn = '1;
    init;
    waitClks(5);
    bus.resetn = '0;
    waitClks(5);
    bus.resetn = '1;
end

assign bus.clk = aclk;

always@(posedge bus.resetn) begin
    
    readReg(AXI_HP_MASTER_BASE,0,rdata);

    writeReg(AXI_HP_MASTER_BASE,2,((ENDCORRCH & 16'hFFFF) << 16) | (BASECORRCH & 16'hFFFF));
    writeReg(AXI_HP_MASTER_BASE,1,1);
end

axi_hp_master#(
    .BASEADDR (AXI_HP_MASTER_BASE)
) AXI_HP_MASTER(
    .axi_hp     (axi_hp),
    .int_bus_m  (bus_m),
    .int_bus_s  (bus)
);

connectbus#(
    .BASEADDR   (HUB_BASE),
    .N_BUSES    (CHANNELS),
    .OUTFF      ("y")
) connectbus_inst(
    .master_bus (bus_m),
    .slave_bus  (bus_sl)
);

for(genvar ch=0; ch<CHANNELS; ch++) begin: CORR_GEN
    corr_ch#(
        .BASEADDR   (BASECORRCH + ch * `CORR_CH_FULL_SIZE)
    ) CORR_CH(
        .bus        (bus_sl[ch]),
        .adc        (adc),
        .fix_pulse  ('1),
        .irq_pulse  ('1),
        .chip_pulse (),
        .bdss_psp   ('0)
    );
end

// always_ff@(posedge bus.clk or negedge bus.resetn)
// if(bus.resetn == '0) begin
    // axi_hp_0.wready <= '0;
// end else begin
        // axi_hp_0.wready <= !axi_hp_0.wready;
// end

// always_ff@(posedge bus.clk or negedge bus.resetn)
// if(bus.resetn == '0) begin
    // axi_hp_0.awready <= '0;
// end else begin
        // axi_hp_0.awready <= !axi_hp_0.awready;
// end

`ifndef SYNTHESIS
    task init ();
        bus.rd <= 0;
        bus.wr <= 0;
        bus.addr <= 0;
    endtask    
    
    // Delay
    task waitClks (input integer numclks);
        repeat (numclks) begin
            @(posedge bus.clk);
        end
    endtask
    
    // Register read
    task readReg
    (
        input  integer base,
        input  integer offset,
        output logic [32 - 1 : 0] data_out
    );
        
        reg [32 - 1 : 0]     val;
        
        @(posedge bus.clk);
        bus.addr = bus.resetn ? base + offset : '0;
        bus.rd <= bus.resetn ? '1 : 0;
        @(negedge bus.clk);
        if(bus.rvalid == '1) begin
            data_out <= bus.rdata;
            @(posedge bus.clk);
            bus.rd <= 0;
        end else begin
            @(posedge bus.clk);
            bus.rd <= 0;
            while(bus.rvalid != '1) begin
                @(negedge bus.clk);
            end
            data_out <= bus.rdata;
        end
        
    endtask
    
    task writeReg
    (
        input integer    base,
        input integer    offset,
        input reg [32 - 1 : 0] val
    );
        
        @ (posedge bus.clk);
        bus.addr = bus.resetn ? base + offset : '0;
        bus.wdata = bus.resetn ? val : '0;
        bus.wr <= bus.resetn ? 1 : 0;
        @ (posedge bus.clk);
        bus.wr <= 0;
        
    endtask
`endif

assign axi_hp.arready = '0;
assign axi_hp.awready = '1;
assign axi_hp.bid     = '0;
assign axi_hp.bresp   = '0;
assign axi_hp.bvalid  = '0;
assign axi_hp.rdata   = '0;
assign axi_hp.rid     = '0;
assign axi_hp.rlast   = '0;
assign axi_hp.rresp   = '0;
assign axi_hp.rvalid  = '0;
assign axi_hp.wready  = '1;

endmodule