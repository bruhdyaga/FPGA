`include "global_param.v"

interface core_interface();

logic we;
logic data_latch;
logic we_adder;
logic code_load;
logic wr_buf;
logic valid;

modport master
(
    input  we,
    input  data_latch,
    input  we_adder,
    input  code_load,
    input  wr_buf,
    output valid
);

modport slave
(
    output we,
    output data_latch,
    output we_adder,
    output code_load,
    output wr_buf,
    input  valid
);

endinterface

module core
#(
    parameter  CORE_SIZE = 0,
    parameter  in_width  = 3,
    localparam out_width = in_width + $clog2(CORE_SIZE)
)
(
    input                         clk,
    input                         time_separation,
    input  signed [in_width-1:0]  I_in,
    input  signed [in_width-1:0]  Q_in,
    input                         psp_in,
    output signed [out_width-1:0] I,
    output signed [out_width-1:0] Q,
    core_interface.master         core_interface
);

//запись ПСП в рабочий регистр сдвига
logic [CORE_SIZE-1:0] code_reg = '0; //рабочий входной регистр ПСП
logic [CORE_SIZE-1:0] code_buf = '0; //буфферный входной регистр ПСП
//(пока в рабочий регистр идет псп для текущей свертки - тут хранится псп для следующего захода)

always_ff@(posedge clk)
if(!time_separation && core_interface.code_load)
  code_reg <= code_buf;//закончилась текущая свертка, загрузили псп для следуюшего блока
else
  if(core_interface.we) 
    code_reg <= {psp_in, code_reg[CORE_SIZE-1:1]};

always_ff@(posedge clk)
  if(time_separation) begin
    if(core_interface.data_latch) code_buf <= code_reg;
  end else begin
    if(core_interface.wr_buf)     code_buf <= code_reg;
  end

//чтение данных в буфферы
logic signed [CORE_SIZE-1:0] [in_width-1:0] dat_I_in_reg; //входные сдвиговые регистры
logic signed [CORE_SIZE-1:0] [in_width-1:0] dat_Q_in_reg;

always_ff@(posedge clk)
if(core_interface.we) begin
    dat_I_in_reg <= {I_in,dat_I_in_reg[CORE_SIZE-1:1]};
    dat_Q_in_reg <= {Q_in,dat_Q_in_reg[CORE_SIZE-1:1]};
end

//защелкивание данных из буффера в рабочие регистры
logic signed [CORE_SIZE-1:0] [in_width-1:0] dat_I_reg; //рабочие регистры
logic signed [CORE_SIZE-1:0] [in_width-1:0] dat_Q_reg;

always_ff@(posedge clk)
if(core_interface.data_latch) begin
    dat_I_reg <= {I_in,dat_I_in_reg[CORE_SIZE-1:1]};
    dat_Q_reg <= {Q_in,dat_Q_in_reg[CORE_SIZE-1:1]};
end
// рабочие регистры
logic signed [CORE_SIZE-1:0] [in_width-1:0] dat_I;
logic signed [CORE_SIZE-1:0] [in_width-1:0] dat_Q;
logic        [CORE_SIZE-1:0]                code;

assign dat_I = (time_separation) ? {I_in,dat_I_in_reg[CORE_SIZE-1:1]} : dat_I_reg;
assign dat_Q = (time_separation) ? {Q_in,dat_Q_in_reg[CORE_SIZE-1:1]} : dat_Q_reg;
assign code  = (time_separation) ?                           code_buf : code_reg;

//стадия перемножения
logic signed [in_width-1:0] mul_I [CORE_SIZE-1:0];
logic signed [in_width-1:0] mul_Q [CORE_SIZE-1:0];

for(genvar i = 0; i < CORE_SIZE; i = i + 1) begin: mul_IQ
    assign mul_I[i] = (code[i]) ? -$signed(dat_I[i]) : dat_I[i];
    assign mul_Q[i] = (code[i]) ? -$signed(dat_Q[i]) : dat_Q[i];
end

piped_adder#(
    .N_args     (CORE_SIZE),
    .arg_width  (in_width),
    .dis_valid  (0)
) SUM_I_INST(
    .clk        (clk),
    .we         (core_interface.we_adder),
    .args_in    ({>>{mul_I}}),
    .sum_out    (I),
    .valid      (core_interface.valid)
);

piped_adder#(
    .N_args     (CORE_SIZE),
    .arg_width  (in_width),
    .dis_valid  (1)
) SUM_Q_INST(
    .clk        (clk),
    .we         (core_interface.we_adder),
    .args_in    ({>>{mul_Q}}),
    .sum_out    (Q),
    .valid      ()
);

`ifdef SIMULATE
    logic signed [out_width-1:0] I_debug;
    logic signed [out_width-1:0] Q_debug;
    logic        [out_width*2:0] R_debug;
    
    assign I_debug = core_interface.valid ? I : 0;
    assign Q_debug = core_interface.valid ? Q : 0;
    assign R_debug = $signed(I_debug)*$signed(I_debug) + $signed(Q_debug)*$signed(Q_debug);
`endif

// debug
logic first_run = 1'b1;
logic [CORE_SIZE-1:0] code_store;
always_ff@(posedge clk)
if(core_interface.wr_buf) begin
  if (first_run) begin
    code_store <= code;
    first_run  <= 1'b0;
  end
end
//
logic [23:0] sumCode;
mf #(CORE_SIZE) MFcode
(
  .clk  (clk),
  .code (code_reverse_store),
  .I_mag(1'b0),
  .I_sig(psp_in),
  .Q_mag(1'b0),
  .Q_sig(psp_in),
  .iVld (core_interface.we),
  .sum  (sumCode)
);

// //
// // write PRBS into file
// //
  // integer fd00, open00 = 0;
  // always @(posedge clk) begin
    // if (!open00) begin
      // fd00 = $fopen("prbs.txt", "w");
      // open00 = 1;
    // end
    // if (core_interface.we) begin
      // $fwrite(fd00, "%b\n", psp_in);
    // end
  // end

// //
// // write DATA into file
// //
  // integer fd01, open01 = 0;
  // always @(posedge clk) begin
    // if (!open01) begin
      // fd01 = $fopen("data.txt", "w");
      // open01 = 1;
    // end
    // if (core_interface.we) begin
      // $fwrite(fd01, "%b\n", I_in[0]);
    // end
  // end

endmodule