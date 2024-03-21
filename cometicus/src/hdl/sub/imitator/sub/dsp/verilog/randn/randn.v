module randn(
    //.number(0)       // Порядковый номер блока (отличаются зерном)
    // ) insname (
    clk, 
    reset_n, 
    out
    );
    
        
    // ---------------------------------------------------------------
    
    parameter number = 0;
        
    // ---------------------------------------------------------------
    
   input clk;
   input reset_n;
   output out;

   wire clk;
   wire reset_n;
   reg signed [9:0] out;

   wire signed [7:0] rand_u_1;
   wire signed [7:0] rand_u_2;
   wire signed [7:0] rand_u_3;
   wire signed [7:0] rand_u_4;

   reg signed [9:0] X_1;
   reg signed [9:0] X_2;
   reg signed [9:0] X_3;
   reg signed [9:0] X_4;

    if (number == 0) begin
        randn_u #(.number(0)) randn_u_1(clk, reset_n, rand_u_1);
        randn_u #(.number(1)) randn_u_2(clk, reset_n, rand_u_2);
        randn_u #(.number(2)) randn_u_3(clk, reset_n, rand_u_3);
        randn_u #(.number(3)) randn_u_4(clk, reset_n, rand_u_4);
    end else begin
        randn_u #(.number(4)) randn_u_1(clk, reset_n, rand_u_1);
        randn_u #(.number(5)) randn_u_2(clk, reset_n, rand_u_2);
        randn_u #(.number(6)) randn_u_3(clk, reset_n, rand_u_3);
        randn_u #(.number(7)) randn_u_4(clk, reset_n, rand_u_4);        
    end

    always @(posedge clk or negedge reset_n) begin
        if (reset_n == 0) begin
            X_1 <= 0;
            X_2 <= 0;
            X_3 <= 200;
            X_4 <= -100;
            out <= 0;
        end else begin
            out <= X_4;
            X_4 <= X_3 + rand_u_4;
            X_3 <= X_2 + rand_u_3;
            X_2 <= X_1 + rand_u_2;
            X_1 <= 0 + rand_u_1;
        end
    end
    
endmodule
