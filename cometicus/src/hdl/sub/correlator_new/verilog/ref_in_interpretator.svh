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

`ifndef REFINTERP_SVH
`define REFINTERP_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:16] LAG_fix;
    logic [15:14] RESERVED1;
    logic [13: 9] SEL_IM;
    logic [ 8: 4] SEL_RE;
    logic [ 3: 2] RESERVED2;
    logic [ 1: 0] MODE;
} REFINTR_CONFIG;

typedef struct packed {
    logic [31:30] RESERVED;
    logic [29:24] MEAS_fix;
    logic [23: 0] GARM_fix;
} REFINTR_MEAS;

typedef struct packed {
    REFINTR_CONFIG CFG;
    REFINTR_MEAS MEAS;
} REFINTERP;

`define REFINTERP_ID_CONST  (16'hA1E1)
`define REFINTERP_SIZE      (`size32(REFINTERP))
`define REFINTERP_FULL_SIZE (`REFINTERP_SIZE + \
                             `RWREGSSIZE)

`endif // REFINTERP_SVH
