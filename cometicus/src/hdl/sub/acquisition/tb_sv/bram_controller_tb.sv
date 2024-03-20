`timescale 1ns/10ps

`include "bram_controller.svh"

module bram_controller_tb();

`define aclk_freq     59
`define rf_clk_freq   125
`define core_clk_freq 81

localparam BRAM_CONTROLLER_ID = 32'h11222233;
localparam BRAM_DEPTH = 1024;
localparam BASEADDR   = 32'h40000000;

localparam CORE_ID_OFFSET       = 0;
localparam CORE_SIZE_OFFSET     = 1;
localparam CORE_CONTROL_OFFSET  = 2;
localparam CORE_RD_ADDR_OFFSET  = 3;
localparam CORE_RD_DEPTH_OFFSET = 4;
localparam RF_ID_OFFSET         = 5;
localparam RF_SIZE_OFFSET       = 6;
localparam RF_CONTROL_OFFSET    = 7;
localparam RF_WR_DEPTH_OFFSET   = 8;
localparam RF_RAM_DEPTH_OFFSET  = 9;



reg aclk     = 1;
reg rf_clk   = 1;
reg core_clk = 1;
reg resetn   = 1;

always #((1000/`aclk_freq)/2)     aclk     = !aclk;
always #((1000/`rf_clk_freq)/2)   rf_clk   = !rf_clk;
always #((1000/`core_clk_freq)/2) core_clk = !core_clk;

initial begin
#20  resetn = 1'b0;
#100 resetn = 1'b1;
end


intbus_interf bus_master();
logic [31:0] rdata;
assign bus_master.baseaddr = BASEADDR/4;
assign bus_master.clk      = aclk;
assign bus_master.resetn   = resetn;

initial begin
bus_master.init;

