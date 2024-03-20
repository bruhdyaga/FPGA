function out = butterfly(data,W,Norm,cut,MEM_bits)

max_abs = 2^(MEM_bits-1)-1;

%% input
A_R = real(data(1));
A_I = imag(data(1));
B_R = real(data(2));
B_I = imag(data(2));
W_R = real(W);
W_I = imag(W);

%% multiply
B_R_W_R = B_R*W_R;
B_I_W_I = B_I*W_I;
B_I_W_R = B_I*W_R;
B_R_W_I = B_R*W_I;
Mult_R = B_R_W_R - B_I_W_I;
Mult_I = B_I_W_R + B_R_W_I;

Norm_A_R = Norm*A_R;
Norm_A_I = Norm*A_I;

%% butterfly
C_R = Norm_A_R + Mult_R;
C_I = Norm_A_I + Mult_I;

D_R = Norm_A_R - Mult_R;
D_I = Norm_A_I - Mult_I;

% if(cut == 4)
%    cc=1; 
% end

%% scale
C_R = floor(C_R/(2^cut)); % сдвиг вправо
C_I = floor(C_I/(2^cut));
D_R = floor(D_R/(2^cut));
D_I = floor(D_I/(2^cut));

%% limit
C_R_sign = sign(C_R);
C_I_sign = sign(C_I);
D_R_sign = sign(D_R);
D_I_sign = sign(D_I);
C_R = C_R_sign * min(abs(C_R),max_abs);
C_I = C_I_sign * min(abs(C_I),max_abs);
D_R = D_R_sign * min(abs(D_R),max_abs);
D_I = D_I_sign * min(abs(D_I),max_abs);

%% output
out(1) = C_R+1i*C_I;
out(2) = D_R+1i*D_I;

if((min([real(out),imag(out)]) < -(2^(MEM_bits-1))) || (max([real(out),imag(out)]) > (2^(MEM_bits-1) - 1)))
    error('OVERFLOW, MEM_bits=%d [%d...%d], min_out=%d, max_out=%d, min_in=%d, max_in=%d',...
        MEM_bits,-(2^(MEM_bits-1)),(2^(MEM_bits-1) - 1),min([real(out),imag(out)]),max([real(out),imag(out)]),...
        min([real(data),imag(data)]),max([real(data),imag(data)]));
end



end