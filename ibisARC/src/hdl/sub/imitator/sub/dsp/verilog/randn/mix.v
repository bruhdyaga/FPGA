module mix(clk, out, RESET);

   input clk;
   output out;
   input RESET;

   wire clk;
   reg signed [11:0] out;
   wire RESET;

   wire signed [9:0] rnd;
   randn randn(clk, RESET, rnd);

   wire signed [7:0] signal_1;
   reg signed [11:0] msignal_1;
   GenSat_1 GenSat_1(clk, signal_1, RESET);

   wire signed [7:0] signal_2;
   reg signed [11:0] msignal_2;
   reg signed [7:0] signal_2_d_1;
   GenSat_2 GenSat_2(clk, signal_2, RESET);

   wire signed [7:0] signal_3;
   reg signed [11:0] msignal_3;
   reg signed [7:0] signal_3_d_1;
   reg signed [7:0] signal_3_d_2;
   GenSat_3 GenSat_3(clk, signal_3, RESET);

   wire signed [7:0] signal_4;
   reg signed [11:0] msignal_4;
   reg signed [7:0] signal_4_d_1;
   reg signed [7:0] signal_4_d_2;
   reg signed [7:0] signal_4_d_3;
   GenSat_4 GenSat_4(clk, signal_4, RESET);

   wire signed [7:0] signal_5;
   reg signed [11:0] msignal_5;
   reg signed [7:0] signal_5_d_1;
   reg signed [7:0] signal_5_d_2;
   reg signed [7:0] signal_5_d_3;
   reg signed [7:0] signal_5_d_4;
   GenSat_5 GenSat_5(clk, signal_5, RESET);

   reg signed [11:0] y_1;
   reg signed [11:0] y_2;
   reg signed [11:0] y_3;
   reg signed [11:0] y_4;
   reg signed [11:0] y_5;

   always @(posedge clk) begin
      if (RESET) begin
         out <= y_1 + rnd;

         y_1 <= y_2 +  signal_5_d_1;
         y_2 <= y_3 +  signal_4_d_1;
         y_3 <= y_4 +  signal_3_d_1;
         y_4 <= y_5 +  signal_2_d_1;
         y_5 <= 0 + {{8{msignal_1[11]}}, msignal_1[11:8]};

         signal_2_d_1 <= 0 + {{8{msignal_2[11]}}, msignal_2[11:8]};

         signal_3_d_1 <= signal_3_d_2;
         signal_3_d_2 <= 0 + {{8{msignal_3[11]}}, msignal_3[11:8]};

         signal_4_d_1 <= signal_4_d_2;
         signal_4_d_2 <= signal_4_d_3;
         signal_4_d_3 <= 0 + {{8{msignal_4[11]}}, msignal_4[11:8]};

         signal_5_d_1 <= signal_5_d_2;
         signal_5_d_2 <= signal_5_d_3;
         signal_5_d_3 <= signal_5_d_4;
         signal_5_d_4 <= 0 + {{8{msignal_5[11]}}, msignal_5[11:8]};

         msignal_1 <= 0 + 12 * signal_1;
         msignal_2 <= 0 + 12 * signal_2;
         msignal_3 <= 0 + 12 * signal_3;
         msignal_4 <= 0 + 12 * signal_4;
         msignal_5 <= 0 + 12 * signal_5;
      end else begin
         y_1 <= 0;
         y_2 <= 0;
         y_3 <= 0;
         y_4 <= 0;
         y_5 <= 0;

         signal_2_d_1 <= 0;
         signal_3_d_1 <= 0;
         signal_3_d_2 <= 0;
         signal_4_d_1 <= 0;
         signal_4_d_2 <= 0;
         signal_4_d_3 <= 0;
         signal_5_d_1 <= 0;
         signal_5_d_2 <= 0;
         signal_5_d_3 <= 0;
         signal_5_d_4 <= 0;
      end
   end

endmodule
