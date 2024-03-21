function [NF_coeff] = GenerateNFcoeff(R, str, ref_list, params)
% function [NF_coeff] = GenerateNFcoeff(R, ref_list, params)
% 
% ƒанна€ функци€ формирует коррел€ционную матрицу по выборке сигнала y
% ѕараметры определ€ютс€ m-файлом params,
% который запускаетс€ в начале функции
% ¬ файле должны быть определены переменные:
%             fd   -   частота дискретизации
%             T    -   длительность формируемой выборки
%             q    -   отношение мощности сигнала к спектральной плотности шума (чтобы выставить мощность помехи)
%            JS    -   отношение мощности помехи к мощности сигнала
%           NCH    -   количество пространственных каналов
%            NT    -   количество отсчЄтов по времени
%         Nstat    -   количество отсчЄтов, накапливаемых дл€ сбора статистики
%    input_width   -   разр€дность формируемых данных
% ¬ходные параметры
%             R    -   коррел€ционна€ матрица
%           str    -   структура фильтра
%      ref_list    -   номера выводов, дл€ которых формируютс€ NullFromer
% ¬ыходные параметры
%             R    -   сформированна€ матрица
%            RT    -   нижне-треугольна€ матрица в виде линейного массива

cmd = fileread(params); eval(cmd);

% ѕересчЄт индексов из структуры str в линейный индекс в массиве y
beta_ind = sub2ind([NCH NT], str(:, 1), NT+1 - str(:, 2));

R = R^(-1);

NF_coeff = zeros(NCH, NT, NCH);
Norm = zeros(1, NCH);
for i=1:NCH
    iA = 1 + (i-1)*NT;
    NF_coeff(beta_ind+(i-1)*NCH*NT) = R(iA, :).' / R(iA, iA);
end

NF_coeff = NF_coeff(:, end:-1:1, :);

