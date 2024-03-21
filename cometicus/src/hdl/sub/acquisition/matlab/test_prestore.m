clc
clear
close all hidden

Fd   = 99.375e6;
Td = 1/ Fd;
Fpre = 2.046e6;
T = 1e-3;
fi = 1575.42e6 - 1590e6;
Nd = fix(T*Fd);
Npsp = 1022;

i = 0 : (Nd - 1);

y_phi = 0*rand(1,1) * 2 * pi;
y_sin = sin(y_phi + 2 * pi * fi * Td * i);
y_cos = cos(y_phi + 2 * pi * fi * Td * i);

[~,~,y_Q] = sig_mag(y_sin);
[~,~,y_I] = sig_mag(y_cos);
y = y_I + 1i*y_Q;

ref_phi = 0*rand(1,1) * 2 * pi;
ref_sin = -round(sin(ref_phi + 2 * pi * fi * Td * i)*5);
ref_cos =  round(cos(ref_phi + 2 * pi * fi * Td * i)*5);
ref = ref_cos + 1i*ref_sin;

data_zero = y .* ref;

pre_I = data_coll(real(data_zero), Npsp);
pre_Q = data_coll(imag(data_zero), Npsp);

subplot(2,1,1)
plot(1:Nd,[real(data_zero); imag(data_zero)])

subplot(2,1,2)
plot(1:Npsp,[pre_I; pre_Q])