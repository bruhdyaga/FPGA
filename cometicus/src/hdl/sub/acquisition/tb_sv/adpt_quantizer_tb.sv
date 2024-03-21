`timescale 1ns/10ps
module adpt_quantizer_tb(
);

localparam N_dig_in  = 13;
localparam N_dig_out = 3;
localparam BASEADDR  = 32'h43c00000;
localparam ID_ADPT   = 32'h12345678;


reg signed [N_dig_in-1:0] test_data;

reg clk = 1;
reg aclk = 1;
reg resetn = 1;

// rwbus_interface.master bus_master;
rwbus_interface bus_master();
reg [31:0] rdata;

assign bus_master.baseaddr = BASEADDR/4;
assign bus_master.clk      = aclk;
assign bus_master.resetn   = resetn;

always #5 clk = !clk;//100 MHz
always #8.33 aclk = !aclk;//60 MHz

initial begin
#20 resetn = 1'b0;
#20 resetn = 1'b1;
bus_master.Init;

bus_master.Read(BASEADDR/4,0,rdata,1);
// while(rdata != ID_ADPT) begin//дожидаемся чтения нужной константы
forever begin
	$display ("%7gns wait bus constant", $time);
	bus_master.Read(BASEADDR/4,0,rdata,1);
	if(rdata == ID_ADPT) break;
end//ресет завершен, датаколлектор готов
$display ("%7gns bus constant OK!", $time);

end

bit tmp;
always@(*) tmp = rdata == ID_ADPT;

always@(posedge clk or negedge resetn)
if(resetn == 0)
	test_data <= 0;
else
	test_data <= $random%(2**N_dig_in-1);



adpt_quantizer
#(
	.ID        (32'h12345678),
	.N_dig_in  (N_dig_in),
	.N_dig_out (N_dig_out)
)
adpt_quantizer_inst (
	.clk     (clk),
	.resetn  (resetn),
	.dat_in  (test_data),//signed
	.dat_out (),//signed
	.we      (1'b1),
	.valid   (),
	.bus     (bus_master)
);


endmodule