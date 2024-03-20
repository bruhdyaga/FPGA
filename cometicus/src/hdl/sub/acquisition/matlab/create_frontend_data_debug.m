% close all hidden
% close all force

rf_I = ones(1,Nd);
rf_Q = ones(1,Nd);

rf_I(sig_I == 1) = -1;
rf_Q(sig_Q == 1) = -1;

% rf_I(mag_I == 1) = rf_I(mag_I == 1)*3;
% rf_Q(mag_Q == 1) = rf_Q(mag_Q == 1)*3;

y = rf_I + 1i*rf_Q;

PSP_Nd = Tpsp*Fd;% количество отсчетов в одной ПСП

spectr(y,Td,1e3)

PN_core(1:2:2046) = PN(1,:);
PN_core(2:2:2046) = PN(1,:);

f_err = 10;% ошибка опорной частоты в преднакопителе
cos_pre = cos(2*pi*(fi + f_err)*Td*i);
sin_pre = sin(2*pi*(fi + f_err)*Td*i);

I_mul_1 = rf_I.*cos_pre;
I_mul_2 = rf_Q.*sin_pre;
Q_mul_1 = rf_Q.*cos_pre;
Q_mul_2 = rf_I.*sin_pre;

if(fi<0)
    I = I_mul_1 - I_mul_2;
    Q = Q_mul_1 + Q_mul_2;
else
    I = I_mul_1 + I_mul_2;
    Q = Q_mul_1 - Q_mul_2;
end

I_coll = data_coll(I,T*2.046e6);
Q_coll = data_coll(Q,T*2.046e6);

[I_coll_sig, I_coll_mag] = sig_mag(I_coll);
[Q_coll_sig, Q_coll_mag] = sig_mag(Q_coll);

I_coll_qnt = ones(1,length(I_coll));
Q_coll_qnt = ones(1,length(I_coll));

I_coll_qnt(I_coll_sig == 1) = -1;
Q_coll_qnt(Q_coll_sig == 1) = -1;

%     I_coll_qnt(I_coll_mag == 1) = I_coll_qnt(I_coll_mag == 1)*3;
%     Q_coll_qnt(Q_coll_mag == 1) = Q_coll_qnt(Q_coll_mag == 1)*3;

y_coll_qnt = I_coll_qnt + 1i*Q_coll_qnt;
y_coll = I_coll + 1i*Q_coll;

i_exp = 1;

clear max_R phi tau;
x_sample = 1:2046;
while(1)% :))
    
%     x_sample = (1:2046)+fix(rand*(length(y_coll_qnt)-2046));% элементы для экспериментальной выборки
    x_sample = x_sample + 10;
    x_sample = mod(x_sample-1,2046)+1;
 
    
    
    
    %     plot(atan(Q_coll./I_coll)/pi*180)% фаза сигнала
    % spectr(I_coll + 1i*Q_coll,1/2.046e6,1e3)
    
    
    
    % N_exp = fix(length(I_coll)/2046);
    % max_R = zeros(1,N_exp);
    % for i_exp = 1:N_exp
    R = abs(ifft(fft(y_coll_qnt(x_sample)) .* conj(fft(PN_core))));
    [max_R(i_exp),tau(i_exp)] = max(R);
    i_exp = i_exp + 1;
    
    subplot(3,1,1)
    plot(max_R)
    title('max R')
    ylim([0 max(max_R)*1.1])
    
    subplot(3,1,2)
    plot(tau,'.')
    title('tau')
    ylim([0 max(tau)])
    
    phi(i_exp) = mean(atan(Q_coll./I_coll)/pi*180);
    subplot(3,1,3)
    plot(phi)
    title('phi')
    drawnow
    % end
    
end