`timescale 1ns/10ps
module antiglitch_tb();

reg clk = 1;

always #5 clk = !clk;

reg glitch_asy = 0;
reg glitch;

initial begin

@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;

@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 1;
@(posedge clk);
glitch_asy = 0;
end

always@(posedge clk)
    glitch <= glitch_asy;

antiglitch#(
    .N (16),
    .M (16) // N by M; N<=M3
) antiglitch_inst(
    .clk    (clk),    
    .glitch (glitch),
    .clean  (clean)
);

endmodule