%таблица для DDS
clc
clear
close all hidden

bit_phase = 9;
bit_IQ = 10; % на каждый из sin и cos с учетом знака

verbose = 1;

fprintf('bit_phase = %d\n',bit_phase)
fprintf('bit_IQ = %d\n',bit_IQ)

sin_arr = zeros(1,2^bit_phase);
cos_arr = zeros(1,2^bit_phase);

fid = fopen(sprintf('../verilog_sv/dds_iq_hd_ph%d_iq_%d.txt',bit_phase,bit_IQ),'w');
for i = 1:2^bit_phase
    phase = 2*pi*((i-1)/(2^bit_phase));
    sin_table = round(sin(phase)*(2^(bit_IQ-1)-1));
    cos_table = round(cos(phase)*(2^(bit_IQ-1)-1));
    
    sin_table_dop = dec2bin(mod((sin_table),2^bit_IQ),bit_IQ);
    cos_table_dop = dec2bin(mod((cos_table),2^bit_IQ),bit_IQ);
    
    sin_arr(i) = sin_table;
    cos_arr(i) = cos_table;
    if(verbose)
%         fprintf('phase = %6.2f | ',phase/pi*180)
%         fprintf('sin = %.1f| ',sin_table)
%         fprintf('cos = %.1f\n',cos_table)

        fprintf('i = %2d | ',i-1)
        fprintf('sin = 0x%s| ',sprintf('%X',typecast(int8(sin_table),'uint8')))
        fprintf('cos = 0x%s\n',sprintf('%X',typecast(int8(cos_table),'uint8')))
    end
    
    fprintf(fid,sprintf('%s%s',sin_table_dop,cos_table_dop));
    if(i ~= 2^bit_phase)
        fprintf(fid,'\n');
    end
end

bar(sin_arr)

figure()
bar(cos_arr)

fprintf('sin_arr = %f\n',sum(sin_arr.*sin_arr))
fprintf('cos_arr = %f\n',sum(cos_arr.*cos_arr))

fprintf('delta = %f\n',sum(sin_arr.*sin_arr) - sum(cos_arr.*cos_arr))

fprintf('IQ = %f\n',sum(sin_arr.*cos_arr))


N_rep = 1000;
I_long = repmat(cos_arr,1,N_rep);
Q_long = repmat(sin_arr,1,N_rep);
y = I_long + 1j*Q_long;

spectr(y,1/100e6,0)

fclose(fid);