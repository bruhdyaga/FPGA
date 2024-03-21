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

`ifndef CORR_CH
`define CORR_CH

`include "macro.svh"
`include "time_scale_ch.svh"
`include "prn_gen.svh"
`include "prn_ram.svh"

localparam N_INP   = 1; // количество входов коррелятора (1 - обычный одновходовый коррелятор)
localparam DELAYS  = 1; // количество отводов по задержке с каждой стороны от центрального (1 - означает два боковых отвода всего)
localparam DLY_LEN = 30; // максимальная задержка отводов от центрального в клоках (0 - означает все отводы = центральному)

typedef struct packed {
    logic [31:31] PN_MUX;
    logic [30:20] RESERVED;
    logic [19:16] INP_NUM;
    logic [15:10] DELAY;
    logic [ 9:5 ] INPUT_Q;
    logic [ 4:0 ] INPUT_I;
} CORR_CH_CFG;

typedef struct packed {
    CORR_CH_CFG                          CFG;        // Channel config register
    logic [31:0]                         PHASE_RATE; // Reference carrier phase_rate
    logic [31:0]                         CAR_PHASE;
    logic [31:0]                         CAR_CYCLES;
    logic [31:EPOCHSIZE]                 RESERVED_EPOCH_IRQ;
    logic [EPOCHSIZE-1:0]                EPOCH_IRQ;
    logic [0:N_INP-1][DELAYS*2:0][31:0]  IQ;         // Correlator components
} CORR_CH;

`define CORR_CH_ID_CONST     (16'hAB13)
`define CORR_CH_SIZE         (`size32(CORR_CH))
`define CORR_CH_FULL_SIZE ( `HUBSIZE + \
                            `CORR_CH_SIZE + \
                            `RWREGSSIZE + \
                            `TIME_SCALE_CH_FULL_SIZE + \
                            `PRN_RAM_FULL_SIZE + \
                            `PRN_GEN_FULL_SIZE)

`endif
