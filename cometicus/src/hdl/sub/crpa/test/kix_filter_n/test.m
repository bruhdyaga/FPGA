function [test_result] = test(varargin)

addpath('../Sub');

% Каталог для хранения временных результатов
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% Список параметров и значения по-умолчанию
DefParams = {'order',       5;
             'width',      14;
             'ncfwidth',   14;};
parse_params

% Дополнительные параметры
NT = order + 1;             % Число умножителей NT = order+1 !

% ======== Общие параметры модели ========
fd = 125e6;             % Частота дискретизации
Td = 1/fd;              % Интервал дискретизации

fh = 10e6;              % Частота среза ФНЧ в тесте

T = 0.1e-3;               % Длительность тестируемой выборки
N = fix(T/Td);          % Количество отсчётов


% ======== Формирование обрабатываемого процесса ========

s = randn(1, N);        % Входной сигнал

% Квантование сигнала
Ks = 1/4*2^(width-1);      % Масштабный коэффициент для квантования
s = quant(Ks*s, width);    % Квантование сигнала


% Запись выборки сигнала в файл
fid = fopen([TMP 's.txt'], 'w'); 
fprintf(fid, '%d\n', s);
fclose(fid);


% ======== Обработка сигнала в Matlab ========
% ==== Расчёт коэффициентов ====
Kb = 2^(ncfwidth-1);          % Масштабный коэффицент 

Wn = fh/(fd/2);         % Нормированная частота среза

B = fir1(order, Wn);    % Расчёт коэффицентов фильтра

B = quant(B*Kb, ncfwidth);    % Квантование коэффициентов фильтра
A = Kb;                 % Нормировка коэффициентов в Matlab делает функция filter(B, A, y)

% Запись коэффицентов в файл
fid = fopen([TMP 'coefs.txt'], 'w');
fprintf(fid, '%d\n', B);
fclose(fid);

% ==== Фильтрация в Matlab ====
y = filter(B, A, s); 


% ======== Обработка данных в Verilog =========

% ==== Запись параметров для Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % Файл с параметрами тестирования
fprintf(fid_param, '`define FIR_WIDTH %d\n', width);
fprintf(fid_param, '`define FIR_NT %d\n', NT);
fprintf(fid_param, '`define FIR_NCFWIDTH %d\n', ncfwidth);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % Файл с продолжительностью тестирования
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== Запуск теста modelsim ====
system('make batch');

% ==== Считывание результатов ====
out = textread('tmp/out.txt', '%n')';

out = out/Kb;

% ======== Анализ и сравнение результатов обработки =========
test_result = compare(y, out, Td);
