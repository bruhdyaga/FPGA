clear
clc
close all hidden
fclose('all');

fid2 = fopen('../verilog/ch_mul_rom.txt');

for i = 1:512
    str = fscanf(fid2,'%s',[1 1]);
    
    I = str(6:10);
    Q = str(1:5);
    
    I = [I(1),I(1),I(1),I];
    Q = [Q(1),Q(1),Q(1),Q];
    
    I_int8 = typecast(uint8(bin2dec(I)),'int8');
    Q_int8 = typecast(uint8(bin2dec(Q)),'int8');
    
    fprintf('%3d | Q=%s | I=%s, QI=%3d %3d\n',i, Q, I, Q_int8, I_int8);
end

fclose(fid2);