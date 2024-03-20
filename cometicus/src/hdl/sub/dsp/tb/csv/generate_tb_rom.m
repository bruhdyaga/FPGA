clear
clc
fclose('all');

file_name = '2022_04_28_14_19_26_oscillogram.csv';
data = importfile(file_name);

L = length(data.Imi_I_norm_y);
bit_IQ = 12; % на каждый из sin и cos с учетом знака

fprintf('L = %d\n',L)
fprintf('bit_IQ = %d\n',bit_IQ)

fid1 = fopen(sprintf('i_in.txt'),'w');
fid2 = fopen(sprintf('q_in.txt'),'w');
fid3 = fopen(sprintf('i_out.txt'),'w');
fid4 = fopen(sprintf('q_out.txt'),'w');
for i = 1:L
    i_in  = dec2bin(mod((data.Imi_I_y(i)),2^bit_IQ),bit_IQ);
    q_in  = dec2bin(mod((data.Imi_Q_y(i)),2^bit_IQ),bit_IQ);
    i_out = dec2bin(mod((data.Imi_I_norm_y(i)),2^bit_IQ),bit_IQ);
    q_out = dec2bin(mod((data.Imi_Q_norm_y(i)),2^bit_IQ),bit_IQ);

    fprintf(fid1,sprintf('%s',i_in));
    fprintf(fid2,sprintf('%s',q_in));
    fprintf(fid3,sprintf('%s',i_out));
    fprintf(fid4,sprintf('%s',q_out));
    
    if(i ~= L)
        fprintf(fid1,'\n');
        fprintf(fid2,'\n');
        fprintf(fid3,'\n');
        fprintf(fid4,'\n');
    end
end

fclose(fid1);
fclose(fid2);
fclose(fid3);
fclose(fid4);