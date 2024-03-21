`timescale 1ns/1ns  // Лучше не менять, тест расчитан на 125 МГц

`include "test_params.v"
`include "math.v"

module tb();
   // ==== Клоки, ресеты ====
   reg clk = 1'b0;
   reg resetn;

   always #4 clk=!clk;   // 125 МГц
   
   initial begin
      resetn = 0;
      #8                 // 2 CLK
      resetn = 1;
      
   end


   // ==== Чтение входного сигнала из файла ====
   integer fd_s, s_cnt;
   initial begin
      fd_s = $fopen("tmp/s.txt", "r");
   end

   reg signed [`WDC_width-1:0] s;
   always @(posedge clk) begin
      // if (resetn == 1'b0) begin
      // 	 s_cnt <= 0;
      // end else begin
	 s_cnt <= $fscanf(fd_s, "%d\n", s);
      // end
   end


   // ==== Обработка сигнала в тестируемом модуле ====
   wire signed [`WDC_width-1 : 0] out;
   wire 			  valid;
   
   wipe_dc
     #(
       .width      (`WDC_width),
       .tau        (`WDC_tau)
       )
   WDC
     (
      .clk          (clk),           // Тактовый сигнал
      .resetn       (resetn),        // Сигнал сброса
      .ena          (1'b1),          // Разрешение работы ena=1
      .data_in      (s),             // Обрабатываемый сигнал
      .data_out     (out),           // Выход фильтра
      .valid        (valid)          // Сигнал готовности
      );
   
   
   // ==== Запись результатов в файл ====
   integer     fd_out;
   initial begin
      fd_out = $fopen("tmp/out.txt", "w");
   end
   
   always @(posedge clk) begin
      if (resetn!=1'b0) begin
   	 $fdisplay(fd_out, "%d", out);
      end
   end	  
		 
   
endmodule // tb
