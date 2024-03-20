module conf_power_supply (

input clk,
input rst,
output POWER_RT_ON_OFF,
output PWR_SYNC_A1,
output PWR_SYNC_D1,
output PWR_SYNC_A2,
output PWR_SYNC_A3,
output LO2_EN,
output T_LO_EN,
output T_PWR_EN

);
assign POWER_RT_ON_OFF = 1'b1;

endmodule