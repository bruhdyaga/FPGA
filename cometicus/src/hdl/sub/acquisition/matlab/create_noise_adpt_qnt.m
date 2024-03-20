clear
close all hidden
clc

N_dig_in = 14;
N = 2^14;


Fd = 1/(5e-9*2);
fi = 10e6;
Td = 1/Fd;
T = Td*N;
fprintf('Fd = %f √ц\n',Fd);
fprintf('fi = %f √ц\n',fi);
fprintf('T = %f мс\n',T*1000);

% max_in = 2^(N_dig_in-2)-1;
max_in = 100;

in = randn(1,N);


in = in*(max_in/max(abs(in)));
in = fix(in);

% in = (1:N)-N/2;
in_dop = in;
in_dop(in_dop<0) = in_dop(in_dop<0) + 2^(N_dig_in)-1;
% plot(in,in_dop)


in_hex = dec2hex(in_dop);

dlmwrite('noise_adpt_qnt.txt',in_hex,'delimiter','')
dlmwrite('noise.txt',in_hex,'delimiter','')
% dlmwrite('noise_adpt_qnt_sig_mag.txt',in2,'delimiter','')