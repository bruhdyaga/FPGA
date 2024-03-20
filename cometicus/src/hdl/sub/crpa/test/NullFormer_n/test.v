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
   integer fd_s[`NF_NCH-1:0];
   integer s_cnt;

   reg [`NF_NCH * `NF_WIDTH -1 : 0] s;

   genvar i;
   generate
      for (i=0; i<`NF_NCH; i=i+1) begin:S
	 initial begin
	    fd_s[i] = $fopen($psprintf("tmp/s_%0d.txt", i+1), "r");
	 end
   
	 always @(posedge clk) begin
	    if (resetn == 1'b0) begin
	       s_cnt <= 0;
	    end else begin
	       s_cnt <= $fscanf(fd_s[i], "%d\n", s[(i+1)*`NF_WIDTH:i*`NF_WIDTH]);
	    end
	 end
      end // block: S
   endgenerate
   
   // ==== Чтение файла с коэффициентами ====
   integer fd_coefs;
   initial begin
      fd_coefs = $fopen("tmp/coefs.txt", "r");
   end

   reg [(`NF_NCH-1)*`NF_NT*`NF_NCFWIDTH-1 : 0] coeff_concat;
   generate
      for (i=0; i<(`NF_NCH-1)*`NF_NT; i=i+1) begin:COEFS
	 initial begin
	    s_cnt <= $fscanf(fd_coefs, "%d\n", coeff_concat[(i+1)*`NF_NCFWIDTH-1:i*`NF_NCFWIDTH]);
	 end
      end
   endgenerate
   

   // ==== Обработка сигнала в тестируемом модуле ====
   localparam NT          = `NF_NT ;                                 // Количество коэффициентов
   localparam NCH         = `NF_NCH;                                 // Количество входов
   localparam length      = NT - 1;                                  // Порядок КИХ-фильтра
   localparam LOG2_NT     = `CLOG2(NT);				     // Расширение разрядности в сумматоре, глубина дерева сумматора
   localparam KOUT_width  = `NF_WIDTH + `NF_NCFWIDTH + LOG2_NT;	     // Выходная разрядность сумматора КИХ-фильтра
   localparam LOG2_NCH    = `CLOG2(NCH);			     // Расширение разрядности в выходном сумматоре
   localparam NFSUM_width = KOUT_width + LOG2_NCH;		     // Выходная разрядность формирователя нулей

   wire signed [NFSUM_width-1 : 0] out;

   NullFormer_n
     #(
       .DIRECT_CH    (`NF_DIRECT_CH),
       .NCH          (`NF_NCH),
       .width        (`NF_WIDTH),
       .ncfwidth     (`NF_NCFWIDTH),
       .length       (length),
       .NFO_width    (NFSUM_width),
       .NFSHIFT       (0),
       .NORM_width   (`NF_WIDTH)
       )
   NF
     (
      .clk           (clk),           // Тактовый сигнал
      .ena           (1'b1),          // Разрешение работы ena=1
      .resetn        (resetn),        // Сигнал сброса
      .norm          ({1'b0, {(`NF_NCFWIDTH-1){1'b1}}}),
      .nshift        (`NF_NCFWIDTH'b0),
      .adc_concat    (s),             // Обрабатываемый сигнал
      .coeffs_concat (coeff_concat),  // Коэффициенты фильтра
      .nf_out        (out)            // Выход фильтра
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
