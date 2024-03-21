`timescale 1ns/1ns  // Лучше не менять, тест расчитан на 125 МГц

`include "test_params.v"

module tb();
`include "math.v"
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
   integer fd_s[`BF_NCH-1:0];
   integer s_cnt;

   reg [`BF_NCH * `BF_INPUT_WIDTH -1 : 0] s;

   genvar i;

   generate
      for (i=0; i<`BF_NCH; i=i+1) begin:S
	 initial begin
	    fd_s[i] = $fopen($psprintf("tmp/s_%0d.txt", i+1), "r");
	 end
   
	 always @(posedge clk) begin
	    if (resetn == 1'b0) begin
	       s_cnt <= 0;
	    end else begin
	       s_cnt <= $fscanf(fd_s[i], "%d\n", s[(i+1)*`BF_INPUT_WIDTH:i*`BF_INPUT_WIDTH]);
	    end
	 end
      end // block: S
   endgenerate

   // ==== Чтение файла с коэффициентами ====
   integer fd_coefs;
   initial begin
      fd_coefs = $fopen("tmp/coefs.txt", "r");
   end

   reg [`BF_NCH*`BF_COEFF_WIDTH-1 : 0] coeff_concat;
   generate
      for (i=0; i<`BF_NCH; i=i+1) begin:COEFS
	 initial begin
	    s_cnt <= $fscanf(fd_coefs, "%d\n", coeff_concat[(i+1)*`BF_COEFF_WIDTH-1:i*`BF_COEFF_WIDTH]);
	 end
      end
   endgenerate
   

   // ==== Обработка сигнала в тестируемом модуле ====
   parameter NN = `BF_NCH;
   parameter BFO_width = `BF_INPUT_WIDTH+`BF_COEFF_WIDTH+(log2(`BF_NCH));
   wire signed [BFO_width-1 : 0] out;

   BeamFormer
     #(
       .NCH           (`BF_NCH),
       .input_width   (`BF_INPUT_WIDTH),
       .coeff_width   (`BF_COEFF_WIDTH)
       )
   BF
     (
      .clk            (clk),           // Тактовый сигнал
      .resetn         (resetn),        // Сигнал сброса
      .ena            (1'b1),          // Сигнал разрешения работы
      .data_in        (s),             // Обрабатываемый сигнал
      .coeff          (coeff_concat),  // Коэффициенты
      .data_out       (out)            // Выход
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
