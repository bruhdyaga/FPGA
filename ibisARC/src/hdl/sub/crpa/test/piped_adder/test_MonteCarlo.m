clear;
% Тест модуля multi_sum_n.v
% 
% Используется метод Монте-Карло. Для параметров, которые можно изменять,
% случайным образом выбираются значения в заданных пределах.
% Запускается файл test.m, осуществляющий моделирование в Matlab и modelsim.
%
% При отличии результатов тест считается не пройденным
% В результате получается вероятность ошибочного прохождения теста
% и список значений параметров, при которых тест провален.
%
% В каталоге tmp сохраняются файлы с названием test_params_failed_X.m
% Можно в заголовке файла test.m вызывать любоий из этих файлов, чтобы повторить
% неудачный тест и разобраться в причинах

addpath('../Sub');

Nstat = 30;   % Количество экспериментов

params = {'NS'        1 64;       % Порядок фильтра (число умножителей NT=order+1)
          'IN_WIDTH'  1 55};      % Разрядность входных данных



[Perr, FailedData, TestDescr] = MonteCarlo(Nstat, params);

fprintf('Вероятность сбоя: %g\n', Perr);

if ~isempty(FailedData)
    for i=1:size(params, 1)
        fprintf('Failed %s:\n', params{i, 1});
        unique(FailedData(i, :))
    end

    A = params{1, 2}:params{1, 3};
    B = params{2, 2}:params{2, 3};
    res = zeros(length(A), length(B));
    for i=1:size(FailedData, 2)
        indA = find(A==FailedData(1, i));
        indB = find(B==FailedData(2, i));
        if (~isempty(indA)) & (~isempty(indB))
            res(indA(1), indB(1)) = 1;
        end
    end

    %imshow(res)
end
    