module conf_power_supply (

input clk,
input rst,
output POWER_R&T_ON/OFF,
output PWR_SYNC_A1,
output PWR_SYNC_D1,
output PWR_SYNC_A2,
output PWR_SYNC_A3,
output LO2_EN,
output T_LO_EN,
output T_PWR_EN

);

always @(posedge clk or negedge rst)

begin
    if(!rst)
    begin
        POWER_R&T_ON/OFF <= 1'b0;
        PWR_SYNC_A1 <= 1'b0;
        PWR_SYNC_D1 <= 1'b0;
        PWR_SYNC_A2 <= 1'b0;
        PWR_SYNC_A3 <= 1'b0;
        LO2_EN      <= 1'b0;
    end
    else begin
        POWER_R&T_ON/OFF <= 1'b1; // more than 1.225V
        // list 2
        PWR_SYNC_A1 <= sync_550kHz;
        PWR_SYNC_D1 <= sync_550kHz;
        //list 3
        PWR_SYNC_A2 <= sync_550kHz;
        PWR_SYNC_A3 <= sync_550kHz;
        //list 5
        PWR_SYNC_D2 <= sync_750kHz;
        //list 9
        LO2_EN      <= 1'b1; // more than 0.5V
        //list 10
        T_LO_EN     <= 1'b1; // more than 0.5V
        //list 11
        T_PWR_EN    <= 1'b1;
    end
end


SYNC_550kHz SYNC_550kHz_inst(
    .sync_550kHz(sync_550kHz)
);

SYNC_750kHz SYNC_750kHz_inst(
    .sync_750kHz(sync_750kHz)
);

endmodule