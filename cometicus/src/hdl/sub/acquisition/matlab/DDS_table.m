%таблица для DDS
clc
clear

bit_phase = 5;
bit_sin = 4;

fid = fopen(sprintf('../verilog/sin_tab_%d_%d.v',bit_phase,bit_sin),'w');

fprintf(fid,sprintf('reg signed [%d:0] sin;\n',bit_sin-1));
fprintf(fid,sprintf('reg signed [%d:0] cos;\n',bit_sin-1));

fprintf(fid,'\nalways@(posedge clk or posedge reset)\n');
fprintf(fid,'if(reset)\n');
fprintf(fid,'\tsin <= 0;\n');
fprintf(fid,'\tcos <= 0;\n');
fprintf(fid,'else\n');
fprintf(fid,'case(addr)\n');
for i = 1:2^bit_phase
    arg = ((i-1)/(2^bit_phase));
    sin_table = round(sin(2*pi*arg)*(2^(bit_sin-1)-1));
    fprintf(fid,sprintf('\t%3d : sin <= %3d;\n',i,sin_table));
end
fprintf(fid,'endcase\n');

fclose(fid);