%% Проверка правильности расчета индексов и работы модулей MACC_NN в корреляционной матрице. (для сверки с _tb.v)
% * с учетом нумерации с 0 в verilog

clc
clear
close all

%%
ADC     = [1 2 3 4];
L       = length(ADC);  % NCH
NT      = 2;
MACC_NN = 10;

Y       = L*NT;

TOTAL_MACCS = ((L*NT)^2 + L*NT)/2; 
TOTAL_MACCS

ADC_DL = repelem(ADC,1,NT);
MACC_ID = zeros(Y,Y);
MACC_SUM = zeros(Y,Y);

for i = 0: (Y-1)
    for j = 0:i
        MACC_ID(i+1,j+1) = i*(i+1)/2 + j;
    end
end

for i = 0: (Y-1)
    for j = 0:i
        for k = 1:MACC_NN
            MACC_SUM(i+1,j+1) = MACC_SUM(i+1,j+1) + ADC_DL(i+1)*ADC_DL(j+1);
        end
    end
end

MACC_ID
MACC_SUM

