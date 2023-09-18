`timescale 1 ps/ 1 ps
module tb();

// test vector input registers
logic clk;
logic KEY0;
logic KEY1;
logic KEY2;
// wires                                               
logic [6:0]  HEX0;
logic [6:0]  HEX1;
logic [6:0]  HEX2;
logic [6:0]  HEX3;

// assign statements (if any)                          
main testbench(
// port map - connection between master ports and signals/registers   
        .clk(clk),
        .KEY0(KEY0),
        .KEY1(KEY1),
        .KEY2(KEY2),
		  .HEX0(HEX0),
		  .HEX1(HEX1),
		  .HEX2(HEX2),
		  .HEX3(HEX3),
		  
);

initial                                                
begin        
  clk = 0;                                          
  KEY0 = 0;
  KEY1 = 0; 
  KEY2 = 0;  
                    
  # 10;
  KEY0 = 1;
  KEY1 = 0; 
  KEY2 = 0;  
               
  # 15;
  KEY0 = 0;
  KEY1 = 1; 
  KEY2 = 0;  
              
  # 20;
  KEY0 = 0;
  KEY1 = 1; 
  KEY2 = 0;  
                
  # 100;
  KEY0 = 1;
  KEY1 = 0; 
  KEY2 = 0;  
                      
  # 10;
  KEY0 = 0;
  KEY1 = 0; 
  KEY2 = 1;  
  $display("Running testbench");                       
  # 10;
end                                                    

always 
  #5  clk =  ! clk;    //создание clk                                                
 
endmodule
