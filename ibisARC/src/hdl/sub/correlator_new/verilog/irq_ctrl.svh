/*
   Copyright  2017  SRNS.RU Team                                              
      _______. .______     .__   __.      ___ ____.    .______      __    __  
     /       | |   _  \    |  \ |  |     /       |     |   _  \    |  |  |  | 
    |   (----` |  |_)  |   |   \|  |    |   (----`     |  |_)  |   |  |  |  | 
     \   \     |      /    |  . `  |     \   \         |      /    |  |  |  | 
 .----)   |    |  |\  \--. |  |\   | .----)   |    __  |  |\  \--. |  `--'  | 
 |_______/     | _| `.___| |__| \__| |_______/    (__) | _| `.___|  \______/  
                                                                              
   Boldenkov E., Korogodin I., Perov A.
                                                                              
   Licensed under the Apache License, Version 2.0 (the "License");            
   you may not use this file except in compliance with the License.           
   You may obtain a copy of the License at                                    
                                                                              
       http://www.apache.org/licenses/LICENSE-2.0                             
                                                                              
   Unless required by applicable law or agreed to in writing, software        
   distributed under the License is distributed on an "AS IS" BASIS,          
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   
   See the License for the specific language governing permissions and        
   limitations under the License.                                             
*/

`ifndef IRQ_CTRL_SVH
`define IRQ_CTRL_SVH

`include "macro.svh"

localparam PERIODSIZE   = 18;

typedef struct packed {
    logic [31:4] RESERVED;
    logic [3:3]  release_pulse;
    logic [2:2]  polarity;
    logic [1:1]  sensitive;
    logic [0:0]  enable;
} IRQ_CTRL_CONF_REG;

typedef struct packed {
    IRQ_CTRL_CONF_REG      CFG;             // IRQ configuration register
    logic [31:PERIODSIZE]  PERIOD_RESERVED;
    logic [PERIODSIZE-1:0] PERIOD;          // IRQ period, clk
    logic [31:PERIODSIZE]  DURATION_RESERVED;
    logic [PERIODSIZE-1:0] DURATION;        // IRQ duration, clk
} IRQ_CTRL;

`define IRQ_ID_CONST  (16'h11)
`define IRQ_CTRL_SIZE (`size32(IRQ_CTRL))
`define IRQ_CTRL_FULL_SIZE (`IRQ_CTRL_SIZE + \
                            `RWREGSSIZE)

`endif
