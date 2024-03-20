function out = quant(y, Nq)
% Квантование входного сигнала с ограничением
N = 2^Nq;

out_re = round(real(y));
out_re =  min( out_re, N/2-1);
out_re = -min(-out_re, N/2);      

out_im = round(imag(y));
out_im =  min( out_im, N/2-1);
out_im = -min(-out_im, N/2);      

out = out_re + 1i*out_im;
