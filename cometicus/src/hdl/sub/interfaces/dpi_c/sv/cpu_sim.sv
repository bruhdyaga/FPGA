module cpu_sim
#(
    parameter ID = 0
)
(
    input aclk,
    axi3_interface.master axi3
);

assign axi3.aclk   = aclk;

export "DPI-C" task waitClks;
export "DPI-C" task readReg;
export "DPI-C" task writeReg;
export "DPI-C" task get_sim_time_sv;
import "DPI-C" context task C_cpu_sim (input int);

initial begin
$display("ID[%0d] %0t", ID, $stime);
    Init;
    
    @ (posedge axi3.aclk);
    @ (posedge axi3.aclk);
    @ (posedge axi3.aclk);
    C_cpu_sim(ID);
end

typedef struct {
  bit [4:1][0:7] data;
} burst_data;


task Init;
    axi3.araddr  <= 0;
    axi3.arburst <= 0;
    axi3.arcache <= 0;
    axi3.arid    <= 0;
    axi3.arlen   <= 0;
    axi3.arlock  <= 0;
    axi3.arprot  <= 0;
    axi3.arqos   <= 0;
    axi3.arsize  <= 0;
    axi3.arvalid <= 0;
    axi3.awaddr  <= 0;
    axi3.awburst <= 0;
    axi3.awcache <= 0;
    axi3.awid    <= 0;
    axi3.awlen   <= 0;
    axi3.awlock  <= 0;
    axi3.awprot  <= 0;
    axi3.awqos   <= 0;
    axi3.awsize  <= 0;
    axi3.awvalid <= 0;
    axi3.bready  <= 0;
    axi3.rready  <= 0;
    axi3.wdata   <= 0;
    axi3.wid     <= 0;
    axi3.wlast   <= 0;
    axi3.wstrb   <= 0;
    axi3.wvalid  <= 0;
    
endtask

task waitClks
(
    input int numclks
);
// $display("waitClks ID[%0d] = %d clock %0t", ID, numclks, $stime);
    repeat (numclks) begin
        @(posedge aclk);
    end
endtask

// Register read
task readReg
(
    input  int unsigned base,
    input  int offset,
    input  int burst_len, // Burst_Length = burst_len[3:0] + 1
    output int unsigned rdata [16],
    output int stime
);
    int i;
    for(i=0;i<16;i=i+1) begin
        rdata[i] <= 0;
    end
    i = 0;
    // $display("readReg ID[%0d] %0t", ID, $stime);
    
    axi3.araddr  <= base + offset;
    axi3.arlen   <= burst_len[3:0];
    axi3.arvalid <= 1;
    @ (posedge axi3.aclk);
    while(axi3.arready != 1'b1) begin
        @ (posedge axi3.aclk);
    end
    axi3.araddr  <= 0;
    axi3.arlen   <= 0;
    axi3.arvalid <= 0;
    
    axi3.rready  <= 1;
    
    while(axi3.rlast != 1'b1) begin
        if(axi3.rvalid) begin
            rdata[i] <= axi3.rdata;
            i = i + 1;
        end
        @ (posedge axi3.aclk);
    end
    rdata[i] <= axi3.rdata;
    
    stime <= $stime;
    axi3.rready  <= 0;
    @ (posedge axi3.aclk);

endtask

task writeReg
(
    input int unsigned base,
    input int    offset,
    input int    burst_len, // Burst_Length = burst_len[3:0] + 1
    input int    val [16],
    output int stime
);
// $display("writeReg ID[%0d] %0t", ID, $stime);
    
    axi3.wlast   <= 0;
    axi3.bready  <= 0;
    
    axi3.awaddr  <= base + offset;
    axi3.awlen   <= burst_len;
    axi3.awvalid <= 1;
    axi3.bready  <= 1;
    @ (posedge axi3.aclk);
    while(axi3.awready != 1'b1) begin
        @ (posedge axi3.aclk);
    end
    axi3.awaddr  <= 0;
    axi3.awlen   <= 0;
    axi3.awvalid <= 0;
    
    axi3.wvalid  <= 1;
    for(int i = 0;i <= burst_len;i ++) begin
        if(i == burst_len)
            axi3.wlast <= 1;
        
        axi3.wdata <= val[i];
        @ (posedge axi3.aclk);
        while(axi3.wready != 1'b1) begin
            @ (posedge axi3.aclk);
        end
    end
    axi3.wdata   <= 0;
    axi3.wvalid  <= 0;
    axi3.wlast   <= 0;
    
    @ (posedge axi3.aclk);
    while(axi3.bvalid != 1'b1) begin
        @ (posedge axi3.aclk);
    end
    axi3.bready  <= 0;
    stime = $stime;
    @ (posedge axi3.aclk);

endtask

task get_sim_time_sv
(
    output int stime
);

    stime = $stime;
endtask

endmodule