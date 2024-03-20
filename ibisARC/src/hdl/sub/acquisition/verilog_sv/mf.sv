module mf
#(
  parameter  PRBS_SIZE = 0
)
(
  input                 clk,
  input [PRBS_SIZE-1:0] code,
  input                 I_mag,
  input                 I_sig,
  input                 Q_mag,
  input                 Q_sig,
  input                 iVld,
  output [23:0]         sum
);

  logic signed [2:0] inp_I;
  logic signed [2:0] inp_Q;

  always_comb
  case({I_mag,I_sig})
      2'b00:
          inp_I <= $signed(1);
      2'b10:
          inp_I <= $signed(3);
      2'b01:
          inp_I <= $signed(-1);
      2'b11:
          inp_I <= $signed(-3);
  endcase

  always_comb
  case({Q_mag,Q_sig})
      2'b00:
          inp_Q <= $signed(1);
      2'b10:
          inp_Q <= $signed(3);
      2'b01:
          inp_Q <= $signed(-1);
      2'b11:
          inp_Q <= $signed(-3);
  endcase

  logic signed [PRBS_SIZE-1:0] [2:0] dat_I; //входные сдвиговые регистры
  logic signed [PRBS_SIZE-1:0] [2:0] dat_Q;

  reg sVld_d1;
  always_ff@(posedge clk) begin
    if(iVld) begin
        dat_I <= {inp_I,dat_I[PRBS_SIZE-1:1]};
        dat_Q <= {inp_Q,dat_Q[PRBS_SIZE-1:1]};
    end
    sVld_d1 <= iVld;
  end

  // logic [63:0] code = 64'hc0fc0fc0fc0fffff;
  // logic [PRBS_SIZE-1:0] code = 64'h1998018661879fe6;
  // logic [PRBS_SIZE-1:0] code = 128'h7e619f867e6079819f86799f86799f86;

  logic signed [2:0] mul_I [PRBS_SIZE-1:0];
  logic signed [2:0] mul_Q [PRBS_SIZE-1:0];
  for(genvar i = 0; i < PRBS_SIZE; i = i + 1) begin: mul_IQ
      assign mul_I[i] = (code[i]) ? -$signed(dat_I[i]) : dat_I[i];
      assign mul_Q[i] = (code[i]) ? -$signed(dat_Q[i]) : dat_Q[i];
  end

  logic signed  [8:0] I, Q;

  piped_adder#(
      .N_args     (PRBS_SIZE),
      .arg_width  (3),
      .dis_valid  (0)
  ) SUM_I_INST(
      .clk        (clk),
      .we         (sVld_d1),
      .args_in    ({>>{mul_I}}),
      .sum_out    (I),
      .valid      (sIQvld)
  );

  piped_adder#(
      .N_args     (PRBS_SIZE),
      .arg_width  (3),
      .dis_valid  (1)
  ) SUM_Q_INST(
      .clk        (clk),
      .we         (sVld_d1),
      .args_in    ({>>{mul_Q}}),
      .sum_out    (Q),
      .valid      ()
  );

  logic signed [17:0] Ipow, Qpow;
  always_ff@(posedge clk) Ipow = I*I;
  always_ff@(posedge clk) Qpow = Q*Q;
  reg [23:0] sumReg;
  always_ff@(posedge clk) sumReg = Ipow + Qpow;
  
  assign sum = sumReg;
  
endmodule