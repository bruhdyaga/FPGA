`timescale 1ns/10ps

`include "global_param.v"

module multi_cpu_tb();

localparam CPU_NUM = 10;
localparam N_REGS  = 16;

`define aclk_freq     150  // MHz

reg aclk = 1;

localparam NBUSES = 2;
axi3_interface  axi3[CPU_NUM]();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus[CPU_NUM]();

always #((1000/`aclk_freq)/2) aclk <= !aclk;

typedef struct packed {
    logic [N_REGS-1:0][31:0] REG;
} REGFILE;

for(genvar i = 0; i < CPU_NUM; i = i + 1) begin
    cpu_sim#(
        .ID (i)
    ) cpu_sim_inst(
        .aclk   (aclk),
        .axi3   (axi3[i])
    );
    
    axi3_to_inter#(
        .ADDR_WIDTH (`ADDR_WIDTH)
    )axi3_to_inter_inst(
        .axi3    (axi3[i]),
        .int_bus (bus[i])
    );
    
    regs_file#(
        .BASEADDR (0),
        .ID       ('hABCD),
        .DATATYPE (REGFILE)
    ) regs_file_acq_ip_tb_inst(
        .clk    (),
        .bus    (bus[i]),
        .in     (),
        .out    (),
        .pulse  (),
        .wr     (),
        .rd     ()
    );
end

// ACQ_IP_TB_STRUCT PL;
// ACQ_IP_TB_STRUCT PS;

endmodule