clc
clear
close all hidden

% trellis = poly2trellis(7,{'1 + x^2 + x^3 + x^5 + x^6', ...
%     '1 + x + x^2 + x^3 + x^6'});
trellis = poly2trellis(2,{'1 + x'});

data = [1,zeros(1,9)]'
codedData = convenc(data,trellis)