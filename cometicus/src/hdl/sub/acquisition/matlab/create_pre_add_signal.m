clear
close all hidden
clc

N = 300000;


Fd = 80e6;
fi = 4.42e6+1e3;
Td = 1/Fd;


fprintf('Fd = %f Ãö\n',Fd);
fprintf('fi = %f Ãö\n',fi);


% max_in = 2^(N_dig_in-1)-1;
i = 1:N;

y = sin(2*pi*fi*Td*i) + 3*randn(1,N);

in = randn(1,N);

sig = y>0;
por = 1*std(y);
mag = abs(y)>por;

sigmag = bin2dec(num2str([mag' sig']));
% dlmwrite('pre_add_signal.txt',bin2dec(sprintf('%d%d',mag,sig)),'delimiter','')
dlmwrite('pre_add_signal.txt',sigmag,'delimiter','')

dat_sign(sigmag==0) = 1;
dat_sign(sigmag==1) = -1;
dat_sign(sigmag==2) = 3;
dat_sign(sigmag==3) = -3;

subplot(2,1,1)
plot(y(1:1000))
grid on
subplot(2,1,2)
plot(dat_sign(1:1000))
grid on