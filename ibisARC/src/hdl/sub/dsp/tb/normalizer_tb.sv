`timescale 1ns/10ps

`include "global_param.v"

module normalizer_tb();

localparam WIDTH   = 12;
localparam TWIDTH  = 16;
localparam IQWIDTH = 10;
localparam LENGTH  = 1000;

`define aclk_freq     150  // MHz
`define clk_freq     150  // MHz

reg aclk = 1;
reg clk = 1;

localparam NBUSES = 2;
axi3_interface  axi3();
intbus_interf#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)bus();

always #((1000/`aclk_freq)/2) aclk <= !aclk;
always #((1000/`clk_freq)/2)  clk  <= !clk;

cpu_sim#(
    .ID (0)
) cpu_sim_inst(
    .aclk   (aclk),
    .axi3   (axi3)
);

axi3_to_inter#(
    .ADDR_WIDTH (`ADDR_WIDTH)
)axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

logic signed [IQWIDTH-1:0] i_dds;
logic signed [IQWIDTH-1:0] q_dds;
logic signed [IQWIDTH-1:0] i_in_scale;
logic signed [IQWIDTH-1:0] q_in_scale;
logic signed [WIDTH-1:0]   i_in;
logic signed [WIDTH-1:0]   q_in;
logic signed [WIDTH-1:0]   i_out;
logic signed [WIDTH-1:0]   q_out;

logic signed [WIDTH-1:0] i_ext_arr     [LENGTH-1:0];
logic signed [WIDTH-1:0] q_ext_arr     [LENGTH-1:0];
logic signed [WIDTH-1:0] i_out_ext_arr [LENGTH-1:0];
logic signed [WIDTH-1:0] q_out_ext_arr [LENGTH-1:0];
logic signed [WIDTH-1:0] i_ext;
logic signed [WIDTH-1:0] q_ext;
logic signed [WIDTH-1:0] i_out_ext;
logic signed [WIDTH-1:0] q_out_ext;
logic signed [WIDTH-1:0] i_err;
logic signed [WIDTH-1:0] q_err;

initial begin
    $readmemb("../sub/dsp/tb/csv/i_in.txt",  i_ext_arr,     0, LENGTH-1);
    $readmemb("../sub/dsp/tb/csv/q_in.txt",  q_ext_arr,     0, LENGTH-1);
    $readmemb("../sub/dsp/tb/csv/i_out.txt", i_out_ext_arr, 0, LENGTH-1);
    $readmemb("../sub/dsp/tb/csv/q_out.txt", q_out_ext_arr, 0, LENGTH-1);
end

logic [$clog2(LENGTH)-1:0] addr = '0;
assign i_ext     = i_ext_arr[addr];
assign q_ext     = q_ext_arr[addr];
assign i_out_ext = i_out_ext_arr[addr];
assign q_out_ext = q_out_ext_arr[addr];
assign i_err     = i_out - i_out_ext;
assign q_err     = q_out - q_out_ext;

always_ff@(posedge clk)
if(addr == (LENGTH-1)) begin
    addr <= '0;
end else begin
    addr <= addr + 1'b1;
end


real scale_s = 1;
real scale_fl = 1;
always_ff@(posedge clk)
if(scale_fl > 20) begin
    scale_s = -1;
end else begin
    if(scale_fl < 1) begin
        scale_s = 1;
    end
end

always_ff@(posedge clk)
scale_fl = scale_fl + (scale_s * 0.01);

assign i_in_scale = $signed(i_dds) / scale_fl;
assign q_in_scale = $signed(q_dds) / scale_fl;

assign i_in = i_in_scale <<< (WIDTH - IQWIDTH);
assign q_in = q_in_scale <<< (WIDTH - IQWIDTH);

dds_iq_hd#(
    .IQ_WIDTH    (IQWIDTH),
    .PHASE_WIDTH (9),
    .TABLE_NAME  ("../sub/dsp/verilog_sv/dds_iq_hd_ph9_iq_10.txt")
) dds_iq_hd_inst(
    .clk        (clk),
    .sin        (i_dds),
    .cos        (q_dds),
    .code       (1 << 25),
    .phase_cntr ()
);

normalizer#(
    .BASEADDR (0),
    .WIDTH    (WIDTH),
    .TWIDTH   (TWIDTH)
) normalizer_ins(
    .bus   (bus),
    .clk   (clk),
    .i_in  (i_ext),
    .q_in  (q_ext),
    .i_out (i_out),
    .q_out (q_out),
    .we    ('1   ),
    .valid (valid)
);

endmodule