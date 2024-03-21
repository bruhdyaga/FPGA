interface intbus_interf
    #(    
          parameter ADDR_WIDTH = 28,         // Address bus width
          parameter DATA_WIDTH = 32          // Data bus width
    );

    /// Bus signals
    logic                      clk;        // Bus (CPU) clock
    logic [ADDR_WIDTH - 1 : 0] addr;       // Address bus
    logic [DATA_WIDTH - 1 : 0] wdata;      // Write data bus
    logic [DATA_WIDTH - 1 : 0] rdata;      // Read data bus
    logic                      rvalid;     // Read valid
    logic                      wr;         // Write enable flag
    logic                      rd;         // Read enable flag
    
    /// Modports    
    modport slave                          // Bus slave modport
    (
        input   clk,
        input   addr,
        input   wdata,
        output  rdata,
        output  rvalid,
        input   wr,
        input   rd
    );
    
    modport master
    (
        output clk,
        output addr,
        output wdata,
        input  rdata,
        input  rvalid,
        output wr,
        output rd
    );
    
    modport debug
    (
        input clk,
        input addr,      // port 1
        input wdata,     // port 2
        input rdata,     // port 3
        input rvalid,    // port 4
        input wr,        // port 5
        input rd         // port 6
    );
endinterface // intbus_interf

// pipeline module
module pipe_line_bus#(
    parameter PS_FF = "n",
    parameter PL_FF = "n"
)
(
    intbus_interf.slave  master_bus, // к хабу процессора
    intbus_interf.master slave_bus   // к модулю
);

assign slave_bus.clk    = master_bus.clk;

if(PS_FF == "n") begin
    always@(*) slave_bus.addr  = master_bus.addr;
    always@(*) slave_bus.wdata = master_bus.wdata;
    always@(*) slave_bus.wr    = master_bus.wr;
    always@(*) slave_bus.rd    = master_bus.rd;
end else begin
    always_ff@(posedge master_bus.clk) begin
        slave_bus.addr  <= master_bus.addr;
        slave_bus.wdata <= master_bus.wdata;
        slave_bus.wr    <= master_bus.wr;
        slave_bus.rd    <= master_bus.rd;
    end
end

if(PL_FF == "n") begin
    always@(*) master_bus.rdata  = slave_bus.rdata;
    always@(*) master_bus.rvalid = slave_bus.rvalid;
end else begin
    always_ff@(posedge master_bus.clk) begin
        master_bus.rdata  <= slave_bus.rdata;
        master_bus.rvalid <= slave_bus.rvalid;
    end
end

endmodule

// hub
module connectbus
    #(
        parameter BASEADDR   = 0,
        parameter N_BUSES    = 1,
        parameter DATA_WIDTH = 32,
        parameter OUTFF      = "n", // триггеры на шины В мастер
        parameter MASTERFF   = "n", // триггеры на шины ИЗ мастера
        parameter TIMEOUT    = 15,
        parameter TOP_LEVEL  = 0
    )
    (
        intbus_interf.slave master_bus,
        intbus_interf.master slave_bus[N_BUSES]
    );
    
    localparam HUB_OUTS_ID_OFFSET   = 0;
    
    localparam HUB_ID = 16'h46E4;
    
    reg [DATA_WIDTH-1:0] hub_rdata;
    
    assign hub_id_rd = master_bus.rd & (master_bus.addr == (BASEADDR + HUB_OUTS_ID_OFFSET));
    
    assign hub_rvalid = hub_id_rd;
    always_comb
    case(1'b1)
        hub_id_rd   : hub_rdata <= {((N_BUSES & 16'hFFFF) << 16) | HUB_ID};
        default     : hub_rdata <= 0;
    endcase
    
    logic [N_BUSES - 1 : 0]    rdata_array_transp [DATA_WIDTH - 1 : 0];
    logic [DATA_WIDTH - 1 : 0] rdata_array        [N_BUSES - 1 : 0]; 
    logic [N_BUSES - 1 : 0]    rvalid_array;
    
    for(genvar i = 0; i < N_BUSES; i ++) begin: loop_hub_buses
        assign slave_bus[i].clk    = master_bus.clk;
        if(MASTERFF == "n") begin
            always@(*) begin
                slave_bus[i].addr   <= master_bus.addr;
                slave_bus[i].wdata  <= master_bus.wdata;
                slave_bus[i].wr     <= master_bus.wr;
                slave_bus[i].rd     <= master_bus.rd;
            end
        end else begin
            always_ff@(posedge master_bus.clk) begin
                slave_bus[i].addr   <= master_bus.addr;
                slave_bus[i].wdata  <= master_bus.wdata;
                slave_bus[i].wr     <= master_bus.wr;
                slave_bus[i].rd     <= master_bus.rd;
            end
        end
        a_vl_1: assert property (@(posedge slave_bus[i].clk) ~slave_bus[i].rvalid |-> slave_bus[i].rdata == '0)
            else $error("data on inactive bus");
        a_vl_2: assert property (@(posedge slave_bus[i].clk) slave_bus[i].rvalid |-> (rvalid_array & (~(1 << i))) == '0)
            else $error("multiple valid on a bus");
        a_rdwr: assert property (@(posedge slave_bus[i].clk) slave_bus[i].rd != '0 |-> slave_bus[i].wr == '0)
            else $error("rd, wr - are both high");
    end
    
    if(TOP_LEVEL) begin
        a_vl_mstr_1: assert property (@(posedge master_bus.clk) master_bus.rd |-> ##[0:TIMEOUT] master_bus.rvalid)
            else $error("no rvalid from rd");
    end
    a_vl_mstr_2: assert property (@(posedge master_bus.clk) master_bus.rvalid |-> ##[0:TIMEOUT] $past(master_bus.rd, TIMEOUT))
        else $error("valid without rd");
    
    for(genvar i = 0; i < N_BUSES; i ++) begin: loop_repack_buses
        assign rdata_array[i]  = slave_bus[i].rdata;
        assign rvalid_array[i] = slave_bus[i].rvalid;
    end
    
    for(genvar i = 0; i < N_BUSES; i ++) begin: loop_transpose_bus
        for(genvar j = 0; j < DATA_WIDTH; j ++) begin: loop_transpose_bus
            assign rdata_array_transp[j][i] = rdata_array[i][j];
        end
    end
    
    if(OUTFF == "n") begin
        always@(*) master_bus.rvalid = |rvalid_array | hub_rvalid;
    end
    else begin
        always_ff@(posedge master_bus.clk) begin
            master_bus.rvalid <= |rvalid_array | hub_rvalid;
        end
    end
    
    for(genvar i = 0; i < DATA_WIDTH; i ++) begin: loop_or_buses
        if(OUTFF == "n") begin
            always@(*) master_bus.rdata[i] = |rdata_array_transp[i] | hub_rdata[i];
        end
        else begin
            always_ff@(posedge master_bus.clk) begin
                master_bus.rdata[i] <= |rdata_array_transp[i] | hub_rdata[i];
            end
        end
    end
    
endmodule