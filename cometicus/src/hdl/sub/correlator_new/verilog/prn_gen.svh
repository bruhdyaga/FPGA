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

`ifndef PRN_GEN_SVH
`define PRN_GEN_SVH

`include "macro.svh"

localparam PRNSIZE           = 14;
localparam CNTRSIZE          = 23;
localparam BOC_REG_WIDTH     = 7;
localparam PSP_MUX_SIZE      = 6;
localparam TDMA_SIZE         = 2;
localparam BOC_SIZE          = 2; // также исп. в case(PS.CODE_OUT_BITMASKS.BOC_MODE)

localparam GPS_L5_PATTERN = 13'b1011111111111;

typedef struct packed {
    logic [31:PRNSIZE*2+3] CODE_STATE_RESERVED;
    logic                  LOCATA;
    logic                  SINGLE_SR;
    logic                  GPS_L5_EN;
    logic [PRNSIZE-1:0]    CODE_STATE2;
    logic [PRNSIZE-1:0]    CODE_STATE1;
} CODE_STATES_WORD;

typedef struct packed {
    logic [31:PRNSIZE*2+TDMA_SIZE] CODE_BITMASK_RESERVED;
    logic [TDMA_SIZE-1:0]          TDMA_MODE;
    logic [PRNSIZE-1:0]            CODE_BITMASK2;
    logic [PRNSIZE-1:0]            CODE_BITMASK1;
} CODE_BITMASKS_WORD;

typedef struct packed {
    logic [31:PRNSIZE*2+BOC_SIZE] CODE_OUT_BITMASK_RESERVED;
    logic [BOC_SIZE-1:0]          BOC_MODE;
    logic [PRNSIZE-1:0]           CODE_OUT_BITMASK2;
    logic [PRNSIZE-1:0]           CODE_OUT_BITMASK1;
} CODE_OUT_BITMASKS_WORD;

typedef struct packed {
    CODE_STATES_WORD        CODE_STATES;          // offset 0x04
    CODE_BITMASKS_WORD      CODE_BITMASKS;        // offset 0x08
    CODE_OUT_BITMASKS_WORD  CODE_OUT_BITMASKS;    // offset 0x0c
    logic [31:31]           CNTR_TIME_SLOTS_EN;   // offset 0x10
    logic [30:28]           CNTR_TIME_SLOTS_RESERVED;
    logic [27:24]           CNTR_TIME_SLOT_ACTIVE_NUM;
    logic [23:CNTRSIZE]     CNTR_RESERVED;
    logic [CNTRSIZE-1:0]    CNTR_LENGTH;
} PRN_GEN_STRUCT;

`define PRN_GEN_ID_CONST  (16'h37)
`define PRN_GEN_SIZE      (`size32(PRN_GEN_STRUCT))
`define PRN_GEN_FULL_SIZE (`PRN_GEN_SIZE + \
                           `RWREGSSIZE)

`endif
