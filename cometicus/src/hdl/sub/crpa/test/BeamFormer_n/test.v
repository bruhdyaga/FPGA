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
   integer fd_s[`BF_NN-1:0];
   integer s_cnt;

   reg [`BF_NN * `BF_A_WIDTH -1 : 0] s;

   genvar i;

   generate
      for (i=0; i<`BF_NN; i=i+1) begin:S
	 initial begin
	    fd_s[i] = $fopen($psprintf("tmp/s_%0d.txt", i+1), "r");
	 end
   
	 always @(posedge clk) begin
	    if (resetn == 1'b0) begin
	       s_cnt <= 0;
	    end else begin
	       s_cnt <= $fscanf(fd_s[i], "%d\n", s[(i+1)*`BF_A_WIDTH:i*`BF_A_WIDTH]);
	    end
	 end
      end // block: S
   endgenerate

   // ==== Чтение файла с коэффициентами ====
   integer fd_coefs;
   initial begin
      fd_coefs = $fopen("tmp/coefs.txt", "r");
   end

   reg [`BF_NN*`BF_B_WIDTH-1 : 0] coeff_concat;
   generate
      for (i=0; i<`BF_NN; i=i+1) begin:COEFS
	 initial begin
	    s_cnt <= $fscanf(fd_coefs, "%d\n", coeff_concat[(i+1)*`BF_B_WIDTH-1:i*`BF_B_WIDTH]);
	 end
      end
   endgenerate
   

   // ==== Обработка сигнала в тестируемом модуле ====
   parameter NN = `BF_NN;
   parameter BFO_width = `BF_A_WIDTH+`BF_B_WIDTH+(`CLOG2(`BF_NN));
   wire signed [BFO_width-1 : 0] out;

   BeamFormer_n
     #(
       .NN           (`BF_NN),
       .a_width      (`BF_A_WIDTH),
       .b_width      (`BF_B_WIDTH),
       .BFO_width    (BFO_width),
       .out_drop_lsb (0)
       )
   BF
     (
      .clk          (clk),           // Тактовый сигнал
      .resetn       (resetn),        // Сигнал сброса
      .we           (1'b1),          // Сигнал разрешения работы
      .argsA        (s),             // Обрабатываемый сигнал
      .argsB        (coeff_concat),  // Коэффициенты
      .bf_out       (out)            // Выход
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
