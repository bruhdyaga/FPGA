function [test_result] = test(varargin)
% clear; varargin={};

addpath('../Sub');

% Каталог для хранения временных результатов
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% Список параметров и значения по-умолчанию
DefParams = {'width',           14;
             'tau',              6};
parse_params

% ======== Общие параметры модели ========
fd = 125e6;             % Частота дискретизации
Td = 1/fd;              % Интервал дискретизации

T = 0.1e-3;               % Длительность тестируемой выборки
N = fix(T/Td);          % Количество отсчётов

% ======== Формирование обрабатываемого процесса ========

M = 1;
s = M + randn(1, N);        % Входной сигнал

% Квантование сигнала
Ks = 1/4*2^(width-1);      % Масштабный коэффициент для квантования
s = quant(Ks*s, width);    % Квантование сигнала

% Запись выборки сигнала в файл
fid = fopen([TMP 's.txt'], 'w'); 
fprintf(fid, '%d\n', s);
fclose(fid);


% ======== Обработка сигнала в Matlab ========

% ==== Фильтрация в Matlab ====
y = s - mean(s);

% ======== Обработка данных в Verilog =========

% ==== Запись параметров для Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % Файл с параметрами тестирования
fprintf(fid_param, '`define WDC_width %d\n', width);
fprintf(fid_param, '`define WDC_tau %d\n', tau);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % Файл с продолжительностью тестирования
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);


% ==== Запуск теста modelsim ====
system('make batch');

% ==== Считывание результатов ====
out = textread('tmp/out.txt', '%n')';


% ======== Анализ и сравнение результатов обработки =========
[M dly] = max(abs(vkf_nan(out, s)));

err = circshift(s', dly-1)' - out;

subplot(2, 1, 1);
plot(1:length(out), circshift(s', dly-1)', 'b', 1:length(out), out, 'g')
grid on
subplot(2, 1, 2)
plot(1:length(err), err, 'b', 1:length(err), mean(s)*ones(size(err)), 'r')
grid on

if (mean(out) < std(s)/100) & (std(err) < std(y)*0.2)
    test_result = 1;
    fprintf('OK\n');
else
    test_result = 0;
    fprintf('Failed\n');
end

