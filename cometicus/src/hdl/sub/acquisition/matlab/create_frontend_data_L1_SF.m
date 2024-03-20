clc
clear
close all hidden

%% config
Fd = 100e6;%частота дискретизации
fi = 10e6;
q  = 55;% dBHz
%%

Td=1/Fd;
T = 1*10e-3;% длительность реализации
Nd=fix(T/Td);
Tfix = Td*Nd;% точна€ длительность реализации
A=sqrt((4*10^(q/10)*Td));

%% PSP
PNSize = 511;
Tpsp = 1;

PN = zeros(1,PNSize);

% filename = 'PSP_GLN\\GLN_L1_SF.txt';
filename = 'PSP_GLN\\psp_gln_L1_OF.txt';
PN(1,1:PNSize) = sign(dlmread(filename)-0.5);


%% раст€гивание и размножение PSP
Npsp_rep = ceil(Tfix/Tpsp);% количество необходимых псп дл€ реализации
PNrep = repmat(PN,1,Npsp_rep);

i=1:Nd;
PNrep_fd = PNrep(:,mod((fix(Td*(1:Npsp_rep*Tpsp/Td)*PNSize/Tpsp)),PNSize)+1);
PNrep_fd_fix = PNrep_fd(:,1:Nd);% массив псп на частоте дискретизации на нужном интревале T. число отсчетов Nd

%% create signal
% phi = 2*pi*rand(1,1);
% phi = -10/180*pi;% временно дл€ отладки
phi   = 0;
noise = 0*randn(1,Nd);
carr_I = cos(2*pi*fi*Td*i + phi);
carr_Q = sin(2*pi*fi*Td*i + phi);
y_I = A*PNrep_fd_fix(1,:).*carr_I + noise;
y_Q = A*PNrep_fd_fix(1,:).*carr_Q + noise;
% y_I = A*carr_I + noise;
% y_Q = A*carr_Q + noise;

[sig_I, mag_I] = sig_mag(y_I);
[sig_Q, mag_Q] = sig_mag(y_Q);
%% write
filename = 'acq_test_signal/sig_I.txt';
fid = fopen(filename, 'w');
fclose(fid);
dlmwrite(filename,sig_I,'delimiter','\n')

filename = 'acq_test_signal/mag_I.txt';
fid = fopen(filename, 'w');
fclose(fid);
dlmwrite(filename,mag_I,'delimiter','\n')

filename = 'acq_test_signal/sig_Q.txt';
fid = fopen(filename, 'w');
fclose(fid);
dlmwrite(filename,sig_Q,'delimiter','\n')

filename = 'acq_test_signal/mag_Q.txt';
fid = fopen(filename, 'w');
fclose(fid);
dlmwrite(filename,mag_Q,'delimiter','\n')
%%

fprintf('size = %.0f\n',Nd);