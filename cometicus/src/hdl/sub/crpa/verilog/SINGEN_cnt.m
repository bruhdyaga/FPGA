clc
clear
close all;


Tclk = 20000e-12; % 20 nan
Fclk = 1/Tclk;    % 50 MHz

CODE_RATE   = 1e6;
CNT_DIG     = 32;

N = 2^CNT_DIG / CODE_RATE;      % число значений счетчика

T = Tclk * N;

