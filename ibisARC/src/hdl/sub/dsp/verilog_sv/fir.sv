`include "fir.svh"

module fir#(
    parameter BASEADDR      = 0,
    parameter WIDTH_IN_DATA = 0,
    parameter WIDTH_COEF    = 0,
    parameter ORDER         = 0,
    parameter NCH           = 0,
    parameter SYN_COEF      = 0,// синхронная запись коэффициентов из зеркала
    parameter ACC_SUM_WIDTH = 48
)
(
    intbus_interf.slave bus,
    adc_interf.slave    in,
    adc_interf.master   out,
    input               coef_mirr
);

wire signed [ACC_SUM_WIDTH-1:0] sum [NCH-1:0][ORDER:0];
wire signed [ACC_SUM_WIDTH-1:0] mul [NCH-1:0][ORDER:0];

reg signed [WIDTH_IN_DATA-1:0] A1_reg    [NCH-1:0][ORDER:0];
reg signed [WIDTH_IN_DATA-1:0] A2_reg    [NCH-1:0][ORDER:1];
reg signed [WIDTH_COEF-1:0]    B1_reg    [NCH-1:0][ORDER:0];
reg signed [WIDTH_COEF-1:0]    MIRR_COEF [NCH-1:0][ORDER:0];
reg signed [ACC_SUM_WIDTH-1:0] M_reg     [NCH-1:0][ORDER:0];
reg signed [ACC_SUM_WIDTH-1:0] P_reg     [NCH-1:0][ORDER:0];

FIR_STRUCT PL; // The registers from logic
FIR_STRUCT PS; // The registers from CPU

//Define which bits will be pulsed
localparam NPULSE = 1;
localparam integer PULSE [NPULSE][2] = '{
    '{1, 31} // release_pulse
};

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`FIR_ID_CONST),
    .DATATYPE (FIR_STRUCT),
    .NPULSE   (NPULSE),
    .PULSE    (PULSE)
)RF (
    .clk    (in.clk),
    .bus    (bus),
    .in     (PL),
    .out    (PS),
    .pulse  (coef_wr),
    .wr     (),
    .rd     ()
);

assign PL.CFG.RESERVED = '0;
assign PL.CFG.OUT_DIV  = '0;
assign PL.COEF         = '0;

assign PL.CFG.WIDTH_COEF_CONST = WIDTH_COEF;
assign PL.CFG.ORDER            = ORDER;


for(genvar i_NCH = 0; i_NCH < NCH; i_NCH ++) begin: CH_LOOP
    for(genvar i_ORDER = 0; i_ORDER <= ORDER; i_ORDER ++) begin: ORDER_LOOP
        if(i_ORDER == 0) begin
        
            always_ff@(posedge in.clk)
            if(in.valid) begin
                A1_reg[i_NCH][i_ORDER] <= in.data[i_NCH];
            end
            
            assign mul[i_NCH][i_ORDER] = A1_reg[i_NCH][i_ORDER] * B1_reg[i_NCH][i_ORDER];
            assign sum[i_NCH][i_ORDER] = M_reg[i_NCH][i_ORDER];
        end else begin // i_ORDER != 0
        
            if(i_ORDER == 1) begin
                always_ff@(posedge in.clk) begin
                    A1_reg[i_NCH][i_ORDER] <= A1_reg[i_NCH][i_ORDER-1];
                end
            end else begin
                always_ff@(posedge in.clk) begin
                    A1_reg[i_NCH][i_ORDER] <= A2_reg[i_NCH][i_ORDER-1];
                end
            end
            
            always_ff@(posedge in.clk) begin
                A2_reg[i_NCH][i_ORDER] <= A1_reg[i_NCH][i_ORDER];
            end
            
            assign mul[i_NCH][i_ORDER] = A2_reg[i_NCH][i_ORDER] * B1_reg[i_NCH][i_ORDER];
            assign sum[i_NCH][i_ORDER] = M_reg[i_NCH][i_ORDER] + P_reg[i_NCH][i_ORDER-1];
        end
        
        always_ff@(posedge in.clk)
        if(SYN_COEF) begin // синхронная запись из зеркала
            if(coef_mirr) begin
                B1_reg[i_NCH][i_ORDER] <= MIRR_COEF[i_NCH][i_ORDER];
            end
        end else begin // запись по шине напрямую
            if(coef_wr & (PS.COEF.ADDR == i_ORDER)) begin
                B1_reg[i_NCH][i_ORDER] <= PS.COEF.COEF[WIDTH_COEF-1:0];
            end
        end
        
        if(SYN_COEF) begin
            always_ff@(posedge in.clk)
            if(coef_wr & (PS.COEF.ADDR == i_ORDER)) begin
                MIRR_COEF[i_NCH][i_ORDER] <= PS.COEF.COEF[WIDTH_COEF-1:0];
            end
        end
        
        always_ff@(posedge in.clk) begin
            M_reg[i_NCH][i_ORDER] <= mul[i_NCH][i_ORDER];
        end
        
        always_ff@(posedge in.clk) begin
            P_reg[i_NCH][i_ORDER] <= sum[i_NCH][i_ORDER];
        end
        
    end
    
    always_ff@(posedge in.clk) begin
        out.data[i_NCH] <= P_reg[i_NCH][ORDER] >>> PS.CFG.OUT_DIV;
    end
end

assign out.clk    = in.clk;

latency#(
    .length (1 + ORDER*2 + 2)
)LATENCY_VALID (
    .clk     (in.clk),
    .in      (in.valid),
    .out     (out.valid),
    .out_reg ()
);

endmodule
