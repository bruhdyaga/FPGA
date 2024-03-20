clear
close all hidden
clc

LUT_mux_inp = 4; % число рабочих входов при мультиплексировании (6 вх, 4 мукса)
DATA_BIT_SIZE = 2048*32; % число бит на чтение
for DATA_WIDTH = [1,2,4,8,16,32,64,128*3]
%     DATA_WIDTH = 32;
    
    N_REGS = ceil(DATA_BIT_SIZE/DATA_WIDTH);
    
    LUTS = 0;
    
    while(N_REGS > 1)
        lut = ceil(N_REGS/LUT_mux_inp);
        LUTS = LUTS + lut;
        N_REGS = lut;
    end
    
    LUTS = LUTS * DATA_WIDTH;
    
    fprintf('32_bit_regs = %.1f, DATA_WIDTH = %d, LUTS = %d\n',DATA_BIT_SIZE/32, DATA_WIDTH, LUTS)
end
