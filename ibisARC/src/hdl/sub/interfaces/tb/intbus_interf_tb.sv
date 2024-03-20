`timescale 1ns/10ps

`include "intbus_interf_tb_struct.svh"

module intbus_interf_tb();

localparam BASEADDR_BYTE  = 32'h40000000;
localparam CLK_FREQ    = 100e6; //MHz
localparam CPU_FREQ    = 59e6;  //MHz
localparam INST = 16'h1;

reg clk = 1;
reg aclk = 1;
reg resetn;

// assign bus_master.baseaddr = BASEADDR/4;


always #(1e9/CLK_FREQ/2) clk  = !clk;
always #(1e9/CPU_FREQ/2) aclk = !aclk;



parameter N_BUSES = 1;

intbus_interf master_bus();
intbus_interf hub_bus[N_BUSES]();

assign master_bus.clk        = aclk;
assign master_bus.resetn     = resetn;
assign master_bus.baseaddr   = BASEADDR_BYTE/4;

initial begin
     resetn = 1'b1;
#30  resetn = 1'b0;
#100 resetn = 1'b1;
end

initial begin
@(negedge resetn);
@(posedge resetn);


master_bus.readReg(BASEADDR_BYTE/4,0);


master_bus.writeReg(BASEADDR_BYTE/4,1,32'h12345678);
master_bus.readReg(BASEADDR_BYTE/4,1);

end

connectbus#(
    .N_BUSES    (N_BUSES),
    .DATA_WIDTH (32),
    .OUTFF      ("n")
) CB(
    .master_bus (master_bus),
    .slave_bus  (hub_bus),
    .clk        (1'b0),
    .resetn     (1'b0)
);

REGFILE REG_in;   // The registers to read from the CPU
REGFILE REG_out;  // The registers to write by the CPU

localparam logic [7 : 0] SYNC [(($bits(REGFILE)+1)/32) - 1 : 0] = '{"n", "n"};

// Initial value of the registers
localparam REGFILE INIT = '{
    ID_INST:'{
        ID     : `REGFILE_ID_CONST,
        INST   : '0
    },
    RW   : '0
};

regs_file#(
    .DATATYPE (REGFILE),
    .SYNC     (SYNC),
    .INIT     (INIT)
) regs_file_0_inst(
    .clk    (clk),
    .resetn (resetn),
    .bus    (hub_bus[0]),
    .in     (REG_in),   // Data from logic to bus
    .out    (REG_out)    // Data from bus to logic
);

assign REG_in = REG_out;

endmodule