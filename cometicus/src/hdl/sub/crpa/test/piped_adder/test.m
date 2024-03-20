function [test_result] = test(varargin)

addpath('../Sub');

% Каталог для хранения временных результатов
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);


% Список параметров и значения по-умолчанию
DefParams = {'NS',         17;
             'IN_WIDTH',   46;};
parse_params

% ======== Общие параметры модели ========
fd = 125e6;             % Частота дискретизации
Td = 1/fd;              % Интервал дискретизации

fi = fd/10;              % Промежуточная частота сигнала

T = 0.01e-3;             % Длительность тестируемой выборки
N = fix(T/Td);          % Количество отсчётов

% ======== Формирование обрабатываемого процесса ========

s = -1+2*rand(NS, N);

% Квантование сигнала
Ks = 1/1.05 * 2^(IN_WIDTH-1);    % Масштабный коэффициент для квантования
s = quant(Ks*s, IN_WIDTH);       % Квантование сигнала

% Запись выборки сигнала в файл
for i=1:NS
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== Обработка сигнала в Matlab ========
% ==== Фильтрация в Matlab ====
y = sum(s);

% ======== Обработка данных в Verilog =========

% ==== Запись параметров для Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % Файл с параметрами тестирования
fprintf(fid_param, '`define MSUM_NS %d\n', NS);
fprintf(fid_param, '`define MSUM_WIDTH %d\n', IN_WIDTH);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % Файл с продолжительностью тестирования
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== Запуск теста modelsim ====
system('make batch');

% ==== Считывание результатов ====
out = textread('tmp/out.txt', '%n')';

% ======== Анализ и сравнение результатов обработки =========
test_result = compare(y, out, Td);
