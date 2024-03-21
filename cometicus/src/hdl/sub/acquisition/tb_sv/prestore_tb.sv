`timescale 1ns/10ps
`include "prestore.svh"
`include "DDS_sin_cos.svh"
module prestore_tb(
);

localparam N_dig_in  = 13;
localparam N_dig_out = 3;
localparam DATA_WIDTH = 32;
localparam BASEADDR  = 32'h43c00000;
localparam ID_PRESTORE = 32'h48964894;

localparam FREQ_SAMPLE = 100e6;
localparam REF_FREQ    = 5e6;

localparam PRESTORE_BASE    = BASEADDR/4;
localparam DDS_SIN_COS_BASE = PRESTORE_BASE + ($bits(PRESTORE_RO_STRUCT)+1+$bits(PRESTORE_RW_STRUCT)+1)/DATA_WIDTH;
localparam DDS_BIN_BASE     = DDS_SIN_COS_BASE + ($bits(DDS_SIN_COS_RO_STRUCT)+1+$bits(DDS_SIN_COS_RW_STRUCT)+1)/DATA_WIDTH;

reg signed [N_dig_in-1:0] test_data;

reg clk = 1;
reg aclk = 1;

rwbus_interface bus_master();
reg [31:0] rdata;

assign bus_master.baseaddr = BASEADDR/4;
assign bus_master.clk      = aclk;

always #(1e9/FREQ_SAMPLE/2) clk = !clk;//100 MHz
always #8.33 aclk = !aclk;//60 MHz

assign resetn = bus_master.resetn;

initial begin
bus_master.Init;

bus_master.Read(PRESTORE_BASE,0,rdata,1);
forever begin
	$display ("%7gns wait bus constant", $time);
	bus_master.Read(PRESTORE_BASE,0,rdata,1);
	if(rdata == ID_PRESTORE) break;
end//ресет завершен, датаколлектор готов
$display ("%7gns bus constant OK!", $time);

bus_master.Write(DDS_SIN_COS_BASE,1,64'd4294967296*(REF_FREQ/FREQ_SAMPLE),1);// конфигурация DDS опорных сигналов
bus_master.Write(DDS_BIN_BASE,1,64'd4294967296*(10.23e6/2/FREQ_SAMPLE),1);// конфигурация DDS интервала преднакопления

bus_master.Write(PRESTORE_BASE,2,32'd1,1);// разрешили синхронный старт поиска
bus_master.Write(PRESTORE_BASE,1,32'hF000,1);// настроили задержку старта поиска
end

always@(posedge clk or negedge resetn)
if(resetn == 0)
	test_data <= 0;
else
	test_data <= $random%(2**N_dig_in-1);

sig_mag_v3
#(
	.width (N_dig_in)
)
sig_mag_v3_I(
	.clk     (clk),
	.resetn  (resetn),
	.data_in (test_data),//signed
	.we      (1'b1),
	.sig     (sig_I),
	.mag     (mag_I),
	.valid   (valid_qnt_I)
);

sig_mag_v3
#(
	.width (N_dig_in)
)
sig_mag_v3_Q(
	.clk     (clk),
	.resetn  (resetn),
	.data_in (test_data),//signed
	.we      (1'b1),
	.sig     (sig_Q),
	.mag     (mag_Q),
	.valid   (valid_qnt_Q)
);

reg ms_epoch;
reg [31:0] ms_epoch_cntr;

always@(posedge clk or negedge resetn)
if(resetn == 0) begin
	ms_epoch_cntr <= 0;
	ms_epoch <= 0;
end else if(ms_epoch_cntr == 32'd100000) begin
	ms_epoch_cntr <= 0;
	ms_epoch <= 1'b1;
end else begin
	ms_epoch_cntr <= ms_epoch_cntr + 1'b1;
	ms_epoch <= 0;
end


prestore
#(
	.ID (ID_PRESTORE)
)
prestore_inst(
	.clk       (clk),//с фронтенда
	.resetn    (resetn),//asy
	.ms_epoch  (ms_epoch),
	.sig_I     (sig_I),
	.mag_I     (mag_I),
	.sig_Q     (sig_Q),
	.mag_Q     (mag_Q),
	.I_sum_sig (I_sum_sig),
	.I_sum_mag (I_sum_mag),
	.Q_sum_sig (Q_sum_sig),
	.Q_sum_mag (Q_sum_mag),
	.valid     (valid),//строб по накопленной величине
	.bus       (bus_master)
);

localparam SIGMAG_CNTR_SIZE = 13;
reg [SIGMAG_CNTR_SIZE-1:0] sigmag_cntr;
reg [SIGMAG_CNTR_SIZE-1:0] sig_cntr;
reg [SIGMAG_CNTR_SIZE-1:0] mag_cntr;

always@(posedge clk or negedge resetn)
if(resetn == 0)
	sigmag_cntr <= 0;
else if(valid)
	sigmag_cntr <= sigmag_cntr + 1'b1;

always@(posedge clk or negedge resetn)
if(resetn == 0) begin
	sig_cntr <= 0;
	mag_cntr <= 0;
end else if(valid)
	if(sigmag_cntr == 0) begin
		sig_cntr <= 0;
		mag_cntr <= 0;
	end else begin
		if(I_sum_sig) sig_cntr <= sig_cntr + 1'b1;
		if(I_sum_mag) mag_cntr <= mag_cntr + 1'b1;
	end

reg [6:0] sig_dist;
reg [6:0] mag_dist;

always@(posedge clk or negedge resetn)
if(resetn == 0) begin
	sig_dist <= 0;
	mag_dist <= 0;
end else if(sigmag_cntr == '1) begin
	sig_dist <= sig_cntr*100/(2**SIGMAG_CNTR_SIZE);
	mag_dist <= mag_cntr*100/(2**SIGMAG_CNTR_SIZE);
end


endmodule