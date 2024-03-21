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

module regs_file
    #(
        parameter BASEADDR    = 0,
        parameter ID          = 0,
        parameter DATA_WIDTH  = 32,
        parameter type DATATYPE = logic[DATA_WIDTH - 1 : 0],  // Type of the data object
        parameter OUTFF = "n",
        parameter NREGS = (($bits(DATATYPE) + 1)/DATA_WIDTH),
        parameter logic [7 : 0] SYNCI [NREGS] = '{NREGS{"n"}},
        parameter logic [7 : 0] SYNCO [NREGS] = '{NREGS{"n"}},
        parameter DATATYPE INIT = '0,
        parameter NPULSE = 0,
        parameter integer PULSE [0 : (NPULSE ? NPULSE : 1)  - 1][2] = '{'{(NPULSE ? NPULSE : 1){0, 0}}},
        parameter [NREGS - 1 : 0] RVALID_FF = '0  // extra ff for rvalid
    )
    (
        input                   clk,
        intbus_interf.slave     bus,
        input  DATATYPE         in,      // Data from logic to bus
        output DATATYPE         out,     // Data from bus to logic
        output [(NPULSE ? NPULSE : 1) - 1 : 0] pulse,
        output [NREGS - 1 : 0]  wr, // Write enable for each register
        output [NREGS - 1 : 0]  rd  // Read enable for each register
    );
    
    typedef logic [0 : $bits(DATATYPE) - 1] arr;
    
    reg  [DATA_WIDTH - 1 : 0] reg_wdata [NREGS - 1 : 0] = '{default:0}; // Writable registers
    wire [DATA_WIDTH - 1 : 0] reg_rdata [NREGS - 1 : 0];                // rdata for each register
    wire [DATA_WIDTH - 1 : 0] reg_rdata_const;                          // rdata for ID and SIZE
    wire [DATA_WIDTH - 1 : 0] reg_rdata_int [NREGS - 1 : 0];
    wire [DATA_WIDTH - 1 : 0][NREGS - 1 : 0] reg_mem;                   // rdata for each register
    wire [DATA_WIDTH - 1 : 0] reg_mem_const;                            // rdata for ID and SIZE
    
    wire                 reg_const_rd; // Read enable for ID and SIZE register
    wire [NREGS - 1 : 0] sync_rd;      // Sync read enable for each register
    
    logic [NREGS - 1 : 0] rvalid_arr; // rd strobe arr with extra FF
    
    reg [(NPULSE ? NPULSE : 1) - 1 : 0] pulse_reg;
    
    arr out_arr;
    assign out = DATATYPE'(out_arr);
    
    arr in_arr;
    assign in_arr = arr'(in);
    
    arr init_arr;
    assign init_arr = arr'(INIT);
    
    // Write access implementation 
    for(genvar i = 0; i < NREGS; i++) begin: WR_GEN
        assign wr[i] = (bus.addr == BASEADDR + i + 1) & bus.wr; // first reg is NREGS_SIZE and ID
        always_ff@(posedge bus.clk) begin: WR_AWS
            if(wr[i]) begin
                reg_wdata[i] <= bus.wdata;
            end
        end
        if(SYNCO[i] == "n") begin
            assign out_arr[DATA_WIDTH * i +: DATA_WIDTH] = reg_wdata[i];
        end
        else if(SYNCO[i] == "l") begin
            level_sync // From bus domain to user domain
                #(
                    .WIDTH      (DATA_WIDTH)
                ) LS_out(
                    .clk      (clk),
                    .async    (reg_wdata[i]),
                    .sync     (out_arr[DATA_WIDTH * i +: DATA_WIDTH])
                );
        end
        else if(SYNCO[i] == "d") begin
            reg start;
            always_ff@(posedge bus.clk) begin
                if(!wr[i]) begin
                    start <= '0;
                end
                else begin
                    start <= '1;
                end
            end
            
            data_sync
                #(.WIDTH  (DATA_WIDTH))
            DS_out
                (
                    .sclk       (bus.clk),
                    .dclk       (clk),
                    .start      (start),
                    .data       (reg_wdata[i]),
                    .ready      (/*not used*/),
                    .sync_data  (out_arr[DATA_WIDTH * i +: DATA_WIDTH])
                );
        end
        else begin
            initial $error("Invalid argument for SYNCO[%0d]: %s",i,SYNCO[i]);
        end
        
        if(NPULSE) begin : PULSING
            for(genvar j = 0; j < DATA_WIDTH; j++) begin
                for(genvar k = 0; k < NPULSE; k++) begin
                    if ((PULSE[k][0] == i) && (PULSE[k][1] == j)) begin
                        always_ff@(posedge bus.clk) begin
                            if(!wr[i]) begin
                                pulse_reg[k] <= '0;
                            end else begin
                                pulse_reg[k] <= bus.wdata[j];
                            end
                        end
                        signal_sync PULSE_SYNC
                        (
                            .sclk     (bus.clk),
                            .dclk     (clk),
                            .start    (pulse_reg[k]),
                            .ready    (pulse[k])
                        );
                    end
                end
            end
        end
        else begin
            assign pulse ='0;
        end
    end
    
    // Read access implementation
    for(genvar i = 0; i < NREGS; i++) begin: TR1
        if(SYNCI[i] == "n") begin
            assign reg_rdata_int[i] = '0;
            assign sync_rd[i] = '0;
            assign rd[i] = (bus.addr == BASEADDR + i + 1) & bus.rd; // first reg is NREGS_SIZE and ID
            assign reg_rdata[i] = rvalid_arr[i] ? in_arr[DATA_WIDTH * i +: DATA_WIDTH] : '0;
        end
        else if(SYNCI[i] == "l") begin
            assign sync_rd[i] = '0;
            level_sync // From user domain to bus domain
                #(
                    .WIDTH      (DATA_WIDTH)
                ) LS_in(
                    .clk      (bus.clk),
                    .async    (in_arr[DATA_WIDTH * i +: DATA_WIDTH]),
                    .sync     (reg_rdata_int[i])
                );
            assign rd[i] = (bus.addr == BASEADDR + i + 1) & bus.rd; // first reg is NREGS_SIZE and ID
            assign reg_rdata[i] = rvalid_arr[i] ? reg_rdata_int[i] : '0;
        end
        else if(SYNCI[i] == "d") begin
            assign reg_rdata_int[i] = '0;
            signal_sync RD_SYNC
            (
                .sclk     (bus.clk),
                .dclk     (clk),
                .start    ((bus.addr == BASEADDR + i + 1) & bus.rd), // first reg is NREGS_SIZE and ID
                .ready    (sync_rd[i])
            );
            data_sync
                #(.WIDTH  (DATA_WIDTH))
            DS_out
            (
                .sclk       (clk),
                .dclk       (bus.clk),
                .start      (sync_rd[i]),
                .data       (in_arr[DATA_WIDTH * i +: DATA_WIDTH]),
                .ready      (rvalid_arr[i]),
                .sync_data  (reg_rdata[i])
            );
        end
        else begin
            initial $error("Invalid argument for SYNCI[%0d]: %s",i,SYNCI[i]);
        end
        
        // "Transposed" read data (for "massive OR" below")
        for(genvar j = 0; j < DATA_WIDTH; j++) begin: TR2
            assign reg_mem[j][i]  = reg_rdata[i][j];
        end
    end
    
    assign reg_const_rd = (bus.addr == BASEADDR) & bus.rd; // NREGS_SIZE and ID
    assign reg_rdata_const = reg_const_rd ? {(((NREGS + 1) & 16'hFFFF) << 16) | (ID & 16'hFFFF)} : '0;
    // "Transposed" read data (for "massive OR" below")
    for(genvar j = 0; j < DATA_WIDTH; j++) begin: TR_CONST
        assign reg_mem_const[j] = reg_rdata_const[j];
    end
    
    for(genvar i = 0; i < NREGS; i++) begin: RVLD
        if(RVALID_FF[i] == '1) begin
            always_ff@(posedge bus.clk) begin
                rvalid_arr[i] <= rd[i];
            end
        end else begin
            assign rvalid_arr[i] = rd[i];
        end
    end
    
    // "Massive OR" over all rdata from registers
    for(genvar i = 0; i < DATA_WIDTH; i++) begin: RD_GEN
        if(OUTFF == "n") begin
            assign bus.rdata[i] = (|{rvalid_arr,reg_const_rd}) ? (|{reg_mem[i],reg_mem_const[i]}) : '0;
        end
        else begin
            always_ff@(posedge bus.clk) begin
                bus.rdata[i] <= |{rvalid_arr,reg_const_rd} ? (|{reg_mem[i],reg_mem_const[i]}) : '0;
            end
        end
    end
    
    if(OUTFF == "n") begin
        assign bus.rvalid = |{rvalid_arr,reg_const_rd} ? '1 : '0;
    end
    else begin
        always_ff@(posedge bus.clk) begin
            bus.rvalid <= |{rvalid_arr,reg_const_rd} ? '1 : '0;
        end
    end

endmodule
