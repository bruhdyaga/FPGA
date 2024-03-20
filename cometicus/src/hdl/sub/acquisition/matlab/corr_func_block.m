clc
clear
close all hidden

core_size = 1023;

y = randn(1,core_size*3);

corr_y_orig = real(ifft(fft(y) .* conj(fft(y))));


for i = 1:3
    switch(i)
        case 1
            dat = y(1:core_size*2);
            code = y(1:core_size);
        case 2
            dat = y(core_size+1:core_size*3);
            code = y(core_size+1:core_size*2);
        case 3
            dat = y([core_size*2+1:core_size*3,1:core_size]);
            code = y(core_size*2+1:core_size*3);
    end
    
    
end