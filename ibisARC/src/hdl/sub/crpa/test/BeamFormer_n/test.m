function [test_result] = test(varargin)

addpath('../Sub');

% Каталог для хранения временных результатов
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% Список параметров и значения по-умолчанию
DefParams = {'NN',          4;
             'a_width',    14;
             'b_width',    14;};
parse_params


% ======== Общие параметры модели ========
fd = 125e6;             % Частота дискретизации
Td = 1/fd;              % Интервал дискретизации

fi = fd/10;              % Промежуточная частота сигнала

T = 0.01e-3;             % Длительность тестируемой выборки
N = fix(T/Td);          % Количество отсчётов

% ======== Формирование обрабатываемого процесса ========

s = zeros(NN, N);
phi = 2*pi*zeros(NN, 1);     % Фазовое распределение сигналов - ЕСТЬ ПРОБЛЕМА, надо решать

for i=1:NN
    s(i, :) = cos(2*pi*fi * Td*(0:N-1) + phi(i));
end

% Квантование сигнала
Ks = 1/1.05 * 2^(a_width-1);    % Масштабный коэффициент для квантования
s = quant(Ks*s, a_width);       % Квантование сигнала

% Запись выборки сигнала в файл
for i=1:NN
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== Обработка сигнала в Matlab ========
% ==== Расчёт коэффициентов ====
Kb = 2^(b_width-1);             % Масштабный коэффицент 

%Kbf = ones(1, NN);              % ПРОБЛЕМА!!!
Kbf = rand(1, NN);              % Пока пусть будут случайные коэффициенты

Kbf = quant(Kbf*Kb, b_width);   % Квантование коэффициентов фильтра

% Запись коэффицентов в файл
fid = fopen([TMP 'coefs.txt'], 'w');
fprintf(fid, '%d\n', Kbf);
fclose(fid);

% ==== Фильтрация в Matlab ====
y = Kbf * s;

% ======== Обработка данных в Verilog =========

% ==== Запись параметров для Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % Файл с параметрами тестирования
fprintf(fid_param, '`define BF_NN %d\n', NN);
fprintf(fid_param, '`define BF_A_WIDTH %d\n', a_width);
fprintf(fid_param, '`define BF_B_WIDTH %d\n', b_width);
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
