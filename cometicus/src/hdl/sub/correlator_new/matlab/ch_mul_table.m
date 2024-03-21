clear
clc
close all hidden
fclose('all');

MAX_prod = 4.25; % эмпирическая константа продукта при амплитуде sincos = 1 и сигимаги на входе (+/-3)

N_digs_phase = 5; % количество разрядов фазы
fprintf('N_digs_phase = %d\n',N_digs_phase);

N_digs = 5; % количество разрядов на I,Q product
fprintf('N_digs = %d\n',N_digs);
product_max = 2^(N_digs-1)-1;
fprintf('product_max = %d\n',product_max);

fid = fopen('../verilog/ch_mul.sv','w');
fid2 = fopen('../verilog/ch_mul_rom.txt','w');

fprintf(fid,'module ch_mul (\n');
fprintf(fid,'    input [1:0] adc_re,\n');
fprintf(fid,'    input [1:0] adc_im,\n');
fprintf(fid,'    input [4:0] phase,\n');
fprintf(fid,'    output reg signed [%d:0] i_prod,\n',N_digs-1);
fprintf(fid,'    output reg signed [%d:0] q_prod\n',N_digs-1);
fprintf(fid,');\n');
fprintf(fid,'\n');
fprintf(fid,'always_comb begin\n');
fprintf(fid,'    case ({adc_re, adc_im, phase})\n');
maxxxx = 0;

i_ind = [-3,-1,1,3];
q_ind = [-3,-1,1,3];
phase_ind = 0 : 2^N_digs_phase - 1;

for i = i_ind
    switch i
        case -3
            i_bin = '11';
        case -1
            i_bin = '10';
        case 1
            i_bin = '00';
        case 3
            i_bin = '01';
    end
    for q = q_ind
        switch q
            case -3
                q_bin = '11';
            case -1
                q_bin = '10';
            case 1
                q_bin = '00';
            case 3
                q_bin = '01';
        end
        for phase = phase_ind
            if(phase > 9)
                space = '';
            else
                space = ' ';
            end
            
            phi = (phase/32*360)/180*pi;
            
            sin_data = sin(phi);
            cos_data = cos(phi);
            
            i_prod = round((i*cos_data + q*sin_data) / MAX_prod * product_max);
            q_prod = round((q*cos_data - i*sin_data) / MAX_prod * product_max);
            
            maxxxx = max(maxxxx,abs(i_prod));
            maxxxx = max(maxxxx,abs(q_prod));
            
            i_prod = sign(i_prod) * min(product_max,abs(i_prod)); % на всякий случай чтобы не переполнилось
            q_prod = sign(q_prod) * min(product_max,abs(q_prod));
            
            if(i_prod < 0)
                i_prod_signed = '-';
            else
                i_prod_signed = '';
            end
            if(q_prod < 0)
                q_prod_signed = '-';
            else
                q_prod_signed = '';
            end
            
            fprintf(fid,'        {2''b%s, 2''b%s, 5''d%d}%c     : {q_prod,i_prod} = {%c%d''d%d, %c%d''d%d};\n',...
                i_bin,q_bin,phase,space,....
                i_prod_signed,N_digs,abs(i_prod),...
                q_prod_signed,N_digs,abs(q_prod));
            
            q_prod_bin = dec2bin(typecast(int8(q_prod),'uint8'));
            i_prod_bin = dec2bin(typecast(int8(i_prod),'uint8'));
            
            q_prod_bin = q_prod_bin(end:-1:1); % сделали младший бит справа
            i_prod_bin = i_prod_bin(end:-1:1);
            
            q_prod_bin = q_prod_bin(1:min(5,length(q_prod_bin)));
            i_prod_bin = i_prod_bin(1:min(5,length(i_prod_bin))); % взяли младшие 5 бит
            
            while(length(q_prod_bin) < 5)
                q_prod_bin(length(q_prod_bin)+1) = num2str(q_prod < 0); % знаковое расширение
            end
            
            while(length(i_prod_bin) < 5)
                i_prod_bin(length(i_prod_bin)+1) = num2str(i_prod < 0); % знаковое расширение
            end
            
            q_prod_bin = q_prod_bin(end:-1:1); % сделали младший бит слева
            i_prod_bin = i_prod_bin(end:-1:1);
            
            fprintf('%s|%s // %3d %3d\n',q_prod_bin,i_prod_bin,q_prod,i_prod);
            % fprintf(fid2,'%s%s',q_prod_bin,i_prod_bin); % это верно
            fprintf(fid2,'%s%s',i_prod_bin,q_prod_bin); % IQ перепутаны!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            
            if((i ~= i_ind(end)) || (q ~= q_ind(end)) || (phase ~= phase_ind(end)))
                fprintf(fid2,'\n');
            end
        end
        fprintf(fid,'        \n');
    end
    fprintf(fid,'        \n');
end
fprintf(fid,'    endcase\n');
fprintf(fid,'end\n');
fprintf(fid,'\n');
fprintf(fid,'endmodule\n');

fprintf('maxxxx = %d\n',maxxxx);

fclose(fid);
fclose(fid2);

fprintf('IQ перепутаны!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n');
