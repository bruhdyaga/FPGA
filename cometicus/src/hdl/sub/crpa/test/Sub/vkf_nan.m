function [out] = vkf_nan (in1,in2)
%
% function [out] = vkf_nan (in1,in2)
%  Расчёт взаимной корреляционной функции
%  массивов in1 и in2
%  c учётом возможного появления nan 
%  и разного размера массивов
% Входные данные:
%   in1, in2  - два массива
% Выходные данные
%   out       - взаимная корреляцоинная функция

N = min(length(in1), length(in2));

in1 = in1(1:N);
ind = find(isnan(in1));
in1(ind) = zeros(size(ind));

in2 = in2(1:N);
ind = find(isnan(in2));
in2(ind) = zeros(size(ind));


S_in1=fft( [in1 zeros(1, N)] );
S_in2=fft( [in2 zeros(1, N)] );

out=S_in1.*conj(S_in2);

out=real(ifft(out));

out=out/N/2;