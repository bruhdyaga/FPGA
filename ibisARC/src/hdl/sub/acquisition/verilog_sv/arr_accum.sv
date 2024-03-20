interface arr_accum_interface#(
    parameter KG_WIDTH  = 0,
    parameter NKG_WIDTH = 0
)
();

logic [KG_WIDTH-1:0]  kg;
logic                 end_kg;
logic [NKG_WIDTH-1:0] nkg;
logic                 end_nkg;
logic                 end_n_tau;
logic                 time_separation;

modport master
(
    output kg,
    output end_kg,
    output nkg,
    output end_nkg,
    output end_n_tau,
    output time_separation
);

modport slave
(
    input kg,
    input end_kg,
    input nkg,
    input end_nkg,
    input end_n_tau,
    input time_separation
);

endinterface

module arr_accum
#(
    parameter IN_WIDTH  = 0,// нет защиты от переполнения накопленной величины
    parameter OUT_WIDTH = 0,// желательно укладываться в разрядность памяти (18,36 разр)
    parameter N_args    = 0,
    parameter KG_MODE   = 0 // 1-когерентное накопление; 0-некогерентное
)
(
    input  clk,
    input  clr,
    input  signed [IN_WIDTH-1:0] R_in,
    output signed [OUT_WIDTH-1:0] R_out,
    input  we,
    output valid,
    arr_accum_interface.slave arr_accum_interface
);

latency#(// компенсация задержки данных перед памятью на 2-х триггерах
    .length(2)
) LATENCY_WE_MEM_INST(
    .clk     (clk),
    .in      (we),
    .out     (we_wr),
    .out_reg ()
);

//----------------------------------------
logic signed [OUT_WIDTH-1:0]      MEM_out;
logic        [$clog2(N_args)-1:0] wr_cntr; //счетчик позиций на запись
logic        [$clog2(N_args)-1:0] rd_cntr; //счетчик позиций на чтение
logic signed [OUT_WIDTH-1:0]      sum_reg;
assign last_rd_cntr = rd_cntr == (N_args-1);

bram_block_v2#(
    .OUT_REG ("EN"),
    .WIDTH   (OUT_WIDTH),
    .DEPTH   (N_args)
) bram_block_v2_inst(
    .wr_clk  (clk),
    .rd_clk  (clk),
    .we      (we_wr),
    .re      ('1),
    .dat_in  (sum_reg),
    .dat_out (MEM_out),
    .wr_addr (wr_cntr),
    .rd_addr (rd_cntr)
);

always_ff@(posedge clk)
if((we_wr == 0) | (wr_cntr == (N_args-1)))
    wr_cntr <= 0;
else
    wr_cntr <= wr_cntr + 1'b1;

always_ff@(posedge clk)
if((we == 0) | last_rd_cntr)
    rd_cntr <= 0;
else
    rd_cntr <= rd_cntr + 1'b1;
// END memory
//----------------------------------------

// --- state mashine ---
logic [15:0] kg_cntr='0;
logic [15:0] nkg_cntr='0;
assign last_kg  = kg_cntr  == (arr_accum_interface.kg-1);
assign last_nkg = nkg_cntr == (arr_accum_interface.nkg-1);

always_ff@(posedge clk)
if(clr)
    kg_cntr <= 0;
else begin
    if(last_rd_cntr)
        if(last_kg)
            kg_cntr <= 0;
        else
            kg_cntr <= kg_cntr + 1'b1;
end

always_ff@(posedge clk)
if(clr)
    nkg_cntr <= 0;
else begin
    if(last_rd_cntr & last_kg)
        if(last_nkg)
            nkg_cntr <= 0;
        else
            nkg_cntr <= nkg_cntr + 1'b1;
end

logic zero_mem = '0;
logic acc_en   = '0;

always_ff@(posedge clk)
if(KG_MODE == 1) begin
    if(kg_cntr == 0)
        zero_mem <= 1'b1;
    else
        zero_mem <= 0;
end else begin
    if(last_kg & (nkg_cntr == 0))
        zero_mem <= 1'b1;
    else
        zero_mem <= 0;
end

always_ff@(posedge clk)
if(KG_MODE == 1) begin
    acc_en <= 1'b1;
end else begin
    if(last_kg)
        acc_en <= 1'b1;
    else
        acc_en <= 0;
end
// --- state mashine end ---

logic signed [IN_WIDTH-1:0] R_in_reg = '0;

always_ff@(posedge clk)
R_in_reg <= $signed(R_in);

always_ff@(posedge clk)
if(zero_mem)
    sum_reg <= $signed(R_in_reg);
else
    if(acc_en)
        sum_reg <= $signed(R_in_reg) + $signed(MEM_out);
    else
        sum_reg <= MEM_out;

assign R_out = sum_reg;

generate
if(KG_MODE == 1) begin
    assign valid = we_wr;
end else begin
    latency#(
        .length(2)
    ) LATENCY_VALID_INST(
        .clk     (clk),
        .in      (last_kg & last_nkg),
        .out     (kg_nkg_cntr_valid),
        .out_reg ()
    );
    
    assign valid = we_wr & kg_nkg_cntr_valid;
end
endgenerate

endmodule
