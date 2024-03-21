function out = fft_fpga(data, W_bits, D_bits, MEM_bits, type)

N = length(data);

W_sign = 1;    % комлпексное сопряжение для ОБПФ
ifft_norm = 1; % нормировка для ОБПФ

if(nargin > 4)
if(~strcmp(type,'inverse'))
    error('type shoud be ''inverse'' or nothing == ''direct''')
else
    W_sign = -1;
    ifft_norm = N;
end
end

N_stages = log2(N);
RADIX = 2;

k = 0:N/2-1;
W = cos(2*pi*k/N) - 1i*sin(2*pi*k/N)*W_sign;
if(W_bits ~= 0)
%     max_int_W = 2^(W_bits-1)-1;
    max_int_W = 2^(W_bits-1);
    W = fix(real(W)*max_int_W) + 1i*fix(imag(W)*max_int_W);
else
    max_int_W = 1;
end

if(D_bits ~= 0)
    max_int_D = 2^(D_bits-1)-1;
    data = fix(real(data)*max_int_D) + 1i*fix(imag(data)*max_int_D);
end

DIT_data = data(bitreverse(0:N-1)+1);

inp_bits = D_bits; % разрядность на входе бабочки

for i = 1:N_stages % перебор стадий
%     for j = 1:N/2/i
N_SUB_STAGES = N/2^i; % число подгрупп в одной стадии
radix_in_sub = N/2/N_SUB_STAGES; % число бабочек в одной подгруппе
delta_W = N/2^i;
overflow = inp_bits + W_bits + 1*0 - MEM_bits;
if(overflow > 0)
    K_DIV = overflow;
else
    K_DIV = 0;
end
% fprintf('stage=%d,inp_bits=%d,overflow=%d,K_DIV=%d\n',i,inp_bits,overflow,K_DIV);
            
% fprintf('=========\n');
% fprintf('STAGE = %3d   |  (%d sub_stage), radix_in_sub=%d, delta_W=%d\n',i,N_SUB_STAGES,radix_in_sub,delta_W);
    for i_sub = 1:N_SUB_STAGES
        for i_radix = 1:radix_in_sub
            address(1) = (i_sub-1)*radix_in_sub*RADIX + (i_radix-1);
            address(2) = address(1) + RADIX^(i-1);
            
            addr_W = mod((i_radix-1)*delta_W,N/2);
%             fprintf('addr=[%2d,%2d], addr_W=%d\n',address,addr_W)
            DIT_data(address+1) = butterfly(DIT_data(address+1),W(addr_W+1),max_int_W,K_DIV,MEM_bits);
            if(i == N_stages) % последняя стадия, для ОБПФ делаем нормировку
                DIT_data(address+1) = DIT_data(address+1)/ifft_norm;
            end
        end
    end
%     histogram(real(DIT_data))
inp_bits = inp_bits + W_bits + 1*0 - K_DIV;
end

% histogram(real(DIT_data))
out = DIT_data;

end

