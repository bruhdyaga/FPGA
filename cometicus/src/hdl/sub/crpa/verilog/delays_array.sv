module delays_array
#(
    parameter  Nin   = 0,
    parameter  NT    = 0
)
(
    adc_interf.slave     data_in,
    adc_interf_3d.master data_dly,
    input                ce
);

assign data_dly.clk    = data_in.clk;

reg [NT-1:0] valid_dly;

always_ff@(posedge data_in.clk)
if(ce) begin
    valid_dly <= {valid_dly[NT-2:0],data_in.valid};
end

assign data_dly.valid = valid_dly[NT-1] & data_in.valid; // конец valid ограничиваем правильными данными на входе

for(genvar i = 0; i < NT; i ++) begin: DLY
    always_ff@(posedge data_in.clk)
    if(ce) begin
        data_dly.data[i] <= (i == 0) ? data_in.data : data_dly.data[i-1];
    end
end

endmodule
