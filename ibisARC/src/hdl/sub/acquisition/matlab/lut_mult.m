%табличный перемножитель 2-х сомножителей
clear
clc

bit_A = 3;
bit_B = 3;
bit_res = bit_A + bit_B;

fid = fopen(sprintf('../verilog/lut_mult_%d_%d.v',bit_A,bit_B),'w');

fprintf(fid,'module lut_mult_%d_%d(\n',bit_A,bit_B);
fprintf(fid,'\tinput_A,\n');
fprintf(fid,'\tinput_B,\n');
fprintf(fid,'\tresult\n');
fprintf(fid,');\n');

fprintf(fid,sprintf('\ninput  signed [%d:0] input_A;\n',bit_A-1));
fprintf(fid,sprintf('input  signed [%d:0] input_B;\n',bit_B-1));
fprintf(fid,sprintf('output signed [%d:0] result;\n',bit_res-1));

fprintf(fid,'\nalways@(*)\n');
fprintf(fid,'case(1''b1)\n');
for i = 1:2^bit_A
    dec_A = i - 2^(bit_A-1)-1;
    for j = 1:2^bit_B
        dec_B = j - 2^(bit_B-1)-1;
        result = dec_A*dec_B;
        fprintf(fid,sprintf('\t((input_A == %2d)&(input_B == %2d))\t: result = %3d;\n',dec_A,dec_B,result));
    end
end
fprintf(fid,'endcase\n');

fprintf(fid,'\nendmodule;');

fclose(fid);