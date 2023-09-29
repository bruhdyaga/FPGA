`timescale 10 ns/ 10 ns

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
logic [9:0]  LED_RED;


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
		  .LED_RED(LED_RED)
		  
		 
		  
);

initial                                                
begin        
  clk = 0;                                          
  KEY0 = 0;
  KEY1 = 0; 
  KEY2 = 0;  
                    
  # 200000000;
  KEY0 = 1;
  KEY1 = 0; 
  KEY2 = 0;  
               
  # 200000000;
  KEY0 = 0;
  KEY1 = 1; 
  KEY2 = 0;  
              
  # 200000000;
  KEY0 = 0;
  KEY1 = 1; 
  KEY2 = 0;  
                
  # 200000000;
  KEY0 = 1;
  KEY1 = 0; 
  KEY2 = 0;  
                      
  # 200000000;
  KEY0 = 1;
  KEY1 = 0; 
  KEY2 = 0;  
  $display("Running testbench");                       
  # 200000000;
end                                                    

always 
  #2  clk =  ! clk;    //создание clk                                                
 
endmodule
