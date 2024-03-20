`timescale 1ns/1ns  // Лучше не менять, тест расчитан на 125 МГц

`include "CRPA_param.v"
`include "test_params.v"

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
   integer fd_s[`NFBF_NCH-1:0];
   integer s_cnt;

   reg [`NFBF_NCH * `NFBF_WIDTH -1 : 0] s;

   genvar i;
   generate
      for (i=0; i<`NFBF_NCH; i=i+1) begin:S
	 initial begin
	    fd_s[i] = $fopen($psprintf("tmp/s_%0d.txt", i+1), "r");
	 end
   
	 always @(posedge clk) begin
	    if (resetn == 1'b0) begin
	       s_cnt <= 0;
	    end else begin
	       s_cnt <= $fscanf(fd_s[i], "%d\n", s[(i+1)*`NFBF_WIDTH:i*`NFBF_WIDTH]);
	    end
	 end
      end // block: S
   endgenerate
   
   // ==== Чтение файла с коэффициентами ====
   integer fd_coefs;
   initial begin
      fd_coefs = $fopen("tmp/K_coefs.txt", "r");
   end

   reg [(`NFBF_NCH-1)*`NFBF_NT*`NFBF_NCFWIDTH-1 : 0] NF_coeff_concat;
   generate
      for (i=0; i<(`NFBF_NCH-1)*`NFBF_NT; i=i+1) begin:COEFS
	 initial begin
	    s_cnt <= $fscanf(fd_coefs, "%d\n", NF_coeff_concat[(i+1)*`NFBF_NCFWIDTH-1:i*`NFBF_NCFWIDTH]);
	 end
      end
   endgenerate
   

   // ==== Обработка сигнала в тестируемом модуле ====
   localparam NT          = `NFBF_NT ;                                 // Количество коэффициентов
   localparam NCH         = `NFBF_NCH;                                 // Количество входов
   localparam length      = NT - 1;                                  // Порядок КИХ-фильтра
   localparam LOG2_NT     = `CLOG2(NT);				     // Расширение разрядности в сумматоре, глубина дерева сумматора
   localparam KOUT_width  = `NFBF_WIDTH + `NFBF_NCFWIDTH + LOG2_NT;	     // Выходная разрядность сумматора КИХ-фильтра
   localparam LOG2_NCH    = `CLOG2(NCH);			     // Расширение разрядности в выходном сумматоре
   localparam NFSUM_width = KOUT_width + LOG2_NCH;		     // Выходная разрядность формирователя нулей

   localparam NFOUT_width = `NFBF_WIDTH;
   
   wire signed [NFOUT_width-1 : 0] NF_out [NCH-1:0];

   NFBF_wrapper
     #(
       .NCH          (`NFBF_NCH),
       .width        (`NFBF_WIDTH),
       .length       (length),
       .ncfwidth     (`NFBF_NCFWIDTH),
       .NBF          (`NFBF_NBF),
       .bcfwidth     (`NFBF_BCFWIDTH),
       .NFOUT_width  (NFOUT_width),
       .NKIX         (`NFBF_NCH-1)
       )
   NFBF
     (
      .clk               (clk),         // Тактовый сигнал
      .resetn            (resetn),      // Сигнал сброса
      .adc_concat        (s),           // Обрабатываемый сигнал

      .nf_load           (1'b1),        // Сигнал загрузки коэффициентов
      .bf_load           (1'b1),

      .cm_rd_data        (),	        // Интерфейс блока расчёта матрицы
      .cm_rd_addr        (),	
      .cm_macc_mod       (),
      .cm_macc_en        (),
      .cm_macc_ready     (),
      .cm_macc_div       (), //new
      .cm_mux_sel        (), //new

      .cvm_clkg          (),
      .cvm_rstg          (),

      .K0_concat         (NF_coeff_concat), // Векторы коэффициентов нульформера_0 длиной [(NCH-1)*(length+1)*ncfwidth]
      .K1_concat         (NF_coeff_concat),
      .K2_concat         (NF_coeff_concat),
      .K3_concat         (NF_coeff_concat),
      .K4_concat         (NF_coeff_concat),
      .K5_concat         (NF_coeff_concat),
      .K6_concat         (NF_coeff_concat),
      .K7_concat         (NF_coeff_concat),

      .BF_coeff_concat   (),		// Вектор коэффициентов для всех бимформеров длиной [bcfwidth * NBF * NCH]

      .nf_norm           ({1'b0, {(`NFBF_NCFWIDTH-1){1'b1}}}), //new
      .nf_shift          (`NFBF_NCFWIDTH'b0), //new
      
      .NF_out0           (NF_out[0][NFOUT_width-1 : 0]),
      .NF_out1           (NF_out[1][NFOUT_width-1 : 0]),
      .NF_out2           (NF_out[2][NFOUT_width-1 : 0]),
      .NF_out3           (NF_out[3][NFOUT_width-1 : 0]),
      .NF_out4           (NF_out[4][NFOUT_width-1 : 0]),
      .NF_out5           (NF_out[5][NFOUT_width-1 : 0]),
      .NF_out6           (NF_out[6][NFOUT_width-1 : 0]),
      .NF_out7           (NF_out[7][NFOUT_width-1 : 0]),

      .BF_out0           (),
      .BF_out1           (),
      .BF_out2           (),
      .BF_out3           (),
      .BF_out4           (),
      .BF_out5           (),
      .BF_out6           (),
      .BF_out7           (),
      .BF_out8           (),
      .BF_out9           (),
      .BF_out10          (),
      .BF_out11	         ()		

      
      );
   
   
   // ==== Запись результатов в файл ====
   integer     fd_out [NCH-1:0];
   generate
      for (i=0; i<NCH; i=i+1) begin:out_NF
	 
	 initial begin
	    fd_out[i] = $fopen($psprintf("tmp/out_NF_%0d.txt", i+1), "w");
	 end
	 
	 always @(posedge clk) begin
	    if (resetn!=1'b0) begin
   	       $fdisplay(fd_out[i], "%d", NF_out[i]);
	    end
	 end	  
      end // block: out_NF
   endgenerate
   
endmodule // tb
