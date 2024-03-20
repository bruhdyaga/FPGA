`timescale 1ns / 1ps

module data_sync_tb();

parameter WIDTH = 8;


reg sclk = 0;
reg dclk = 0;
reg start = 0;
reg [WIDTH-1:0] data = 'b1010;

//reg busy = 0;   //Для запуска моделирования необходимо задать
//reg sync = 0;   //начальные состояния для регистров
//reg dly_sync_s = 0;
//reg dly_sync_d = 0;

wire ready;
wire [WIDTH-1:0] sync_data; 

always #23 sclk = !sclk;
always #37 dclk = !dclk;

initial begin

@(posedge sclk)
    start <= 1'b1;
@(posedge sclk)
    start <= 1'b0;   
    
end

data_sync#
(
    .WIDTH       (WIDTH)
) 
DATA_SYNC
(
    .sclk      (sclk),
    .dclk      (dclk),
    .start     (start),
    .data      (data),
    .ready     (ready),
    .sync_data (sync_data)
);

endmodule
