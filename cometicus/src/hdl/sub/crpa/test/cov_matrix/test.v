`timescale 1ns/1ns  // Лучше не менять, тест расчитан на 125 МГц

`include "test_params.v"

module tb();
    // ==== Клоки ====
    reg clk = 1'b0;
    always 
        #4 clk=!clk;   // 125 МГц
   
    // ==== Ресеты ====
    reg resetn = 1'b0;
    event reset;
    event resetDone;
    initial begin
        forever begin
            @ (reset)
            @ (negedge clk)
            resetn = 0;
            @ (negedge clk)
            resetn = 1;
            ->resetDone;
        end
    end

   // ==== Чтение входного сигнала из файла ====
   reg launch_sgn = 1'b0;
   
   integer fd_s[`CVM_NCH-1:0];
   integer s_cnt;
   integer Sin[`CVM_NCH-1:0];

   reg [`CVM_NCH * `CVM_WIDTH -1 : 0] s = 0;

    genvar i;
    generate
        for (i=0; i<`CVM_NCH; i=i+1) begin:S
            initial begin : file_read
                reg[1000*8:0] filename;
                $sformat(filename, "%s/s_%0d.txt", `TMPPATH, i+1);
                fd_s[i] = $fopen(filename, "r");
            end
            
            always @(posedge clk) begin
                if ((launch_sgn == 1'b0)) begin
                    s_cnt <= 0;
                end else begin
                    if (s_cnt == 0) begin
                        s_cnt <= 1; // Задержка в такт
                    end else begin
                        s_cnt = $fscanf(fd_s[i], "%d\n", Sin[i]);
                        s[(i+1)*`CVM_WIDTH - 1:i*`CVM_WIDTH] = Sin[i];
                    end
                end
            end
        end // block: S
    endgenerate
   

    // ==== Параметры ====
    localparam integer NT          = `CVM_NT ;                                // Глубина по времени
    localparam integer NCH         = `CVM_NCH;                                // Количество входных сигналов (антенн)
    localparam integer MSIZE       = NT * NCH;                                // Размер матрицы
    localparam integer INW         = `CVM_WIDTH;                              // Разрядность сигналов на входе
    localparam integer NSTAT       = `CVM_NSTAT;                              // Размер статистики
    localparam integer ELEMENTS    = (MSIZE*MSIZE + MSIZE)/2;                 // Сколько рассчитываемых элементов в матрице (диагональ и всё что ниже)
    localparam integer MODE        = `CVM_MODE;                               // Режим мультиплексоров входного сигнала
    localparam integer STARTDELAY  = `CVM_STARTDELAY;                         // Пауза перед запуском сигнала из файла
   
   
    // ==== Подключение тестируемого модуля ====
//   wire signed [NFSUM_width-1 : 0] out;

   wire [31:0]  rdata;
   reg  [31:0]  raddr       = 0;
   reg          start_macc  = 0;
   wire         macc_ready;
   reg  [1:0]   sel         = 0;
   wire [31:0]  status;
   
    cov_matrix#(
            .NCH  	     (NCH),
            .NT 	     (NT),
            .width	     (INW),
            .ACCUM_WIDTH (2*INW + 10)
        )
        CVM(
            .clk  	     (clk),
            .resetn      (resetn),
            .ena         (1'b1),
            .rd_data 	 (rdata),
            .rd_addr 	 (raddr),
            .Y 		     (s),	
            .sel         (sel),
            .NStat	     (NSTAT[11:0]),
            .start       (start_macc),
            .ready	     (macc_ready),
            .macc_status (status)
        );
        
        
    // ==== Timeline ====
    integer j;
    initial begin: TEST_CASE
        waitClks(2);
        ->reset; @(resetDone);
        
        sel = MODE;
        
        
        waitClks(1);
        @(negedge clk);
        launch_sgn = 1'b1;

        waitClks(STARTDELAY); // Первый отсчет сигнала дошел до конца линии задержки
                
        @(negedge clk);
        start_macc = 1'b1;

        @(macc_ready == 1'b1);
        
        j = 0;
        repeat (ELEMENTS) begin
            readReg(0, j);
            $fdisplay(fd_out, "%d", $signed(rdata));
            $fflush(fd_out);
            j = j + 1;
        end
        
        waitClks(10);
        start_macc = 1'b0;
        waitClks(2);
        start_macc = 1'b1;
        
        @(macc_ready == 1'b1);
        
        
    end
    
    
    // ==== Вспомогательные таски ====
    
    task waitClks;
        input numclks;
        integer numclks;
        begin
            repeat (numclks) begin
                @(posedge clk);  
            end
        end
    endtask  

    // Чтение из регистра
    event read;
    event readDone;
    
    initial begin
        forever begin
            @(read)
                @ (negedge clk)
//             rd_en = 1;
                @ (negedge clk)
                @ (negedge clk)
                @ (negedge clk)
//             rd_en = 0;
            ->readDone;
        end
    end
    
    task readReg;
        input chnl;
        input offset;

        integer chnl;
        integer offset;
        reg [31:0] val;

        begin
            raddr = (chnl << 0) + offset;
            -> read;
            @ (readDone);  
        end
    endtask
    
    
    // Запись в регистр
    event write;
    event writeDone;
    
    initial begin
        forever begin
            @ (write)
//             @ (negedge clk)
//             wr_en = 1;
//             @ (negedge clk)
//             @ (negedge clk)
//             @ (negedge clk)
//             wr_en = 0;
            -> writeDone;
        end
    end
    
    task writeReg;
        input chnl;
        input offset;
        input val;

        integer chnl;
        integer offset;
        reg [31:0] val;

        begin
            raddr = (chnl << 0) + offset;
//             wdata = val;
            -> write;
            @ (writeDone);  
        end
    endtask
    
  
   // ==== Запись результатов в файл ====
   integer     fd_out;
   initial begin : write_files
        reg[1000*8:0] filename;
        $sformat(filename, "%s/out.txt", `TMPPATH);
        fd_out = $fopen(filename, "w");
   end
   
//    always @(posedge clk) begin
//       if (resetn!=1'b0) begin
//    	 $fdisplay(fd_out, "%d", macc_ready);
//       end
//    end	  
		 
   
endmodule // tb
