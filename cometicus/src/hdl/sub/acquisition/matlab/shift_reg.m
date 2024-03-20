clc
clear

sr_g1 = ones(1,25);
PRN = NaN(1,5110000);


for i = 1:5110000
    feedback1 = xor(sr_g1(3),sr_g1(25))-0;
    %     fprintf('i = %5d',i-1);
    %     fprintf(' sr_g1 = '); fprintf('%d',sr_g1);
    %     fprintf(' PRN_out = %d',sr_g1(23));
    %     fprintf(' sr1_xor = %d',feedback1);
    %     fprintf('\n')
    
    PRN(i) = sr_g1(10);
    
    sr_g1 = [feedback1,sr_g1(1:24)];
end

for i = 1:100
    fprintf('%3d | %i\n',i,PRN(i))
end