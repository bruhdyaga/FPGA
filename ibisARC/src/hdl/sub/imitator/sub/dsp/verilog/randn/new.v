module new(clk, RESET, out);
   input clk;
   input RESET;
   output out;

   wire clk;
   wire RESET;
   reg [7:0] out;

   reg [7:0] X_1;
   reg [7:0] X_2;
   reg [7:0] X_3;
   reg [7:0] X_4;
   reg [7:0] X_5;
   reg [7:0] X_6;
   reg [7:0] X_7;
   reg [7:0] X_8;
   reg [7:0] X_9;
   reg [7:0] X_10;
   reg [7:0] X_11;
   reg [7:0] X_12;
   reg [7:0] X_13;
   reg [7:0] X_14;
   reg [7:0] X_15;
   reg [7:0] X_16;
   reg [7:0] X_17;
   reg [7:0] X_18;
   reg [7:0] X_19;
   reg [7:0] X_20;
   reg [7:0] X_21;
   reg [7:0] X_22;
   reg [7:0] X_23;
   reg [7:0] X_24;
   reg [7:0] X_25;
   reg [7:0] X_26;
   reg [7:0] X_27;
   reg [7:0] X_28;
   reg [7:0] X_29;
   reg [7:0] X_30;
   reg [7:0] X_31;
   reg [7:0] X_32;
   reg [7:0] X_33;
   reg [7:0] X_34;
   reg [7:0] X_35;
   reg [7:0] X_36;
   reg [7:0] X_37;
   reg [7:0] X_38;
   reg [7:0] X_39;
   reg [7:0] X_40;
   reg [7:0] X_41;
   reg [7:0] X_42;
   reg [7:0] X_43;
   reg [7:0] X_44;
   reg [7:0] X_45;
   reg [7:0] X_46;
   reg [7:0] X_47;
   reg [7:0] X_48;
   reg [7:0] X_49;
   reg [7:0] X_50;
   reg [7:0] X_51;
   reg [7:0] X_52;
   reg [7:0] X_53;
   reg [7:0] X_54;
   reg [7:0] X_55;

   always @(posedge clk) begin
      if (RESET) begin
         if (X_55 >= X_24) begin
            X_1 <= X_55 - X_24;
         end else begin
            X_1 <= X_55 - X_24 + 256;
         end
         X_55 <= X_54;
         X_54 <= X_53;
         X_53 <= X_52;
         X_52 <= X_51;
         X_51 <= X_50;
         X_50 <= X_49;
         X_49 <= X_48;
         X_48 <= X_47;
         X_47 <= X_46;
         X_46 <= X_45;
         X_45 <= X_44;
         X_44 <= X_43;
         X_43 <= X_42;
         X_42 <= X_41;
         X_41 <= X_40;
         X_40 <= X_39;
         X_39 <= X_38;
         X_38 <= X_37;
         X_37 <= X_36;
         X_36 <= X_35;
         X_35 <= X_34;
         X_34 <= X_33;
         X_33 <= X_32;
         X_32 <= X_31;
         X_31 <= X_30;
         X_30 <= X_29;
         X_29 <= X_28;
         X_28 <= X_27;
         X_27 <= X_26;
         X_26 <= X_25;
         X_25 <= X_24;
         X_24 <= X_23;
         X_23 <= X_22;
         X_22 <= X_21;
         X_21 <= X_20;
         X_20 <= X_19;
         X_19 <= X_18;
         X_18 <= X_17;
         X_17 <= X_16;
         X_16 <= X_15;
         X_15 <= X_14;
         X_14 <= X_13;
         X_13 <= X_12;
         X_12 <= X_11;
         X_11 <= X_10;
         X_10 <= X_9;
         X_9 <= X_8;
         X_8 <= X_7;
         X_7 <= X_6;
         X_6 <= X_5;
         X_5 <= X_4;
         X_4 <= X_3;
         X_3 <= X_2;
         X_2 <= X_1;
         out <= X_1;
      end else begin
         X_1 <= 236;
         X_2 <= 184;
         X_3 <= 170;
         X_4 <= 59;
         X_5 <= 95;
         X_6 <= 72;
         X_7 <= 210;
         X_8 <= 119;
         X_9 <= 219;
         X_10 <= 230;
         X_11 <= 74;
         X_12 <= 107;
         X_13 <= 160;
         X_14 <= 44;
         X_15 <= 131;
         X_16 <= 190;
         X_17 <= 246;
         X_18 <= 6;
         X_19 <= 121;
         X_20 <= 76;
         X_21 <= 5;
         X_22 <= 144;
         X_23 <= 193;
         X_24 <= 84;
         X_25 <= 12;
         X_26 <= 255;
         X_27 <= 107;
         X_28 <= 41;
         X_29 <= 43;
         X_30 <= 134;
         X_31 <= 228;
         X_32 <= 134;
         X_33 <= 157;
         X_34 <= 219;
         X_35 <= 106;
         X_36 <= 45;
         X_37 <= 192;
         X_38 <= 142;
         X_39 <= 218;
         X_40 <= 193;
         X_41 <= 173;
         X_42 <= 23;
         X_43 <= 163;
         X_44 <= 63;
         X_45 <= 133;
         X_46 <= 216;
         X_47 <= 60;
         X_48 <= 184;
         X_49 <= 147;
         X_50 <= 129;
         X_51 <= 133;
         X_52 <= 241;
         X_53 <= 63;
         X_54 <= 243;
         X_55 <= 22;
      end
   end
endmodule