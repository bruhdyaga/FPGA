clear
clc
close all hidden

N = 1e4;
NF = 5;


y = randn(1,N);
R = zeros(NF,N);

for i=1:NF
    f = (i-(NF+1)/2);
    sd = sign(sin(2*pi*f*(1:N)/N);
%     cd = 
%     y.*
end