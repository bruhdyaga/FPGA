`include "rgb.svh"

module rgb
#(
    parameter BASEADDR = 0
)
(
intbus_interf.slave bus,
    output logic R,
    output logic G,
    output logic B
);

localparam FREQ   = 100e6;                // частота шины [Гц]
localparam FPS    = 300;                  // частота мигания светодиода (частота ШИМ) [Гц]
localparam PER    = FREQ/FPS;             // количество тактов на одном периоде ШИМ
localparam L_elem = int'(PER/(2**WIDTH)); // минимальный квант времени свечения светодиода

localparam L_WIDTH = $clog2(L_elem); // количечество разрядов под счетчик кванта

// The generator data structure definition
RGB_STRUCT PL; // The registers from logic
RGB_STRUCT PS; // The registers from CPU
RGB_STRUCT D; // working registers
RGB_STRUCT M; // mirror  registers

regs_file#(
    .BASEADDR (BASEADDR),
    .ID       (`RGB_ID_CONST),
    .DATATYPE (RGB_STRUCT)
)RF (
    .clk     ('0),
    .bus     (bus),
    .in      (PL),
    .out     (PS),
    .pulse   (),
    .wr      (),
    .rd      ()
);

assign PL.RGB.WIDTH_RGB = WIDTH;
assign PL.RGB.RESERVED  = '0;
assign PL.RGB.R         = '0;
assign PL.RGB.G         = '0;
assign PL.RGB.B         = '0;

reg [L_WIDTH-1:0] l_cntr;
wire l_elem_pulse;
reg [WIDTH-1:0] rgb_reset_cntr;
wire rgb_reset;


always_ff@(posedge bus.clk)
if(l_elem_pulse) begin
    l_cntr <= '0;
end else begin
    l_cntr <= l_cntr + 1'b1;
end

assign l_elem_pulse = l_cntr == L_elem; // задает темп ШИМ

always_ff@(posedge bus.clk)
if(l_elem_pulse) begin
    rgb_reset_cntr <= rgb_reset_cntr + 1'b1;
end

assign rgb_reset = rgb_reset_cntr == '0; // сброс счетчиков цветов

// ****************************************************************
always_ff@(posedge bus.clk)
if(l_elem_pulse) begin
    if(rgb_reset) begin
        D.RGB.R <= '0;
    end else begin
        if(D.RGB.R != M.RGB.R) begin
            D.RGB.R <= D.RGB.R + 1'b1;
        end
    end
end

always_ff@(posedge bus.clk) begin
    if(l_elem_pulse) begin
        if(rgb_reset) begin
            D.RGB.G <= '0;
        end else begin
            if(D.RGB.G != M.RGB.G) begin
                D.RGB.G <= D.RGB.G + 1'b1;
            end
        end
    end
end

always_ff@(posedge bus.clk) begin
    if(l_elem_pulse) begin
        if(rgb_reset) begin
            D.RGB.B <= '0;
        end else begin
            if(D.RGB.B != M.RGB.B) begin
                D.RGB.B <= D.RGB.B + 1'b1;
            end
        end
    end
end

// ****************************************************************
always_ff@(posedge bus.clk)
if(l_elem_pulse & rgb_reset) begin
    M.RGB.R <= PS.RGB.R;
    M.RGB.G <= PS.RGB.G;
    M.RGB.B <= PS.RGB.B;
end

// ****************************************************************
always_ff@(posedge bus.clk) begin
    if(l_elem_pulse) begin
        if(D.RGB.R != M.RGB.R) begin
            R <= '1;
        end else begin
            if(M.RGB.R != '1) begin
                R <= '0;
            end
        end
    end
end

always_ff@(posedge bus.clk) begin
    if(l_elem_pulse) begin
        if(D.RGB.G != M.RGB.G) begin
            G <= '1;
        end else begin
            if(M.RGB.G != '1) begin
                G <= '0;
            end
        end
    end
end

always_ff@(posedge bus.clk) begin
    if(l_elem_pulse) begin
        if(D.RGB.B != M.RGB.B) begin
            B <= '1;
        end else begin
            if(M.RGB.B != '1) begin
                B <= '0;
            end
        end
    end
end

endmodule