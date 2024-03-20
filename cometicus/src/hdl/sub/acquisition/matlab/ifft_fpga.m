function out = ifft_fpga(data, W_bits, D_bits, MEM_bits)

if(nargin == 1)
    W_bits = 0; % default value
    D_bits = 0; % default value
end

out = fft_fpga(data,W_bits,D_bits,MEM_bits,'inverse');
end