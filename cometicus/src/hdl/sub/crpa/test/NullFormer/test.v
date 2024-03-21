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
   integer fd_s[`NF_NCH-1:0];
   integer s_cnt;

   reg [`NF_NCH * `NF_INPUT_WIDTH -1 : 0] s;

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
	       s_cnt <= $fscanf(fd_s[i], "%d\n", s[(i+1)*`NF_INPUT_WIDTH:i*`NF_INPUT_WIDTH]);
	    end
	 end
      end // block: S
   endgenerate
   
   // ==== Чтение файла с коэффициентами ====
   integer fd_coefs;
   initial begin
      fd_coefs = $fopen("tmp/coefs.txt", "r");
   end

   reg [(`NF_NCH-1)*`NF_NT*`NF_COEFF_WIDTH-1 : 0] coeff_concat;
   generate
      for (i=0; i<(`NF_NCH-1)*`NF_NT; i=i+1) begin:COEFS
	 initial begin
	    s_cnt <= $fscanf(fd_coefs, "%d\n", coeff_concat[(i+1)*`NF_COEFF_WIDTH-1:i*`NF_COEFF_WIDTH]);
	 end
      end
   endgenerate
   

   // ==== Обработка сигнала в тестируемом модуле ====
   localparam LOG2_NT     = log2(`NF_NT);
   localparam LOG2_NCH    = log2(`NF_NCH);
   localparam out_width   = `NF_INPUT_WIDTH + `NF_COEFF_WIDTH + LOG2_NT + LOG2_NCH;  // Выходная разрядность сумматора КИХ-фильтра

   wire signed [out_width-1 : 0] out;

   NullFormer
     #(
       .NCH          (`NF_NCH),
       .DIRECT_CH    (`NF_DIRECT_CH),
       .NT           (`NF_NT),
       .input_width  (`NF_INPUT_WIDTH),
       .coeff_width  (`NF_COEFF_WIDTH)
       )
   NF
     (
      .clk           (clk),           // Тактовый сигнал
      .resetn        (resetn),        // Сигнал сброса
      .ena           (1'b1),          // Разрешение работы ena=1
      .data_in       (s),             // Обрабатываемый сигнал
      .coeffs_concat (coeff_concat),  // Коэффициенты фильтра
      .data_out      (out)            // Выход фильтра
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
