`timescale 1ns/1ns  // Лучше не менять, тест расчитан на 125 МГц

`include "test_params.v"
`include "CRPA_param.v"

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

   reg signed [`FIR_WIDTH-1:0] s;
   always @(posedge clk) begin
      if (resetn == 1'b0) begin
	 s_cnt <= 0;
      end else begin
	 s_cnt <= $fscanf(fd_s, "%d\n", s);
      end
   end

   // ==== Чтение файла с коэффициентами ====
   integer fd_coefs;
   initial begin
      fd_coefs = $fopen("tmp/coefs.txt", "r");
   end

   reg [`FIR_NT*`FIR_NCFWIDTH-1 : 0] coeff_concat;
   genvar  i;
   generate
      for (i=0; i<`FIR_NT; i=i+1) begin:COEFS
	 initial begin
	    s_cnt <= $fscanf(fd_coefs, "%d\n", coeff_concat[(i+1)*`FIR_NCFWIDTH-1:i*`FIR_NCFWIDTH]);
	 end
      end
   endgenerate
   

   // ==== Обработка сигнала в тестируемом модуле ====
   localparam NT         = `FIR_NT;                                 // Количество коэффициентов
   localparam length     = NT - 1;                                      // Порядок КИХ-фильтра
   localparam LOG2_NT    = `CLOG2(NT);					// Расширение разрядности в сумматоре, глубина дерева сумматора
   localparam KOUT_width = `FIR_NCFWIDTH + `FIR_WIDTH + LOG2_NT;	// Выходная разрядность сумматора

   wire signed [KOUT_width-1 : 0] out;

   kix_filter_n 
     #(
       .width       (`FIR_WIDTH),
       .ncfwidth    (`FIR_NCFWIDTH),
       .length      (length)
       )
   filter
     (
      .clk          (clk),           // Тактовый сигнал
      .ena          (1'b1),          // Разрешение работы ena=1
      .resetn       (resetn),        // Сигнал сброса
      .data_in      (s),             // Обрабатываемый сигнал
      .coeff_concat (coeff_concat),  // Коэффициенты фильтра
      .delays       (),	             // Выход линии задержки
      .kix_out      (out)            // Выход фильтра
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