begin // чтение ID
    bus_master.readReg(BASEADDR/4,RF_ID_OFFSET,rdata);
    forever begin
        $display ("%7gns wait bus constant", $time);
        bus_master.readReg(BASEADDR/4,RF_ID_OFFSET,rdata);
        if(rdata[15:0] == `BRAM_CONTROLLER_ID_CONST) break;
    end//ресет завершен, датаколлектор готов
    $display ("%7gns bus constant OK!", $time);
end

bus_master.readReg(BASEADDR/4,RF_RAM_DEPTH_OFFSET,rdata);// чтение объема памяти блока поиска
$display ("%7gns DEPTH : %d", $time, rdata);

begin // запись выборки в память
    bus_master.writeReg(BASEADDR/4,RF_WR_DEPTH_OFFSET,32);// указали объем записи выборки в память
    bus_master.writeReg(BASEADDR/4,RF_CONTROL_OFFSET,1);// импульс на старт записи выборки
    begin // ожидание завершения записи выборки
        bus_master.readReg(BASEADDR/4,RF_CONTROL_OFFSET,rdata);
        forever begin
            // $display ("%7gns waiting end of write bram", $time);
            bus_master.readReg(BASEADDR/4,RF_CONTROL_OFFSET,rdata);
            if(rdata[1] == 1'b1) break;
        end//ресет завершен, датаколлектор готов
        $display ("%7gns write bram COMPLETE 1!", $time);
    end
end

// берем, да и перетераем выборку
begin // запись выборки в память
    bus_master.writeReg(BASEADDR/4,RF_WR_DEPTH_OFFSET,128);// указали объем записи выборки в память
    bus_master.writeReg(BASEADDR/4,RF_CONTROL_OFFSET,1);// импульс на старт записи выборки
    begin // ожидание завершения записи выборки
        bus_master.readReg(BASEADDR/4,RF_CONTROL_OFFSET,rdata);
        forever begin
            // $display ("%7gns waiting end of write bram", $time);
            bus_master.readReg(BASEADDR/4,RF_CONTROL_OFFSET,rdata);
            if(rdata[1] == 1'b1) break;
        end//ресет завершен, датаколлектор готов
        $display ("%7gns write bram COMPLETE 2!", $time);
    end
end

begin // чтение выборки из памяти
    bus_master.writeReg(BASEADDR/4,CORE_RD_ADDR_OFFSET,0);// старторвый адрес чтения
    bus_master.writeReg(BASEADDR/4,CORE_RD_DEPTH_OFFSET,32);// указали объем чтения
    bus_master.writeReg(BASEADDR/4,CORE_CONTROL_OFFSET,1);// импульс на старт чтения выборки
    begin // ожидание завершения записи выборки
        bus_master.readReg(BASEADDR/4,CORE_CONTROL_OFFSET,rdata);
        forever begin
            // $display ("%7gns waiting end of read bram", $time);
            bus_master.readReg(BASEADDR/4,CORE_CONTROL_OFFSET,rdata);
            if(rdata[1] == 1'b1) break;
        end//ресет завершен, датаколлектор готов
        $display ("%7gns read bram COMPLETE 1!", $time);
    end
end

begin // чтение выборки из памяти #2
    bus_master.writeReg(BASEADDR/4,CORE_RD_ADDR_OFFSET,1);// старторвый адрес чтения
    bus_master.writeReg(BASEADDR/4,CORE_RD_DEPTH_OFFSET,32);// указали объем чтения
    bus_master.writeReg(BASEADDR/4,CORE_CONTROL_OFFSET,1);// импульс на старт чтения выборки
    begin // ожидание завершения записи выборки
        bus_master.readReg(BASEADDR/4,CORE_CONTROL_OFFSET,rdata);
        forever begin
            // $display ("%7gns waiting end of read bram", $time);
            bus_master.readReg(BASEADDR/4,CORE_CONTROL_OFFSET,rdata);
            if(rdata[1] == 1'b1) break;
        end//ресет завершен, датаколлектор готов
        $display ("%7gns read bram COMPLETE 2!", $time);
    end
end

begin // чтение выборки из памяти #3
    bus_master.writeReg(BASEADDR/4,CORE_RD_ADDR_OFFSET,2);// старторвый адрес чтения
    bus_master.writeReg(BASEADDR/4,CORE_RD_DEPTH_OFFSET,32);// указали объем чтения
    bus_master.writeReg(BASEADDR/4,CORE_CONTROL_OFFSET,1);// импульс на старт чтения выборки
    begin // ожидание завершения записи выборки
        bus_master.readReg(BASEADDR/4,CORE_CONTROL_OFFSET,rdata);
        forever begin
            // $display ("%7gns waiting end of read bram", $time);
            bus_master.readReg(BASEADDR/4,CORE_CONTROL_OFFSET,rdata);
            if(rdata[1] == 1'b1) break;
        end//ресет завершен, датаколлектор готов
        $display ("%7gns read bram COMPLETE 3!", $time);
    end
end

end


reg [2:0] wr_cntr;
always@(posedge rf_clk or negedge resetn)
if(resetn == 0)
    wr_cntr <= 0;
else
    wr_cntr <= wr_cntr + 1'b1;

assign we_sum = wr_cntr == 1;

reg [3:0] data_cntr;
reg [3:0] data_cntr_read;
always@(posedge rf_clk or negedge resetn)
if(resetn == 0)
    data_cntr <= 0;
else if(we_sum)
    data_cntr <= data_cntr + 1'b1;



bram_controller
#(
    .DEPTH      (BRAM_DEPTH)
) bram_controller_inst(
    .rf_clk      (rf_clk),
    .core_clk    (core_clk),
    .rf_resetn   (resetn),
    .core_resetn (resetn),
    .I_sum_sig   (data_cntr[0]),
    .I_sum_mag   (data_cntr[1]),
    .Q_sum_sig   (data_cntr[2]),
    .Q_sum_mag   (data_cntr[3]),
    .we_sum      (we_sum),
    .I_mem_sig   (data_cntr_read[0]),
    .I_mem_mag   (data_cntr_read[1]),
    .Q_mem_sig   (data_cntr_read[2]),
    .Q_mem_mag   (data_cntr_read[3]),
    .valid       (valid),
    .timegen_wr  (timegen_wr),
    .bus         (bus_master)
);

endmodule