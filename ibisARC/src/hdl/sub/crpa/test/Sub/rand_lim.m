function [out] = rand_lim(Lim)
% function [out] = rand_lim(Lim)
%
% Целое случайное число в пределах Lim(1)...Lim(2)
    
   out = fix(Lim(1) + (Lim(2)+1-Lim(1))*rand(1, 1));
