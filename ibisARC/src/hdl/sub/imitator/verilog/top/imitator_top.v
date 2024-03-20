`timescale 1ns / 1ps

`include "global_param.v"

module imitator_top();
	
    reg aclk = 0;
    reg pclk = 0;
    reg prog_reset = 0; 
    reg aresetn = 0;
	reg wr = 0;
	reg rd = 0;
	reg [`ADDR_WIDTH - 1 : 0] addr_reg = 0;
	reg [31 : 0] wdata = 0;
    reg intr_pulse = 0;
    reg fix_pulse = 0;
    reg [`IMI_OUTWIDTH - 1 : 0] I;
    reg [`IMI_OUTWIDTH - 1 : 0] Q; 
    reg [31 : 0] rdata; 
	
    imitator
    #(`CORR_BASE_ADDR + 32'h1A00) IMI (
        .clk            (aclk),
        .pclk           (pclk),
        .reset_n        (prog_reset & aresetn),    // [in]  Асинхронный резет с активным низким уровнем
        .wr_en          (wr),                      // [in]  Write Enable
        .rd_en          (rd),                      // [in]  Read Enable
        .reg_addr       (addr_reg),                // [in]  Шина адреса
        .wdata          (wdata),                   // [in]  Данные на запись
        .intr_pulse     (intr_pulse),              // [in]  Импульс прерывания
        .fix_pulse      (fix_pulse),               // [in]  Импульс снятия измерений
        .rdata          (rdata),                   // [out] Данные на чтение
        .I              (I),                       // [out] Синфазная составляюющая сигнала имитатора
        .Q              (Q)                        // [out] Квадратурная составляюющая сигнала имитатора         
    );

endmodule
