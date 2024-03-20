/* 
dualport_ram#(
	.HI_PERFORMANCE_REG (),//"YES" or else(default)
	.WIDTH              (),
	.DEPTH              ()
)
dualport_ram_inst(
	.Aclk   (),
	.Awaddr (),
	.Araddr (),
	.Awdata (),
	.Ardata (),
	.Aen    (),
	.Awe    (),
	.Bclk   (),
	.Bwaddr (),
	.Braddr (),
	.Bwdata (),
	.Brdata (),
	.Ben    (),
	.Bwe    ()
);
 */
module dualport_ram(
	Aclk,
	Awaddr,
	Araddr,
	Awdata,
	Ardata,
	Aen,
	Awe,
	Bclk,
	Bwaddr,
	Braddr,
	Bwdata,
	Brdata,
	Ben,
	Bwe
);
`include "math.v"//log2

// Parameters
parameter HI_PERFORMANCE_REG = 0;//"YES" or else(default)//дополнительный регистр на выходе для большей производительности
parameter WIDTH = 1;
parameter DEPTH = 1;

// Do not modify below!

localparam AWIDTH = log2(DEPTH);

input               Aclk;
input  [AWIDTH-1:0] Awaddr;
input  [AWIDTH-1:0] Araddr;
input  [WIDTH-1:0]  Awdata;
output [WIDTH-1:0]  Ardata;
input               Aen;
input               Awe;
input               Bclk;
input  [AWIDTH-1:0] Bwaddr;
input  [AWIDTH-1:0] Braddr;
input  [WIDTH-1:0]  Bwdata;
output [WIDTH-1:0]  Brdata;
input               Ben;
input               Bwe;


wire [WIDTH-1:0] Ardata;   // Port A RAM output data
wire [WIDTH-1:0] Brdata;   // Port B RAM output data

reg [WIDTH-1:0] ram [DEPTH-1:0];
reg [WIDTH-1:0] ram_data_a = {WIDTH{1'b0}};
reg [WIDTH-1:0] ram_data_b = {WIDTH{1'b0}};

// The following code either initializes the memory values to a specified file or to all zeros to match hardware
generate
begin: init_bram_to_zero
  integer ram_index;
  initial
	for (ram_index = 0; ram_index < DEPTH; ram_index = ram_index + 1)
	  ram[ram_index] = {WIDTH{1'b0}};
end
endgenerate

always@(posedge Aclk)
if (Aen)
	if (Awe)
		ram[Awaddr] <= Awdata;
	else
		ram_data_a <= ram[Araddr];

always@(posedge Bclk)
if(Ben) begin
	if(Bwe)
		ram[Bwaddr] <= Bwdata;
	else
		ram_data_b <= ram[Braddr];
end

//  The following code generates HIGH_PERFORMANCE (use output register) or LOW_LATENCY (no output register)
generate
if (HI_PERFORMANCE_REG != "YES") begin: no_output_register

	// The following is a 1 clock cycle read latency at the cost of a longer clock-to-out timing
	assign Ardata = ram_data_a;
	assign Brdata = ram_data_b;

end else begin: output_register

	// The following is a 2 clock cycle read latency with improve clock-to-out timing

	reg [WIDTH-1:0] douta_reg = {WIDTH{1'b0}};
	reg [WIDTH-1:0] doutb_reg = {WIDTH{1'b0}};

	always@(posedge Aclk)
	if(Aen)
		douta_reg <= ram_data_a;

	always@(posedge Bclk)
	if(Ben)
		doutb_reg <= ram_data_b;

	assign Ardata = douta_reg;
	assign Brdata = doutb_reg;

end
endgenerate


endmodule