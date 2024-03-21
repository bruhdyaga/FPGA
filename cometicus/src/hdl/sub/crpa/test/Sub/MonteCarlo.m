function [Perr, FailedData, TestDescr] = MonteCarlo(NMCstat, params)
% function [Perr, FailedData, TestDescr] = MonteCarlo(NMCstat, params)
%
% Тест Монте-Карло для проверки всех параметров
% Случайным образом выбирает сочетание параметров тестируемого модуля
% и сохраняет условия при ошибочном результате
% Входные параметры:
%   NMCstat  - количество экспериментов
%   params - список параметров - cell: имя, минимум, максимум
%      params = {'order' 1 3; 'width' 10 20}
% Выходные параметры
%   Perr       - вероятность ошибки
%   FailedData - список значений параметров, при которых произошёл сбой
%   TestDescr  - список названий параметров

% Подготовка каталога для временных данных
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);
system(['rm -f ' TMP 'test_params_fail*']);

res.iP = 1;

FailCnt = 0;
tstat = tic;
for iStat = 1:NMCstat
    if iStat > 1
        fprintf('MonteCarlo test  %5d / %5d (%g c)\n', iStat, NMCstat, toc(tstat)/(iStat-1)*(NMCstat-iStat+1));
    else
        fprintf('MonteCarlo test  %5d / %5d\n', iStat, NMCstat);
    end

    % ======== Выбор тестируемых параметров ========
    ParamVals = {};
    
    res.iP = 1;
    % Начальное состояние датчика случайных чисел
    %    randn('state', 0);
    rand('state', sum(clock));
    
    % Параметры тестируемого модуля
    for i=1:size(params, 1)
        val = rand_lim( [params{i, 2} params{i, 3}]);
        eval(sprintf('%s = %d;\n', params{i, 1}, val));
        res = Store(params{i, 1}, val, res, iStat);
        
        ParamVals = [ParamVals {params{i, 1} val}];

    end

    % ======== Запуск теста ========
    test_result = test(ParamVals{:});
    
    % ======== Анализ результатов ========
    if test_result == 1  % Тест прошёл успешно
        res.TestRes(iStat) = 1;
    else                 % Тест не пройден
        res.TestRes(iStat) = 0;
        
        % Сохранение результатов тестирования для разборок
        system(sprintf('cp tmp/test_params.m tmp/test_params_fail_%d.m', FailCnt)); FailCnt=FailCnt+1;
    end

end

Perr = 1-mean(res.TestRes);
%fprintf('Вероятность сбоя: %g\n', Perr);

ind = find(res.TestRes == 0);
FailedData = res.TestData(:, ind);

TestDescr = res.TestDescr;


function [res] = Store(ParamName, Value, res, iStat)
% Сохранение параметра во внутренней структуре программы
   n = length(Value);

   if iStat < 2
       res.TestDescr{res.iP} = ParamName;
   end
   res.TestData(res.iP+(0:n-1), iStat) = Value; 
   res.iP = res.iP+n;

