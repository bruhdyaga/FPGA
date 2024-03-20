`timescale 1ns/10ps
module max_args_tb();

`define aclk_freq     59
`define core_clk_freq 81

localparam MAX_ARGS_ID = 32'h11222233;
localparam BASEADDR    = 32'h40000000;
localparam ID_ADDR     = 0;
localparam NX_ADDR     = 1;
localparam NF_ADDR     = 1;
localparam R_LO_ADDR   = 2;
localparam R_HI_ADDR   = 3;
localparam IN_WIDTH    = 18;

reg aclk      = 1;
reg core_clk  = 1;
reg resetn    = 1;
reg reset_max = 0;
reg [15:0] NX;
reg [15:0] NF;
reg [63:0] R;

rwbus_interface bus_master();
reg [31:0] rdata;

assign bus_master.baseaddr = BASEADDR/4;
assign bus_master.clk      = aclk;
assign bus_master.resetn   = resetn;

always #((1000/`aclk_freq)/2)     aclk     = !aclk;
always #((1000/`core_clk_freq)/2) core_clk = !core_clk;



reg [IN_WIDTH-1:0] test_data;
reg [15:0] tau;
reg [15:0] freq;
reg we = 0;

initial begin
#20  resetn = 1'b0;
#100 resetn = 1'b1;

bus_master.Init;

bus_master.Read(BASEADDR/4,ID_ADDR,rdata,1);
forever begin
	$display ("%7gns wait bus constant", $time);
	bus_master.Read(BASEADDR/4,ID_ADDR,rdata,1);
	if(rdata == MAX_ARGS_ID) break;
end
$display ("%7gns bus constant OK!", $time);

#100 we  = 1'b1;
#1000 we = 1'b0;
#100 we  = 1'b1;
#1000 we = 1'b0;
#100 we  = 1'b1;
#1000 we = 1'b0;
#100 we  = 1'b1;
#1000 we = 1'b0;

bus_master.Read(BASEADDR/4,NX_ADDR,rdata,1);
NX = rdata[31:16];
NF = rdata[15:0];

bus_master.Read(BASEADDR/4,R_LO_ADDR,rdata,1);
R[31:0] = rdata;

bus_master.Read(BASEADDR/4,R_HI_ADDR,rdata,1);
R[63:32] = rdata;

end

ed_det#(
    .TYPE      ("fal"),  //"ed"-default,"ris","fal"
    .RESET_POL ("NEG")   // "POS" or "NEG"(def="POS")
) ed_det(
    .clk   (core_clk),
    .reset (resetn),
    .in    (we),
    .out   (we_fal)
);

always@(posedge core_clk or negedge resetn)
if(resetn == 0)
    test_data <= 0;
else
    if(we)
        test_data <= $random%(2**IN_WIDTH-1);

always@(posedge core_clk or negedge resetn)
if(resetn == 0)
    tau <= 0;
else
    if(we)
        tau <= tau + 1'b1;

always@(posedge core_clk or negedge resetn)
if(resetn == 0)
    freq <= 0;
else
    if(we_fal)
        freq <= freq + 1'b1;


max_args#(
    .IN_WIDTH (IN_WIDTH),
    .ID       (MAX_ARGS_ID)
) max_args_inst(
    .clk        (core_clk),
    .resetn     (resetn),
    .reset_max  (reset_max),
    .R          (test_data),
    .tau        (tau),
    .freq       (freq),
    .we         (we),
    .bus        (bus_master)
);

endmodule