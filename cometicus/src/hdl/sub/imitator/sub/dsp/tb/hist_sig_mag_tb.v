`timescale 1ns/10ps
module hist_sig_mag_tb();

parameter lines = 7;

reg clk = 1;
reg tmp1 = 1;
reg tmp2 = 1;
reg tmp3 = 1;
reg reset = 0;
reg [7:0] addr;
reg [lines-1:0] sig;
wire [10:0] sig_asy;
reg [lines-1:0] mag;
wire [10:0] mag_asy;
reg [1:0] cntr;


genvar i;

always #5 clk = !clk;
always #1.12 tmp1 = !tmp1;
always #2.17 tmp2 = !tmp2;
always #6.39 tmp3 = !tmp3;

initial
begin
#15 reset  = 1'b1;
#150 reset = 1'b0;
end


initial
begin
#0     addr = 0;
#1000  addr = 1;
end

always@(posedge clk or posedge reset)
if(reset)
	cntr <= 0;
else
	cntr <= cntr + 1'b1;

assign mag_en = (cntr == 3);


assign sig_asy[0] = tmp1^tmp2;
assign sig_asy[1] = tmp1^tmp3;
assign sig_asy[2] = tmp2^tmp3;
assign sig_asy[3] = tmp1^tmp2^tmp3;
assign sig_asy[4] = tmp1^tmp3^tmp3;
assign sig_asy[5] = tmp2^tmp3^tmp3;
assign sig_asy[6] = tmp1;
assign sig_asy[7] = tmp2;
assign sig_asy[8] = tmp3;

assign mag_asy[0] = mag_en & (tmp1^tmp2);
assign mag_asy[1] = mag_en & (tmp1^tmp3);
assign mag_asy[2] = mag_en & (tmp2^tmp3);
assign mag_asy[3] = mag_en & (tmp1^tmp2^tmp3);
assign mag_asy[4] = mag_en & (tmp1^tmp3^tmp3);
assign mag_asy[5] = mag_en & (tmp2^tmp3^tmp3);
assign mag_asy[6] = mag_en & (tmp1);
assign mag_asy[7] = mag_en & (tmp2);
assign mag_asy[8] = mag_en & (tmp3);

generate
for(i=0;i<lines;i=i+1)
begin:loop_lines_sig_mag
	always@(posedge clk)
	begin
		sig[i] <= sig_asy[i];
		mag[i] <= mag_asy[i];
	end
end
endgenerate

hist_sig_mag#(
	.lines(lines)
)
hist_sig_mag_inst(
	.clk    (clk),
	.reset  (reset),
	.sig    (sig),
	.mag    (mag),
	.lock   (0),
	.addr   (addr),//8 bit
	.result ()
);

endmodule