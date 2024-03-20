interface imi_interf
#(
    parameter WIDTH = 0
)
();

logic [WIDTH-1:0] I;
logic [WIDTH-1:0] Q;
logic [WIDTH-1:0] In; // noised
logic [WIDTH-1:0] Qn; // noised

modport master
(
    output I,
    output Q,
    output In, // noised
    output Qn  // noised
);

modport slave
(
    input I,
    input Q,
    input In, // noised
    input Qn  // noised
);

endinterface
