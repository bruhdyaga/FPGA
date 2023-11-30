`timescale 1 ps/ 1 ps

module tb();

//input registers
reg clk;
reg KEY0;
reg KEY1;
reg KEY2;


//wires                                               
logic [6:0]  HEX0;
logic[6:0]  HEX1;
logic[6:0]  HEX2;
wire [6:0]  HEX3;
logic [9:0]  LED_RED;


                         
main testbench(

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
  KEY0 = 1 ;
  KEY1 = 1; 
  KEY2 = 1;  




                    
# 100;
  KEY0 = 0;
  KEY1 = 0; 
  KEY2 = 0;


               
  # 100;
  KEY0 = 0;
  KEY1 = 0; 
  KEY2 = 1;
              
  # 100;
  KEY0 = 1;
  KEY1 = 0; 
    
                
  # 100;
  KEY0 = 1 ;
  KEY1 = 1; 
    
                      
  # 150;
  KEY1 = 0; 
    
  # 300;
  KEY0 = 0;
  KEY1 = 1;






  $display("Running testbench");                
  
end                                                    

always 
  #1 clk =  ! clk;                                                   
 
endmodule


