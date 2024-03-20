`timescale 1ns/1ns  // Лучше не менять, тест расчитан на 125 МГц

`include "test_params.v"
//`define TMPPATH "tmp"

module tb();
   // Шина
   parameter BUS_WIDTH = 30;
   parameter BASE_ADDR = 16'h123;
   `include "bus_syn_task.v"
   `include "math.v"

   // ==== Клоки, ресеты ====
    reg clk = 1'b0;
    always #4 clk=!clk;   // 125 МГц
    
    reg resetn = 1'b0;
    event reset;
    event resetDone;
    initial begin
        forever begin
            @ (reset)
            @ (negedge clk)
            resetn = 0;
            waitClks(16);
	 
            @ (negedge clk)
            resetn = 1;
	 
            INIT_BIS_TASK;

            while (BIS_rdata != 32'hAE130000) begin
                READ_BIS_TASK(BASE_ADDR + 0); //чтение константы
            end
            $display("Bus reset done");
	 
            ->resetDone;
        end
    end

    integer ii;
    genvar  i;
    
    // Параметры
    parameter NCH              = `CRPA_NCH;
    parameter NT               = `CRPA_NT;
    parameter NBF              = `CRPA_NBF;
    parameter input_width      = `CRPA_INPUT_WIDTH;
    parameter NF_coeff_width   = `CRPA_NF_COEFF_WIDTH;
    parameter BF_coeff_width   = `CRPA_BF_COEFF_WIDTH;
    parameter NF_lsb_drop      = `CRPA_NF_LSB_DROP;
    parameter CVM_sel          = `CRPA_CVM_SEL;
    parameter NStat            = `CRPA_CVM_NSTAT;

    parameter NF_BASE    = 12'h100;  // NullFormer registers base relative to BASE_ADDR
    
    parameter BF_RE_BASE = 16'h1000; // BeamFormer real coefficients base relative to BASE_ADDR
    parameter BF_IM_BASE = 16'h1200; // BeamFormer imaginary coefficients base relative to BASE_ADDR
    
    parameter CVM_BASE   = 16'h1400; // cov_matrix registers base relative to BASE_ADDR
   
   
    localparam NF_No_COEFF     = NCH*NT;                       // Количество коэффициентов в одном NullFormer
    localparam NF_No_BITS      = NF_No_COEFF*NF_coeff_width;   // Количество бит на коэффициенты в одном NullFormer
    
    localparam BF_No_COEFF     = NCH;                          // Количество коэффициентов в одном BeamFormer
    localparam BF_No_BITS      = BF_No_COEFF*BF_coeff_width;   // Количество бит на коэффициенты в одном BeamFormer

    reg [NCH*input_width-1: 0]  s = 0;                             // Входной сигнал
   
    wire [NF_coeff_width-1: 0] NF_coeffs [NCH*NF_No_COEFF-1 : 0];     // Коэффициенты NullFormer
    reg [NCH*NF_No_BITS-1: 0]  NF_coeffs_concat;                      // Коэффициенты NullFormer
    
    wire [BF_coeff_width-1: 0] BF_RE_coeffs [NBF*BF_No_COEFF-1 : 0];  // Коэффициенты BeamFormer RE
    reg [NBF*BF_No_BITS-1: 0]  BF_RE_coeffs_concat;                   // Коэффициенты BeamFormer RE
    
    wire [BF_coeff_width-1: 0] BF_IM_coeffs [NBF*BF_No_COEFF-1 : 0];  // Коэффициенты BeamFormer IM
    reg [NBF*BF_No_BITS-1: 0]  BF_IM_coeffs_concat;                   // Коэффициенты BeamFormer IM
   
    // Времянка
    reg processing;            // Сигнал начала обработки   
    reg CVM_ready;             // Сигнал готовности корреляционной матрицы
    reg CVM_start;
   
    reg launch_sgn = 1'b0;     // Запуск сигнала из файлика
    integer pause_launch_signal = 0;
   
    localparam integer pauses = 3;
    initial begin: TIMELINE
        processing = 1'b0;
        CVM_ready = 1'b0;
        CVM_start = 0;
        waitClks(2);
        ->reset;   @(resetDone);
        
        // Чтение тестового регистра
        READ_BIS_TASK(BASE_ADDR + 0);
        $display("   Read ID:      %08X", BIS_rdata);
        
        // Запись тестового регистра
        WRITE_BIS_TASK(BASE_ADDR + 0, 32'h123567);
        $display("   Write ID:     %08X", 32'h123567);
        
        READ_BIS_TASK(BASE_ADDR + 0);
        $display("   Read ID:      %08X", BIS_rdata);
        
        READ_BIS_TASK(BASE_ADDR + 1);
        $display("   CRPA PARAMS:  %08X", BIS_rdata);
        
        // Запись коэффициентов NullFormer
        for (ii=0; ii<NCH*NF_No_COEFF; ii=ii+1)
            WRITE_BIS_TASK(BASE_ADDR+NF_BASE + ii + 0, NF_coeffs[ ii ] );

        // Запись коэффициентов BeamFormer
        // Действительная часть
        for (ii=0; ii<NBF*BF_No_COEFF; ii=ii+1)
            WRITE_BIS_TASK(BASE_ADDR+BF_RE_BASE + ii + 0, BF_RE_coeffs[ ii ] );
        
        // Мнимая часть
        for (ii=0; ii<NBF*BF_No_COEFF; ii=ii+1)
            WRITE_BIS_TASK(BASE_ADDR+BF_IM_BASE + ii + 0, BF_IM_coeffs[ ii ] );

        waitClks(1);                
      
        // Write NStat and CVMsel
        WRITE_BIS_TASK(BASE_ADDR + 2, 
                                       (         0 <<  3) |      // CRPA_CVM_START
                                       (         0 <<  4) |      // CRPA_NF_START
                                       (         0 <<  5) |      // CRPA_BF_START
                                       (     NStat <<  6) |      // CRPA_CVM_STAT
                                       (   CVM_sel << 24)        // CRPA_CVM_MODE
                                       );

        WRITE_BIS_TASK(BASE_ADDR + 2, 
                                       (         0 <<  3) |      // CRPA_CVM_START
                                       (         1 <<  4) |      // CRPA_NF_START
                                       (         1 <<  5) |      // CRPA_BF_START
                                       (     NStat <<  6) |      // CRPA_CVM_STAT
                                       (   CVM_sel << 24)        // CRPA_CVM_MODE
                                       );
        waitClks(1);
        @(negedge clk);
        
        pause_launch_signal = pauses;
        launch_sgn = 1'b1;  // Launch signals from file
        processing = 1'b1;  // Start NF/BF processing
        
        waitClks(pauses + NT + 3);                // CVM start delay, see test/cov_matrix/test.v // It will not work with NT = 1 =(
//        waitClks(pauses + NT + 1);                // CVM start delay, see test/cov_matrix/test.v // It will not work with NT = 1 =(
      
        WRITE_BIS_TASK(BASE_ADDR + 2, 
                                       (         1 <<  3) |      // CRPA_CVM_START
                                       (         1 <<  4) |      // CRPA_NF_START
                                       (         1 <<  5) |      // CRPA_BF_START
                                       (     NStat <<  6) |      // CRPA_CVM_STAT
                                       (   CVM_sel << 24)        // CRPA_CVM_MODE
                                       );
        CVM_start = 1;  // For waveform

        while (CVM_ready == 1'b0) begin
            #1000
            READ_BIS_TASK(BASE_ADDR + 3);
            if (BIS_rdata == 32'h1) begin
                CVM_ready = 1'b1;
            end
        end
      
    end

   wire [NBF*input_width-1 : 0] bf_out_re;
   wire [NBF*input_width-1 : 0] bf_out_im;
    
   wire [NBF-1: 0]  bf_re_sig;                        // BeamFormers RE SIG output
   wire [NBF-1: 0]  bf_re_mag;                        // BeamFormers RE MAG output
   wire [NBF-1: 0]  bf_im_sig;                        // BeamFormers IM SIG output
   wire [NBF-1: 0]  bf_im_mag;                        // BeamFormers IM MAG output
   

   
   // Тестируемый модуль
   CRPA #(
	  .BUS_WIDTH      (BUS_WIDTH),
	  .BASE_ADDR      (BASE_ADDR),
	  .NCH            (NCH),
	  .NT             (NT),
	  .NBF            (NBF),
	  .DIRECT         (0),               // Прямого канала не будет
	  .input_width    (input_width),
	  .NF_coeff_width (NF_coeff_width),
	  .BF_coeff_width (BF_coeff_width),
	  .NF_lsb_drop    (NF_lsb_drop),
	  .BF_out_width   (input_width)
	  )
   crpa  (
	  .clk       (clk),
	  .resetn    (resetn),

	  .cpu_clk   (BIS_clk),
	  .wr_en     (BIS_wr),
	  .rd_en     (BIS_rd),
	  .addr      (BIS_addr),
	  .wdata     (BIS_wdata),
	  .rdata     (BIS_rdata),
	  
	  .data_in   (s),                    // Входной сигнал

	  .bf_out_re (bf_out_re),
	  .bf_out_im (bf_out_im),
	  
	  .bf_re_sig (bf_re_sig),            // BeamFormers RE SIG output
	  .bf_re_mag (bf_re_mag),            // BeamFormers RE MAG output
	  .bf_im_sig (bf_im_sig),            // BeamFormers IM SIG output
	  .bf_im_mag (bf_im_mag)             // BeamFormers IM MAG output
	);

   
   // ==== Чтение входного сигнала из файла ====
   integer fd_s[NCH-1:0];
   integer s_cnt;
   integer Sin[NCH-1:0];

    generate
        for (i=0; i<NCH; i=i+1) begin:S
            initial begin: S_FILENAME
                reg[1000*8:0] filename;
                $sformat(filename, "%s/s_%0d.txt", `TMPPATH, i+1);
                fd_s[i] = $fopen(filename, "r");
        //	    fd_s[i] = $fopen($psprintf("tmp/s_%0d.txt", i+1), "r");
            end
   
            always @(posedge clk) begin
                if (launch_sgn == 1'b0 || pause_launch_signal != 0) begin
                    s_cnt <= 0;
                end else begin
                    if (s_cnt == 0) begin
                        s_cnt <= 1; // Задержка в такт
                    end else begin
                        s_cnt = $fscanf(fd_s[i], "%d\n", Sin[i]);
                        s[(i+1)*input_width - 1:i*input_width] = Sin[i];
                    end
                end
            end
        end // block: S
    endgenerate
    
    always @(posedge clk) begin
        if (launch_sgn == 1'b1 && pause_launch_signal > 0) begin
            pause_launch_signal = pause_launch_signal - 1;
        end
    end

    // ==== Чтение файла с коэффициентами NullFormer ====
    genvar j;
    generate
        for (j=0; j<NCH; j=j+1) begin: NF_COEFFS
            reg [1000*8:0] filename;
            integer 	fd_NF_coeffs;
            
            initial begin
                $sformat(filename, "%s/NF_coeffs_%0d.txt", `TMPPATH, j+1);
                fd_NF_coeffs = $fopen(filename, "r");
            end
            
            for (i=0; i<NF_No_COEFF; i=i+1) begin:NCH_NF_COEFFS
                initial begin
                    s_cnt <= $fscanf(fd_NF_coeffs, "%d\n", NF_coeffs_concat[ j*NF_No_BITS+(i+1)*NF_coeff_width-1 : j*NF_No_BITS+i*NF_coeff_width ]);
                end
            end
        end
    endgenerate

    generate
        for (i=0; i<NCH*NF_No_COEFF; i=i+1) begin
            assign NF_coeffs[ i ] = NF_coeffs_concat[ (i+1)*NF_coeff_width-1 : i*NF_coeff_width ];
        end
    endgenerate

   
   // ==== Чтение файла с коэффициентами BeamFormer ====
    // Действительная часть
    generate
        for (j=0; j<NBF; j=j+1) begin: BF_RE_COEFFS
            reg [1000*8:0] filename;
            integer 	fd_BF_coeffs;
            
            initial begin
                $sformat(filename, "%s/BF_RE_coeffs_%0d.txt", `TMPPATH, j+1);
                fd_BF_coeffs = $fopen(filename, "r");
            end
        
            for (i=0; i<BF_No_COEFF; i=i+1) begin:NCH_BF_COEFFS
                initial begin
                    s_cnt <= $fscanf(fd_BF_coeffs, "%d\n", BF_RE_coeffs_concat[ j*BF_No_BITS+(i+1)*BF_coeff_width-1 : j*BF_No_BITS+i*BF_coeff_width ]);
                end
            end
        end
    endgenerate

    generate
        for (i=0; i<NBF*BF_No_COEFF; i=i+1) begin
            assign BF_RE_coeffs[ i ] = BF_RE_coeffs_concat[ (i+1)*BF_coeff_width-1 : i*BF_coeff_width ];
        end
    endgenerate


    // Мнимая часть
    generate
        for (j=0; j<NBF; j=j+1) begin: BF_IM_COEFFS
            reg [1000*8:0] filename;
            integer 	fd_BF_coeffs;
            
            initial begin
                $sformat(filename, "%s/BF_IM_coeffs_%0d.txt", `TMPPATH, j+1);
                fd_BF_coeffs = $fopen(filename, "r");
            end
            
            for (i=0; i<BF_No_COEFF; i=i+1) begin:NCH_BF_COEFFS
                initial begin
                    s_cnt <= $fscanf(fd_BF_coeffs, "%d\n", BF_IM_coeffs_concat[ j*BF_No_BITS+(i+1)*BF_coeff_width-1 : j*BF_No_BITS+i*BF_coeff_width ]);
                end
            end
        end
    endgenerate

    generate
        for (i=0; i<NBF*BF_No_COEFF; i=i+1) begin
            assign BF_IM_coeffs[ i ] = BF_IM_coeffs_concat[ (i+1)*BF_coeff_width-1 : i*BF_coeff_width ];
        end
    endgenerate
   
   // Запись результатов теста NullFormer
   generate
      for (i=0; i<NCH; i=i+1) begin: NF_OUT
	 integer     fd_out;
	 initial begin: NF_OUT_FILE
            reg[1000*8:0] filename;
            $sformat(filename, "%s/out_nf_%0d.txt", `TMPPATH, i+1);
            fd_out = $fopen(filename, "w");
	 end
	 
	 always @(posedge clk) begin
	    if (resetn!=1'b0) begin
	       if (processing == 1'b1)
   		 $fdisplay(fd_out, "%d", $signed(crpa.NF_out_full[i]));
	    end
	 end	  
      end
   endgenerate   

   // Запись результатов теста BeamFormer
   // Действительная часть
   generate
      for (i=0; i<NBF; i=i+1) begin: BF_RE_OUT
	 integer     fd_out;
	 initial begin: BF_RE_OUT_FILE
            reg[1000*8:0] filename;
            $sformat(filename, "%s/out_bf_RE_%0d.txt", `TMPPATH, i+1);
            fd_out = $fopen(filename, "w");
	 end
	 
	 always @(posedge clk) begin
	    if (resetn!=1'b0) begin
	       if (processing == 1'b1)
   		 $fdisplay(fd_out, "%d", $signed(crpa.BF_RE_out_full[i]));
	    end
	 end	  
      end
   endgenerate   

   // Мнимая часть
   generate
      for (i=0; i<NBF; i=i+1) begin: BF_IM_OUT
	 integer     fd_out;
	 initial begin: BF_IM_OUT_FILE
            reg[1000*8:0] filename;
            $sformat(filename, "%s/out_bf_IM_%0d.txt", `TMPPATH, i+1);
            fd_out = $fopen(filename, "w");
	 end
	 
	 always @(posedge clk) begin
	    if (resetn!=1'b0) begin
	       if (processing == 1'b1)
   		 $fdisplay(fd_out, "%d", $signed(crpa.BF_IM_out_full[i]));
	    end
	 end	  
      end
   endgenerate   

   // Запись результатов на выходе с квантованием
   // Действительная часть
   generate
      for (i=0; i<NBF; i=i+1) begin: BFQ_RE_OUT
	 integer     fd_out;
	 initial begin: BFQ_RE_OUT_FILE
            reg[1000*8:0] filename;
            $sformat(filename, "%s/out_bfq_RE_%0d.txt", `TMPPATH, i+1);
            fd_out = $fopen(filename, "w");
	 end
	 
	 always @(posedge clk) begin
	    if (resetn!=1'b0) begin
	       if (processing == 1'b1)
   		 $fdisplay(fd_out, "%d", (bf_re_sig[i]==1) ? ((bf_re_mag[i]==1)?+3:+1) : ((bf_re_mag[i]==1)?-3:-1) );
	    end
	 end	  
      end
   endgenerate   

   // Мнимая часть
   generate
      for (i=0; i<NBF; i=i+1) begin: BFQ_IM_OUT
	 integer     fd_out;
	 initial begin: BFQ_IM_OUT_FILE
            reg[1000*8:0] filename;
            $sformat(filename, "%s/out_bfq_IM_%0d.txt", `TMPPATH, i+1);
            fd_out = $fopen(filename, "w");
	 end
	 
	 always @(posedge clk) begin
	    if (resetn!=1'b0) begin
	       if (processing == 1'b1)
   		 $fdisplay(fd_out, "%d", $signed(bf_im_sig[i])*$unsigned(1+2*bf_im_mag[i]));
	    end
	 end	  
      end
   endgenerate   
   
    // Запись результатов вычисления корреляционной матрицы
    integer fd_cvm;
    integer cvm_cnt;
    initial begin: CVM_OUT_FILE
        reg[1000*8:0] filename;
        $sformat(filename, "%s/out_cvm.txt", `TMPPATH);
        fd_cvm = $fopen(filename, "w");
        cvm_cnt = 0;
        
        while (cvm_cnt < (NCH*NT+1)*NCH*NT/2) begin
            if (resetn!=1'b0) begin
                if (CVM_ready == 1'b1) begin
                    READ_BIS_TASK(BASE_ADDR + CVM_BASE + cvm_cnt);
                    $fdisplay(fd_cvm, "%d", $signed(BIS_rdata));
                    cvm_cnt = cvm_cnt + 1;
                end
            end
            waitClks(4);
        end	  
    end   
   
    // Additional tasks

    // Delay
    task waitClks;
        input numclks;
        integer numclks;
        begin
            repeat (numclks) begin
                @(posedge clk);  
            end
        end
    endtask  

   // // Register read
   // event read;
   // event readDone;
   
   // initial begin
   //    forever begin
   //       @(read)
   //         @ (negedge clk)
   // 	     rd_en = 1;
   //         @ (negedge clk)
   //         @ (negedge clk)
   //         @ (negedge clk)
   // 	     rd_en = 0;
   // 	 ->readDone;
   //    end
   // end
   
   // task READ_BIS_TASK;
   //    input base;
   //    input offset;

   //    integer base;
   //    integer offset;
   //    reg [31:0] val;

   //    begin
   //       addr = base + offset;
   //       -> read;
   //       @ (readDone);  
   //    end
   // endtask

   // // Register write
   // event write;
   // event writeDone;
   
   // initial begin
   //    forever begin
   //       @ (write)
   // 	 @ (negedge clk)
   // 	    BIS_wr = 1;
   // 	 @ (negedge clk)
   // 	 @ (negedge clk)
   // 	 @ (negedge clk)
   // 	    BIS_wr = 0;
   //       -> writeDone;
   //    end
   // end
   
   // task WRITE_BIS_TASK;
   //    input base;
   //    input offset;
   //    input val;

   //    integer base;
   //    integer offset;
   //    reg [31:0] val;

   //    begin
   //       addr = (base << 0) + offset;
   // 	 wdata = val;
   //       -> write;
   //       @ (writeDone);  
   //    end
   // endtask
   
   
endmodule // tb
