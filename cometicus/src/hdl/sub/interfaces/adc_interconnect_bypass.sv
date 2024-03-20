module adc_interconnect_bypass
#(
    parameter NCH = 1
)
(
    adc_interf.slave    adc_in[NCH],
    adc_interf.master   adc_out[NCH]
);

for(genvar i = 0; i < NCH; i ++) begin
    assign adc_out[i].clk    = adc_in[i].clk;
    assign adc_out[i].valid  = adc_in[i].valid;
    assign adc_out[i].data   = adc_in[i].data;
end

endmodule