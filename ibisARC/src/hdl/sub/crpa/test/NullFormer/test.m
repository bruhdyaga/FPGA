function [test_result] = test(varargin)
%clear; varargin = {};

addpath('../Sub');

% Каталог для хранения временных результатов
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% Список параметров и значения по-умолчанию
DefParams = {'NCH',           2;
             'DIRECT_CH',     1;
             'NT',            4;
             'input_width',  14;
             'coeff_width',  14;};
parse_params

% ======== Общие параметры модели ========
fd = 125e6;             % Частота дискретизации
Td = 1/fd;              % Интервал дискретизации

fh = 10e6;              % Частота среза ФНЧ в тесте

T = 0.1e-3;               % Длительность тестируемой выборки
N = fix(T/Td);          % Количество отсчётов


% ======== Формирование обрабатываемого процесса ========

s = randn(NCH, N);        % Входной сигнал

% Квантование сигнала
Ks = 1/4*2^(input_width-1);      % Масштабный коэффициент для квантования
s = quant(Ks*s, input_width);    % Квантование сигнала

% Запись выборки сигнала в файл
for i=1:NCH
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== Обработка сигнала в Matlab ========
% ==== Расчёт коэффициентов ====
Kb = 2^(coeff_width-1);          % Масштабный коэффицент 

B = zeros(NCH-1, NT);
for i=1:NCH-1
    Wn = (0.5+0.5*rand(1, 1)) * fh/(fd/2);         % Нормированная частота среза

    B(i, :) = fir1(NT-1, Wn);    % Расчёт коэффицентов фильтра
end

B = quant(B*Kb, coeff_width);    % Квантование коэффициентов фильтра
A = Kb-1;                     % Нормировка коэффициентов в Matlab делает функция filter(B, A, y)


% Запись коэффицентов в файл
fid = fopen([TMP 'coefs.txt'], 'w');
fprintf(fid, '%d\n', B');
fclose(fid);

% ==== Фильтрация в Matlab ====
y = s(DIRECT_CH, :);
k = 1;
for i=1:NCH
    if i~= DIRECT_CH
        y = y + filter(B(k, :), A, s(i, :)); 
        k = k + 1;
    end
end

% ======== Обработка данных в Verilog =========

% ==== Запись параметров для Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % Файл с параметрами тестирования
fprintf(fid_param, '`define NF_NCH %d\n', NCH);
fprintf(fid_param, '`define NF_DIRECT_CH %d\n', DIRECT_CH-1); % В NullFormer_n DIRECT_CH нумеруется с 0
fprintf(fid_param, '`define NF_NT %d\n', NT);
fprintf(fid_param, '`define NF_INPUT_WIDTH %d\n', input_width);
fprintf(fid_param, '`define NF_COEFF_WIDTH %d\n', coeff_width);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % Файл с продолжительностью тестирования
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== Запуск теста modelsim ====
system('make batch');

% ==== Считывание результатов ====
out = textread('tmp/out.txt', '%n')';

y = round(y*(Kb-1));  % Последствия деления на 2^(coeff_width-1)-1 - не степень двойки

% ======== Анализ и сравнение результатов обработки =========
test_result = compare(y, out, Td);
