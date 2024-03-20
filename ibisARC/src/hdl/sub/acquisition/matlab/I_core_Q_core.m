clc

L_core = 128;
NKg = fix(sum(zero_mem_NKg==0)/L_core);
fprintf('NKg = %d\n',NKg)
R = zeros(1,L_core*NKg);
R_NKg = zeros(1,L_core);

for i = 1:NKg;
    I = I_core_lim((1:L_core)+L_core*(i-1));
    Q = Q_core_lim((1:L_core)+L_core*(i-1));
    R((1:L_core)+L_core*(i-1)) = I.^2 + Q.^2;
%     R_NKg = R_NKg + R((1:L_core)+L_core*(i-1));
    
    R_NKg = R_abs((1:L_core)+L_core*(i-1));
end