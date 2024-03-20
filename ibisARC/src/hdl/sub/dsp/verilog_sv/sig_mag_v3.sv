module sig_mag_v3
#(
    parameter WIDTH   = 14,
    parameter N_CH    = 1
)
(
    input                         clk,
    input signed [N_CH*WIDTH-1:0] data_in,
    input                         we,
    input                         clr,
    output logic [N_CH-1:0]       sig        = '0,
    output logic [N_CH-1:0]       mag        = '0,
    output logic                  valid      = '0,
    output logic                  adpt_ready = '0,
    output logic [WIDTH-2:0]      por_out,
    input        [WIDTH-2:0]      por_in,
    input                         por_manual
);

localparam cntr_width = 10;
localparam num_mag = (2**cntr_width)/3;

logic signed [WIDTH-1:0]      data [N_CH-1:0];
logic        [N_CH-1:0]       mag_bisec           = '0;
logic        [cntr_width-1:0] mag_cntr [N_CH-1:0] = '{default:'0};
logic        [cntr_width-1:0] cntr                = '0;

assign {>>{data}} = data_in;

logic [4:0] cntr_iter = '0;
assign cntr_end = cntr_iter[4:0] == ((WIDTH > 31)? 31 : WIDTH);

always_ff@(posedge clk)
if(clr | cntr_end)
    cntr_iter <= '0;
else if(we & (cntr == '1)) begin
    cntr_iter <= cntr_iter + 1'b1;
end

// logic adpt_ready = '0;

always_ff@(posedge clk)
if(clr)
    adpt_ready <= 1'b0;
else if(cntr_end) begin
    adpt_ready <= 1'b1;
end

logic [WIDTH-2:0] thr     [N_CH-1:0];
logic [WIDTH-2:0] thr_a   [N_CH-1:0] = '{default:'0};
logic [WIDTH-2:0] thr_b   [N_CH-1:0] = '{default:'1};

for(genvar i = 0; i < N_CH; i = i + 1) begin: CH_LOOP
    assign thr[i] = (thr_a[i] >> 1) + (thr_b[i] >> 1);
    
    always_ff@(posedge clk)
    if(clr | cntr_end) begin
        thr_a[i] <= '0;
        thr_b[i] <= '1;
    end else if(we & (cntr == '1)) begin
        if(mag_cntr[i] > num_mag) begin
            thr_a[i] <= thr[i];
        end else begin
            thr_b[i] <= thr[i];
        end
    end
    
    //---result---
    always_ff@(posedge clk)
    if(clr | (we & (cntr == '1)))
        mag_cntr[i] <= '0;
    else if(we & mag_bisec[i]) begin
        mag_cntr[i] <= mag_cntr[i] + 1'b1;
    end
    
    always_ff@(posedge clk)
    if(we & (adpt_ready | por_manual))
        sig[i] <= data[i][WIDTH-1];
    
    always_ff@(posedge clk)
    if(we & (adpt_ready | por_manual)) begin
        if(($signed(data[i]) > $signed({1'b0,por_out})) | ($signed(data[i]) < -$signed({1'b0,por_out})))
            mag[i] <= 1'b1;
        else
            mag[i] <= 1'b0;
    end
    
    always_ff@(posedge clk)
    if(we) begin
        if(($signed(data[i]) > $signed({1'b0,thr[i]})) | ($signed(data[i]) < -$signed({1'b0,thr[i]})))
            mag_bisec[i] <= 1'b1;
        else
            mag_bisec[i] <= 1'b0;
    end
end

max_parallel#(
    .WIDTH (WIDTH-1),
    .N_CH  (N_CH),
    .FL_EN (1)
) max_inst(
    .clk      (clk),
    .we       (cntr_end),
    .data_in  ({>>{thr}}),
    .data_out (por_out)
);

always_ff@(posedge clk)
if(clr)
    cntr <= 1'b0;
else if(we) begin
    cntr <= cntr + 1'b1;
end

always_ff@(posedge clk)
if(clr)
    valid = '0;
else if((adpt_ready | por_manual) & we)
    valid = '1;
else
    valid = '0;

endmodule