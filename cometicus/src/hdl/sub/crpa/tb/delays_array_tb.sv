`timescale 1ns/10ps

module delays_array_tb();

localparam Nin      = 8;
localparam in_width = 14;
localparam NT       = 4;

reg clk = 1;
// ADC interface
adc_interf#(
    .PORTS (Nin),
    .R     (in_width)
)data_in ();

adc_interf_3d#(
    .PORTS (Nin),
    .GROUP (NT),
    .R     (in_width)
)data_dly ();

always #5 clk <= !clk;
initial begin
    @(posedge clk);
    data_in.resetn <= '1;
    
    @(posedge clk);
    data_in.resetn <= '0;
    
    @(posedge clk);
    data_in.resetn <= '1;
end

assign data_in.clk = clk;

for(genvar i = 0; i < Nin; i ++) begin: GEN_DATA
    always_ff@(posedge data_in.clk or negedge data_in.resetn)
    if(data_in.resetn == '0) begin
        data_in.data[i] <= '0;
    end else begin
        data_in.data[i] <= data_in.data[i] + i;
    end
end

delays_array#(
    .Nin      (Nin     ),
    .in_width (in_width),
    .NT       (NT      )
) DLA(
    .data_in  (data_in),
    .data_dly (data_dly),
    .ena      ('1)
);

endmodule