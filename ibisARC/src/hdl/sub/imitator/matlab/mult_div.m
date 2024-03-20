close all hidden
clear
clc

D=2.^(0:7);

for M = 1:255
    K(M,:) = fix(M./D)
end

K = K(:);