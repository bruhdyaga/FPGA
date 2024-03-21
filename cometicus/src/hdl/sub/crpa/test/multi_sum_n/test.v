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
   integer fd_s[`MSUM_NS-1:0];
   integer s_cnt;

   reg [`MSUM_NS * `MSUM_WIDTH -1 : 0] s;

   genvar i;

   generate
      for (i=0; i<`MSUM_NS; i=i+1) begin:S
	 initial begin
	    fd_s[i] = $fopen($psprintf("tmp/s_%0d.txt", i+1), "r");
	 end
	 
	 always @(posedge clk) begin
	    if (resetn == 1'b0) begin
	       s_cnt <= 0;
	    end else begin
	       s_cnt <= $fscanf(fd_s[i], "%d\n", s[(i+1)*`MSUM_WIDTH:i*`MSUM_WIDTH]);
	    end
	 end
      end // block: S
   endgenerate

   // ==== Обработка сигнала в тестируемом модуле ====
   parameter NS = `MSUM_NS;
   parameter tree_width = `CLOG2(`MSUM_NS); 
   parameter BFO_width = `MSUM_WIDTH+(`CLOG2(`MSUM_NS));
   wire signed [BFO_width-1 : 0] out;

   localparam log2_in = `CLOG2(`MSUM_NS);
   localparam NS2 = 2**log2_in;
   localparam NZeros = NS2*`MSUM_WIDTH - `MSUM_NS*`MSUM_WIDTH;

   wire [NS2*`MSUM_WIDTH-1:0] 	 s_concat;
 
   if (NZeros > 0) begin  
      reg [NZeros*`MSUM_WIDTH - 1 : 0] conc_zeros; 
      always @(posedge clk or negedge resetn)
	if (!resetn)
	  conc_zeros <= {NZeros*`MSUM_WIDTH{1'b0}};
	else
	  conc_zeros <= {NZeros*`MSUM_WIDTH{1'b0}};

	assign s_concat = {conc_zeros, s};
     end else begin
	assign s_concat = s;
   end
   
   multi_sum_n
     #(
       .N_args              (NS2),
       .in_width            (`MSUM_WIDTH),
       .sum_conv_tree_width (tree_width) //,       .out_width    (BFO_width)
       )
   BF
     (
      .clk          (clk),           // Тактовый сигнал
      .resetn       (resetn),        // Сигнал сброса
      .args_in      (s_concat),             // Обрабатываемый сигнал
      .sum_out      (out),            // Выход
      .we           (1'b1),
      .valid        ()
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
