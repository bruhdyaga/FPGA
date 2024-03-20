%таблица для DDS
clc
clear

bit_phase = 5;

N = 2^bit_phase;
sin_table = zeros(1,N);
cos_table = zeros(1,N);
arg = zeros(1,N);

fid = fopen(sprintf('../verilog/doppler_dds_tab_%d_1.v',bit_phase),'w');

fprintf(fid,sprintf('reg sin_tab;\n'));
fprintf(fid,sprintf('reg cos_tab;\n'));


for i = 1:N
    small = 1/N/2;
    arg(i) = ((i-1)/(2^bit_phase)) + small;
    sin_table(i) = round((sin(2*pi*arg(i))+1)/2);
    cos_table(i) = round((cos(2*pi*arg(i))+1)/2);
    fprintf('i = %2d | arg = %5.3f | sin = %7.4f | cos = %7.4f\n',i,arg(i),sin_table(i),cos_table(i));
end

fprintf(fid,'\nalways@(*)\n');
fprintf(fid,'case(addr)\n');
for i = 1:N
    fprintf(fid,sprintf('\t5''d%d : sin_tab <= %1d;\n',i-1,sin_table(i)));
end
fprintf(fid,'\tdefault: sin_tab <= 0;\n');
fprintf(fid,'endcase\n');

fprintf(fid,'\nalways@(*)\n');
fprintf(fid,'case(addr)\n');
for i = 1:N
    fprintf(fid,sprintf('\t5''d%d : cos_tab <= %1d;\n',i-1,cos_table(i)));
end
fprintf(fid,'\tdefault: cos_tab <= 0;\n');
fprintf(fid,'endcase\n');

plot(arg,[sin_table;cos_table])
legend('sin','cos','Location','east')
ylim([-0.1 1.1])
grid on

fclose(fid);