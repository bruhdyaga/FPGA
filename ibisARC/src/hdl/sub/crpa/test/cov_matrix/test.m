function [test_result] = test(varargin)

addpath('../Sub');

% Каталог для хранения временных результатов
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% Список параметров и значения по-умолчанию
DefParams = {'NCh',         8;      % Количество антенн
             'NT',          4;      % Глубина по времени
             'InWidth',    14;      % Разрядность входных данных    
             'NStat',    1000;      % Объем набираемой статистики
             'Mode',        1;      % 0 - первая четверка, 1 - вторая четверка, 2 - матрица 8х1 
             'dTau',        7;      % Постоянная времени корреляции входных данных (при <= 4 нет корреляции), тактов
             'do_plot',     1;      % Рисовать ли график
             'silent',      0;      % Не писать в консоль
             };
parse_params

% ======== Общие параметры модели ========
fd = 125e6;             % Частота дискретизации
Td = 1/fd;              % Интервал дискретизации

T = 0.01e-3 + NStat*Td; % Длительность тестируемой выборки
N = fix(T/Td);          % Количество отсчётов

Shift = 6;              % Сдвиг результата

NTi = NT;
if (Mode == 0)
    NABr = 4;
elseif (Mode == 1)
    NABr = 4;
elseif (Mode == 2)
    NABr = 8;
    NTi = 1;
elseif (Mode == 3)
    NABr = 8;  
end

StartDelay = NTi + 2;
    
% ======== Формирование обрабатываемого процесса ========
YLENGTH = NStat + NTi - 1;   % Длина сигнальной выборки, тактов

y = nan(YLENGTH, NCh);
W = rand(NCh) - 0.5;
% W(5:8, :) = 0;
if (dTau > 4)
    K = 4 / dTau;
else
    K = 1;
end
yold = W*randn(NCh, 1);
yold = yold.';
for k = 1:YLENGTH
    yseed = W*randn(NCh, 1);
    ynew = yold + K*(yseed.' - yold);
    y(k, :) = ynew;
    yold = ynew;
end
y = y / max(max(y));    % Нормировка к 1

y(:, 3) = 0;
s = y';        % Входной сигнал

% Квантование сигнала
Ks = 1/4*2^(InWidth-1);      % Масштабный коэффициент для квантования
s = quant(Ks*s, InWidth);    % Квантование сигнала

% Запись выборки сигнала в файл
for i=1:NCh
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== Обработка сигнала в Matlab ========
y = s';
[Mm, NMm] = y2cvm( y, NT, Mode );

Mm = floor(Mm / 2^Shift);

% ======== Обработка данных в Verilog =========

% ==== Запись параметров для Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % Файл с параметрами тестирования
fprintf(fid_param, '`define TMPPATH "%s/tmp"\n', pwd);

fprintf(fid_param, '`define CVM_NCH %d\n', NCh);
if (Mode == 2)
    fprintf(fid_param, '`define CVM_NT %d\n', 4);
else
    fprintf(fid_param, '`define CVM_NT %d\n', NT);
end
fprintf(fid_param, '`define CVM_WIDTH %d\n', InWidth);
fprintf(fid_param, '`define CVM_NSTAT %d\n', NStat);
fprintf(fid_param, '`define CVM_MODE %d\n', Mode);
fprintf(fid_param, '`define CVM_STARTDELAY %d\n', StartDelay);

fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % Файл с продолжительностью тестирования
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== Запуск теста modelsim ====
system('make batch');

% ==== Считывание результатов ====
out = textread('tmp/out.txt', '%n')';

[Mv, NMv, err] = maccs2cvm( out, NCh, NT, Mode );

if err
    if (~silent)
        fprintf('Fail\n');
    end
    test_result = 0;
    return;
end

% ======== Анализ и сравнение результатов обработки =========

if (do_plot)
    figure(1)
    Ns = 1; Ms = 2; ks = 0;
    ks = ks + 1; ha = subplot(Ns, Ms, ks);
    plot_matrix(ha, Mv);
    title({'Verilog:', ['Matrix ' num2str(NABr) 'x' num2str(NTi) ': ' num2str(NMv) ' multipliers']});
    
    ks = ks + 1; ha = subplot(Ns, Ms, ks);
    plot_matrix(ha, Mm);
    title({'Matlab:', ['Matrix ' num2str(NABr) 'x' num2str(NTi) ': ' num2str(NMm) ' multipliers']});
end

if (norm(Mm - Mv) == 0)
    test_result = 1;
    if ~silent
        fprintf('OK\n');
    end
else
    test_result = 0;
    if ~silent
        fprintf('Fail\n');
    end
end
