module conf_power_supply (

input clk,
output POWER_R&T_ON/OFF,
output PWR_SYNC_A1,
output PWR_SYNC_D1
    
);

always @(posedge clk)

begin
    if(!rst)
    begin
        POWER_R&T_ON/OFF <= 1'b0;
        PWR_SYNC_A1 <= 1'b0;
        PWR_SYNC_D1F <= 1'b0;

    end
    else begin
        POWER_R&T_ON/OFF <= 1'b1; // more than 1.225V
        PWR_SYNC_A1 <= sync;
        PWR_SYNC_D1F <= sync;


    end
end
endmodule

SYNC SYNC_inst(
    .sync(sync)
)