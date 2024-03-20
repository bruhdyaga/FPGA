clc
clear

sr_g1 = ones(1,10);
sr_g2 = ones(1,10);


for i = 1:1026
    fprintf('i = %3d',i-1);
    fprintf(' sr_g1 = '); fprintf('%d',sr_g1);
    fprintf(' sr_g2 = '); fprintf('%d',sr_g2);
    fprintf('\n')
    feedback1 = xor(sr_g1(3),sr_g1(10));
    feedback2 = xor(xor(xor(xor(xor(sr_g2(2),sr_g2(3)),sr_g2(6)),sr_g2(8)),sr_g2(9)),sr_g2(10));
    sr_g1 = [feedback1,sr_g1(1:9)];
    sr_g2 = [feedback2,sr_g2(1:9)];
end