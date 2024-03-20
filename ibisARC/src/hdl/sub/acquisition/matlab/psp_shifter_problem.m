clc
close all hidden

PNSize = 1023;
PN(1:PNSize) = dlmread('PSP_GPS\\psp_gps_L1_ca_1.txt');

psp_full = code_out;
psp_valid_full = valid_dop_shift;

x1 = 1:10e3;
% x1 = 10e3:20e3;
% x1 = 20e3:30e3;
% x1 = 30e3:40e3;
% x1 = 42e3:52e3;
% x1 = 52e3:62e3;

psp_cut = psp_full(x1);
psp_valid_cut = psp_valid_full(x1);

psp = psp_cut(psp_valid_cut == 1);
psp_valid = psp_valid_cut(psp_valid_cut == 1);

psp=sign(psp-0.5);


plot(real(ifft(fft(psp(1:2:2046)) .* conj(fft(PN')))))