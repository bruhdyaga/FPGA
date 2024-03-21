`timescale 100ps / 1ps

`include "global_param.v"
`include "imichnl_param.v"

`define IMI_CHNLOUTWIDTH 11
module imitator_channel_tb();
 
    parameter BASE_ADDR = `ADDR_WIDTH'h8000;
    
    
    // [in]
    reg             clk;                
    reg             pclk;               
    reg             reset_n;
    reg             wr_en;               
    reg             rd_en;
    reg [`ADDR_WIDTH - 1 : 0] reg_addr;
    reg [31 : 0]    wdata; 
    reg             intr_pulse;
    reg             fix_pulse;

    // [out]
    wire [31 : 0] rdata;
    wire [`IMI_CHNLOUTWIDTH - 1 : 0] i_ch; // Синфазная компонента i-го канала
    wire [`IMI_CHNLOUTWIDTH - 1 : 0] q_ch; // Квадратурная компонента i-го канала
    
`define chNum 0    
    imitator_channel #(
        .BASE_ADDR(BASE_ADDR + (`chNum << 6)),
        .out_width(`IMI_CHNLOUTWIDTH)
    ) IMI_CH ( 
        .clk          (clk),            // In
        .pclk         (pclk),
        .reset_n      (reset_n),
        .wr_en        (wr_en),
        .rd_en        (rd_en),
        .reg_addr     (reg_addr),
        .wdata        (wdata),
        .intr_pulse   (intr_pulse), 
        .fix_pulse    (fix_pulse),
        .rdata        (rdata),          // Out
        .I            (i_ch),
        .Q            (q_ch)           
    );

    initial begin
        clk = 0;
        pclk = 0;
        reset_n = 1;
        wr_en = 0;
        rd_en = 0;
        reg_addr = 0;
        wdata = 0;        
        intr_pulse = 0;
        fix_pulse = 0;
    end
    
    always  // 105.6 MHz
        #47 pclk = !pclk;
        
    always // 60 MHz
        #83 clk = !clk; 
        
    event reset;
    event irq;
    event fix;
    
    event write;
    event writeDone;
    event read;
    event readDone;
    
    initial begin
        forever begin
            @ (reset)
            @ (negedge pclk)
            reset_n = 0;
            @ (negedge pclk)
            reset_n = 1;
        end
    end
    
    initial begin
        forever begin
            @ (irq)
            @ (negedge pclk)
            intr_pulse = 1;
            @ (negedge pclk)
            intr_pulse = 0;
        end
    end
    
    initial begin
        forever begin
            @ (fix)
            @ (negedge pclk)
            fix_pulse = 1;
            @ (negedge pclk)
            fix_pulse = 0;
        end
    end    
    
    initial begin
        fork // Распараллеливание блоков
            forever begin
                #6000000 -> irq;
            end
            forever begin
                #10000000 -> fix;
            end
        join
    end
    
    initial begin
        forever begin
            @ (write)
            @ (negedge clk)
            wr_en = 1;
            @ (negedge clk)
            @ (negedge clk)
            @ (negedge clk)
            wr_en = 0;
            -> writeDone;
        end
    end
    
    initial begin
        forever begin
            @ (read)
            @ (negedge clk)
            rd_en = 1;
            @ (negedge clk)
            @ (negedge clk)
            @ (negedge clk)
            rd_en = 0;
            -> readDone;
        end
    end   
       
    integer ch;   
    initial begin: TEST_CASE
        #10 -> reset;

        #500
       
        ch = 0;
        writeReg(ch, `CODE_RATE_OFFSET,     20783411);
        writeReg(ch, `PHASE_RATE_OFFSET,    32'd1000000);  
        initChnlGlnLxOF(ch);
        writeReg(ch, `CHANNEL_CONFIG_OFFSET,   1);
                   
    end
    
    task writeReg;
        input chnl;
        input offset;
        input val;
        
        integer chnl;
        integer offset;
        reg [31:0] val;
        
        begin
            reg_addr = (chnl << 6) + offset;
            wdata = val;
            -> write;
            @ (writeDone);  
        end
    endtask
    
    task initChnlGlnLxOF;
        input ch;
        integer ch;
        begin
            writeReg(ch, `CODE_STATE1_OFFSET,   32'hFFFFFFFF);
            writeReg(ch, `CODE_BITMASK1_OFFSET, 32'h08800000);       
            writeReg(ch, `CODE_OUT_BITMASK1_OFFSET, 32'h02000000);
            writeReg(ch, `CODE_STATE2_OFFSET,   32'h00000000);
            writeReg(ch, `CODE_BITMASK2_OFFSET, 32'h00000000);
            writeReg(ch, `CODE_OUT_BITMASK2_OFFSET, 32'h00000000);        
            writeReg(ch, `PRN_LENGTH_OFFSET,    511-1);        
            writeReg(ch, `PRN_LENGTH1_OFFSET,   511-1);
            writeReg(ch, `CHIP_MAX_OFFSET,      511-1);        
            writeReg(ch, `PRN_INIT_OFFSET,      0);
            writeReg(ch, `PRN_INIT1_OFFSET,     0);                
            writeReg(ch, `BOC_REGS_OFFSET,      0);
            writeReg(ch, `CODE_PHASE_OFFSET,    0);
            writeReg(ch, `EPOCH_AND_TOW_OFFSET, 0);                
            writeReg(ch, `EPOCH_AND_SYMB_MAX_OFFSET, 1000-1);
            writeReg(ch, `CODE_DOINIT_OFFSET,   {16'h12AB, 16'b0});
            writeReg(ch, `CODE_STATE1_OFFSET,   32'hFFFFFFFF);
        end
    endtask    

endmodule