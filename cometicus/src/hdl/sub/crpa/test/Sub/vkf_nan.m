function [out] = vkf_nan (in1,in2)
%
% function [out] = vkf_nan (in1,in2)
%  ������ �������� �������������� �������
%  �������� in1 � in2
%  c ������ ���������� ��������� nan 
%  � ������� ������� ��������
% ������� ������:
%   in1, in2  - ��� �������
% �������� ������
%   out       - �������� �������������� �������

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