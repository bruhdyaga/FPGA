clc
clear
close all hidden

%% config
Fd = 100e6;%частота дискретизации
fi = 12e6;
q = 55;% dBHz
%%

Td=1/Fd;
T = 16e-3;% длительность реализации
Nd=fix(T/Td);
Tfix = Td*Nd;% точна€ длительность реализации
A=sqrt((4*10^(q/10)*Td));

NS = 1;

%% GPS_L%
% PNSize = 10230;
% Tpsp = 1e-3;
%% GPS_L1_CA
PNSize = 1023;
Tpsp = 1e-3;
%% GLN_L1_OF
% PNSize = 511;
% Tpsp = 1e-3;
%% GLN_L1_SF
% PNSize = 5110000;
% Tpsp = 1000e-3;
%% GalE1
% PNSize = 4092;
% Tpsp = 4e-3;
% load('GalE1B_0.mat','prn_gal')
% PN(1,1:PNSize) = prn_gal(1:PNSize);

PN = zeros(1,PNSize);
for i = 1:NS
    filename = sprintf('PSP_GPS\\psp_gps_L1_ca_%d.txt',i);
%     filename = sprintf('PSP_GPS\\GpsL5Q_%d.txt',i);
%     filename = sprintf('PSP_GLN\\psp_gln_L1_OF.txt');
    % filename = sprintf('PSP_GLN\\GLN_L1_SF.txt');
    PN(i,1:PNSize) = sign(dlmread(filename)-0.5);
    
%     PN(i,1:PNSize) = dlmread(filename);
end

tau = fix(-300/2);

%% раст€гивание и размножение PSP
Npsp_rep = ceil(Tfix/Tpsp);% количество необходимых псп дл€ реализации
PNrep = repmat(PN,1,Npsp_rep);
PNrep = circshift(PNrep,tau,2);

i=1:Nd;
PNrep_fd = PNrep(:,mod((fix(Td*(1:Npsp_rep*Tpsp/Td)*PNSize/Tpsp)),PNSize)+1);
PNrep_fd_fix = PNrep_fd(:,1:Nd);% массив псп на частоте дискретизации на нужном интревале T. число отсчетов Nd

%% create signal
% phi = 2*pi*rand(1,1);
phi = (145-90-45)/180*pi;% временно дл€ отладки
noise = randn(1,Nd)*0;
carr_I = cos(2*pi*fi*Td*i + phi);
carr_Q = -sin(2*pi*fi*Td*i + phi);
y_I = A*PNrep_fd_fix(1,:).*carr_I + noise;
y_Q = A*PNrep_fd_fix(1,:).*carr_Q + noise;
% y_I = A*carr_I;
% y_Q = A*carr_Q;

[sig_I, mag_I] = sig_mag(y_I);
[sig_Q, mag_Q] = sig_mag(y_Q);
%% write
if ~exist('acq_test_signal', 'dir')
  mkdir('acq_test_signal');
end

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