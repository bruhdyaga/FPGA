interface i2c_interf();

logic scl_i;
logic scl_o;
logic scl_t;
logic sda_i;
logic sda_o;
logic sda_t;


modport master
(
    input  scl_i,
    output scl_o,
    output scl_t,
    input  sda_i,
    output sda_o,
    output sda_t
);

endinterface
