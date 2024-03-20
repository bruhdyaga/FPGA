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

`include "time_scale_ch.svh"
`include "global_param.v"

module time_scale_ch
#(
    parameter BASEADDR   = 0
)
(
    intbus_interf.slave bus,     // CPU bus bus,
    input  clk,                   // RF clk
    output chip_pulse,
    output logic epoch_pulse,
    output sec_pulse,
    input  fix_pulse,
    output do_rqst,
    output eph_apply,
    output TIME_WORD time_out,
    output [2:0] phase_hi
);

// The system timescale data structure definition
TIME_SCALE_CH_STRUCT PL;              // The registers to read from the CPU
TIME_SCALE_CH_STRUCT PS;              // The registers to write by the CPU
TIME_SCALE_CH_STRUCT T;               // Registers to use in time generator

//Define which bits will be pulsed
localparam NPULSE = 2;
localparam integer PULSE [NPULSE][2] = '{
    '{0, 0}, // do_rqst
    '{0, 1}  // eph_rqst
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`TIME_SCALE_CH_ID_CONST),
    .DATATYPE (TIME_SCALE_CH_STRUCT),
    .OUTFF    ("n"),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  ({eph_rqst, do_rqst}),
    .wr     (),
    .rd     ()
);

assign PL.CHIP_EPOCH.RESERVED              = '0;
assign PL.RESERVED_SEC                     = '0;
assign PL.CHIP_EPOCH_MAX                   = '0;
assign PL.CODE_RATE                        = '0;

reg eph_set = '0;
always_ff@(posedge clk) begin
    if(eph_rqst == 1'b1)
        eph_set <= 1'b1;
    else if(epoch_pulse == 1'b1)
        eph_set <= 1'b0;
end

assign eph_apply = epoch_pulse & eph_set;

// Phase accumulator
wire [PHASESIZE:0] phase_next;
assign phase_next = T.PHASE + T.CODE_RATE;
assign chip_pulse = phase_next[PHASESIZE];
assign phase_hi = phase_next[PHASESIZE-1:PHASESIZE-3];

always_ff@(posedge clk)
if(do_rqst) begin
    T.PHASE <= '0;
end else begin
    T.PHASE <= phase_next[PHASESIZE-1:0];
end

// Chip accumulator
assign epoch_pulse = (T.CHIP_EPOCH.CHIP[CHIPSIZE_CH-1:0] == T.CHIP_EPOCH_MAX.CHIP_MAX[CHIPSIZE_CH-1:0]) & chip_pulse;

always_ff@(posedge clk) begin
    if(do_rqst | epoch_pulse) begin
        T.CHIP_EPOCH.CHIP <= '0;
    end else begin
        if(chip_pulse) begin
            T.CHIP_EPOCH.CHIP <= T.CHIP_EPOCH.CHIP + 1'b1;
        end
    end
end

// Epoch counter
assign sec_pulse = (T.CHIP_EPOCH.EPOCH == T.CHIP_EPOCH_MAX.EPOCH_MAX) & epoch_pulse;

always_ff@(posedge clk) begin
    if(sec_pulse) begin
        T.CHIP_EPOCH.EPOCH <= '0;
    end else begin
        if(do_rqst) begin
            T.CHIP_EPOCH.EPOCH <= PS.CHIP_EPOCH.EPOCH;
        end
        else if(epoch_pulse) begin
            T.CHIP_EPOCH.EPOCH <= T.CHIP_EPOCH.EPOCH + 1'b1;
        end
    end
end

assign week_pulse = (T.SEC == (`SEC_IN_WEEK - 1)) & sec_pulse;

// Seconds counter
always_ff@(posedge clk) begin
    if(do_rqst | week_pulse) begin
        T.SEC <= '0;
    end else begin
        if(sec_pulse)  begin
            T.SEC <= T.SEC + 1'b1;
        end
    end
end

// === Registers update ===
always_ff@(posedge clk) begin
    if(do_rqst) begin
        T.CHIP_EPOCH_MAX.CHIP_MAX  <= {{(CHIPSIZE-CHIPSIZE_CH){1'b0}},PS.CHIP_EPOCH_MAX.CHIP_MAX[CHIPSIZE_CH-1:0]};
        T.CHIP_EPOCH_MAX.EPOCH_MAX <= PS.CHIP_EPOCH_MAX.EPOCH_MAX;
    end
end

always_ff@(posedge clk) begin
    if(do_rqst | eph_apply) begin
        T.CODE_RATE <= PS.CODE_RATE;
    end
end

always_ff@(posedge clk) begin
    if(fix_pulse) begin
        PL.PHASE            <= T.PHASE;
        PL.CHIP_EPOCH.EPOCH <= T.CHIP_EPOCH.EPOCH;
        PL.CHIP_EPOCH.CHIP  <= {{(CHIPSIZE-CHIPSIZE_CH){1'b0}},T.CHIP_EPOCH.CHIP[CHIPSIZE_CH-1:0]};
        PL.SEC              <= T.SEC;
    end
end

assign time_out.CHIP  = {{(CHIPSIZE-CHIPSIZE_CH){1'b0}},T.CHIP_EPOCH.CHIP[CHIPSIZE_CH-1:0]};
assign time_out.EPOCH = T.CHIP_EPOCH.EPOCH;
assign time_out.SEC   = T.SEC;

endmodule
