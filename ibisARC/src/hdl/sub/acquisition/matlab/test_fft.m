clc
clear
close all hidden


N_exp = 20; % число экспериментов для усреднения

tic
%% config
W_bits = 4;
D_bits = 3;
MEM_bits = 14; % место в памяти для хранения отсчетов
N = 2^15; % число входных отсчетов
T = 1e-3;% длительность реализации
Fd = N/T;%частота дискретизации
q = 35;% dBHz
NN = 1; % некогерентное накопление

%%
Td=1/Fd;
A=sqrt((4*10^(q/10)*Td));

loss = NaN(length(W_bits),length(D_bits));

i_wait = 0; % итератор для waitbar
f_wait = waitbar(0);

R_ref = 0;
R = 0;

for i_W_bits = 1:length(W_bits)
    for i_D_bits = 1:length(D_bits)
        loss_exp = NaN(1,N_exp);
        for i_exp = 1:N_exp
            for i_NN = 1:NN
                fprintf('i_exp=%d; i_NN=%d\n',i_exp,i_NN)
                waitbar(i_wait/(NN*N_exp*length(W_bits)*length(D_bits)))
                PN(1,1:N) = sign(randn(1,N));
                
                %% create signal
                noise = randn(1,N);
                y_I = A*PN + noise;
                y_Q = A*PN + noise;
                
                [sig_I, mag_I, sigmag_signed_I] = sig_mag(y_I);
                [sig_Q, mag_Q, sigmag_signed_Q] = sig_mag(y_Q);
                
                
                %%
                data = sigmag_signed_I + 1i*sigmag_signed_Q;
                
                data_fft = fft(data);
                data_ifft = ifft(data);
                
                
                
                
                data_fft_fpga  = fft_fpga(data,W_bits(i_W_bits),D_bits(i_D_bits),MEM_bits);
                data_ifft_fpga = ifft_fpga(data,W_bits(i_W_bits),D_bits(i_D_bits),MEM_bits);
                
                % нормируем к единице БПФ для расчета ошибки
                std_fft  = std(data_fft);
                std_ifft = std(data_ifft);
                
                std_fft_fpga  = std(data_fft_fpga);
                std_ifft_fpga = std(data_ifft_fpga);
                
                err_fft = sqrt(sum(abs(data_fft/std_fft-data_fft_fpga/std_fft_fpga).^2)/(N-1));
                err_ifft = sqrt(sum(abs(data_ifft/std_ifft-data_ifft_fpga/std_ifft_fpga).^2)/(N-1));
                fprintf('err_fft = %g\n',err_fft)
                fprintf('err_ifft = %g\n',err_ifft)
                
                
                R_ref = R_ref + abs(  ifft(fft(data) .* conj(fft(PN)))  );
                R_ref_log = 10*log10(R_ref);
                R_ref_log = R_ref_log-max(R_ref_log);
                
                R_ref_delta = max(R_ref_log)-max(R_ref_log((R_ref_log<max(R_ref_log))));
                
                R = R + abs(  ifft_fpga((data_fft_fpga .* conj(fft_fpga(PN,W_bits(i_W_bits),D_bits(i_D_bits),MEM_bits))),W_bits(i_W_bits),D_bits(i_D_bits),MEM_bits)  );
                R_log = 10*log10(R);
                R_log = R_log-max(R_log);
                
                R_delta = max(R_log)-max(R_log((R_log<max(R_log))));
                loss_exp(i_exp) = R_ref_delta-R_delta;
                i_wait = i_wait + 1;
            end
        end
        loss(i_W_bits,i_D_bits) = mean(loss_exp);
        fprintf('loss[W=%d,D=%d,MEM=%d]=%.1fdB\n',W_bits(i_W_bits),D_bits(i_D_bits),MEM_bits,loss(i_W_bits,i_D_bits))
    end
end
toc
close(f_wait)

plot(1:N,[R_log;R_ref_log])
legend('fpga','reference')

figure()
sgtitle(sprintf('N=%d, loss=%.1f',N,mean(loss)))
subplot(2,1,1)
plot(1:N,R_ref_log)
title(sprintf('reference, delta = %.1fdB',R_ref_delta))

subplot(2,1,2)
plot(1:N,R_log)
title(sprintf('fpga, delta = %.1fdB',R_delta))
% 
% fprintf('loss = %fdB\n',mean(loss))
